=head1 NAME

load_cmwsi0006 - This script will load the excel report cmwsi0006 into table vo.cmwsi0006.

=head1 VERSION HISTORY

version 1.0 24 July 2013 DV

=over 4

Initial release.

=back

=head1 DESCRIPTION

This script will load the report cmwsi0006 into the table cmwsi0006_work.

=head1 SYNOPSIS

 load_cmwsi0006.pl [-x cmwsi0006.xls file]

 load_cmwsi0006 -h	Usage
 load_cmwsi0006 -h 1  Usage and description of the options
 load_cmwsi0006 -h 2  All documentation

=head1 OPTIONS

=over 4

=item B<-x Full path to cmwsi0006 file in .xls format>

Full path and file to the cmwsi0006 report. The report needs to be in .xls format, since the Perl application cannot handle .xlsx files.

If -x is not specified, then parameter DATAWAREHOUSE.cmwsi0006 is read to find the report location.

=back

=head1 ADDITIONAL DOCUMENTATION

=cut

###########
# Variables
########### 

my ($log, $dbh, $xls_file);

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
use DbUtil qw (db_connect do_stmt);

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
my $cfg = load_ini($ini);
# Start logging
setup_logging;
$log = get_logger();
$log->info("Start application");
# Get xls file
if (defined $options{"x"}) {
	$xls_file = $options{"x"};
} elsif ($cfg->SectionExists("DATAWAREHOUSE")) {
	if ($cfg->val("DATAWAREHOUSE", "cmwsi0006")) {
		$xls_file = $cfg->val("DATAWAREHOUSE", "cmwsi0006");
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

# Truncate tables
my @tables = qw (cmwsi0006_work);
foreach my $table (@tables) {
	if ($dbh->do("truncate $table")) {
		$log->debug("Table $table truncated");
	} else {
		$log->fatal("Failed to truncate `$table'. Error: " . $dbh->errstr);
		exit_application(1);
	}
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

# Get spider data in CMDB
my @worksheets = $workbook->worksheets();
my $worksheet = $worksheets[0];
my $worksheet_name = $worksheet->get_name;
$log->info("Ready to load worksheet: $worksheet_name");
import_sheet($worksheet, $dbh, "cmwsi0006_work", 4, "Overzicht");

my $query = "DROP TABLE if exists cmwsi0006";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table cmwsi0006, exiting...");
	exit_appilcation(1);
}

$query = "CREATE TABLE cmwsi0006
		  SELECT distinct `CMDB referentie` as cmdb_id, 
				 `Systeemnaam` as naam, 
				 `Kenmerk` as kenmerk,
				 `Serienummer server` as serienummer 
		  FROM `cmwsi0006_work`";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table cmwsi0006, exiting...");
	exit_application(1);
}

$query = "ALTER TABLE  `cmwsi0006` ENGINE = MYISAM";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not set cmswi0006 Engine to MyISAM");
	exit_application(1);
}

$query = "ALTER TABLE `cmwsi0006` ADD PRIMARY KEY(`cmdb_id`)";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not set cmdb_id as primary key");
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
