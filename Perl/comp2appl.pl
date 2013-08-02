=head1 NAME

comp2appl.pl - Verification of the Component to Application relations.

=head1 VERSION HISTORY

version 1.0 01 August 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

For all software components, try to find a link to the application. Links to multiple applications is allowed.

=head1 SYNOPSIS

 comp2appl.pl

 comp2appl -h	Usage
 comp2appl -h 1  Usage and description of the options
 comp2appl -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, @msgs, $connections);
my @fields = qw (cmdb_id naam ci_type ci_categorie connections msgstr);

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
use IniUtil qw(load_ini);
use XlsWrite qw(write_table);

use Data::Dumper;

################
# Trace Warnings
################

# use Carp;
# $SIG{__WARN__} = sub { Carp::confess( @_ ) };

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

sub go_up($);

sub go_up($) {
	my ($cmdb_id) = @_;
	my $query = "SELECT relation, cmdb_id_source, naam_source, ci_type_source,
						ci_categorie, status
				 FROM relations, component
				 WHERE cmdb_id_target = '$cmdb_id'
				   AND cmdb_id_source = cmdb_id
				   AND relation = 'is afhankelijk van'";
	my $ref = do_select($dbh, $query);
	# Assumption is that component links to Application.
	# Remember if not, make a note.
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_source = $$arrayhdl{cmdb_id_source};
		my $naam_source = $$arrayhdl{naam_source};
		my $ci_type_source = $$arrayhdl{ci_type_source};
		my $ci_categorie = $$arrayhdl{ci_categorie};
		my $status = $$arrayhdl{status} || "not defined";
		$connections++;
		# Is this toepassingcomponentinstallatie as expected?
		if ($ci_type_source =~ m/^toepassingomgeving$/i) {
			my $msg = "OK, found application";
			push @msgs, $msg;
		} else {
			my $msg = "Unexpected type $ci_type_source found";
			push @msgs, $msg;
			go_up($cmdb_id_source);
		}
	}
}

sub save_results {
	my ($cmdb_id, , $naam, $ci_type, $ci_categorie) = @_;
	my $msgstr = join ("\n", @msgs);
	my (@vals) = map { eval ("\$" . $_ ) } @fields;
	unless (create_record($dbh, "comp_apps", \@fields, \@vals)) {
		$log->fatal("Could not create record for $cmdb_id");
		exit_application(1);
	}
}

######
# Main
######

# Handle input values
my %options;
getopts("h:", \%options) or pod2usage(-verbose => 0);
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

$log->info("Preparing table comp_apps");
# Drop table comp_apps if exists
my $query = "DROP TABLE IF EXISTS comp_apps";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table comp_apps, exiting...");
	exit_application(1);
}

# CREATE table EOSL
# Table eosl_raw needs to have cmdb_id, naam, standaarddatum, uitdovend_datum, uitgedoofd_datum
# Table eosl_raw should not have ID! (otherwise each raw is unique)
$query = "CREATE TABLE IF NOT EXISTS `comp_apps` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `ci_type` varchar(255) DEFAULT NULL,
			  `ci_categorie` varchar(255) DEFAULT NULL,
			  `connections` int(11) default null,
			  `msgstr` text,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table comp_apps, exiting...");
	exit_application(1);
}

# Find components without link to computer
$log->info("Collect components without link to computer");
$query = "SELECT sw_id, sw_naam, sw_type, sw_categorie
		  FROM sw_checks";
my $ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect components, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	$connections = 0;
	undef @msgs;
	my $cmdb_id = $$record{sw_id};
	my $naam = $$record{sw_naam};
	my $ci_type = $$record{sw_type};
	my $ci_categorie = $$record{sw_categorie};
	go_up($cmdb_id);
	save_results($cmdb_id, $naam, $ci_type, $ci_categorie);
}

$log->info("Export sw_checks to excel");
my $nr_lines = write_table($dbh, "comp_apps",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table sw_checks");
	exit_application(1);
}

exit_application(0);

=head1 To Do

=over 4

=item *

Check for CMDB ID 60833. Double 'maakt gebruik van' relation??

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
