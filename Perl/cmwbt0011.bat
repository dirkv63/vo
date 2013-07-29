SET WORKDIR=C:\Development\Perl\vo
perl %WORKDIR%\load_cmwbt0011.pl -x %1
perl %WORKDIR%\process_cmwbt0011.pl
perl %WORKDIR%\get_data_cmwbt0011.pl
perl %WORKDIR%\get_rels_cmwbt0011.pl
