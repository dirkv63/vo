=head1 NAME

sw_component_factors.pl - Consolidates the factors related to SW component migration.

=head1 VERSION HISTORY

version 1.0 24 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will find the factors that have an impact on the migration of the software components.

=head1 SYNOPSIS

 sw_component_factors.pl

 sw_component_factors -h	Usage
 sw_component_factors -h 1  Usage and description of the options
 sw_component_factors -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh);
my @ci_types = ("ANDERE TOEP.COMP.INSTALL.",
	            "DB TOEP.COMP-INSTALL.",
				"TOEP.COMP. COLLAB. SYST.",
				"WEB TOEP.COMP-INSTALL.");

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
use DbUtil qw(db_connect do_select);

use Log::Log4perl qw(get_logger);
use SimpleLog qw(setup_logging);
use IniUtil qw(load_ini get_ini);

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

sub go_down($$) {
	my ($cmdb_id, $naam) = @_;
	my $query = "SELECT relation, cmdb_id_target, naam_target, ci_type_target
				 FROM relations
				 WHERE cmdb_id_source = '$cmdb_id'
				   AND naam_source    = '$name'
				   AND relation = 'is afhankelijk van'";
	my $ref = do_select($dbh, $query);
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_target = $$arrayhdl{cmdb_id_target};
		my $naam_target = $$arrayhdl{naam_target};
		my $ci_type_target = $$arrayhdl{ci_type_target};


		if ((defined $no_gebruiksrel) && ($relation eq "maakt gebruik van")) {
			# Don't look at this relation
			next;
		}
		if (exists $ci_hash{$cmdb_id}) {
			# Only add relation in this case
			print DOT $edge_str;
		} else {
			my $label = "{$naam_target | $cmdb_id_target | $ci_type_target}";
			my $node_attr = get_node_attr($cmdb_id_target);
			print DOT "$cmdb_id_target [shape=record, label=\"{$node_attr}\"];\n";
			print DOT $edge_str;
			$ci_hash{$ci_key} = 1;
			if (not ($relation eq "maakt gebruik van")) {
				go_down($cmdb_id_target, $naam_target);
			}
		}
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

# Get all the SW Components
my $where_str = join (" OR ", map { "ci_type = ?" } @ci_types);
my $query = "SELECT `cmdb_id`, `naam`, `ci_categorie`, `ci_type`
			 FROM component
			 WHERE $where_str";
my $ref = do_select($dbh, $query, @ci_types);
foreach my $record (@$ref) {
	my $cmdb_id      = $$record{'cmdb_id'};
	my $naam         = $$record{'naam'};
	my $ci_categorie = $$record{'ci_categorie'};
	my $ci_type      = $$record{'ci_type'};
	go_down($cmdb_id, $naam);
}

exit_application(0);

=head1 To Do

=over 4

=item *

Check for CMDB ID 60833. Double 'maakt gebruik van' relation??

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
