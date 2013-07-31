=head1 NAME

get_data_cmwbt0011 - This file handles the data from report CMWBT0011_OR_Inventaris HW-SW configuratie per toepassingscomponent.

=head1 VERSION HISTORY

version 1.0 29 May 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will convert cmwbt0011 data into unique components. The component types are 'Bedrijfstoepassingen', 'Toepassingcomponentinstallaties' and all others.

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

use FindBin;
use lib "$FindBin::Bin/lib";

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
	foreach my $ref (@$tpo_arrayref) {
		my $ci_class = "toepassingcomponentinstallatie";
		my $naam = $$ref{Toepassingomgeving};
		my $status = $$ref{'Status toepassingomgeving'};
		my $cmdb_id = $$ref{'CMDB referentie omgeving'};
		my $versie = $$ref{'Versie'};
		my $omgeving = $$ref{'Type omgeving'};
		my $datum_in_gebruik = $$ref{'Datum in gebruik'};
		my $datum_buiten_gebruik = $$ref{'Datum buiten gebruik'};
		my $dienstentype = $$ref{'Dienstentype'};
		my $eigenaar_beleidsdomein = $$ref{'Eigenaar (Beleidsdomein)'};
		my $eigenaar_entiteit = $$ref{'Eigenaar (entiteit)'};
		my $fin_beleidsdomein = $$ref{'Financieel beheerder (Beleidsdomein)'};
		my $fin_entiteit = $$ref{'Financieel beheerder (entiteit)'};
		my @fields = qw (ci_class naam status cmdb_id versie omgeving datum_in_gebruik			
						 datum_buiten_gebruik dienstentype
						 vo_applicatiebeheerder eigenaar_beleidsdomein
						 eigenaar_entiteit fin_beleidsdomein fin_entiteit);
		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		unless (create_record($dbh, "component", \@fields, \@vals)) {
			$log->fatal("Could not create record for $ci_class $cmdb_id");
			exit_application(1);
		}
	}
}

sub handle_bedrijfstoepassing($) {
	my ($bd_arrayref) = @_;
	foreach my $ref (@$bd_arrayref) {
		my $ci_class = "bedrijfstoepassing";
		my $cmdb_id = $$ref{'CMDB referentie bedrijfstoepassing'} || "";
		my $naam = $$ref{'Naam bedrijfstoepassing'} || "";
		my $bt_nummer = $$ref{'Nummer bedrijfstoepassing'} || "";
		my $so_toepassingsmanager = $$ref{'SO Toepassingsmanager(s)'};
		my $vo_applicatiebeheerder = $$ref{'VO Applicatiebeheerder(s)'};
		# Now make CMDB ID unique
		$cmdb_id = $cmdb_id + 1000000;
		my @fields = qw (ci_class cmdb_id naam bt_nummer so_toepassingsmanager);
		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		unless (create_record($dbh, "component", \@fields, \@vals)) {
			$log->fatal("Could not create record for $ci_class $cmdb_id");
			exit_application(1);
		}
	}
}

sub handle_component($) {
	my ($comp_arrayref) = @_;
	foreach my $ref (@$comp_arrayref) {
		my $ci_categorie = $$ref{'CI categorie'} || "";
		my $ci_type = $$ref{'CI type'} || "";
		my $cmdb_id = $$ref{'CI CMDB referentie'} || "";
		my $naam = $$ref{'CI systeemnaam'} || "";
		my $status = $$ref{'CI status'} || "";
		my $eigenaar_entiteit = $$ref{'CI eigenaar'} || "";
		my $producent = $$ref{'Producent'} || "";
		my $product = $$ref{'Product'} || "";
		my $versie = $$ref{'ci_versie'} || "";
		my $os = $$ref{'OS'} || "";
		my $os_versie = $$ref{'Versie OS'} || "";
		my $hw_sw_flag = $$ref{'HW/SW'} || "";
		my $locatie = $$ref{'Locatie'} || "";
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

# Drop table component if exists
my $query = "DROP TABLE IF EXISTS component";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table component, exiting...");
	exit_application(1);
}

# Create Table Component
$query = "CREATE TABLE IF NOT EXISTS `component` (
			  `id` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` int(11) NOT NULL,
			  `bt_nummer` int(11) DEFAULT NULL,
			  `ci_categorie` varchar(255) DEFAULT NULL,
			  `ci_class` varchar(255) DEFAULT NULL,
			  `ci_type` varchar(255) DEFAULT NULL,
			  `datum_buiten_gebruik` date DEFAULT NULL,
			  `datum_in_gebruik` date DEFAULT NULL,
			  `dienstentype` varchar(255) DEFAULT NULL,
			  `eigenaar_beleidsdomein` varchar(255) DEFAULT NULL,
			  `eigenaar_entiteit` varchar(255) DEFAULT NULL,
			  `fin_beleidsdomein` varchar(255) DEFAULT NULL,
			  `fin_entiteit` varchar(255) DEFAULT NULL,
			  `functionele_naam` varchar(255) DEFAULT NULL,
			  `hw_sw_flag` varchar(255) DEFAULT NULL,
			  `locatie` varchar(255) DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `omgeving` varchar(255) DEFAULT NULL,
			  `os` varchar(255) DEFAULT NULL,
			  `os_versie` varchar(255) DEFAULT NULL,
			  `producent` varchar(255) DEFAULT NULL,
			  `product` varchar(255) DEFAULT NULL,
			  `so_toepassingsmanager` varchar(255) DEFAULT NULL,
			  `status` varchar(255) DEFAULT NULL,
			  `versie` varchar(255) DEFAULT NULL,
			  `vo_applicatiebeheerder` varchar(255) DEFAULT NULL,
			  `standaarddatum` date DEFAULT NULL,
			  `uitdovend_datum` date DEFAULT NULL,
			  `uitgedoofd_datum` date DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `cmdb_id` (`cmdb_id`),
			  KEY `naam` (`naam`)
			) ENGINE=MyISAM  DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table component, exiting...");
	exit_application(1);
}

# Get Toepassingomgeving
$log->info("Get data for Toepassingomgeving");
$query = "SELECT DISTINCT  `Toepassingomgeving` ,  `Status toepassingomgeving` ,  
				`CMDB referentie omgeving` ,  `Versie` , `Type omgeving` ,  
				`Datum in gebruik` ,  `Datum buiten gebruik`, `Dienstentype`,
				`Financieel beheerder (Beleidsdomein)`, `Financieel beheerder (entiteit)`,
				`Eigenaar (Beleidsdomein)`, `Eigenaar (entiteit)`
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
				 `Nummer bedrijfstoepassing`, `SO Toepassingsmanager(s)`,
				 `VO Applicatiebeheerder(s)`  
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
