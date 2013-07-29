=head1 NAME

find_apps - Find Applications that are related to Boudewijn.

=head1 VERSION HISTORY

version 1.0 07 June 2013 DV

=over 4

=item *

Initial release.

=back

=head1 DESCRIPTION

This script find the Applications that relate to the Boudewijn Computercenter.

=head1 SYNOPSIS

 find_apps.pl [-t] [-l log_dir]

 find_apps -h	Usage
 find_apps -h 1  Usage and description of the options
 find_apps -h 2  All documentation

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

my ($logdir, $dbh);
my $fys_srv_bd = 0;
my $solaris_bd = 0;
my $used_comp_bd = 0;
my $printerror = 0;
my $filedir = "c:/temp/";

#####
# use
#####

use warnings;			    # show warning messages
no warnings "recursion";
use strict 'vars';
use strict 'refs';
use strict 'subs';
use Getopt::Std;		    # Handle input params
use Pod::Usage;			    # Allow Usage information
use DBI();
use Log;
use dbParams_vo;

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
	close FH;
	logging("Exit application with return code $return_code.\n");
    close_log();
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
	my ($cmdb_id, $use_rel) = @_;
	my $query = "SELECT relation, cmdb_id_target, naam_target, ci_type_target, os, locatie
				 FROM relations, component
				 WHERE cmdb_id_source = '$cmdb_id'
				   AND cmdb_id_target = cmdb_id";
	my $sth = $dbh->prepare($query);
	my $rv = $sth->execute();
	if (not defined $rv) {
		error("Could not execute query $query, Error: ".$sth->errstr);
		exit_application(1);
	}
	my $ref = $sth->fetchall_arrayref();
	foreach my $arrayhdl (@$ref) {
		my $relation = @$arrayhdl[0];
		my $cmdb_id_target = @$arrayhdl[1];
		my $naam_target = @$arrayhdl[2];
		my $ci_type_target = @$arrayhdl[3];
		my $os = @$arrayhdl[4];
		my $locatie = @$arrayhdl[5];
		if ($relation eq "maakt gebruik van") {
			$use_rel = "Yes";
			next;
		}
		if ($ci_type_target eq "FYSIEKE COMPUTER") {
			if (index($locatie, "-1C Computerzaal") > -1) {
				if ($use_rel eq "Yes") {
					$used_comp_bd++;
				} else {
					$fys_srv_bd++;
					if ($os eq "SOLARIS") {
						$solaris_bd++;
					}
				}
			}
		}
		go_down($cmdb_id_target, $use_rel);
	}
}

######
# Main
######

# Handle input values
my %options;
getopts("tl:h:c:b:g", \%options) or pod2usage(-verbose => 0);
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
# Trace required?
if (defined $options{"t"}) {
    Log::trace_flag(1);
    trace("Trace enabled");
}
# Find log file directory
if ($options{"l"}) {
    $logdir = logdir($options{"l"});
    if (not(defined $logdir)) {
		error("Could not set $logdir as Log directory, exiting...");
		exit_application(1);
    }
} else {
    $logdir = logdir();
    if (not(defined $logdir)) {
		error("Could not find default Log directory, exiting...");
		exit_application(1);
    }
}
if (-d $logdir) {
    trace("Logdir: $logdir");
} else {
    pod2usage(-msg     => "Cannot find log directory $logdir",
	      -verbose => 0);
}
# Logdir found, start logging
open_log();
logging("Start application");
# Show input parameters
while (my($key, $value) = each %options) {
    logging("$key: $value");
    trace("$key: $value");
}
# End handle input values

# Make database connection for vo database
my $connectionstring = "DBI:mysql:database=$database;host=$server;port=$port";
$dbh = DBI->connect($connectionstring, $username, $password,
		   {'PrintError' => $printerror,    # Set to 1 for debug info
		    'RaiseError' => 0});	    	# Do not die on error
if (not defined $dbh) {
   	error("Could not open $database, exiting...");
   	exit_application(1);
}

my $filename = "$filedir/toepassingen.csv";
my $openres = open (FH, ">$filename");
if (not(defined $filename)) {
	error("Could not open $filename for writing, exiting...");
	exit_application(1);
}

# Find all IDs for toepassingcomponentinstallatie
my $query = "SELECT cmdb_id, naam
			 FROM component
			 WHERE ci_class = 'toepassingcomponentinstallatie'";
my $sth = $dbh->prepare($query);
my $rv = $sth->execute();
if (not defined $rv) {
	error("Could not execute query $query, Error: ".$sth->errstr);
	exit_application(1);
}
my $ref = $sth->fetchall_arrayref();
foreach my $arrayhdl (@$ref) {
	$fys_srv_bd = 0;
	$solaris_bd = 0;
	$used_comp_bd = 0;
	my $use_rel = "No";
	my $cmdb_id = @$arrayhdl[0];
	my $naam = @$arrayhdl[1];
	print "Checking for $naam ($cmdb_id)\n";
	go_down($cmdb_id, $use_rel);
	print FH "$cmdb_id;$naam;$fys_srv_bd;$solaris_bd;$used_comp_bd\n";
}

exit_application(1);

# exit_application(0);

=head1 To Do

=over 4

=item *

Count number of distinct records. For now the assumption is that the table only has unique records.

=back

=head1 AUTHOR

Any suggestions or bug reports, please contact E<lt>dirk.vermeylen@hp.comE<gt>
