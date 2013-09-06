=head1 NAME

system_cost.pl - Checks the Computersystems.

=head1 VERSION HISTORY

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

 system_cost.pl

 system_cost -h	Usage
 system_cost -h 1  Usage and description of the options
 system_cost -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, @fields, @vals, %kost, @functies, $mgmt_waarde, $arch_waarde, %uitdovend_hash, %uitgedoofd_hash);
my ($uitdovend_date, $uitdovend_waarde, $uitgedoofd_date, $uitgedoofd_waarde);
my @fields_check = qw (cmdb_id naam ci_type ci_categorie locatie connections 
				       status_not_defined status_buiten_gebruik status_in_gebruik
				       status_in_stock status_nieuw status_not_niet_in_gebruik);
my @fields_excel = qw (cmdb_id naam financieel_beheerder eigenaar status
					   dienstentype omgeving functionele_naam kenmerk
					   migratie eosl_kost project_kost totale_kost uitdovend_datum 
					   uitgedoofd_datum connections ci_type ci_categorie locatie);

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

sub get_cost($) {
	my ($kenmerk) = @_;
	my $cost = 0;
	my @chars = split /;/, $kenmerk;
	foreach my $label (@chars) {
		$label = lc(trim($label));
		if (defined $kost{$label}) {
			$cost += $kost{$label};
		}
	}
	return $cost;
}

sub get_eosl_factor($$) {
	my ($uitdovend, $uitgedoofd) = @_;
	my $eosl_factor;
	if ((defined $uitdovend) && (length($uitdovend) > 2)) {
		if ((defined $uitdovend_date) && (defined $uitdovend_waarde)) {
			$eosl_factor = get_max_eosl($uitdovend_date, $uitdovend_waarde, $uitdovend, $eosl_factor);
		}
	}
	if ((defined $uitgedoofd) && (length($uitgedoofd) > 2)) {
		if ((defined $uitgedoofd_date) && (defined $uitgedoofd_waarde)) {
			$eosl_factor = get_max_eosl($uitgedoofd_date, $uitgedoofd_waarde, $uitgedoofd, $eosl_factor);
		}
	}
	if (not defined $eosl_factor) {
		$eosl_factor = 0;
	}
	return $eosl_factor;
}

sub get_attribs($$$) {
	my ($cmdb_id, $sys_uitdovend, $sys_uitgedoofd) = @_;
	my @attribs = qw (dienstentype omgeving kenmerk financieel_beheerder eigenaar);
	my $query = "SELECT a.dienstentype, a.omgeving, 
						a.financieel_beheerder, a.eigenaar,
						b.kenmerk 
				 FROM cmwsi0514 a, cmwsi0006 b
				 WHERE a.cmdb_id = $cmdb_id
				   AND b.cmdb_id = $cmdb_id";
	my $ref = do_select($dbh, $query);
	unless (defined $ref) {
		$log->error("Could not get results from querying cmwsi0006 and cmwsi0514");
		return;
	}
	my $record = @$ref[0];
	foreach my $field (@attribs) {
		push @fields, $field;
		push @vals, $$record{$field};
	}
	my $migratie = 0;
	if (defined $$record{kenmerk}) {
		$migratie = get_cost($$record{kenmerk});
	}
	if ($migratie == 0) {
		$migratie = $kost{default};
	}
	if (defined $$record{omgeving}) {
		my $omgeving = $$record{omgeving};
		if (($omgeving eq "Test") || ($omgeving eq "Ontwikkeling")) {
			$migratie = $migratie / 3;
		}
	}
	my $eosl_factor = get_eosl_factor($sys_uitdovend, $sys_uitgedoofd);
	my $eosl_kost = $migratie * $eosl_factor;
	my $project_kost = ($migratie * $mgmt_waarde) + ($migratie * $arch_waarde);
	my $totale_kost = $migratie + $eosl_kost + $project_kost;
	my @labels = qw(migratie eosl_kost project_kost totale_kost);
	foreach my $label (@labels) {
		push @fields, $label;
		push @vals, sprintf("%.2f", map { eval ("\$" . $_ ) } $label);
	}
	return;
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

$log->info("Preparing table system_cost");
# Drop table system_cost if exists
my $query = "DROP TABLE IF EXISTS system_cost";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table system_cost, exiting...");
	exit_application(1);
}

# CREATE table system_cost
$query = "CREATE TABLE IF NOT EXISTS `system_cost` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `ci_type` varchar(255) DEFAULT NULL,
			  `ci_categorie` varchar(255) DEFAULT NULL,
			  `locatie` varchar(255) DEFAULT NULL,
			  `status` varchar(255) DEFAULT NULL,
			  `connections` double DEFAULT NULL,
			  `migratie` double DEFAULT NULL,
			  `eosl_kost` double DEFAULT NULL,
			  `project_kost` double DEFAULT NULL,
			  `totale_kost` double DEFAULT NULL,
			  `omgeving` varchar(255) DEFAULT NULL,
			  `dienstentype` varchar(255) DEFAULT NULL,
			  `kenmerk` varchar(255) DEFAULT NULL,
			  `uitdovend_datum` date DEFAULT NULL,
			  `uitgedoofd_datum` date DEFAULT NULL,
			  `functionele_naam` varchar(255) DEFAULT NULL,
			  `financieel_beheerder` varchar(255) DEFAULT NULL,
			  `eigenaar` varchar(255) DEFAULT NULL,
			  `status_not_defined` int(11) DEFAULT NULL,
			  `status_buiten_gebruik` int(11) DEFAULT NULL,
			  `status_in_gebruik` int(11) DEFAULT NULL,
			  `status_in_stock` int(11) DEFAULT NULL,
			  `status_nieuw` int(11) DEFAULT NULL,
			  `status_not_niet_in_gebruik` int(11) DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table system_cost, exiting...");
	exit_application(1);
}

# Collect Kostelementen for Servers
$query = "SELECT functie, waarde 
		  FROM kostelementen
		  WHERE element = 'Server'";
my $ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect kostelementen, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $functie = lc(trim($$record{functie}));
	my $waarde = $$record{waarde};
	$kost{$functie} = $waarde;
	push @functies, $functie;
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
		} else {
			$log->error("Found unknown project cost for $functie ($waarde)");
		}
	} else {
		$log->warn("Element $element not known");
	}
}

# Collect EOSL information
$query = "SELECT * FROM rls0004";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	$log->fatal("Could not collect EOSL data for servers, exiting...");
	exit_application(1);
}
foreach my $record (@$ref) {
	my $producent = $$record{producent};
	my $product   = $$record{product};
	my $uitdovend = $$record{uitdovend_datum} || "";
	my $uitgedoofd = $$record{uitgedoofd_datum} || "";
	my $key = $producent . $product;
	$uitdovend_hash{$key} = $uitdovend;
	$uitgedoofd_hash{$key} = $uitgedoofd;
}

$log->info("Investigating Computer Systems in scope for Migration");
# Get all the 'Fysieke' Computers
$query = "SELECT * FROM system_checks
		  WHERE length(locatie) > 5
		    AND sw_cnt  = 0
			AND job_cnt = 0";
$ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef @fields;
	undef @vals;
	my $cmdb_id      = $$record{'cmdb_id'};
	my $full_name    = $$record{'naam'};
	foreach my $field (@fields_check) {
		my $val = $$record{$field};
		push @fields, $field;
		push @vals, $val;
	}
	my $producent = $$record{producent};
	my $product   = $$record{product};
	my $key = $producent . $product;
	if ((defined($uitdovend_hash{$key}) && length($uitdovend_hash{$key}) > 5)) {
		push @fields, "uitdovend_datum";
		push @vals, $uitdovend_hash{$key};
	}
	if ((defined $uitgedoofd_hash{$key}) && (length($uitgedoofd_hash{$key}) > 5)) {
		push @fields, "uitgedoofd_datum";
		push @vals, $uitgedoofd_hash{$key};
	}
	my $status = $$record{'status'};
	push @fields, "status";
	push @vals, $status;
	# Get admin data
	get_attribs($cmdb_id, $uitdovend_hash{$key}, $uitgedoofd_hash{$key});
	# Get functionele_naam
	if (index($full_name, "(") > -1) {
		# OK - Extract part between brackets as functionele_naam
		my $functionele_naam = trim(substr($full_name, index($full_name, "(")+1));
		$functionele_naam = substr($functionele_naam, 0, -1);
		push @fields, "functionele_naam";
		push @vals, $functionele_naam;
	}
	unless (create_record($dbh, "system_cost", \@fields, \@vals)) {
		$log->fatal("Could not create record for $cmdb_id");
		exit_application(1);
	}
}

# Export the results to excel files
$log->info("Export system_cost to excel");
my $nr_lines = write_table($dbh, "system_cost",\@fields_excel);
if (defined $nr_lines) {
	$log->info("$nr_lines lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table system_cost");
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
