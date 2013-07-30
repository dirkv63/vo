=head1 NAME

jobs_checks.pl - Consolidates the factors related to SW component migration.

=head1 VERSION HISTORY

version 1.0 25 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

There are a number of assumptions for the Installed Jobs. This script will verify the assumptions.

=head1 SYNOPSIS

 jobs_checks.pl

 jobs_checks -h	Usage
 jobs_checks -h 1  Usage and description of the options
 jobs_checks -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, $top_ci, $msg, @msgs, $computer, $cluster, $connections, %states);
my (%migratiekost, %complexiteitkost);
my @fields = qw (sw_id sw_naam sw_type sw_categorie 
                 comp_id comp_naam comp_type comp_categorie 
				 connections migratie complexiteit msgstr 
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

sub go_down($$);

=pod

=head2 Check Software Component

This procedure will check if each 'ToepassingComponentInstallatie' is implemented on one or more computer systems.

There are a small number of CIs (44) that cannot be implemented on a computer system. These are CIs that relate to a 'Toepassingomgeving', without any further configuration. These CIs are potential risks.

Every other CI is connected to one or more computersystems. If there is more than one computer system, then there is a 'Computer Cluster' or a 'Technical Platform - Cluster' in between.

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
	# Note that singleton_select assumes that only one record returns,
	# it doesn't allow error handling locally.
	my $nr_rels = @$ref;
	if ($nr_rels > 1) {
		# Found multiple afhankelijk relations
		# This can be the case for SW Product installations on Computer Cluster => OK!
		# Cluster => I will find more than one computersystem
		if ((defined $cluster) && ($cluster eq "Node")) {
			$msg = "$nr_rels in cluster";
		} else {
			$msg = "$nr_rels afhankelijk relations found while walking down";
		}
		push @msgs, $msg;
	}
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_target = $$arrayhdl{cmdb_id_target};
		my $naam_target = $$arrayhdl{naam_target};
		my $ci_type_target = $$arrayhdl{ci_type_target};
		my $ci_categorie = $$arrayhdl{ci_categorie};
		my $status = $$arrayhdl{status} || "not defined";
		$states{$status}++;
		$connections++;
		# Did I find a Fysieke or Virtuele Computer?
		if ($ci_type_target =~ m/ computer$/i) {
			if ((defined $computer) && (not(defined $cluster))) {
				$msg = "More than one computer found, no cluster defined";
				push @msgs, $msg;
			} else {
				# Be careful, I may be overwriting computers
				$computer = $cmdb_id_target;
			}
		} elsif ($ci_type_target =~ m/netwerk/i) {
			# If not, did I end up on Network component?
			$msg = "Afhankelijk relations to Network component $cmdb_id_target, missing computersystem";
			push @msgs, $msg;
		} elsif (lc($ci_type_target) eq "jobcluster install.") {
			# Job Install link to it's Ctrl-M Master Scheduler, ignore this link
		} else {
			# Target node is not a Computer or a Network component, so keep on searching
			# Maybe a cluster?
			if ((lc($ci_type_target) eq "computer cluster") ||
				(lc($ci_type_target) eq "techn. platf. - cluster")) {
				$cluster = "Node";
			} elsif (defined $cluster) {
				$cluster = "In cluster tree";
			}
			go_down($cmdb_id_target, $naam_target);
		}
	}
}

=pod

=head2 Get CI

Gets a CI ID, returns naam, type and categorie for the CI.

If CI ID is not found, or CI ID is not defined, returns an array with undefined values.

=cut

sub get_ci {
	my ($cmdb_id) = @_;
	unless (defined $cmdb_id) {
		return (undef, undef, undef);
	}
	my $query = "SELECT naam, ci_type, ci_categorie
				 FROM component
				 WHERE cmdb_id = $cmdb_id";
	my $ref = singleton_select($dbh, $query);
	unless (defined $ref) {
		return (undef, undef, undef);
	}
	my $record = @$ref[0];
	my $naam = $$record{naam};
	my $ci_type = $$record{ci_type};
	my $ci_categorie = $$record{ci_categorie};
	return ($naam, $ci_type, $ci_categorie);
}

sub save_results {
	my ($sw_id, $comp_id, $msgref) = @_;
	my ($migratie, $complexiteit, $comp_type_key);
	my ($sw_naam, $sw_type, $sw_categorie) = get_ci($sw_id);
	my ($comp_naam, $comp_type, $comp_categorie) = get_ci($comp_id);
	unless (defined $comp_id) {
		$msg = "Job not implemented on Computer";
		push @$msgref, $msg;
	}
	my $msgstr = join ("\n", @$msgref);
	# If no computer type known, assume 'FYSIEKE COMPUTER'
	if (defined $comp_type) {
		$comp_type_key = $comp_type;
	} else {
		$comp_type_key = "FYSIEKE COMPUTER";
	}
	my $kostkey = $sw_type . $sw_categorie . $comp_type_key;
	if (defined $migratiekost{$kostkey}) {
		$migratie = $migratiekost{$kostkey};
	} else {
		$log->warn("Migratiekosten voor $sw_type $sw_categorie $comp_type niet gevonden");
		$migratie = 0;
	}
	if (defined $complexiteitkost{$kostkey}) {
		$complexiteit = $complexiteitkost{$kostkey};
	} else {
		$log->warn("Complexiteitkosten voor $sw_type $sw_categorie $comp_type niet gevonden");
		$complexiteit = 0;
	}
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
	unless (create_record($dbh, "job_checks", \@fields, \@vals)) {
		$log->fatal("Could not create record for $sw_id");
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

$log->info("Preparing table job_checks");
# Drop table job_checks if exists
my $query = "DROP TABLE IF EXISTS job_checks";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table job_checks, exiting...");
	exit_application(1);
}
$query = "CREATE TABLE IF NOT EXISTS `job_checks` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `sw_id` double DEFAULT NULL,
			  `sw_naam` varchar(255) DEFAULT NULL,
			  `sw_type` varchar(255) DEFAULT NULL,
			  `sw_categorie` varchar(255) DEFAULT NULL,
			  `comp_id` double DEFAULT NULL,
			  `comp_naam` varchar(255) DEFAULT NULL,
			  `comp_type` varchar(255) DEFAULT NULL,
			  `comp_categorie` varchar(255) DEFAULT NULL,
			  `connections` int(11) DEFAULT NULL,
			  `complexiteit` double DEFAULT NULL,
			  `migratie` double DEFAULT NULL,
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
	$log->fatal("Could not create table job_checks, exiting...");
	exit_application(1);
}

# WHERE string for Software Components
my @ci_types = $cfg->val("TYPES", "job_type");
my $where_str = join (" OR ", map { "ci_type = ?" } @ci_types);

# Collect Kostelementen for Software Components
$query = "SELECT * 
		  FROM kostelementen
		  WHERE $where_str";
my $ref = do_select($dbh, $query, @ci_types);
unless (defined $ref) {
	$log->fatal("Could not collect kostelementen, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $element      = $$record{element};
	my $ci_type         = $$record{ci_type};
	my $ci_categorie    = $$record{ci_categorie};
	my $computertype = $$record{computertype};
	my $waarde       = $$record{waarde};
	my $kostkey      = $ci_type . $ci_categorie . $computertype;
	if (trim(lc($element)) eq "migratie") {
		$migratiekost{$kostkey} = $waarde;
	} elsif (trim(lc($element)) eq "complexiteit") {
		$complexiteitkost{$kostkey} = $waarde;
	} else {
		$log->warn("Element $element not known");
	}
}

$log->info("Investigating SW Components");
# Get all the SW Components
$query = "SELECT `cmdb_id`, `naam`, `ci_categorie`, `ci_type`
			 FROM component
			 WHERE ($where_str)";
$ref = do_select($dbh, $query, @ci_types);
foreach my $record (@$ref) {
	undef @msgs;
	undef $computer;
	undef $cluster;
	undef %states;
	$connections = 0;
	my $cmdb_id      = $$record{'cmdb_id'};
	my $naam         = $$record{'naam'};
	my $ci_categorie = $$record{'ci_categorie'};
	my $ci_type      = $$record{'ci_type'};
	$top_ci          = $cmdb_id;
	go_down($cmdb_id, $naam);
	save_results($top_ci, $computer, \@msgs);
}

$log->info("Export job_checks to excel");
my $nr_lines = write_table($dbh, "job_checks",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table job_checks");
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
