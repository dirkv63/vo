=head1 NAME

strip_urls.pl - This script reads table with multiple URLs in cell and converts to one URL per record.

=head1 VERSION HISTORY

version 1.0 08 January 2015 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

See title.

=head1 SYNOPSIS

 strip_urls.pl 

 strip_urls -h	Usage
 strip_urls -h 1  Usage and description of the options
 strip_urls -h 2  All documentation

=head1 OPTIONS

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

use FindBin;
use lib "$FindBin::Bin/lib";

use warnings;			    # show warning messages
use strict 'vars';
use strict 'refs';
use strict 'subs';
use Getopt::Std;		    # Handle input params
use Pod::Usage;			    # Allow Usage information
use DBI();
use DbUtil qw(db_connect do_select create_record);

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

sub strip_urls($$$) {
	my ($nr, $naam, $urls) = @_;
	my $startpos = index($urls, "http");
	my $endpos = index($urls, "http", $startpos + 1);
	if ($endpos < $startpos) {
		$endpos = length($urls);
	}
	my $URL = substr($urls, $startpos, $endpos - $startpos);
	chomp($URL);
	$urls = substr($urls, $endpos - 1);
	
	my @fields = qw(nr naam URL);
	my (@vals) = map { eval ("\$" . $_ ) } @fields;
    unless (create_record($dbh, "2loadurls", \@fields, \@vals)) {
        $log->fatal("Could not insert record into 2loadurls");
	    exit_application(1);
	}
	return $urls;
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
#     if ($options{"h"} == 0) {
#         pod2usage(-verbose => 0);
#     } elsif ($options{"h"} == 1) {
#         pod2usage(-verbose => 1);
#     } else {
# 		pod2usage(-verbose => 2);
# 	}
# }
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

# Truncate table
my @tables = qw (2loadurls);
foreach my $table (@tables) {
    if ($dbh->do("delete from $table")) {
	    $log->debug("Table $table truncated");
    } else {
	    $log->fatal("Failed to truncate `$table'. Error: " . $dbh->errstr);
	    exit_application(1);
    }
}

# Slurp all records
my $query = "SELECT nr, naam, URL from 2loadbis";
my $ref = do_select($dbh, $query);
foreach my $arrayhdl (@$ref) {
	my $nr = $$arrayhdl{nr};
	my $naam = $$arrayhdl{naam};
	my $urls = $$arrayhdl{URL} || "";
	while (index($urls, "http") > -1) {
		$urls = strip_urls($nr, $naam, $urls);
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
