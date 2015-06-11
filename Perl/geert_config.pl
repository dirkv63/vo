=head1 NAME

dc_get_config.pl - This script will get the configuration for the specified CI

=head1 VERSION HISTORY

version 1.0 04 June 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will get the configuration for the specified CI. The CI number is input parameter. Specify 'normal' CI or number Bedrijfstoepassing.

=head1 SYNOPSIS

 dc_get_config.pl [-c ci_id] [-b bedrijfsnummer] [-g] [-e] [-f]

 dc_get_config -h	Usage
 dc_get_config -h 1  Usage and description of the options
 dc_get_config -h 2  All documentation

=head1 OPTIONS

=over 4

=item B<-c cmdb_id>

The CMDB ID number.

=item B<-b bt_id>

Bedrijfstoepassingnummer. If CMDB_ID is also specified, then bedrijfstoepassingnummer is ignored.

=item B<-g>

If specified, then do not include 'gebruiksrelaties'.

=item B<-e>

If specified, then add EOSL information if available.

=item B<-f>

If specified, then do not go below Fysieke computer.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh, $cmdb_id, %ci_hash, $no_gebruiksrel, $get_eosl, $not_below_fys);
my $filedir = "c:/temp/gc/";
my @ids = (4,7,10,15,18,24,28,31,71,76,78,83,84,92,94,96,100,101,107,109,110,111,114,115,116,117,120,123,124,127,138,142,147,148,151,152,164,165,168,174,175,176,177,178,182,183,191,192,193,205,212,217,218,221,222,226,230,233,240,246,251,260,274,277,278,290,298,302,309,321,323,326,328,335,336,343,344,348,352,353,356,359,362,365,380,382,397,406,407,421,425,432,433,444,453,457,458,461,463,464,465,467,469,473,474,475,477,486,492,493,494,498,515,518,519,523,524,526,527,529,533,540,541,559,569,573,575,577,578,601,621,663,681,701,721,722,741,781,801,841,842,861,862,881,921,942,961,981,1002,1004,1021,1042,1101,1121,1181,1201,1282,1350,1355,1381,1421,1422,1441,1501,1521,1541,1563,1581,1621,1642,1661,1681,1701,1702,1743,1801,1921,1981,1982,2003,2041,2061,2121,2141,2161,2201,2261,2301,2302,2386,2403,2404,2422,2541,2562,2602,2721,2741,2761,2881);

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

sub get_eosl($) {
	my ($cmdb_id) = @_;
	my $query  = "SELECT uitdovend_datum, uitgedoofd_datum
				  FROM dc_component
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

sub edge_attr($) {
	my ($relation) = @_;
	my $color;
	if (($relation eq "heeft component") || ($relation eq "netwerk connectie")) {
		$color= "blue";
	} elsif ($relation eq "maakt gebruik van") {
		$color = "red";
	} else {
		$color = "black";
	}
	return "[color=$color]";
}

sub get_node_attr($) {
	my ($cmdb_id) = @_;
	my $query = "SELECT * 
				 FROM dc_component
				 WHERE cmdb_id = '$cmdb_id'";
	my $ref = singleton_select($dbh, $query);
	unless ((defined $ref) && (1 == @$ref)) {
		exit_application(1);
	}
	my $arrayhdl = $ref->[0];
	my $bt_nummer = $$arrayhdl{BT_NUMMER} || "";
	my $ci_categorie = $$arrayhdl{CI_CATEGORIE} || "";
	my $ci_type = $$arrayhdl{CI_TYPE} || "";
	my $locatie = $$arrayhdl{LOCATIE} || "";
	my $naam = $$arrayhdl{NAAM} || "";
	my $omgeving = $$arrayhdl{OMGEVING} || "";
	my $os = $$arrayhdl{OS} || "";
	my $os_versie = $$arrayhdl{OS_VERSIE} || "";
	my $producent = $$arrayhdl{PRODUCENT} || "";
	my $product = $$arrayhdl{PRODUCT} || "";
	my $status = $$arrayhdl{STATUS} || "";
	my $versie = $$arrayhdl{VERSIE} || "";
	$naam =~ s/[^a-zA-Z0-9 _-]//g;
	my $naam_id = "$naam ($cmdb_id)";
	my @attrib_arr = ($naam_id, $ci_categorie, $ci_type, $locatie, "$os $os_versie", "$producent $product $versie", $status);
	if (defined $get_eosl) {
		my ($uitdovend, $uitgedoofd) = get_eosl($cmdb_id);
		if (length($uitdovend) > 4) {
			push @attrib_arr, "Uitdovend: $uitdovend";
		}
		if (length($uitgedoofd) > 4) {
			push @attrib_arr, "Uitgedoofd: $uitgedoofd";
		}
	}
	# Remove empty values from array
	my (@clean_attribs);
	foreach my $val (@attrib_arr) {
		if (length(trim($val)) > 0) {
			# Replace double quote with single quote
			$val =~ s/\"/\'/g;
			push @clean_attribs, $val;
		}
	}
	return join " | ", @clean_attribs;
}

sub go_down($$);

sub go_down($$) {
	my ($cmdb_id, $name) = @_;
	my $query = "SELECT relation, cmdb_id_target, naam_target, ci_type_target
				 FROM dc_relations
				 WHERE cmdb_id_source = ?
				   AND naam_source    = ?";
	my $ref = do_select($dbh, $query, ($cmdb_id, $name));
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_target = $$arrayhdl{cmdb_id_target};
		my $naam_target = $$arrayhdl{naam_target};
		my $ci_type_target = $$arrayhdl{ci_type_target};
		$log->debug("Relation: $relation - $cmdb_id_target - $naam_target - $ci_type_target");
		# Check op loops
		my $edge_attr = edge_attr($relation);
		my $edge_str = "$cmdb_id -> $cmdb_id_target $edge_attr;\n";
		my $ci_key = "$cmdb_id_target|$naam_target";
		if ((defined $no_gebruiksrel) && ($relation eq "maakt gebruik van")) {
			# Don't look at this relation
			next;
		}
		if (exists $ci_hash{$ci_key}) {
			# Only add relation in this case
			print DOT $edge_str;
		} else {
			my $label = "{$naam_target | $cmdb_id_target | $ci_type_target}";
			my $node_attr = get_node_attr($cmdb_id_target);
			print DOT "$cmdb_id_target [shape=record, label=\"{$node_attr}\"];\n";
			print DOT $edge_str;
			$ci_hash{$ci_key} = 1;
			# Conditions to stop go down again
			if ($relation eq "maakt gebruik van") { next; }
			if ((defined $not_below_fys) && ($ci_type_target eq "FYSIEKE COMPUTER")) { next; }
			# No more conditions, so continue to go down
			go_down($cmdb_id_target, $naam_target);
		}
	}
}

sub go_up($$);

sub go_up($$) {
	my ($cmdb_id, $name) = @_;
	my $query = "SELECT relation, cmdb_id_source, naam_source, ci_type_source
				 FROM dc_relations
				 WHERE cmdb_id_target = ?
				   AND naam_target    = ?";
	my $ref = do_select($dbh, $query, ($cmdb_id, $name));
	foreach my $arrayhdl (@$ref) {
		my $relation = $$arrayhdl{relation};
		my $cmdb_id_source = $$arrayhdl{cmdb_id_source};
		my $naam_source = $$arrayhdl{naam_source};
		my $ci_type_source = $$arrayhdl{ci_type_source};
		$log->debug("Relation: $relation - $cmdb_id_source - $naam_source - $ci_type_source");
		# Check op loops
		my $edge_attr = edge_attr($relation);
		my $edge_str = "$cmdb_id_source -> $cmdb_id $edge_attr;\n";
		my $ci_key = "$cmdb_id_source|$naam_source";
		if ((defined $no_gebruiksrel) && ($relation eq "maakt gebruik van")) {
			# Don't look at this relation
			next;
		}
		if (exists $ci_hash{$ci_key}) {
			print DOT $edge_str;
		} else {
			my $edge_attr = edge_attr($relation);
			my $node_attr = get_node_attr($cmdb_id_source);
			my $label = "{$naam_source | $cmdb_id_source | $ci_type_source}";
			print DOT "$cmdb_id_source [shape=record, label=\"{$node_attr}\"];\n";
			print DOT $edge_str;
			$ci_hash{$ci_key} = 1;
			if (not ($relation eq "maakt gebruik van")) {
				go_up($cmdb_id_source, $naam_source);
			}
		}
	}
}

######
# Main
######

# Handle input values
my %options;
getopts("h:c:b:gef", \%options) or pod2usage(-verbose => 0);
my $arglength = scalar keys %options;  
if ($arglength == 0) {			# If no options specified,
	$options{"h"} = 0;			# display usage.
}
#Print Usage
# if (defined $options{"h"}) {
#    if ($options{"h"} == 0) {
#        pod2usage(-verbose => 0);
#    } elsif ($options{"h"} == 1) {
#        pod2usage(-verbose => 1);
#    } else {
#		pod2usage(-verbose => 2);
#	}
#}
# Get ini file configuration
my $ini = { project => "vo" };
my $cfg = load_ini($ini);
# Start logging
setup_logging;
$log = get_logger();
$log->info("Start application");
# Get cmdb_id
#if (defined $options{"c"}) {
#	$cmdb_id = $options{"c"};
#} else {
#	if (defined $options{"b"}) {
#		$bt_id = $options{"b"};
#	} else {
#		$log->fatal("CMDB ID and Bedrijfstoepassingnummer both not defined, exiting...");
#		exit_application(1);
#	}
#}
#if (exists $options{"g"}) {
	$no_gebruiksrel = "Do not show";
#}
#if (exists $options{"e"}) {
	$get_eosl = "Show EOSL Information";
#}
#if (exists $options {"f"}) {
	$not_below_fys = "Not below Physical Computer";
#}
# Show input parameters
if ($log->is_trace()) {
	while (my($key, $value) = each %options) {
		$log->trace("$key: $value");
	}
}
# End handle input values

# Make database connection for vo database
$dbh = db_connect("vo") or exit_application(1);

for my $bt_id (@ids) {
undef %ci_hash;
# First get name for CMDB or Bedrijfstoepassing
my ($query);
$cmdb_id = $bt_id + 1000000;
$query = "SELECT naam, ci_categorie ci_type FROM dc_component
		  WHERE cmdb_id = '$cmdb_id'";

my $ref = singleton_select($dbh, $query);
unless ((defined $ref) && (1 == @$ref)) {
	exit_application(1);
}
my $arrayhdl = $ref->[0];
my $name = $$arrayhdl{naam};
my $abbr_name = $name;
$abbr_name =~ s/[^a-zA-Z0-9 ]*//g;
print "Working on $name ($abbr_name)\n";
my $ci_categorie = $$arrayhdl{ci_categorie} || "";
my $ci_type = $$arrayhdl{ci_type} || "";
my $filename = $filedir . $cmdb_id . ".dot";
my $gifname  = $filedir . $abbr_name . ".gif";
my $openres = open (DOT, ">$filename");
if (not (defined $openres)) {
	$log->fatal("Could not open $filename for writing, exiting...");
	exit_application(1);
}

my $node_attr = get_node_attr($cmdb_id);
print DOT "digraph $cmdb_id {\n";
print DOT "$cmdb_id [color=red, shape=record, label=\"{$node_attr}\"];\n";

# Find components from this CI
go_down($cmdb_id, $name);

# Find the hierarchy that depends on this CI
go_up($cmdb_id, $name);

print DOT "}";

close DOT;

my $cmd = "dot -Tgif -Gcharset=latin1 \"$filename\" -o \"$gifname\"";
system($cmd);
# exec("\"$gifname\"");
} 

exit_application(0);

=head1 To Do

=over 4

=item *

Check for CMDB ID 60833. Double 'maakt gebruik van' relation??

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>