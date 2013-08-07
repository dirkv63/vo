=head1 NAME

load_cmwsi0514 - This script will load the excel report cmwsi0514 into table vo.cmwsi0514.

=head1 VERSION HISTORY

version 1.0 24 July 2013 DV

=over 4

Initial release.

=back

=head1 DESCRIPTION

This script will load the report cmwsi0514 into the table cmwsi0514.

=head1 SYNOPSIS

 load_cmwsi0514.pl [-x cmwsi0514.xls file]

 load_cmwsi0514 -h	Usage
 load_cmwsi0514 -h 1  Usage and description of the options
 load_cmwsi0514 -h 2  All documentation

=head1 OPTIONS

=over 4

=item B<-x Full path to cmwsi0514 file in .xls format>

Full path and file to the cmwsi0514 report. The report needs to be in .xls format, since the Perl application cannot handle .xlsx files.

If -x is not specified, then parameter DATAWAREHOUSE.cmwsi0514 is read to find the report location.

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
use DbUtil qw (db_connect do_stmt do_select singleton_select);

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

=pod

=head2 Remove Duplicates

There are duplicate records in cmwsi0514. The assumption is that this is due to changes in BHV history. Therefore find duplicate records, find youngest BHV date and throw away records with older BHV start dates.

=cut

sub remove_duplicates($) {
	my ($cmdb_id) = @_;
	$log->trace("Remove duplicates for $cmdb_id");
	# First get max 'Begindatum BHV'
	my $query = "SELECT max(begindatum_bhv) as begindatum_bhv
				   FROM cmwsi0514
				   WHERE cmdb_id = $cmdb_id";
	my $ref = singleton_select($dbh, $query);
	my $record = @$ref[0];
	my $begindatum_bhv = $$record{begindatum_bhv};
	# Now throw away the duplicate records
	$query = "DELETE FROM cmwsi0514
			   WHERE cmdb_id = $cmdb_id
			    AND (NOT (begindatum_bhv = '$begindatum_bhv'))";
	unless (do_stmt($dbh, $query)) {
		$log->fatal("Could not remove duplicate records from cmwsi0514");
		exit_application(1);
	}
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
	if ($cfg->val("DATAWAREHOUSE", "cmwsi0514")) {
		$xls_file = $cfg->val("DATAWAREHOUSE", "cmwsi0514");
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
my @tables = qw (cmwsi0514_work);
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
import_sheet($worksheet, $dbh, "cmwsi0514_work", 4);

my $query = "DROP TABLE if exists cmwsi0514";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not drop table cmwsi0514, exiting...");
	exit_appilcation(1);
}

$query = "CREATE TABLE cmwsi0514
		  SELECT distinct `CMDB Referentie` as cmdb_id, 
						  `Systeemnaam` as naam,  
						  `Dienstentype` as dienstentype, 
						  `ICT dienstverlener` as dienstverlener, 
						  `Omgevingtype` as omgeving,
						  `Financieel beheerder` as financieel_beheerder,
						  `Eigenaar` as eigenaar,
						  `Begindatum BHV` as begindatum_bhv
		  FROM `cmwsi0514_work` 
		  WHERE `Locatie` = 'Boudewijn - Brussel/-1C Computerzaal'";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not create table cmwsi0514, exiting...");
	exit_application(1);
}

$query = "ALTER TABLE  `cmwsi0514` ENGINE = MYISAM";
unless (do_stmt($dbh, $query)) {
	$log->fatal("Could not set cmswi0006 Engine to MyISAM");
	exit_application(1);
}

$log->info("Remove duplicates from cmwsi0514");
# Now find and remove duplicate cmdb_ids
$query = "SELECT count(*) as cnt, cmdb_id
			FROM cmwsi0514
			GROUP BY cmdb_id
			HAVING cnt > 1";
my $ref = do_select($dbh, $query);
foreach my $record (@$ref) {
	my $cmdb_id = $$record{cmdb_id};
	remove_duplicates($cmdb_id);
}

$query = "ALTER TABLE `cmwsi0514` ADD PRIMARY KEY(`cmdb_id`)";
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
