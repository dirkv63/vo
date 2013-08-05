@echo off
@echo
@echo Data collection for Components
@echo
perl sw_component_checks.pl
@echo
@echo Data collection for Jobs
@echo
perl jobs_checks.pl
@echo
@echo Data collection for Systems
@echo
perl system_checks.pl
@echo
@echo Consolidation of all information into Application and migration report
@echo
perl apps_check.pl
