=head1 NAME

system_checks.pl - Checks the Computersystems.

=head1 VERSION HISTORY

version 1.1 06 August 2013 DV

=over 4

=item *

This script will collect system information and propagate attributes up the system chain, but it will not attempt to calculate migration costs. The script system_cost.pl is introduced to consolidate migration cost calculation.

=back

version 1.0 29 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

There are a number of assumptions for the Computer Systems. This script will verify and document the assumptions.

Each Computer must be connected to a Software Component. The relation between Software Components and the Applications is checked in another script.

Each Physical Computer has a location. This location is upwards propagated to all components on the path, up till Software / Job Component.

On path to (software) component, remember and propagate eosl variables. Remember the oldest date for each ID. For OS, attach OS EOSL first to it's computersystem before it can be propagated.

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
# eosl variables
my (%computer_uitdovend, %component_uitdovend, %os_uitdovend);
my (%computer_uitgedoofd, %component_uitgedoofd, %os_uitgedoofd);
my @fields = qw (cmdb_id naam ci_type ci_categorie producent product
				 locatie sw_cnt job_cnt connections msgstr
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

sub get_eosl($) {
	my ($cmdb_id) = @_;
	my $query  = "SELECT uitdovend_datum, uitgedoofd_datum
				  FROM eosl
				  WHERE cmdb_id = $cmdb_id";
	my $ref = do_select($dbh, $query);
	my $uitdovend = "";
	my $uitgedoofd = "";
	if (defined $ref) {
		my $record = @$ref[0];
		$uitdovend = $$record{uitdovend_datum} || "";
		$uitgedoofd = $$record{uitgedoofd_datum} || "";
	}
	return ($uitdovend, $uitgedoofd);
}

sub get_eosl_os {
	my $query = "SELECT r.cmdb_id_target as cmdb_id, 
						e.uitdovend_datum as uitdovend_datum, 
						e.uitgedoofd_datum as uitgedoofd_datum
				 FROM relations r, component c, eosl e
				 WHERE r.relation = 'is afhankelijk van'
				   AND r.cmdb_id_source = c.cmdb_id
				   AND c.ci_type = 'SW PROD INSTALL. OP SYST.INFRA.'
				   AND c.ci_categorie = 'OPERATING SYSTEEM'
				   AND r.cmdb_id_source = e.cmdb_id
				   AND (NOT ((e.uitdovend_datum is null) AND
							 (e.uitgedoofd_datum is null)))";
	my $ref = do_select($dbh, $query);
	unless (defined $ref) {
		$log->fatal("Could not get EOSL data for OS");
		exit_application(1);
	}
	foreach my $record (@$ref) {
		my $cmdb_id = $$record{cmdb_id};
		my $uitdovend_datum = $$record{uitdovend_datum} || "";
		my $uitgedoofd_datum = $$record{uitgedoofd_datum} || "";
		if (length($uitdovend_datum) > 4) {
			$os_uitdovend{$cmdb_id} = $uitdovend_datum;
		}
		if (length($uitgedoofd_datum) > 4) {
			$os_uitgedoofd{$cmdb_id} = $uitgedoofd_datum;
		}
	}
}

sub get_minimum($$) {
	my ($val1, $val2) = @_;
	if ((length($val1) > 4) && (defined $val2)) {
		my $int_val1 = $val1;
		my $int_val2 = $val2;
		$int_val1 =~ s/\-//g;
		$int_val2 =~ s/\-//g;
		if ($int_val1 < $int_val2) {
			return $val1;
		} else {
			return $val2;
		}
	} elsif ((length($val1) > 4) && (not(defined $val2))) {
		return $val1;
	} elsif ((not(length($val1) > 4)) && (defined $val2)) {
		return $val2;
	} elsif ((not(length($val1) > 4)) && (not(defined $val2))) {
		return "";
	}
}

=pod

=head2 Handle EOSL data

Get EOSL data for this component. 

If category = 'FYSIEKE COMPUTER' then 
verify if there is a value already
if yes, print error message.
Keep oldest date.
If type = 'SW PROD...', but not OS:
keep oldest value.
If type = 'SW PROD...' and OS
ignore
IF other type
print error message.

Be careful: keep track of values within recursive path, but do not share values between recursive paths.

=cut

sub handle_eosl_data($$$$) {
	my ($cmdb_id_prev, $cmdb_id, $ci_type, $ci_categorie) = @_;
	my $uitdovend = "";
    my $uitgedoofd= "";
	if (($ci_type eq "FYSIEKE COMPUTER") ||
		(($ci_type eq "SW PROD INSTALL. OP SYST.INFRA.") && (not($ci_categorie eq "OPERATING SYSTEEM")))) {
		($uitdovend, $uitgedoofd) = get_eosl($cmdb_id);
	}
	# Handle Fysieke Computer
	if ($ci_type eq "FYSIEKE COMPUTER") {
		my $computer_uitdovend_val = get_minimum($uitdovend, $computer_uitdovend{$cmdb_id_prev});
		my $computer_uitgedoofd_val = get_minimum($uitgedoofd, $computer_uitgedoofd{$cmdb_id_prev});
		if (length($computer_uitdovend_val) > 4) {
			$computer_uitdovend{$cmdb_id} = $computer_uitdovend_val;
		}
		if (length($computer_uitgedoofd_val) > 4) {
			$computer_uitgedoofd{$cmdb_id} = $computer_uitgedoofd_val;
		}
	}
	# Handle Component
	if (($ci_type eq "SW PROD INSTALL. OP SYST.INFRA.") && (not($ci_categorie eq "OPERATING SYSTEEM"))) {
		my $component_uitdovend_val = get_minimum($uitdovend, $component_uitdovend{$cmdb_id_prev});
		my $component_uitgedoofd_val = get_minimum($uitgedoofd, $component_uitgedoofd{$cmdb_id_prev});
		if (length($component_uitdovend_val) > 4) {
			$component_uitdovend{$cmdb_id} = $component_uitdovend_val;
		}
		if (length($component_uitgedoofd_val) > 4) {
			$component_uitgedoofd{$cmdb_id} = $component_uitgedoofd_val;
		}
	}
	# Now propagate values in all cases
	if (not(defined $computer_uitdovend{$cmdb_id})) {
		if (defined $computer_uitdovend{$cmdb_id_prev}) {
			$computer_uitdovend{$cmdb_id} = $computer_uitdovend{$cmdb_id_prev};
		}
	}
	if (not(defined $component_uitdovend{$cmdb_id})) {
		if (defined $component_uitdovend{$cmdb_id_prev}) {
			$component_uitdovend{$cmdb_id} = $component_uitdovend{$cmdb_id_prev};
		}
	}
	if (not(defined $os_uitdovend{$cmdb_id})) {
		if (defined $os_uitdovend{$cmdb_id_prev}) {
			$os_uitdovend{$cmdb_id} = $os_uitdovend{$cmdb_id_prev};
		}
	}
	if (not(defined $computer_uitgedoofd{$cmdb_id})) {
		if (defined $computer_uitgedoofd{$cmdb_id_prev}) {
			$computer_uitgedoofd{$cmdb_id} = $computer_uitgedoofd{$cmdb_id_prev};
		}
	}
	if (not(defined $component_uitgedoofd{$cmdb_id})) {
		if (defined $component_uitgedoofd{$cmdb_id_prev}) {
			$component_uitgedoofd{$cmdb_id} = $component_uitgedoofd{$cmdb_id_prev};
		}
	}
	if (not(defined $os_uitgedoofd{$cmdb_id})) {
		if (defined $os_uitgedoofd{$cmdb_id_prev}) {
			$os_uitgedoofd{$cmdb_id} = $os_uitgedoofd{$cmdb_id_prev};
		}
	}
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
		handle_eosl_data($cmdb_id, $cmdb_id_source, $ci_type_source, $ci_categorie);
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
	my ($cmdb_id, $naam, $ci_type, $ci_categorie, $locatie, $producent, $product) = @_;
	# Remove duplicates from msgs array
	my %msghash = map { $_, 1} @msgs;
	my $msgstr = join ("\n", keys %msghash);
	# Locatie is defined only for Boudewijn Computerzaal
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
			  `producent` varchar(255) DEFAULT NULL,
			  `product` varchar(255) DEFAULT NULL,
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

# Assign EOSL for OS to Computersystem
$log->info("Assign OS EOSL to computer systems");
get_eosl_os;

$log->info("Investigating Computer Systems");
# Get all the 'Fysieke' Computers
$query = "SELECT `cmdb_id`, `naam`, `ci_categorie`, `ci_type`, status, locatie,
				 product, producent
			 FROM component
			 WHERE ci_type = 'FYSIEKE COMPUTER'";
my $ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef @msgs;
	undef %states;
	$connections = 0;
	$sw_cnt = 0;
	$job_cnt = 0;
	my ($computer_uitdovend, $component_uitdovend, $os_uitdovend);
	my ($computer_uitgedoofd, $component_uitgedoofd, $os_uitgedoofd);
	my $cmdb_id      = $$record{'cmdb_id'};
	my $naam         = $$record{'naam'};
	my $ci_categorie = $$record{'ci_categorie'};
	my $ci_type      = $$record{'ci_type'};
	my $status		 = $$record{'status'} || "not defined";
	my $locatie		 = $$record{'locatie'} || "not defined";
	my $product	     = $$record{'product'};
	my $producent    = $$record{'producent'};
	if ($locatie eq "Boudewijn - Brussel/-1C Computerzaal") {
		# All CIs that are related to Boudewijn have entry in derived_locations table.
		$locations{$cmdb_id} = $locatie;
	} else {
		undef $locatie;
	}
	# Initialize EOSL data
	# Read data for Fysieke server
	# If there is data for OS, then it was initialized in sub get_eosl_os
	# There is not yet Component data.
	my ($uitdovend, $uitgedoofd) = get_eosl($cmdb_id);
	if (length($uitdovend) > 4) {
		$computer_uitdovend{$cmdb_id} = $uitdovend;
	}
	if (length($uitgedoofd) > 4) {
		$computer_uitgedoofd{$cmdb_id} = $uitgedoofd;
	}
	$states{$status}++;
	go_up($cmdb_id, $naam, $locatie);
	save_results($cmdb_id, $naam, $ci_type, $ci_categorie, $locatie, $producent, $product);
}

# Export the results to excel files
$log->info("Export system_checks to excel");
my $nr_lines = write_table($dbh, "system_checks",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines lines exported into excel file");
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

# CREATE table derived_locations
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

# Save the derived_eosl
$log->info("Write the Derived EOSL to Table");
# Drop table derived_eosl if exists
$query = "DROP TABLE IF EXISTS derived_eosl";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table derived_eosl, exiting...");
	exit_application(1);
}

# CREATE table derived_locations
$query = "CREATE TABLE IF NOT EXISTS `derived_eosl` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `label` varchar(255) default NULL,
			  `eosl_date` date DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table derived_locations, exiting...");
	exit_application(1);
}
while (my ($cmdb_id, $eosl_date) = each %computer_uitdovend) {
	my $label = "computer_uitdovend";
	my @fields = qw (cmdb_id label eosl_date);
	my @vals = ($cmdb_id, $label, $eosl_date);
	unless (create_record($dbh, "derived_eosl", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_eosl");
		exit_application(1);
	}
}
while (my ($cmdb_id, $eosl_date) = each %computer_uitgedoofd) {
	my $label = "computer_uitgedoofd";
	my @fields = qw (cmdb_id label eosl_date);
	my @vals = ($cmdb_id, $label, $eosl_date);
	unless (create_record($dbh, "derived_eosl", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_eosl");
		exit_application(1);
	}
}
while (my ($cmdb_id, $eosl_date) = each %component_uitdovend) {
	my $label = "component_uitdovend";
	my @fields = qw (cmdb_id label eosl_date);
	my @vals = ($cmdb_id, $label, $eosl_date);
	unless (create_record($dbh, "derived_eosl", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_eosl");
		exit_application(1);
	}
}
while (my ($cmdb_id, $eosl_date) = each %component_uitgedoofd) {
	my $label = "component_uitgedoofd";
	my @fields = qw (cmdb_id label eosl_date);
	my @vals = ($cmdb_id, $label, $eosl_date);
	unless (create_record($dbh, "derived_eosl", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_eosl");
		exit_application(1);
	}
}
while (my ($cmdb_id, $eosl_date) = each %os_uitdovend) {
	my $label = "os_uitdovend";
	my @fields = qw (cmdb_id label eosl_date);
	my @vals = ($cmdb_id, $label, $eosl_date);
	unless (create_record($dbh, "derived_eosl", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_eosl");
		exit_application(1);
	}
}
while (my ($cmdb_id, $eosl_date) = each %os_uitgedoofd) {
	my $label = "os_uitgedoofd";
	my @fields = qw (cmdb_id label eosl_date);
	my @vals = ($cmdb_id, $label, $eosl_date);
	unless (create_record($dbh, "derived_eosl", \@fields, \@vals)) {
		$log->fatal("Could not insert record into derived_eosl");
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
