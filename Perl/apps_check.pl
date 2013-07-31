=head1 NAME

apps_check.pl - Verification of every Application Component (Toepassingomgeving).

=head1 VERSION HISTORY

version 1.1 30 July 2013 DV

=over 4

=item *

Add Derived location information to the Application consolidated information.

=item *

Extend Perl library path to local /lib directory.

=back

version 1.0 26 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

There are a number of assumptions on the Application Component environment. This script will verify and document the assumptions.

=head1 SYNOPSIS

 apps_check.pl

 apps_check -h	Usage
 apps_check -h 1  Usage and description of the options
 apps_check -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, $top_ci, $msg, @msgs, $connections, %states);
my ($comp, $no_comp, $sw_cnt, $sw_cnt_bou, $job_cnt, $job_cnt_bou, %locations);
my ($complexiteit, $migratie);
my @fields = qw (cmdb_id naam connections comp no_comp sw_cnt sw_cnt_bou 
				 job_cnt job_cnt_bou complexiteit migratie totale_kost msgstr 
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

# sub go_down($$);

=pod

=head2 Check Application

An application is build up of components (Toepassingcomponentinstallatie) and / or Jobs. These are the building blocks of the application. For each application find the building blocks and read the component or job information from their tables. 

An application needs to be build up of its components. There should be no need for recursive traveling down the relation tree.

=cut

sub go_down($$) {
	my ($cmdb_id, $naam) = @_;
	my $query = "SELECT relation, cmdb_id_target, naam_target, ci_type_target,
						ci_categorie, status
				 FROM relations, component
				 WHERE cmdb_id_source = '$cmdb_id'
				   AND naam_source    = '$naam'
				   AND cmdb_id_target = cmdb_id
				   AND relation = 'is afhankelijk van'";
	my $ref = do_select($dbh, $query);
	# In case of an application, no need to count number of relations.
	# An application should have multiple connections.
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_target = $$arrayhdl{cmdb_id_target};
		my $naam_target = $$arrayhdl{naam_target};
		my $ci_type_target = $$arrayhdl{ci_type_target};
		my $ci_categorie = $$arrayhdl{ci_categorie};
		my $status = $$arrayhdl{status} || "not defined";
		# Handle the component. Assumption is that it should be
		# software or job component.
		handle_component($cmdb_id_target, $ci_type_target);
	}
}

sub handle_component {
	my ($cmdb_id, $ci_type) = @_;
	my $table;
	# Did I find a Software Component or Job?
	my @sw_types = $cfg->val("TYPES", "sw_type");
	my @job_types = $cfg->val("TYPES", "job_type");
	if (grep {lc($_) eq lc($ci_type)} @sw_types) {
		$table = "sw_checks";
		$sw_cnt++;
		if (defined $locations{$cmdb_id}) {
			$sw_cnt_bou++;
		}
	} elsif (grep {lc($_) eq lc($ci_type)} @job_types) {
		$table = "job_checks";
		$job_cnt++;
		if (defined $locations{$cmdb_id}) {
			$job_cnt_bou++;
		}
	} else {
		my $msg = "Unexpected Component Type $ci_type ($cmdb_id)";
		return;
	}
	my @fields = qw (comp_naam comp_type connections complexiteit migratie
					 status_not_defined status_buiten_gebruik status_in_gebruik
					 status_in_stock status_nieuw status_not_niet_in_gebruik);
	my $selectstr = join (", ", map { $_ } @fields);
	my $query = "SELECT $selectstr
				 FROM $table
				 WHERE sw_id = $cmdb_id";
	my $ref = singleton_select($dbh, $query);
	# Consolidate values for this application
	my $arrayhdl = @$ref[0];
	my $comp_name = $$arrayhdl{comp_naam};
	if (defined $comp_name) {
		$comp++;
	} else {
		$no_comp++;
	}
	$connections += $$arrayhdl{connections};
	# Remember total complexiteit kost, but use it only if at least one
	# leg of application is in Boudewijn
	$complexiteit += $$arrayhdl{complexiteit};
	# Add migratie kost only for components in Boudewijn
	if (defined $locations{$cmdb_id}) {
		$migratie += $$arrayhdl{migratie};
	}
	foreach my $status (qw(status_not_defined status_buiten_gebruik status_in_gebruik
		status_in_stock status_nieuw status_not_niet_in_gebruik)) {
		$states{$status} += $$arrayhdl{$status};
	}
}

sub save_results {
	my ($cmdb_id, $naam, $msgref) = @_;
	if ($comp == 0) {
		$msg = "Application cannot be linked to a Computer";
		push @$msgref, $msg;
	}
	my $msgstr = join ("\n", @$msgref);
	# Set migratie & complexiteit kost to 0 if not related to Boudewijn Computerzaal
	if (($sw_cnt_bou == 0) && ($job_cnt_bou == 0)) {
		$complexiteit = 0;
		$migratie = 0;
	}
	my $totale_kost = $complexiteit + $migratie;
	my @fields = qw (cmdb_id naam connections comp no_comp sw_cnt sw_cnt_bou job_cnt job_cnt_bou complexiteit migratie totale_kost msgstr);
    my (@vals) = map { eval ("\$" . $_ ) } @fields;
	# Also add status counters to fields and vals
	foreach my $status (qw(status_not_defined status_buiten_gebruik status_in_gebruik
		status_in_stock status_nieuw status_not_niet_in_gebruik)) {
		push @fields, $status;
		push @vals, $states{$status};
	}
	# $log->trace(Dumper @fields);
	# $log->trace(Dumper @vals);
	unless (create_record($dbh, "apps_checks", \@fields, \@vals)) {
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

$log->info("Preparing table apps_checks");
# Drop table apps_checks if exists
my $query = "DROP TABLE IF EXISTS apps_checks";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table apps_checks, exiting...");
	exit_application(1);
}

# CREATE table EOSL
# Table eosl_raw needs to have cmdb_id, naam, standaarddatum, uitdovend_datum, uitgedoofd_datum
# Table eosl_raw should not have ID! (otherwise each raw is unique)
$query = "CREATE TABLE IF NOT EXISTS `apps_checks` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `connections` int(11) DEFAULT NULL,
			  `comp` int(11) DEFAULT NULL,
			  `no_comp` int(11) DEFAULT NULL,
			  `sw_cnt` int(11) DEFAULT NULL,
			  `sw_cnt_bou` int(11) DEFAULT NULL,
			  `job_cnt` int(11) DEFAULT NULL,
			  `job_cnt_bou` int(11) DEFAULT NULL,
			  `complexiteit` double DEFAULT NULL,
			  `migratie` double DEFAULT NULL,
			  `totale_kost` double DEFAULT NULL,
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
	$log->fatal("Could not create table apps_checks, exiting...");
	exit_application(1);
}

$log->info("Get derived location information");
$query  = "SELECT cmdb_id, locatie
		   FROM derived_locations";
my $ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not get derived location information");
	exit_application(1);
}
foreach my $arrayhdl (@$ref) {
	my $cmdb_id = $$arrayhdl{cmdb_id};
	my $location = $$arrayhdl{locatie};
	$locations{$cmdb_id} = $location;
}

$log->info("Investigating Applications");
# Get all the SW Components
$query = "SELECT `cmdb_id`, `naam`, `ci_categorie`, `ci_type`, status
			 FROM component
			 WHERE ci_class = 'toepassingcomponentinstallatie'";
$ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef @msgs;
	undef %states;
	$comp = 0;
	$no_comp = 0;
	$connections = 0;
	$sw_cnt = 0;
	$sw_cnt_bou = 0;
	$job_cnt = 0;
	$job_cnt_bou = 0;
	$complexiteit = 0;
	$migratie = 0;
	my $cmdb_id      = $$record{'cmdb_id'};
	my $naam         = $$record{'naam'};
	my $ci_categorie = $$record{'ci_categorie'};
	my $ci_type      = $$record{'ci_type'};
	my $status		 = $$record{'status'} || "not defined";
	$states{$status}++;
	$top_ci          = $cmdb_id;
	go_down($cmdb_id, $naam);
	save_results($top_ci, $naam, \@msgs);
}

$log->info("Export apps_checks to excel");
my $nr_lines = write_table($dbh, "apps_checks",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table apps_checks");
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
