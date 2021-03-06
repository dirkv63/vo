@echo off
@echo Data collection for Components
@echo ******************************
perl sw_component_checks.pl
@echo Data collection for Jobs
@echo ************************
perl jobs_checks.pl
@echo Data collection for Systems
@echo ***************************
perl system_checks.pl
@echo Consolidation of all information into Application and migration report
@echo **********************************************************************
perl apps_check.pl
@echo Collect information for Isolated Servers
@echo ****************************************
perl system_cost.pl
@echo Collect virtual systems associated with Isolated Servers
@echo ********************************************************
perl virt_syst_cost.pl
@echo Verify all computer systems are handled somewhere
@echo *************************************************
perl system_verification.pl
