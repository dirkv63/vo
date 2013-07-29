=head1 NAME

get_data_cmwbt0011 - This file handles the data from report CMWBT0011_OR_Inventaris HW-SW configuratie per toepassingscomponent.

=head1 VERSION HISTORY

version 1.0 29 May 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will convert CMWBT0011_OR_Inventaris HW-SW configuratie per toepassingscomponent into unique components.

=head1 SYNOPSIS

 get_data_cmwbt0011.pl 

 get_data_cmwbt0011 -h	Usage
 get_data_cmwbt0011 -h 1  Usage and description of the options
 get_data_cmwbt0011 -h 2  All documentation

=head1 OPTIONS

=over 4

Options are read from properties\vo.ini file.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh);

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

use Log::Log4perl qw(get_logger);
use SimpleLog qw(setup_logging);
use IniUtil qw(load_ini get_ini);

use DbUtil qw(db_connect do_select do_stmt create_record);

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

sub handle_toepassingomgeving($) {
	my ($tpo_arrayref) = @_;
	foreach my $tpo_arr (@$tpo_arrayref) {
		my $ci_class = "toepassingcomponentinstallatie";
		my $naam = $$tpo_arr{Toepassingomgeving};
		my $status = $$tpo_arr{'Status toepassingomgeving'};
		my $cmdb_id = $$tpo_arr{'CMDB referentie omgeving'};
		my $versie = $$tpo_arr{'Versie'};
		my $omgeving = $$tpo_arr{'Type omgeving'};
		my $datum_in_gebruik = $$tpo_arr{'Datum in gebruik'};
		my $datum_buiten_gebruik = $$tpo_arr{'Datum buiten gebruik'};
		my @fields = qw (ci_class naam status cmdb_id versie omgeving datum_in_gebruik datum_buiten_gebruik);
		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		unless (create_record($dbh, "component", \@fields, \@vals)) {
			$log->fatal("Could not create record for $ci_class $cmdb_id");
			exit_application(1);
		}
	}
}

sub handle_bedrijfstoepassing($) {
	my ($bd_arrayref) = @_;
	foreach my $bd_array (@$bd_arrayref) {
		my $ci_class = "bedrijfstoepassing";
		my $cmdb_id = $$bd_array{'CMDB referentie bedrijfstoepassing'} || "";
		my $naam = $$bd_array{'Naam bedrijfstoepassing'} || "";
		my $bt_nummer = $$bd_array{'Nummer bedrijfstoepassing'} || "";
		# Now make CMDB ID unique
		$cmdb_id = $cmdb_id + 1000000;
		my @fields = qw (ci_class cmdb_id naam bt_nummer);
		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		unless (create_record($dbh, "component", \@fields, \@vals)) {
			$log->fatal("Could not create record for $ci_class $cmdb_id");
			exit_application(1);
		}
	}
}

sub handle_component($) {
	my ($comp_arrayref) = @_;
	foreach my $comp_array (@$comp_arrayref) {
		my $ci_categorie = $$comp_array{'CI categorie'} || "";
		my $ci_type = $$comp_array{'CI type'} || "";
		my $cmdb_id = $$comp_array{'CI CMDB referentie'} || "";
		my $naam = $$comp_array{'CI systeemnaam'} || "";
		my $status = $$comp_array{'CI status'} || "";
		my $eigenaar_entiteit = $$comp_array{'CI eigenaar'} || "";
		my $producent = $$comp_array{'Producent'} || "";
		my $product = $$comp_array{'Product'} || "";
		my $versie = $$comp_array{'ci_versie'} || "";
		my $os = $$comp_array{'OS'} || "";
		my $os_versie = $$comp_array{'Versie OS'} || "";
		my $hw_sw_flag = $$comp_array{'HW/SW'} || "";
		my $locatie = $$comp_array{'Locatie'} || "";
		my @fields = qw (ci_categorie ci_type cmdb_id naam status
						eigenaar_entiteit producent product versie os os_versie
						hw_sw_flag locatie);
		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		unless (create_record($dbh, "component", \@fields, \@vals)) {
			$log->fatal("Could not create record for $ci_type ($ci_categorie) $cmdb_id");
			exit_application(1);
		}
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

# New Run, so clear Component Table
$log->info("Truncate Table");
my $query = "TRUNCATE TABLE component";
unless (do_stmt($dbh, $query)) {
	exit_application(1);
}

# Get Toepassingomgeving
$log->info("Get data for Toepassingomgeving");
$query = "SELECT DISTINCT  `Toepassingomgeving` ,  `Status toepassingomgeving` ,  
				`CMDB referentie omgeving` ,  `Versie` , `Type omgeving` ,  
				`Datum in gebruik` ,  `Datum buiten gebruik` 
		  FROM  `cmwbt0011`
		  WHERE `CMDB referentie omgeving` > 0";
my $ref = do_select($dbh, $query);
unless (defined $ref) {
	exit_application(1);
}
handle_toepassingomgeving($ref);

# Get Bedrijfstoepassing
$log->info("Get data for Bedrijfstoepassing");
$query = "SELECT distinct `CMDB referentie bedrijfstoepassing`, `Naam bedrijfstoepassing`, 
				 `Nummer bedrijfstoepassing` 
				 FROM `cmwbt0011` WHERE length( `Naam bedrijfstoepassing`) > 0";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	exit_application(1);
}
handle_bedrijfstoepassing($ref);

# Get Other CIs
$log->info("Get data for Component CIs");
$query = "SELECT distinct `CI categorie`, `CI type`, `CI CMDB referentie`, 
			`CI systeemnaam`, `CI status`, `CI eigenaar`, `Producent`, `Product`, 
			`ci_versie`, `OS`, `Versie OS`, `HW/SW`, `Locatie` 
		  FROM `cmwbt0011`";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	exit_application(1);
}
handle_component($ref);

exit_application(0);

=head1 To Do

=over 4

=item *

Count number of distinct records. For now the assumption is that the table only has unique records.

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
