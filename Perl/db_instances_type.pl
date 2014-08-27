=head1 NAME

db_instances_type.pl - Find database instances per type database.

=head1 VERSION HISTORY

version 1.0 27 August 2014 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will find the Database instances per database type. Start with 'SW PROD INSTALL. OP SYST.INFRA.', 'Database SW Prod.Install.' and walk up to 'Databank Vo Install'. 

=head1 SYNOPSIS

 db_instances_type.pl

 db_instances_type -h	Usage
 db_instances_type -h 1  Usage and description of the options
 db_instances_type -h 2  All documentation

=head1 OPTIONS

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh, %ci_hash, %db_instances, $stepcnt);
my $max_steps = 200;

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
use DbUtil qw(db_connect do_select singleton_select);

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

sub go_up($$$);

sub go_up($$$) {
	my ($cmdb_id, $name, $type) = @_;
	# Check for loops
	$stepcnt++;
	if ($stepcnt > $max_steps) {
		$log->error("Looks like we are in a loop for $cmdb_id ($stepcnt steps)");
		exit_application(1);
	}
	my $query = "SELECT relation, cmdb_id_source, naam_source, ci_type_source
				 FROM dc_relations
				 WHERE cmdb_id_target = ?
				   AND naam_target    = ?
				   AND relation = 'is afhankelijk van'";
	my $ref = do_select($dbh, $query, ($cmdb_id, $name));
	foreach my $arrayhdl (@$ref) {
		my $cmdb_id_source = $$arrayhdl{cmdb_id_source};
		my $naam_source = $$arrayhdl{naam_source};
		my $ci_type_source = $$arrayhdl{ci_type_source};
		# Check op loops
		my $ci_key = "$cmdb_id_source|$naam_source";
		if (exists $ci_hash{$ci_key}) {
			# been there, done that
			next;
		} else {
			# Remember type and name
			my $instance = "$type;$name";
			$ci_hash{$ci_key} = 1;
			$db_instances{$instance} = 1;
			go_up($cmdb_id_source, $naam_source, $type);
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

# First get name for CMDB or Bedrijfstoepassing
my $query =  "SELECT id, naam, product, producent, versie, cmdb_id 
			  FROM dc_component 
			  WHERE ci_type = 'SW PROD INSTALL. OP SYST.INFRA.' 
			    AND ci_categorie = 'DATABASE SW PROD. INSTALL.'";

my $ref = do_select($dbh, $query);
foreach my $arrayhdl (@$ref) {
	my $naam = $$arrayhdl{naam};
	my $cmdb_id = $$arrayhdl{cmdb_id};
	my $producent = $$arrayhdl{producent} || "";
	my $product = $$arrayhdl{product} || "";
	my $versie = $$arrayhdl{versie} || "";
	my $type = "$producent;$product;$versie";
	$stepcnt = 0;
	$log->debug("Working on $type ($cmdb_id)");
	go_up($cmdb_id, $naam, $type);
}

while (my ($key, $value) = each %db_instances) {
	print $key . "\n";
}

# exit_application(0);

=head1 To Do

=over 4

=item *

Check for CMDB ID 60833. Double 'maakt gebruik van' relation??

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
