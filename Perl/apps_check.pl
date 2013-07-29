=head1 NAME

apps_check.pl - Verification of every Application Component (Toepassingomgeving).

=head1 VERSION HISTORY

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

my ($log, $dbh, $top_ci, $msg, @msgs, $connections, %states);
my ($comp, $no_comp, $sw_cnt, $job_cnt);
my @sw_types = ("ANDERE TOEP.COMP.INSTALL.",
	            "DB TOEP.COMP-INSTALL.",
				"RAPPORTEN",
				"TOEP.COMP. COLLAB. SYST.",
				"WEB TOEP.COMP-INSTALL.");
my @job_types = ("JOB INSTALL. (ANDERE)",
				"JOB INSTALL. (CRON)",
				"JOB INSTALL. (CTRL-M)",
				"JOB INSTALL. (WIN)",
				"JOBCLUSTER INSTALL.");
my @fields = qw (cmdb_id naam connections comp no_comp sw_cnt job_cnt msgstr 
				 status_not_defined status_buiten_gebruik status_in_gebruik
				 status_in_stock status_nieuw status_not_niet_in_gebruik);

#####
# use
#####

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
		# Verify if this is a software component or a job.
		if (grep {lc($_) eq lc($ci_type_target)} @sw_types) {
			$sw_cnt++;
			get_type($cmdb_id_target, "sw_type");
		} elsif (grep {lc($_) eq lc($ci_type_target)} @job_types) {
			$job_cnt++;
			get_type($cmdb_id_target, "job_type");
		} else {
			my $msg = "Unexpected Component Type $ci_type_target for application $cmdb_id";
			push @msgs, $msg;
#			$log->error($msg);
		}
	}
}

sub get_type {
	my ($sw_id, $sw_type) = @_;
	my $table;
	if ($sw_type eq "sw_type") {
		$table = "sw_checks";
	} elsif ($sw_type eq "job_type") {
		$table = "job_checks";
	} else  {
		$log->error("SW Type $sw_type unknown (should be sw_type or job_type)");
		return;
	}
	my @fields = qw (comp_naam comp_type connections
					 status_not_defined status_buiten_gebruik status_in_gebruik
					 status_in_stock status_nieuw status_not_niet_in_gebruik);
	my $selectstr = join (", ", map { $_ } @fields);
	my $query = "SELECT $selectstr
				 FROM $table
				 WHERE sw_id = $sw_id";
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
	my @fields = qw (cmdb_id naam connections comp no_comp sw_cnt job_cnt msgstr);
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
my $cfg = load_ini($ini);
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
			  `job_cnt` int(11) DEFAULT NULL,
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

$log->info("Investigating Applications");
# Get all the SW Components
$query = "SELECT `cmdb_id`, `naam`, `ci_categorie`, `ci_type`, status
			 FROM component
			 WHERE ci_class = 'toepassingcomponentinstallatie'";
my $ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef @msgs;
	undef %states;
	$comp = 0;
	$no_comp = 0;
	$connections = 0;
	$sw_cnt = 0;
	$job_cnt = 0;
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
