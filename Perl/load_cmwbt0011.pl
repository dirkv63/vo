=head1 NAME

load_cmwbt0011 - This script will load the excel report cmwbt0011 into table vo.cmwbt0011_Work.

=head1 VERSION HISTORY

version 1.0 22 July 2013 DV

=over 4

Initial release.

=back

=head1 DESCRIPTION

This script will load the report cmwbt0011 into the table cmwbt0011_work. The script process_cmwbt0011.pl then needs to convert the table into cmwbt0011 for further processing.

=head1 SYNOPSIS

 load_cmwbt0011.pl [-x cmwbt0011.xls file]

 load_cmwbt0011 -h	Usage
 load_cmwbt0011 -h 1  Usage and description of the options
 load_cmwbt0011 -h 2  All documentation

=head1 OPTIONS

=over 4

=item B<-x Full path to CMWBT0011 file in .xls format>

Full path and file to the CMWBT0011 report. The report needs to be in .xls format, since the Perl application cannot handle .xlsx files.

If -x is not specified, the vo.ini parameter DATAWAREHOUSE.cmwbt0011 is read.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $cfg, $dbh, $xls_file);
my $table = "cmwbt0011_work";

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
# use dbParams_vo;
use DbUtil qw (db_connect);

use Spreadsheet::ParseExcel;
use Spreadsheet::ParseExcel::Fmt8Bit;
use XlsUtil qw(small_cell_handler import_sheet);

use Data::Dumper;

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
# Get xls file
if (defined $options{"x"}) {
	$xls_file = $options{"x"};
} elsif ($cfg->SectionExists("DATAWAREHOUSE")) {
	if ($cfg->val("DATAWAREHOUSE", "cmwbt0011")) {
		$xls_file = $cfg->val("DATAWAREHOUSE", "cmwbt0011");
	}
}
if (defined $xls_file) {
	if (-r $xls_file) {
		$log->info("Reading Datawarehouse input file $xls_file");
	} else {
		$log->fatal("Cannot read excel file $xls_file.");
		exit_application(1);
	}
} else {
	$log->fatal("Excel file not defined, exiting...");
	exit_application(1);
}

# Show input parameters
if ($log->is_debug()) {
	while (my($key, $value) = each %options) {
		$log->debug("$key: $value");
	}
}
# End handle input values

# Make database connection for vo database
$dbh = db_connect('vo') or exit_application(1);

# Truncate table
if ($dbh->do("truncate $table")) {
	$log->debug("Table $table truncated");
} else {
	$log->fatal("Failed to truncate `$table'. Error: " . $dbh->errstr);
	exit_application(1);
}

# Open Excel object, define cell handler for memory savings
$log->info("Launch excel");
my $InExcel = Spreadsheet::ParseExcel->new(CellHandler => \&small_cell_handler, 
NotSetCell => 1);
if (not(defined $InExcel)) {
	$log->fatal("Can't launch Excel, exiting...");
	exit_application(1);
}

# Launch the Excel Formatter
$log->info("Launch excel formatter");
my $oFmt = new Spreadsheet::ParseExcel::Fmt8Bit;
if (not(defined $oFmt)) {
	$log->fatal("Can't launch Excel Formatter, exiting...");
	exit_application(1);
}

$log->info("Parse file into workbook object");
my $workbook = $InExcel->parse($xls_file);
if (not(defined $workbook)) {
	$log->fatal("Can't parse excel file $xls_file: " . $InExcel->error());
	exit_application(1);
}

# Get the worksheets in the workbook
$log->info("Get the worksheets in the workbook");
my $worksheets;
foreach my $worksheet ($workbook->worksheets()) {
	my $worksheet_name = $worksheet->get_name;
	$worksheets->{$worksheet_name} = $worksheet;
	$log->debug("Ready to load worksheet: $worksheet_name");
#	if ($log->is_trace()) {
#		$log->trace(Dumper $worksheet->{SmallCells});
#	}
	import_sheet($worksheet, $dbh, $table, 10, "RLS0011");
}

exit_application(0);

=head1 To Do

=over 4

=item *

Nothing for now...

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
