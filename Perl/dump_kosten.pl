=head1 NAME

dump_kosten - This script will dump the kostenelement table for refinement.

=head1 VERSION HISTORY

version 1.0 30 July 2013 DV

=over 4

Initial release.

=back

=head1 DESCRIPTION

This script will dump the Kost Elementen file.

=head1 SYNOPSIS

 dump_kosten.pl

 dump_kosten -h	Usage
 dump_kosten -h 1  Usage and description of the options
 dump_kosten -h 2  All documentation

=head1 OPTIONS

=over 4

No options have been specified.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh);
my @fields = qw( element ci_type ci_categorie computertype waarde);

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
use DbUtil qw (db_connect);

use Data::Dumper;

use IniUtil qw (load_ini get_ini);
use Log::Log4perl qw (get_logger);
use SimpleLog qw (setup_logging);
use XlsWrite qw(write_table);

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
	$log->info("Exit application with return code $return_code.\n");
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
getopts("h:x:", \%options) or pod2usage(-verbose => 0);
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
if ($log->is_debug()) {
	while (my($key, $value) = each %options) {
		$log->debug("$key: $value");
	}
}
# End handle input values

# Make database connection for vo database
$dbh = db_connect('vo') or exit_application(1);

# Export the results to excel files
$log->info("Export kostenelementen to excel");
my $nr_lines = write_table($dbh, "kostelementen",\@fields);
if (defined $nr_lines) {
	$log->info("$nr_lines lines exported into excel file");
} else {
	$log->fatal("Could not create excel report for table kostelementen");
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
