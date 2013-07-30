=head1 NAME

system_checks.pl - Checks the Computersystems.

=head1 VERSION HISTORY

version 1.0 29 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

There are a number of assumptions for the Computer Systems. This script will verify and document the assumptions.

Each Computer must be connected to a Software Component. The relation between Software Components and the Applications is checked in another script.

=head1 SYNOPSIS

 system_checks.pl

 system_checks -h	Usage
 system_checks -h 1  Usage and description of the options
 system_checks -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, @msgs, $connections, %states);
my ($sw_cnt, $job_cnt, %locations);
my @fields = qw (cmdb_id naam ci_type ci_categorie locatie 
                 sw_cnt job_cnt 
				 connections msgstr 
				 status_not_defined status_buiten_gebruik status_in_gebruik
				 status_in_stock status_nieuw status_not_niet_in_gebruik);

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
use DbUtil qw(db_connect do_select do_stmt singleton_select create_record);

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

sub go_up($$$);

=pod

=head2 Check Systems

Go UP the 'afhankelijk' chain until a CI from Component or Jobs type is found. 
Warn if 'Toepassingomgeving' if found without Component. Also inform if 'Go Up' chain stops without having found a component.

Don't go up to 'Operating Systeem' component.

=cut

sub go_up($$$) {
	my ($cmdb_id, $naam, $location_comp) = @_;
	my $query = "SELECT relation, cmdb_id_source, naam_source, ci_type_source,
						ci_categorie, status, ci_class, locatie
				 FROM relations, component
				 WHERE cmdb_id_target = '$cmdb_id'
				   AND cmdb_id_source = cmdb_id
				   AND NOT (ci_categorie = 'OPERATING SYSTEEM')
				   AND relation = 'is afhankelijk van'";
	my $ref = do_select($dbh, $query);
	# Always at least one result line expected
	my $reccnt = @$ref;
	if ($reccnt == 0) {
		my $msg = "Unexpected end of path";
		push @msgs, $msg;
	}
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_source = $$arrayhdl{cmdb_id_source};
		my $naam_source = $$arrayhdl{naam_source};
		my $ci_type_source = $$arrayhdl{ci_type_source};
		my $ci_categorie = $$arrayhdl{ci_categorie};
		my $status = $$arrayhdl{status} || "not defined";
		my $ci_class = $$arrayhdl{ci_class};
		# Update status count and number of connections
		$states{$status}++;
		$connections++;
		if (defined($location_comp)) {
			$locations{$cmdb_id_source} = $location_comp;
		}
		# Did I find a Software Component or Job?
		my @sw_types = $cfg->val("TYPES", "sw_type");
		my @job_types = $cfg->val("TYPES", "job_type");
		# First find the Software Components
		if (grep {lc($_) eq lc($ci_type_source)} @sw_types) {
			$sw_cnt++;
#			get_type($cmdb_id_target, "sw_type");
		} elsif (grep {lc($_) eq lc($ci_type_source)} @job_types) {
			$job_cnt++;
		} elsif ((defined $ci_class) && (lc($ci_class) eq "toepassingcomponentinstallatie")) {
			 # Path from Fysieke computer up to Application found without SW Component
			 my $msg = "Path from Computer to Application without SW Component";
			 push @msgs, $msg;
		} else {
			 # Check next level
			 go_up($cmdb_id_source, $naam_source, $location_comp);

		}
	}
}

sub save_results {
	my ($cmdb_id, $naam, $ci_type, $ci_categorie, $locatie) = @_;
	# Remove duplicates from msgs array
	my %msghash = map { $_, 1} @msgs;
	my $msgstr = join ("\n", keys %msghash);
	# Collect states
	my ($status_not_defined, $status_buiten_gebruik, $status_in_gebruik,
		$status_in_stock, $status_nieuw, $status_not_niet_in_gebruik);
	if (defined $states{'not defined'}) {
		$status_not_defined = $states{'not defined'};
	} else {
		$status_not_defined = 0;
	}
	if (defined $states{'Buiten gebruik'}) {
		$status_buiten_gebruik = $states{'Buiten gebruik'};
	} else {
		$status_buiten_gebruik = 0;
	}
	if (defined $states{'In gebruik'}) {
		$status_in_gebruik = $states{'In gebruik'};
	} else {
		$status_in_gebruik = 0;
	}
	if (defined $states{'In stock bij klant'}) {
		$status_in_stock = $states{'In stock bij klant'};
	} else {
		$status_in_stock = 0;
	}
	if (defined $states{'Nieuw'}) {
		$status_nieuw = $states{'Nieuw'};
	} else {
		$status_nieuw = 0;
	}
	if (defined $states{'Nog niet in gebruik'}) {
		$status_not_niet_in_gebruik = $states{'Nog niet in gebruik'};
	} else {
		$status_not_niet_in_gebruik = 0;
	}
	my (@vals) = map { eval ("\$" . $_ ) } @fields;
	unless (create_record($dbh, "system_checks", \@fields, \@vals)) {
		$log->fatal("Could not create record for $cmdb_id");
		exit_application(1);
	}
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

$log->info("Preparing table system_checks");
# Drop table system_checks if exists
my $query = "DROP TABLE IF EXISTS system_checks";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table system_checks, exiting...");
	exit_application(1);
}

# CREATE table system_checks
$query = "CREATE TABLE IF NOT EXISTS `system_checks` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `ci_type` varchar(255) DEFAULT NULL,
			  `ci_categorie` varchar(255) DEFAULT NULL,
			  `locatie` varchar(255) DEFAULT NULL,
			  `sw_cnt` double DEFAULT NULL,
			  `job_cnt` double DEFAULT NULL,
			  `connections` double DEFAULT NULL,
			  `msgstr` text,
			  `status_not_defined` int(11) DEFAULT NULL,
			  `status_buiten_gebruik` int(11) DEFAULT NULL,
			  `status_in_gebruik` int(11) DEFAULT NULL,
			  `status_in_stock` int(11) DEFAULT NULL,
			  `status_nieuw` int(11) DEFAULT NULL,
			  `status_not_niet_in_gebruik` int(11) DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table system_checks, exiting...");
	exit_application(1);
}

$log->info("Investigating Computer Systems");
# Get all the 'Fysieke' Computers
$query = "SELECT `cmdb_id`, `naam`, `ci_categorie`, `ci_type`, status, locatie
			 FROM component
			 WHERE ci_type = 'FYSIEKE COMPUTER'";
my $ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef @msgs;
	undef %states;
	$connections = 0;
	$sw_cnt = 0;
	$job_cnt = 0;
	my $cmdb_id      = $$record{'cmdb_id'};
	my $naam         = $$record{'naam'};
	my $ci_categorie = $$record{'ci_categorie'};
	my $ci_type      = $$record{'ci_type'};
	my $status		 = $$record{'status'} || "not defined";
	my $locatie		 = $$record{'locatie'} || "not defined";
	if ($locatie eq "Boudewijn - Brussel/-1C Computerzaal") {
		# All CIs that are related to Boudewijn have entry in derived_locations table.
		$locations{$cmdb_id_source} = $location_comp;
	} else {
		undef $locatie;
	}
	$states{$status}++;
	go_up($cmdb_id, $naam, $locatie);
	save_results($cmdb_id, $naam, $ci_type, $ci_categorie, $locatie);
}

# Export the results to excel files
$log->info("Export system_checks to excel");
my $nr_lines = write_table($dbh, "system_checks",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table system_checks");
	exit_application(1);
}

# Save the locations
$log->info("Write the Derived Locations to Table");
# Drop table system_checks if exists
$query = "DROP TABLE IF EXISTS derived_locations";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table derived_locations, exiting...");
	exit_application(1);
}

# CREATE table system_checks
$query = "CREATE TABLE IF NOT EXISTS `derived_locations` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `locatie` varchar(255) DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table derived_locations, exiting...");
	exit_application(1);
}
while (my ($cmdb_id, $locatie) = each %locations) {
	my @fields = qw (cmdb_id locatie);
	my @vals = ($cmdb_id, $locatie);
	unless (create_record($dbh, "derived_locations", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_locations");
		exit_application(1);
	}
}

exit_application(0);

=head1 To Do

=over 4

=item *

Nothing for now...

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
