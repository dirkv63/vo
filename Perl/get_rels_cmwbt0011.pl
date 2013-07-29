=head1 NAME

get_rels_cmwbt0011 - This file gets the relations from CMWBT0011.

=head1 VERSION HISTORY

version 1.1 23 July 2013 DV

=over 4

Update scripts in line with Pauwel scripting.

=back

version 1.0 01 June 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will get the relations from the table CMWBT0011_OR.

=head1 SYNOPSIS

 get_rels_cmwbt0011.pl

 get_rels_cmwbt0011 -h	Usage
 get_rels_cmwbt0011 -h 1  Usage and description of the options
 get_rels_cmwbt0011 -h 2  All documentation

=head1 OPTIONS

=over 4

=item B<-t>

Tracing enabled, default: no tracing

=item B<-l logfile_directory>

default: d:\temp\log

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh, %allvalues, %cmdb_id_hash, %naam_hash, %ci_type_hash, %relation_hash, $reccnt);

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

use DbUtil qw(db_connect do_select do_stmt );

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

sub handle_relation($$$$$$$) {
	my ($cmdb_id_source, $naam_source, $ci_type_source, $relation, 
		$cmdb_id_target, $naam_target, $ci_type_target) = @_;
	my $valuestr = "('$cmdb_id_source', " . $dbh->quote($naam_source) . 
				   ", '$ci_type_source', '$relation', '$cmdb_id_target', "
				   . $dbh->quote($naam_target) . ", '$ci_type_target')";
	$allvalues{$valuestr} = 1;
}

sub handle_bedrijfstoepassingen($) {
	my ($hndl_arrayrefs) = @_;
	foreach my $arrayref (@$hndl_arrayrefs) {
		my $naam_target = $$arrayref{'Toepassingomgeving'} || "";
		my $cmdb_id_target = $$arrayref{'CMDB referentie omgeving'} || "";
		my $cmdb_id_source = $$arrayref{'CMDB referentie bedrijfstoepassing'} || "";
		my $naam_source = $$arrayref{'Naam bedrijfstoepassing'} || "";
		my $ci_type_target = "Toepassingomgeving";
		my $ci_type_source = "Bedrijfstoepassing";
		my $relation = "heeft component";
		$cmdb_id_source = $cmdb_id_source + 1000000;
		handle_relation($cmdb_id_source, $naam_source, $ci_type_source, $relation, 
						$cmdb_id_target, $naam_target, $ci_type_target);
	}
}

sub store_level($$$$$) {
	my ($cmdb_id, $naam, $ci_type, $level, $relation) = @_;
	$cmdb_id_hash{$level} = $cmdb_id;
	$naam_hash{$level} = $naam;
	$ci_type_hash{$level} = $ci_type;
	$relation_hash{$level} = $relation;
	# Clear all information on levels above current level
	for (my $cnt = $level+1; $cnt < 10; $cnt++) {
		undef $cmdb_id_hash{$cnt};
		undef $naam_hash{$cnt};
		undef $ci_type_hash{$cnt};
		undef $relation_hash{$cnt};
	}
}

sub process_level ($$$$$) {
	my ($cmdb_id, $naam, $ci_type, $level, $relation) = @_;
	my $id = $level - 1;
	if (defined $cmdb_id_hash{$id}) {
		handle_relation($cmdb_id_hash{$id}, $naam_hash{$id}, $ci_type_hash{$id},
			            $relation, $cmdb_id, $naam, $ci_type);
		store_level($cmdb_id, $naam, $ci_type, $level, $relation);
	} else {
		my $msg = "No previous record found for ID $cmdb_id, $naam, $ci_type on level $level and relation $relation\n";
		$log->fatal($msg);
		exit_application(1);
	}
}

sub evaluate_rel($$$$$$) {
	my ($relation, $level);
	my ($naam_tpo, $cmdb_id_tpo, $rel_str, $ci_type, $cmdb_id, $naam) = @_;
	# Get type and index of relation
	$rel_str = trim($rel_str);
	if (index($rel_str, "G") > -1) {
		# Gebruiksrelatie
		$relation = "maakt gebruik van";
		$level = substr $rel_str, -4, 1;
	} else {
		$relation = "is afhankelijk van";
		$level = substr $rel_str, -3, 1;
	}
	if ($level == 1) {
		if ($cmdb_id_tpo > -1) {
			# Relation to toepassingsomgeving
			if ($rel_str eq "G") {
				handle_relation($cmdb_id, $naam, $ci_type, $relation, 
					        $cmdb_id_tpo, $naam_tpo, "Toepassingomgeving");
			} else {
				handle_relation($cmdb_id_tpo, $naam_tpo, "Toepassingomgeving",
							    $relation, $cmdb_id, $naam, $ci_type);
			}
		} 
		store_level($cmdb_id, $naam, $ci_type, $level, $relation);
	} else {
		process_level($cmdb_id, $naam, $ci_type, $level, $relation);
	}
}

sub handle_ci_records($) {
	my ($hndl_arrayrefs) = @_;
	foreach my $arrayref (@$hndl_arrayrefs) {
		my $naam_tpo = $$arrayref{'Toepassingomgeving'} || "";
		my $cmdb_id_tpo = $$arrayref{'CMDB referentie omgeving'} || "";
		my $rel_str = $$arrayref{'relatie'} || "";
		my $ci_type = $$arrayref{'CI type'} || "";
		my $cmdb_id = $$arrayref{'CI CMDB referentie'} || "";
		my $naam = $$arrayref{'CI systeemnaam'} || "";
		evaluate_rel($naam_tpo, $cmdb_id_tpo, $rel_str, $ci_type, 
			         $cmdb_id, $naam);
	}
}

sub load_records($) {
	# Remove last comma from $all_valuestr
	my ($all_valuestr) = @_;
	$all_valuestr = substr $all_valuestr, 0, -1;
	my $query = "INSERT INTO relations (cmdb_id_source, naam_source, ci_type_source, relation,
								 cmdb_id_target, naam_target, ci_type_target)
	  		     VALUES $all_valuestr";
	unless (do_stmt($dbh, $query)) {
		$log->fatal("Could not load relation records.");
		exit_application(1);
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

# Drop table relations if exists
my $query = "DROP TABLE IF EXISTS relations";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table relations.");
	exit_application(1);
}

# Create table relations
$query = "CREATE TABLE relations (
			cmdb_id_source INT NOT NULL,
			naam_source VARCHAR(255) NOT NULL,
			ci_type_source VARCHAR(255) NOT NULL,
			relation VARCHAR(255) NOT NULL,
			cmdb_id_target INT NOT NULL,
			naam_target VARCHAR(255) NOT NULL,
			ci_type_target VARCHAR(255) NOT NULL)
		  ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table relations");
	exit_application(1);
}

# Get Toepassingcomponentinstallatie - Bedrijfstoepassing relations first
$query = "SELECT distinct `Toepassingomgeving`, `CMDB referentie omgeving`, 
				 `CMDB referentie bedrijfstoepassing`, `Naam bedrijfstoepassing` 
		  FROM `cmwbt0011` WHERE `CMDB referentie omgeving` > 0";
my $ref = do_select($dbh, $query);
unless (defined $ref) {
	exit_application(1);
}
handle_bedrijfstoepassingen($ref);

# Get all the component relation information
$query = "SELECT `Toepassingomgeving`, `CMDB referentie omgeving`, 
				 `relatie`, `CI type`, `CI CMDB referentie`, `CI systeemnaam` 
		  FROM `cmwbt0011`
		  ORDER BY ID ASC";
$ref = do_select($dbh, $query);
unless (defined $ref) {
	exit_application(1);
}
handle_ci_records($ref);

# Now insert all relations into the relations table
my $cnt = 0;
my $all_valuestr;
foreach my $values (keys %allvalues) {
	$cnt++;
	$all_valuestr .= $values . ",";
	if ($cnt > 1000) {
		# Load records in table
		load_records($all_valuestr);
		$cnt = 0;
		$all_valuestr = "";
	}
}
# Also load the remaining records
if (length($all_valuestr) > 0) {
	load_records($all_valuestr);
}

# Add Indexes to the relation table
$query = "ALTER TABLE  `relations` ADD INDEX (`cmdb_id_source`)";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not add index cmdb_id_source to relations table");
	exit_application(1);
}
$query = "ALTER TABLE  `relations` ADD INDEX (`cmdb_id_target`)";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not add index cmdb_id_target to relations table");
	exit_application(1);
}

exit_application(0);

=head1 To Do

=over 4

=item *

Count number of distinct records. For now the assumption is that the table only has unique records.

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
