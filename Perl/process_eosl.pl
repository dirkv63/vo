=head1 NAME

Process EOSL - This file will add EOSL data to the Component.

=head1 VERSION HISTORY

version 1.1 24 July 2014 DV

=over 4

=item *

Update to Pauwel scripting

=item *

Read from RLS0013_work table.

=back

version 1.0 09 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will read the report RLS0013 on CMDB ID and add the EOSL dates to the vo.component table.

=head1 SYNOPSIS

 process_eosl.pl 

 process_eosl -h	Usage
 process_eosl -h 1  Usage and description of the options
 process_eosl -h 2  All documentation

=head1 OPTIONS

=over 4

This script takes no options.

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
use DbUtil qw(db_connect do_select do_stmt create_record);

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

######
# Main
######

# Handle input values
my %options;
getopts("h:", \%options) or pod2usage(-verbose => 0);
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
# Show input parameters
if ($log->is_trace()) {
	while (my($key, $value) = each %options) {
		$log->trace("$key: $value");
	}
}
# End handle input values

# Make database connection for vo database
$dbh = db_connect("vo") or exit_application(1);

# Drop table eosl if exists
my $query = "DROP TABLE IF EXISTS eosl";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table eosl, exiting...");
	exit_application(1);
}

# CREATE table EOSL
# Table eosl_raw needs to have cmdb_id, naam, standaarddatum, uitdovend_datum, uitgedoofd_datum
# Table eosl_raw should not have ID! (otherwise each raw is unique)
$query = "CREATE TABLE IF NOT EXISTS `eosl` (
			  `ID` int(11) NOT NULL AUTO_INCREMENT,
			  `cmdb_id` double DEFAULT NULL,
			  `naam` varchar(255) DEFAULT NULL,
			  `standaarddatum` date DEFAULT NULL,
			  `uitdovend_datum` date DEFAULT NULL,
			  `uitgedoofd_datum` date DEFAULT NULL,
			  PRIMARY KEY (`ID`)
		  ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table eosl, exiting...");
	exit_application(1);
}

# Check that each cmdb_id occurs only once
$query = "SELECT `CI CMDB referentie`, `CI systeemnaam`,`Standaarddatum`,
				 `Uitdovend datum`, `Uitgedoofd datum` 
		  FROM `rls0013_work`
		  WHERE NOT ((`Standaarddatum` is null) 
			     AND (`Uitdovend datum` is null) 
				 AND (`Uitgedoofd datum` is null))";
my $ref = do_select($dbh, $query);
foreach my $cmdb_ref (@$ref) {
	my $cmdb_id = $$cmdb_ref{'CI CMDB referentie'};
	my $naam = $$cmdb_ref{'CI systeemnaam'};
	my $standaarddatum = $$cmdb_ref{'Standaarddatum'};
	my $uitdovend_datum = $$cmdb_ref{'Uitdovend datum'};
	my $uitgedoofd_datum = $$cmdb_ref{'Uitgedoofd datum'};
	my @fields = qw (cmdb_id naam standaarddatum uitdovend_datum uitgedoofd_datum);
	my (@vals) = map { eval ("\$" . $_ ) } @fields;
	unless (create_record($dbh, "eosl", \@fields, \@vals)) {
			$log->fatal("Could not create record for $naam $cmdb_id");
			exit_application(1);
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
