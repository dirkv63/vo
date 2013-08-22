=head1 NAME

virt_syst_cost.pl - This script starts from the physical computers and finds to virtual computers.

=head1 VERSION HISTORY

version 1.0 21 August 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will start with the isolated physical systems and find the virtual systems. The cluster computers are also added - if any.

=head1 SYNOPSIS

 virt_syst_cost.pl

 virt_syst_cost -h	Usage
 virt_syst_cost -h 1  Usage and description of the options
 virt_syst_cost -h 2  All documentation

=head1 OPTIONS

=over 4

No inline options are available. There is a properties\vo.ini file that contains script settings.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, %virt);
my @fields = qw (cmdb_id naam cluster_id cluster_naam virt_comp_id virt_comp_naam);

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

sub go_up($$$$);

sub go_up($$$$) {
	my ($cmdb_id, $naam, $cluster_id, $cluster_naam) = @_;
	my $query = "SELECT relation, cmdb_id_source, naam_source, ci_type_source
				 FROM relations
				 WHERE cmdb_id_target = '$cmdb_id'
				   AND ((ci_type_source = 'COMPUTER CLUSTER') OR
						(ci_type_source = 'VIRTUELE COMPUTER'))
				   AND relation = 'is afhankelijk van'";
	my $ref = do_select($dbh, $query);
	# Check if only cluster found in this path
	if ((scalar @$ref) == 0) {
		if (length($cluster_naam) > 2) {
			my $id_key = "|" . $cluster_id;
			my $naam_key = "|" . $cluster_naam;
			$virt{$id_key} = $naam_key;
		}
	}
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_source = $$arrayhdl{cmdb_id_source};
		my $naam_source = $$arrayhdl{naam_source};
		my $ci_type_source = $$arrayhdl{ci_type_source};
		# Update status count and number of connections
		if (lc($ci_type_source) eq "computer cluster") {
			if (length($cluster_naam) > 2) {
				$cluster_id = $cluster_id . " * " . $cmdb_id_source;
				$cluster_naam = $cluster_naam . " * " . $naam_source;
				$log->info("$cluster_id");
			} else {
				# Remember Cluster and
				# try to find that Virtual Computer
				$cluster_id = $cmdb_id_source;
				$cluster_naam = $naam_source;
			}
			# In both cases go up again to continue searching
			go_up($cmdb_id_source, $naam_source, $cluster_id, $cluster_naam);
		} else {
			# Not a computer cluster, so it must be a virtual computer
			my $id_key = $cmdb_id_source . "|" . $cluster_id;
			my $naam_key = $naam_source . "|" . $cluster_naam;
			$virt{$id_key} = $naam_key;
		}
	}
}

sub save_results($$) {
	my ($cmdb_id, $naam) = @_;
	# Check if there are any virtual computers at all
	if ((scalar keys %virt) == 0) {
		my (@vals) = map { eval ("\$" . $_ ) } @fields;
		unless (create_record($dbh, "virtual_systems", \@fields, \@vals)) {
			$log->fatal("Could not create record for $cmdb_id");
			exit_application(1);
		}
	} else {
		while (my ($ids, $naams) = each %virt) {
			my ($virt_comp_id, $cluster_id) = split /\|/, $ids;
			my ($virt_comp_naam, $cluster_naam) = split /\|/, $naams;
			my (@vals) = map { eval ("\$" . $_ ) } @fields;
			unless (create_record($dbh, "virtual_systems", \@fields, \@vals)) {
				$log->fatal("Could not create record for $cmdb_id");
				exit_application(1);
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

$log->info("Preparing table virtual_systems");
# Drop table virtual_systems if exists
my $query = "DROP TABLE IF EXISTS virtual_systems";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table virtual_systems, exiting...");
	exit_application(1);
}

# CREATE table virtual_systems
$query = "CREATE TABLE IF NOT EXISTS `virtual_systems` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `cluster_id` varchar(255) DEFAULT NULL,
			  `cluster_naam` varchar(255) DEFAULT NULL,
			  `virt_comp_id` varchar(255) DEFAULT NULL,
			  `virt_comp_naam` varchar(255) DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table virtual_systems, exiting...");
	exit_application(1);
}

# Get all physical servers related to Boudewijn
$query = "SELECT cmdb_id, naam
		  FROM system_cost";
my $ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	undef %virt;
	my $cmdb_id = $$record{cmdb_id};
	my $naam = $$record{naam};
	my $cluster_id = "";
	my $cluster_naam = "";
	go_up($cmdb_id, $naam, $cluster_id, $cluster_naam);
	save_results($cmdb_id, $naam);
}

# Export the results to excel files
$log->info("Export virtual_systems to excel");
my $nr_lines = write_table($dbh, "virtual_systems",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table virtual_systems");
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
