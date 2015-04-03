=head1 NAME

app2db_server - Script to get all apps, their databases and servers.

=head1 VERSION HISTORY

version 1.0 13 March 2015 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script is for Application availability monitoring. It will extract all business applications, find the productive instance, then walk down the configuration to find database instance, database products and the servers on which it is installed.

MAKE SURE that there is an index on cmdb_id in dc_component and dc_relations!

=head1 SYNOPSIS

 app2db_server.pl 

 app2db_server -h	Usage
 app2db_server -h 1  Usage and description of the options
 app2db_server -h 2  All documentation

=head1 OPTIONS

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh, %ci_hash);
my ($bt_cmdb_id, $bt_nummer, $bt_naam);
my ($app_cmdb_id, $app_naam, $app_status);
my ($inst_cmdb_id, $inst_naam, $inst_status);
my ($sw_cmdb_id, $sw_naam, $sw_status, $sw_producent, $sw_product, $sw_versie);
my ($comp_cmdb_id, $comp_naam, $comp_status);
my $filename = "c:/temp/db_config.csv";

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
use DbUtil qw(db_connect do_select singleton_select create_record);

use Log::Log4perl qw(get_logger);
use SimpleLog qw(setup_logging);
use IniUtil qw(load_ini get_ini);

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

sub handle_result {
	# Does this Computer has a Database Product installed?
	if (defined ($sw_naam)) {
    my @fields = qw (bt_nummer bt_naam app_naam app_status 
                 inst_cmdb_id inst_naam inst_status 
				 sw_cmdb_id sw_naam sw_producent sw_product sw_versie sw_status 
				 comp_cmdb_id comp_naam comp_status);

		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		create_record($dbh, "db_config", \@fields, \@vals);
		undef $sw_naam;
	}
}

sub go_down($$);

sub go_down($$) {
	my ($cmdb_id, $name) = @_;
	my $query = "SELECT relation, cmdb_id_target, naam_target, ci_type_target, c.ci_categorie, c.status,
	                    c.producent, c.product, c.versie
				 FROM dc_relations r, dc_component c
				 WHERE cmdb_id_source = ?
				   AND naam_source    = ?
				   AND cmdb_id_target = c.cmdb_id";
	my $ref = do_select($dbh, $query, ($cmdb_id, $name));
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_target = $$arrayhdl{cmdb_id_target};
		my $naam_target = $$arrayhdl{naam_target};
		my $ci_type_target = $$arrayhdl{ci_type_target};
		my $status = $$arrayhdl{status};
		my $ci_categorie = $$arrayhdl{ci_categorie};
		my $producent = $$arrayhdl{producent} || "";
		my $product = $$arrayhdl{product} || "";
		my $versie = $$arrayhdl{versie} || "";
		$log->debug("Relation: $relation - $cmdb_id_target - $naam_target - $ci_type_target");
		# Not interested if this is a 'maakt gebruik van' relation.
		if ($relation eq "maakt gebruik van") {
			# Don't look at this relation
			next;
		}
		# Check op loops
		# my $ci_key = "$cmdb_id_target|$naam_target";
		# if (exists $ci_hash{$ci_key}) {
			# This item has been investigated already, ignore...
		# } else {
		# $ci_hash{$ci_key} = 1;
			# Check if this is Database instance or database installation
			# Remember the data.
			if ($ci_categorie eq "DATABANK VO INSTALL") {
				$inst_naam = $naam_target;
				$inst_cmdb_id = $cmdb_id_target;
				$inst_status = $status;
			} elsif ($ci_categorie eq "DATABASE SW PROD. INSTALL.") {
				$sw_cmdb_id = $cmdb_id_target;
				$sw_naam = $naam_target;
				$sw_status = $status;
				$sw_producent = $producent;
				$sw_product = $product;
				$sw_versie = $versie;
			}
			# Now check if this is ComputerSystem
			if (index($ci_type_target, "COMPUTER") > -1) {
				$comp_cmdb_id = $cmdb_id_target;
				$comp_naam = $naam_target;
				$comp_status = $status;
				# OK, stop searching and print result
				handle_result;
			} else {
				go_down($cmdb_id_target, $naam_target);
			}
		# }
	}
}

######
# Main
######

# Handle input values
my %options;
getopts("h:c:b:gef", \%options) or pod2usage(-verbose => 0);
# my $arglength = scalar keys %options;  
# if ($arglength == 0) {			# If no options specified,
# 	$options{"h"} = 0;			# display usage.
# }
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

my @tables = qw (db_config);
foreach my $table (@tables) {
	if ($dbh->do("truncate $table")) {
		$log->debug("Table $table truncated");
	} else {
		$log->fatal("Failed to truncate `$table'. Error: " . $dbh->errstr);
		exit_application(1);
	}
}

# First get Bedrijfstoepassing
my $query =  "SELECT bt_nummer, naam, cmdb_id FROM dc_component
		      WHERE ci_class = 'bedrijfstoepassing'";
my $ref = do_select($dbh, $query);
foreach my $arrayhdl (@$ref) {
	$bt_nummer = $$arrayhdl{bt_nummer};
	$bt_naam = $$arrayhdl{naam};
	$bt_cmdb_id = $$arrayhdl{cmdb_id};
	# Then get Production instances for these Bedrijfstoepassingen.
	my $query = "SELECT c.cmdb_id cmdb_id, c.naam naam, c.status
	          FROM dc_component c, dc_relations r
			  WHERE r.cmdb_id_source = $bt_cmdb_id
			    AND r.cmdb_id_target = c.cmdb_id
				AND c.omgeving = 'P'";
	my $ref = do_select($dbh, $query);
    foreach my $arrayhdl (@$ref) {
	    $app_naam = $$arrayhdl{naam};
		$app_cmdb_id = $$arrayhdl{cmdb_id};
		$app_status = $$arrayhdl{status};
		# Then walk down to find Database information
		# Initialize Installed Database Component
		undef $sw_naam;
		$log->info("Toepassing: $bt_naam, Application: $app_naam");
		go_down($app_cmdb_id, $app_naam);
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
