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
my ($assessment, $migratie, %eosl, %appl_eosl);
my ($uitdovend_date, $uitdovend_waarde, $uitgedoofd_date, $uitgedoofd_waarde);
my ($mgmt_waarde, $arch_waarde, $def_waarde);
my @eosl_labels = qw (computer_uitdovend computer_uitgedoofd
					  os_uitdovend os_uitgedoofd
					  component_uitdovend component_uitgedoofd);
my @fields = qw (cmdb_id naam dienstentype eigenaar_beleidsdomein 
		         eigenaar_entiteit fin_beleidsdomein fin_entiteit
				 connections comp no_comp sw_cnt sw_cnt_bou 
				 assessment migratie eosl_kost project_kost totale_kost 
				 so_toepassingsmanager vo_applicatiebeheerder msgstr 
				 computer_uitdovend computer_uitgedoofd
				 os_uitdovend os_uitgedoofd
				 component_uitdovend component_uitgedoofd
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

Add potential migration and complexity costs for the application. For each component that is in Boudewijn, add the migration cost. If at least one component in Boudewijn is found, add sum of all complexity costs.

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
	my @fields = qw (comp_naam comp_type connections assessment migratie
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
	# Remember total assessment kost, but use it only if at least one
	# leg of application is in Boudewijn
	$assessment += $$arrayhdl{assessment};
	# Add migratie kost only for components in Boudewijn
	if (defined $locations{$cmdb_id}) {
		$migratie += $$arrayhdl{migratie};
	}
	foreach my $status (qw(status_not_defined status_buiten_gebruik status_in_gebruik
		status_in_stock status_nieuw status_not_niet_in_gebruik)) {
		$states{$status} += $$arrayhdl{$status};
	}
	handle_eosl($cmdb_id);
}

sub handle_eosl($) {
	my ($cmdb_id) = @_;
	foreach my $label (@eosl_labels) {
		my $key = $cmdb_id . $label;
		if (defined $eosl{$key}) {
			if (defined $appl_eosl{$label}) {
				my $val1 = $eosl{$key};
				my $val2 = $appl_eosl{$label};
				my $intval1 = $val1;
				my $intval2 = $val2;
				$intval1 =~ s/\-//g;
				$intval2 =~ s/\-//g;
				if ($intval1 < $intval2) {
					$appl_eosl{$label} = $val1;
				}
			} else {
				$appl_eosl{$label} = $eosl{$key};
			}
		}
	}
}

sub get_mgmt($) {
	my ($cmdb_id) = @_;
	my $so_toepassingsmanager = "";
	my $vo_applicatiebeheerder = "";
	my $query = "SELECT so_toepassingsmanager, vo_applicatiebeheerder
		         FROM relations, component
				 WHERE relation = 'heeft component'
				   AND cmdb_id_target = $cmdb_id
				   AND cmdb_id_source = cmdb_id";
	my $ref = do_select($dbh, $query);
	if (defined $ref) {
		my $record = @$ref[0];
		$so_toepassingsmanager = $$record{so_toepassingsmanager};
		$vo_applicatiebeheerder = $$record{vo_applicatiebeheerder};
	} else {
		$log->error("Could not find Bedrijfstoepassing for Application ID $cmdb_id");
	}
	return ($so_toepassingsmanager, $vo_applicatiebeheerder);
}

sub get_eosl_factor() {
	my $eosl_factor;
	foreach my $label (@eosl_labels) {
		if (defined $appl_eosl{$label}) {
			if (index($label, "uitdovend") > -1) {
				if ((defined $uitdovend_date) && (defined $uitdovend_waarde)) {
					$eosl_factor = get_max_eosl($uitdovend_date, $uitdovend_waarde, $appl_eosl{$label}, $eosl_factor);
				}
			} elsif (index($label, "uitgedoofd") > -1) {
				if ((defined $uitgedoofd_date) && (defined $uitgedoofd_waarde)) {
					$eosl_factor = get_max_eosl($uitgedoofd_date, $uitgedoofd_waarde, $appl_eosl{$label}, $eosl_factor);
				}
			} else {
				$log->warn("Found label $label in eosl_labels array, don't know what to do with it");
			}
		}
	}
	if (not defined $eosl_factor) {
		$eosl_factor = 0;
	}
	return $eosl_factor;
}

sub get_max_eosl($$$$) {
	my ($cut_date, $cut_waarde, $appl_date, $eosl_factor) = @_;
	my $val1 = $cut_date;
	my $val2 = $appl_date;
	my $int_cut_date = $cut_date;
	my $int_appl_date = $appl_date;
	$int_cut_date =~ s/\-//g;
	$int_appl_date =~ s/\-//g;
	if ($int_cut_date > $int_appl_date) {
		# OK, found and application date within range for cutoff
		# Remember value, unless I got an larger value already.
		if (defined $eosl_factor) {
			if ($eosl_factor < $cut_waarde) {
				$eosl_factor = $cut_waarde;
			}
		} else {
			$eosl_factor = $cut_waarde;
		}
	}
	if (not defined $eosl_factor) {
		$eosl_factor = 0;
	}
	return $eosl_factor;
}

sub save_results {
	my ($cmdb_id, $naam, $dienstentype, $eigenaar_beleidsdomein, 
        $eigenaar_entiteit, $fin_beleidsdomein, $fin_entiteit, $msgref) = @_;
	if ($comp == 0) {
		$msg = "Application cannot be linked to a Computer";
		push @$msgref, $msg;
	}
	my $msgstr = join ("\n", @$msgref);
	# Set migratie & assessment kost to 0 if not related to Boudewijn Computerzaal
#	if (($sw_cnt_bou == 0) && ($job_cnt_bou == 0)) {
	if ($sw_cnt_bou == 0) {
		$assessment = 0;
		$migratie = 0;
	}
	# If location is Boudewijn and no cost was found (so only Jobs on this application),
	# add default cost
	if (($job_cnt_bou > 0) && (($assessment + $migratie) == 0)) {
		$assessment = $def_waarde;
		$migratie = $def_waarde;
	}
	# Get EOSL cost
	my $eosl_factor = get_eosl_factor;
	my $eosl_kost = $assessment * $eosl_factor;
	my $work_kost = $assessment + $migratie + $eosl_kost;
	my $project_kost = ($work_kost * $mgmt_waarde) + ($work_kost * $arch_waarde);
	my $totale_kost = $assessment + $migratie + $eosl_kost + $project_kost;
	# Kost reformatting
	$project_kost = sprintf("%.2f", $project_kost);
	$totale_kost  = sprintf("%.2f", $totale_kost);
	my ($so_toepassingsmanager, $vo_applicatiebeheerder) = get_mgmt($cmdb_id);
	my @fields = qw (cmdb_id naam dienstentype eigenaar_beleidsdomein 
		         eigenaar_entiteit fin_beleidsdomein fin_entiteit
				 connections comp no_comp sw_cnt sw_cnt_bou job_cnt 
				 job_cnt_bou assessment migratie eosl_kost project_kost totale_kost 
				 so_toepassingsmanager vo_applicatiebeheerder msgstr);
    my (@vals) = map { eval ("\$" . $_ ) } @fields;
	# Also add status counters to fields and vals
	foreach my $status (qw(status_not_defined status_buiten_gebruik status_in_gebruik
		status_in_stock status_nieuw status_not_niet_in_gebruik)) {
		push @fields, $status;
		push @vals, $states{$status};
	}
	# And add EOSL information
	foreach my $label (@eosl_labels) {
		push @fields, $label;
		if (defined $appl_eosl{$label}) {
			push @vals, $appl_eosl{$label};
		} else {
			push @vals, undef;
		}
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
			  `dienstentype` varchar(255) DEFAULT NULL,
			  `eigenaar_beleidsdomein` varchar(255) DEFAULT NULL,
			  `eigenaar_entiteit` varchar(255) DEFAULT NULL,
			  `fin_beleidsdomein` varchar(255) DEFAULT NULL,
			  `fin_entiteit` varchar(255) DEFAULT NULL,
			  `so_toepassingsmanager` varchar(255) DEFAULT NULL,
			  `vo_applicatiebeheerder` varchar(255) DEFAULT NULL,
			  `assessment` double DEFAULT NULL,
			  `migratie` double DEFAULT NULL,
			  `eosl_kost` double DEFAULT NULL,
			  `project_kost` double DEFAULT NULL,
			  `totale_kost` double DEFAULT NULL,
			  `msgstr` text,
			  `computer_uitdovend` date DEFAULT NULL,
			  `computer_uitgedoofd` date DEFAULT NULL,
			  `component_uitdovend` date DEFAULT NULL,
			  `component_uitgedoofd` date DEFAULT NULL,
			  `os_uitdovend` date DEFAULT NULL,
			  `os_uitgedoofd` date DEFAULT NULL,
			  `connections` int(11) DEFAULT NULL,
			  `comp` int(11) DEFAULT NULL,
			  `no_comp` int(11) DEFAULT NULL,
			  `sw_cnt` int(11) DEFAULT NULL,
			  `sw_cnt_bou` int(11) DEFAULT NULL,
			  `job_cnt` int(11) DEFAULT NULL,
			  `job_cnt_bou` int(11) DEFAULT NULL,
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

$log->info("Get derived EOSL information");
$query = "SELECT *
		  FROM derived_eosl";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not get derived eosl information");
	exit_application(1);
}
foreach my $arrayhdl (@$ref) {
	my $cmdb_id = $$arrayhdl{cmdb_id};
	my $label = $$arrayhdl{label};
	my $eosl_date = $$arrayhdl{eosl_date};
	my $key = $cmdb_id . $label;
	$eosl{$key} = $eosl_date;
}

# Collect Kostelementen for EOSL
$query = "SELECT element, functie, datum, waarde 
		  FROM kostelementen
		  WHERE ((element = 'uitdovend') 
		         OR (element = 'uitgedoofd')
				 OR (element = 'project'))";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect kostelementen, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $element = $$record{element};
	my $functie = $$record{functie};
	my $date	= $$record{datum};
	my $waarde  = $$record{waarde};
	if (trim(lc($element)) eq "uitdovend") {
		$uitdovend_date = $date;
		$uitdovend_waarde = $waarde;
	} elsif (trim(lc($element)) eq "uitgedoofd") {
		$uitgedoofd_date = $date;
		$uitgedoofd_waarde = $waarde;
	} elsif (trim(lc($element)) eq "project") {
		if (trim(lc($functie)) eq "management") {
			$mgmt_waarde = $waarde;
		} elsif (trim(lc($functie)) eq "architectuur") {
			$arch_waarde = $waarde;
		} elsif (trim(lc($functie)) eq "default") {
			$def_waarde = $waarde;
		} else {
			$log->error("Found unknown project cost for $functie ($waarde)");
		}
	} else {
		$log->warn("Element $element not known");
	}
}

$log->info("Investigating Applications");
# Get all the SW Components
$query = "SELECT *
			 FROM component
			 WHERE ci_class = 'toepassingcomponentinstallatie'";
$ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef @msgs;
	undef %states;
	undef %appl_eosl;
	$comp = 0;
	$no_comp = 0;
	$connections = 0;
	$sw_cnt = 0;
	$sw_cnt_bou = 0;
	$job_cnt = 0;
	$job_cnt_bou = 0;
	$assessment = 0;
	$migratie = 0;
	my $cmdb_id      = $$record{'cmdb_id'};
	my $naam         = $$record{'naam'};
	my $ci_categorie = $$record{'ci_categorie'};
	my $ci_type      = $$record{'ci_type'};
	my $status		 = $$record{'status'} || "not defined";
	my $dienstentype = $$record{'dienstentype'};
	my $eigenaar_beleidsdomein = $$record{'eigenaar_beleidsdomein'};
	my $eigenaar_entiteit = $$record{'eigenaar_entiteit'};
	my $fin_beleidsdomein = $$record{'fin_beleidsdomein'};
	my $fin_entiteit = $$record{'fin_entiteit'};
	$states{$status}++;
	$top_ci          = $cmdb_id;
	go_down($cmdb_id, $naam);
	save_results($top_ci, $naam, $dienstentype, $eigenaar_beleidsdomein, 
		         $eigenaar_entiteit, $fin_beleidsdomein, $fin_entiteit, \@msgs);
}

$log->info("Export apps_checks to excel");
my $nr_lines = write_table($dbh, "apps_checks",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table apps_checks");
	exit_application(1);
}

# Now get excel with Applications to be migrated only
$query = "CREATE TEMPORARY TABLE apps_migrate
		  SELECT * FROM apps_checks
		  WHERE totale_kost > 0";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create migration report");
	exit_application(1);
}

$log->info("Export apps_migrate to excel");
$nr_lines = write_table($dbh, "apps_migrate",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table apps_migrate");
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
