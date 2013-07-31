=head1 NAME

consolidate_apps.pl - This application will consolidate components 'toepassingomgeving'.

=head1 VERSION HISTORY

version 1.0 15 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will consolidate the components per 'toepassingomgeving'. Start from every toepassingomgeving, follow the 'is afhankelijk van' relation (unless the relation is in the exception table). Count the number of occurences per component type. If location is available, count the number of components in Boudewijn.

=head1 SYNOPSIS

 consolidate_apps.pl [-t] [-l log_dir] 

 consolidate_apps -h	Usage
 consolidate_apps -h 1  Usage and description of the options
 consolidate_apps -h 2  All documentation

=head1 OPTIONS

=over 4

=item B<-t>

Tracing enabled, default: no tracing

=item B<-l logfile_directory>

default: d:\temp\log

=back

=head1 SUPPORTED PLATFORMS

The script has been developed and tested on Windows XP, Perl v5.10.0, build 1005 provided by ActiveState.

The script should run unchanged on UNIX platforms as well, on condition that all directory settings are provided as input parameters (-l, -p, -c, -d options).

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh, %ci_hash, %flows, %actions, %object_cnt, %object_loc);

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
	my ($cmdb_id, $name) = @_;
	my $query = "SELECT relation, cmdb_id_target, naam_target, ci_type_target, ci_categorie, locatie
				 FROM relations, component
				 WHERE cmdb_id_source = '$cmdb_id'
				   AND relation       = 'is afhankelijk van'
				   AND cmdb_id        = cmdb_id_target";
	my $ref = do_select($dbh, $query);
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_target = $$arrayhdl{cmdb_id_target};
		my $naam_target = $$arrayhdl{naam_target};
		my $ci_type_target = $$arrayhdl{ci_type_target};
		my $ci_category = $$arrayhdl{ci_categorie};
		my $location = $$arrayhdl{locatie} || "";
		if (exists $ci_hash{$cmdb_id_target}) {
			# Target object has been evaluated already, don't process further.
			next;
		} else {
			$ci_hash{$cmdb_id_target} = 1;
			my $object_type = "$ci_type_target|$ci_category";
			if (defined $object_cnt{$object_type}) {
				$object_cnt{$object_type}++;
			} else {
				$object_cnt{$object_type} = 1;
			}
			if (index($location, "Boudewijn") > -1) {
				if (defined $object_loc{$object_type}) {
					$object_loc{$object_type}++;
				} else {
					$object_loc{$object_type} = 1;
				}
			}
			go_down($cmdb_id_target, $naam_target);
		}
	}
}

sub store_results($$) {
	my ($cmdb_id, $name) = @_;
	my $valuestr = "";
	my ($cnt_in_bou);
	while (my ($object_type, $value) = each %object_cnt) {
		my ($ci_type, $ci_category) = split /\|/, $object_type;
		if (defined $object_loc{$object_type}) {
			$cnt_in_bou = $object_loc{$object_type};
		} else {
			$cnt_in_bou = 0;
		}
		$valuestr .= "('$cmdb_id', '$ci_category', '$ci_type', $value, $cnt_in_bou),";
	}
	# Remove last comma
	$valuestr = substr $valuestr, 0, -1;
	if (length($valuestr) > 0) {
		my $query = "INSERT INTO appl_cons (cmdb_id, ci_categorie, ci_type, cnt, cnt_in_bou)
						  VALUES $valuestr";
		unless (do_stmt($dbh, $query)) {
			$log->fatal("Could not write result into appl_cons table");
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
#my $arglength = scalar keys %options;  
#if ($arglength == 0) {			# If no options specified,
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

# Drop table appl_cons if exists
my $query = "DROP TABLE IF EXISTS appl_cons";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Cannot drop table appl_cons");
	exit_application(1);
}

# Create table appl_cons
$query = "CREATE TABLE appl_cons (
			cmdb_id INT NOT NULL,
			ci_categorie VARCHAR(255) DEFAULT NULL,
			ci_class VARCHAR(255) DEFAULT NULL,
			ci_type VARCHAR(255) DEFAULT NULL,
			cnt INT DEFAULT 0,
			cnt_in_bou INT DEFAULT 0)
		  ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Cannot create table appl_cons");
	exit_application(1);
}

# Get Relations Engine
$query = "SELECT *
		  FROM relation_rules";
my $ref = do_select($dbh, $query);
foreach my $arrayhdl (@$ref) {
	my $ci_type_source = $$arrayhdl{ci_type_source} || "";
	my $relation = $$arrayhdl{relation} || "";
	my $ci_type_target = $$arrayhdl{ci_type_target} || "";
	my $flow = $$arrayhdl{flow} || "";
	my $action = $$arrayhdl{action} || "";
	my $full_relation = "$ci_type_source|$relation|$ci_type_target";
	$flows{$full_relation} = $flow;
	$actions{$full_relation} = $action;
}

# Find all 'Toepassingomgeving' objects
$query = "SELECT cmdb_id, naam
		  FROM component
		  WHERE ci_class = 'toepassingcomponentinstallatie'";
#		    AND cmdb_id=50";
$ref = do_select($dbh, $query);
foreach my $arrayhdl (@$ref) {
	# Clear Hashes
	undef %object_cnt;
	undef %object_loc;
	undef %ci_hash;
	my $cmdb_id = $$arrayhdl{cmdb_id} || "";
	my $naam = $$arrayhdl{naam} || "";
	# Find all components with 'is afhankelijk van' relation
	go_down($cmdb_id, $naam);
	store_results($cmdb_id, $naam);
}


exit_application(0);

=head1 To Do

=over 4

=item *

Nothing for now.

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
