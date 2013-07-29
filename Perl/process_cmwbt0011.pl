=head1 NAME

process_cmwbt0011 - This file gets the data from table vo.cmwbt0011_work and modifies column names to the required values.

=head1 VERSION HISTORY

version 1.1 22 July 2013 DV

=over 4

Update to Pauwel processing for log file and database select.

=back

version 1.0 17 July 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script will handle the one-time actions for CMWBT0011_OR_Inventaris HW-SW configuratie per toepassingscomponent.

=head1 SYNOPSIS

 process_cmwbt0011.pl 

 process_cmwbt0011 -h	Usage
 process_cmwbt0011 -h 1  Usage and description of the options
 process_cmwbt0011 -h 2  All documentation

=head1 OPTIONS

=over 4

This table runs without options.

=back

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
use DbUtil qw (db_connect do_stmt);

use IniUtil qw (load_ini get_ini);
use Log::Log4perl qw (get_logger);
use SimpleLog qw (setup_logging);

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
$dbh = db_connect('vo') or exit_application(1);

$log->info("Drop and Create table cmwbt0011");
my $query = "DROP TABLE IF EXISTS cmwbt0011";
do_stmt($dbh, $query);
$query = "CREATE TABLE cmwbt0011 
			ENGINE=MyISAM
			SELECT * FROM cmwbt0011_work";
do_stmt($dbh, $query);

$log->info("Modify Field names");
$log->info("Field17 => bt Datum in gebruik");
# Modify Field names
$query = "ALTER TABLE cmwbt0011
			 CHANGE Field17 `bt Datum in gebruik`
			 DATETIME NULL DEFAULT NULL";
do_stmt($dbh, $query);

$log->info("Field18 => bt Datum buiten gebruik");
$query = "ALTER TABLE cmwbt0011
			 CHANGE Field18 `bt Datum buiten gebruik`
			 DATETIME NULL DEFAULT NULL";
do_stmt($dbh, $query);

$log->info("Field21 => relatie");
$query = "ALTER TABLE cmwbt0011
			 CHANGE Field21 `relatie`
			 VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL";
do_stmt($dbh, $query);

$log->info("Field30 => ci_versie");
$query = "ALTER TABLE cmwbt0011
			 CHANGE Field30 `ci_versie`
			 VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL";
do_stmt($dbh, $query);

exit_application(0);

=head1 To Do

=over 4

=item *

Nothing for now...

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
