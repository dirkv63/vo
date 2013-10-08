=head1 NAME

system_verification.pl - Verifies for each Physical Computer where it fits in costing.

=head1 VERSION HISTORY

version 1.0 03 October 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

Verifies each Physical Computer where it fits in the cost model. First try to find the computer in the network list, then in the application list and finally in the isolated servers list. 

Each system must be available in one and only one category.

=head1 SYNOPSIS

 system_verification.pl

 system_verification -h	Usage
 system_verification -h 1  Usage and description of the options
 system_verification -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, @vals, %comp2check, %netwerk, %comp2apps, %isolated);
my @fields = qw (cmdb_id naam source msg);

#####
# use
#####

use FindBin;
use lib "$FindBin::Bin/lib";

use warnings;			    # show warning messages
use strict 'vars';
use strict 'refs';
use strict 'subs';
use Getopt::Std;		    # Handle input params
use Pod::Usage;			    # Allow Usage information
use DBI();
use DbUtil qw(db_connect do_select do_stmt create_record);

use Log::Log4perl qw(get_logger);
use SimpleLog qw(setup_logging);
use IniUtil qw(load_ini get_ini);
use XlsWrite qw(write_table);

use Data::Dumper;

################
# Trace Warnings
################

use Carp;
$SIG{__WARN__} = sub { Carp::confess( @_ ) };

#############
# subroutines
#############

sub exit_application($) {
    my ($return_code) = @_;
	if (defined $dbh) {
		$dbh->disconnect;
	}
	$log->info("Exit application with return code $return_code.");
	exit $return_code;
}

sub trim {
    my @out = @_;
    for (@out) {
        s/^\s+//;
        s/\s+$//;
    }
    return wantarray ? @out : $out[0];
}

######
# Main
######

# Handle input values
my %options;
getopts("h:c:b:g", \%options) or pod2usage(-verbose => 0);
# my $arglength = scalar keys %options;  
# if ($arglength == 0) {			# If no options specified,
#	$options{"h"} = 0;			# display usage.
#}
#Print Usage
if (defined $options{"h"}) {
    if ($options{"h"} == 0) {
        pod2usage(-verbose => 0);
    } elsif ($options{"h"} == 1) {
        pod2usage(-verbose => 1);
    } else {
		pod2usage(-verbose => 2);
	}
}
# Get ini file configuration
my $ini = { project => "vo" };
$cfg = load_ini($ini);
# Start logging
setup_logging;
$log = get_logger();
$log->info("Start application");
# Show input parameters
if ($log->is_trace()) {
	while (my($key, $value) = each %options) {
		$log->trace("$key: $value");
	}
}
# End handle input values

# Make database connection for vo database
$dbh = db_connect("vo") or exit_application(1);

$log->info("Preparing table system_verification");
# Drop table system_verification if exists
my $query = "DROP TABLE IF EXISTS system_verification";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table system_verification, exiting...");
	exit_application(1);
}

# CREATE table system_verification
$query = "CREATE TABLE IF NOT EXISTS `system_verification` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `source` varchar(255) DEFAULT NULL,
			  `msg` varchar(255) DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table system_verification, exiting...");
	exit_application(1);
}

$log->info("Create Table srv2apps");
# Create table that connects servers to applications
$query = "DROP TABLE IF EXISTS srv2apps";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table srv2apps, exiting...");
	exit_application(1);
}

# No need to create WHERE string with sw comp or job ci_types, since 
# these are the only ones that are in apps_cis.
$query = "CREATE TABLE srv2apps
			SELECT DISTINCT c.cmdb_id_src as cmdb_id_comp, 
			       c.naam_src as naam_comp,
				   a.cmdb_id_src as cmdb_id_appl,
				   a.naam_src as naam_appl
			FROM cons_cis c, apps_cis a
		    WHERE c.cmdb_id_tgt = a.cmdb_id_tgt";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table srv2apps, exiting...");
	exit_application(1);
}

$log->info("Collect information from all sources");
# Collect Servers for Investigation
$query = "SELECT cmdb_id, naam
          FROM  `component` 
          WHERE ci_type =  'FYSIEKE COMPUTER'
            AND locatie =  'Boudewijn - Brussel/-1C Computerzaal'";
my $ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect physical computers from component table, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $cmdb_id = $$record{'cmdb_id'};
	my $naam = $$record{'naam'};
	$comp2check{$cmdb_id} = $naam;
}

# Collect Servers in Network table 
# ... or collect everything from network table. The other CIs won't do any harm.
$query = "SELECT cmdb_id, naam
          FROM netwerk
		  WHERE length(cmdb_id) > 4";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect cis from netwerk table, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $cmdb_id = $$record{'cmdb_id'};
	my $naam = $$record{'naam'};
	$netwerk{$cmdb_id} = $naam;
}

# Collect Servers in Application table
$query = "SELECT distinct cmdb_id_comp, naam_comp
          FROM srv2apps";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect cis from netwerk table, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $cmdb_id = $$record{'cmdb_id_comp'};
	my $naam = $$record{'naam_comp'};
	$comp2apps{$cmdb_id} = $naam;
}

# Collect Servers in Isolated Server List
$query = "SELECT cmdb_id, naam
          FROM system_cost";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect cis from system_cost table, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $cmdb_id = $$record{'cmdb_id'};
	my $naam = $$record{'naam'};
	$isolated{$cmdb_id} = $naam;
}

$log->info("Now verify each physical computer");
# Now verify each computer
while (my ($cmdb_id, $naam) = each %comp2check) {
	my $source = "";
	my $msg = "";
	if (exists $isolated{$cmdb_id}) {
		$source = "Geïsoleerde servers Rapport - Server_Migratie.xls";
	}
	if (exists $netwerk{$cmdb_id}) {
		if (length($source) > 2) {
			$msg .= " ook in $source rapport";
		}
		$source = "Netwerk Rapport - Netwerk_DC_Migratie.xls";
	}
	if (exists $comp2apps{$cmdb_id}) {
		if (length($source) > 2) {
			$msg .= " ook in $source rapport";
		}
		$source = "Applicatie Rapport - Apps_Migratie.xls (via Servers_per_Applicatie.xls)";
	}
	if (length($source) == 0) {
		$msg = "Server NIET gevonden in één van de rapporten";
	}
    my (@vals) = map { eval ("\$" . $_ ) } @fields;
    unless (create_record($dbh, "system_verification", \@fields, \@vals)) {
	    $log->fatal("Could not create record for $cmdb_id - $naam");
	    exit_application(1);
    }
}

# Export system verification to excel files
$log->info("Export system_verification to excel");
my $nr_lines = write_table($dbh, "system_verification", \@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table system_verification");
	exit_application(1);
}

# Export srv2apps table to excel files
@fields = qw (cmdb_id_comp naam_comp cmdb_id_appl naam_appl);
$log->info("Export srv2apps to excel");
$nr_lines = write_table($dbh, "srv2apps", \@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table srv2apps");
	exit_application(1);
}

exit_application(0);

=head1 To Do

=over 4

=item *

Nothing for now...

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
