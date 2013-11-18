set define off
set verify off
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
 
--application/set_environment
prompt  APPLICATION 175 - Raming DC Verhuis
--
-- Application Export:
--   Application:     175
--   Name:            Raming DC Verhuis
--   Date and Time:   14:16 Monday November 18, 2013
--   Exported By:     VERMEYDI
--   Flashback:       0
--   Export Type:     Application Export
--   Version:         4.2.1.00.08
--   Instance ID:     69320437437387
--
-- Import:
--   Using Application Builder
--   or
--   Using SQL*Plus as the Oracle user APEX_040200 or as the owner (parsing schema) of the application
 
-- Application Statistics:
--   Pages:                     13
--     Items:                   13
--     Processes:                7
--     Regions:                 13
--     Buttons:                  2
--     Dynamic Actions:          5
--   Shared Components:
--     Logic:
--     Navigation:
--       Parent Tabs:            3
--       Tab Sets:               3
--         Tabs:                 8
--       Breadcrumbs:            1
--         Entries:              1
--       NavBar Entries:         1
--     Security:
--       Authentication:         2
--     User Interface:
--       Themes:                 1
--       Templates:
--         Page:                19
--         Region:              36
--         Label:                6
--         List:                19
--         Popup LOV:            1
--         Calendar:             3
--         Breadcrumb:           2
--         Button:              10
--         Report:              11
--       Shortcuts:              1
--     Globalization:
--     Reports:
 
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040200 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,51155200479522588));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2012.01.01');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,175);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

--application/delete_application
 
begin
 
   -- Remove Application
wwv_flow_api.remove_flow(nvl(wwv_flow_application_install.get_application_id,175));
 
end;
/

 
begin
 
wwv_flow_audit.remove_audit_trail(nvl(wwv_flow_application_install.get_application_id,175));
null;
 
end;
/

prompt  ...ui types
--
 
begin
 
null;
 
end;
/

--application/create_application
 
begin
 
wwv_flow_api.create_flow(
  p_id    => nvl(wwv_flow_application_install.get_application_id,175),
  p_display_id=> nvl(wwv_flow_application_install.get_application_id,175),
  p_owner => nvl(wwv_flow_application_install.get_schema,'APEX_USER_019'),
  p_name  => nvl(wwv_flow_application_install.get_application_name,'Raming DC Verhuis'),
  p_alias => nvl(wwv_flow_application_install.get_application_alias,'F_175'),
  p_page_view_logging => 'YES',
  p_page_protection_enabled_y_n=> 'Y',
  p_checksum_salt_last_reset => '20131118141616',
  p_max_session_length_sec=> null,
  p_compatibility_mode=> '4.2',
  p_html_escaping_mode=> 'E',
  p_flow_language=> 'nl-be',
  p_flow_language_derived_from=> 'FLOW_PRIMARY_LANGUAGE',
  p_allow_feedback_yn=> 'N',
  p_date_format=> 'DD-MON-YYYY HH24:MI:SS',
  p_date_time_format=> 'DD-MON-YYYY HH24:MI:SS',
  p_timestamp_format=> 'DD-MON-YYYY HH24:MI:SS',
  p_timestamp_tz_format=> 'DD-MON-YYYY HH24:MI:SS',
  p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'/j/'),
  p_publish_yn=> 'N',
  p_documentation_banner=> '',
  p_authentication=> 'PLUGIN',
  p_authentication_id=> 59509031821229301 + wwv_flow_api.g_id_offset,
  p_logout_url=> '',
  p_application_tab_set=> 0,
  p_logo_image => 'TEXT:Raming DC Verhuis',
  p_public_url_prefix => '',
  p_public_user=> 'APEX_PUBLIC_USER',
  p_dbauth_url_prefix => '',
  p_proxy_server=> nvl(wwv_flow_application_install.get_proxy,''),
  p_cust_authentication_process=> '',
  p_cust_authentication_page=> '',
  p_flow_version=> 'release 1.0',
  p_flow_status=> 'AVAILABLE_W_EDIT_LINK',
  p_flow_unavailable_text=> 'This application is currently unavailable at this time.',
  p_build_status=> 'RUN_AND_BUILD',
  p_exact_substitutions_only=> 'Y',
  p_browser_cache=>'N',
  p_browser_frame=>'D',
  p_deep_linking=>'Y',
  p_vpd=> '',
  p_vpd_teardown_code=> '',
  p_authorize_public_pages_yn=>'N',
  p_csv_encoding=> 'Y',
  p_include_legacy_javascript=> 'Y',
  p_default_error_display_loc=> 'INLINE_WITH_FIELD_AND_NOTIFICATION',
  p_last_updated_by => 'VERMEYDI',
  p_last_upd_yyyymmddhh24miss=> '20131118141616',
  p_ui_type_name => null,
  p_required_roles=> wwv_flow_utilities.string_to_table2(''));
 
 
end;
/

prompt  ...user interfaces
--
 
begin
 
--application/user interface/desktop
wwv_flow_api.create_user_interface (
  p_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_ui_type_name => 'DESKTOP'
 ,p_display_name => 'Desktop'
 ,p_display_seq => 10
 ,p_use_auto_detect => false
 ,p_is_default => true
 ,p_theme_id => 26
 ,p_home_url => 'f?p=&APP_ID.:15:&SESSION.'
 ,p_login_url => 'f?p=&APP_ID.:LOGIN_DESKTOP:&SESSION.'
  );
null;
 
end;
/

prompt  ...plug-in settings
--
 
begin
 
--application/plug-in setting/item_type_native_yes_no
wwv_flow_api.create_plugin_setting (
  p_id => 57405507199816149 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_type => 'ITEM TYPE'
 ,p_plugin => 'NATIVE_YES_NO'
 ,p_attribute_01 => 'Y'
 ,p_attribute_03 => 'N'
  );
null;
 
end;
/

prompt  ...authorization schemes
--
 
begin
 
null;
 
end;
/

--application/shared_components/navigation/navigation_bar
prompt  ...navigation bar entries
--
 
begin
 
wwv_flow_api.create_icon_bar_item(
  p_id => 57416503086816486 + wwv_flow_api.g_id_offset,
  p_flow_id => wwv_flow.g_flow_id,
  p_icon_sequence=> 200,
  p_icon_image => '',
  p_icon_subtext=> 'Logout',
  p_icon_target=> '&LOGOUT_URL.',
  p_icon_image_alt=> 'Logout',
  p_icon_height=> 32,
  p_icon_width=> 32,
  p_icon_height2=> 24,
  p_icon_width2=> 24,
  p_nav_entry_is_feedback_yn => 'N',
  p_icon_bar_disp_cond=> '',
  p_icon_bar_disp_cond_type=> '',
  p_begins_on_new_line=> '',
  p_cell_colspan      => 1,
  p_onclick=> '',
  p_icon_bar_comment=> '');
 
 
end;
/

prompt  ...application processes
--
prompt  ...application items
--
prompt  ...application level computations
--
 
begin
 
null;
 
end;
/

prompt  ...Application Tabs
--
 
begin
 
--application/shared_components/navigation/tabs/standard/t_applicatiemigratie
wwv_flow_api.create_tab (
  p_id=> 64931108655937165 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'TS1',
  p_tab_sequence=> 5,
  p_tab_name=> 'T_APPLICATIEMIGRATIE',
  p_tab_text => 'Applicatie Migratie',
  p_tab_step => 15,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/netwerk
wwv_flow_api.create_tab (
  p_id=> 57443718998894175 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'TS1',
  p_tab_sequence=> 20,
  p_tab_name=> 'Netwerk',
  p_tab_text => 'Netwerk',
  p_tab_step => 2,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/geïsoleerde_servers
wwv_flow_api.create_tab (
  p_id=> 57457513455923264 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'TS1',
  p_tab_sequence=> 30,
  p_tab_name=> 'Geïsoleerde Servers',
  p_tab_text => 'Geïsoleerde Servers',
  p_tab_step => 3,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/beheer_kostelementen
wwv_flow_api.create_tab (
  p_id=> 57643427977005791 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'T_BEHEERKOSTELEMENTEN',
  p_tab_sequence=> 30,
  p_tab_name=> 'Beheer KostElementen',
  p_tab_text => 'Beheer KostElementen',
  p_tab_step => 12,
  p_tab_also_current_for_pages => '13',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/default_kostelementen
wwv_flow_api.create_tab (
  p_id=> 57835608293446160 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'T_BEHEERKOSTELEMENTEN',
  p_tab_sequence=> 40,
  p_tab_name=> 'Default KostElementen',
  p_tab_text => 'Default KostElementen',
  p_tab_step => 14,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/server_applicatie
wwv_flow_api.create_tab (
  p_id=> 57608813965660763 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'T_BIJKOMENDEGEGEVENS',
  p_tab_sequence=> 220,
  p_tab_name=> 'Server -> Applicatie',
  p_tab_text => 'Server -> Applicatie',
  p_tab_step => 5,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/afgeleide_eosl
wwv_flow_api.create_tab (
  p_id=> 57625823392826402 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'T_BIJKOMENDEGEGEVENS',
  p_tab_sequence=> 230,
  p_tab_name=> 'Afgeleide EOSL',
  p_tab_text => 'Afgeleide EOSL',
  p_tab_step => 6,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
--application/shared_components/navigation/tabs/standard/servers_per_rapport
wwv_flow_api.create_tab (
  p_id=> 58629927639655551 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'T_BIJKOMENDEGEGEVENS',
  p_tab_sequence=> 240,
  p_tab_name=> 'Servers per Rapport',
  p_tab_text => 'Servers per Rapport',
  p_tab_step => 16,
  p_tab_also_current_for_pages => '',
  p_tab_parent_tabset=>'main',
  p_tab_comment  => '');
 
 
end;
/

prompt  ...Application Parent Tabs
--
 
begin
 
--application/shared_components/navigation/tabs/parent/t_rapporten
wwv_flow_api.create_toplevel_tab (
  p_id=> 57418125948816653 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'main',
  p_tab_sequence=> 10,
  p_tab_name  => 'T_Rapporten',
  p_tab_text  => 'Rapporten',
  p_tab_target=> 'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:::',
  p_current_on_tabset=> 'TS1',
  p_tab_comment=> '');
 
--application/shared_components/navigation/tabs/parent/t_beheerkostelementen
wwv_flow_api.create_toplevel_tab (
  p_id=> 57631122054882338 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'main',
  p_tab_sequence=> 20,
  p_tab_name  => 'T_BEHEERKOSTELEMENTEN',
  p_tab_text  => 'Beheer KostElementen',
  p_tab_target=> 'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:::',
  p_current_on_tabset=> 'T_BEHEERKOSTELEMENTEN',
  p_tab_comment=> '');
 
--application/shared_components/navigation/tabs/parent/t_bijkomendegegevens
wwv_flow_api.create_toplevel_tab (
  p_id=> 57585926892500228 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_tab_set=> 'main',
  p_tab_sequence=> 30,
  p_tab_name  => 'T_BIJKOMENDEGEGEVENS',
  p_tab_text  => 'Bijkomende Gegevens',
  p_tab_target=> 'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:::',
  p_current_on_tabset=> 'T_BIJKOMENDEGEGEVENS',
  p_tab_comment=> '');
 
 
end;
/

prompt  ...Shared Lists of values
--
prompt  ...Application Trees
--
--application/pages/page_groups
prompt  ...page groups
--
 
begin
 
null;
 
end;
/

--application/comments
prompt  ...comments: requires application express 2.2 or higher
--
 
--application/pages/page_00001
prompt  ...PAGE 1: Apps Checks
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 1
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'TS1'
 ,p_name => 'Apps Checks'
 ,p_step_title => 'Apps Checks'
 ,p_step_sub_title => 'Apps Checks'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131030140233'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
'"ID",'||unistr('\000a')||
'"CMDB_ID",'||unistr('\000a')||
'"NAAM",'||unistr('\000a')||
'"DIENSTENTYPE",'||unistr('\000a')||
'"EIGENAAR_BELEIDSDOMEIN",'||unistr('\000a')||
'"EIGENAAR_ENTITEIT",'||unistr('\000a')||
'"FIN_BELEIDSDOMEIN",'||unistr('\000a')||
'"FIN_ENTITEIT",'||unistr('\000a')||
'"SO_TOEPASSINGSMANAGER",'||unistr('\000a')||
'"VO_APPLICATIEBEHEERDER",'||unistr('\000a')||
'"ASSESSMENT",'||unistr('\000a')||
'"MIGRATIE",'||unistr('\000a')||
'"EOSL_KOST",'||unistr('\000a')||
'"PROJECT_KOST",'||unistr('\000a')||
'"TOTALE_KOST",'||unistr('\000a')||
'"MSGSTR",'||unistr('\000a')||
'"EOSL_STRATEGY",'||unistr('\000a')||
'"COMPUTER_UITDOVEND",'||unistr('\000a')||
'"COMPUTER_UITGEDOOFD",'||unistr('\000a')||
'"COMPONENT_UITDOVEND",'||unistr('\000a')||
'"COMPONENT_UITGEDOOFD",'||unistr('\000a')||
'"OS_UITDOVEND",'||unistr('\000a')||
'"OS_UITGEDO';

s:=s||'OFD",'||unistr('\000a')||
'"CONNECTIONS",'||unistr('\000a')||
'"COMP",'||unistr('\000a')||
'"NO_COMP",'||unistr('\000a')||
'"SW_CNT",'||unistr('\000a')||
'"SW_CNT_BOU",'||unistr('\000a')||
'"JOB_CNT",'||unistr('\000a')||
'"JOB_CNT_BOU"'||unistr('\000a')||
' from   "APPS_CHECKS" '||unistr('\000a')||
'where totale_kost > 0';

wwv_flow_api.create_page_plug (
  p_id=> 57418213150816677 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_plug_name=> 'Applicatie Migratie',
  p_region_name=>'',
  p_escape_on_http_output=>'N',
  p_plug_template=> 57409123273816283+ wwv_flow_api.g_id_offset,
  p_plug_display_sequence=> 10,
  p_plug_new_grid         => false,
  p_plug_new_grid_row     => true,
  p_plug_new_grid_column  => true,
  p_plug_display_column=> null,
  p_plug_display_point=> 'BODY_3',
  p_plug_item_display_point=> 'ABOVE',
  p_plug_source=> s,
  p_plug_source_type=> 'DYNAMIC_QUERY',
  p_translate_title=> 'Y',
  p_plug_query_row_template=> 1,
  p_plug_query_headings_type=> 'COLON_DELMITED_LIST',
  p_plug_query_row_count_max => 500,
  p_plug_display_condition_type => '',
  p_plug_customized=>'0',
  p_plug_caching=> 'NOT_CACHED',
  p_plug_comment=> '');
end;
/
declare
 a1 varchar2(32767) := null;
begin
a1:=a1||'select '||unistr('\000a')||
'"ID",'||unistr('\000a')||
'"CMDB_ID",'||unistr('\000a')||
'"NAAM",'||unistr('\000a')||
'"DIENSTENTYPE",'||unistr('\000a')||
'"EIGENAAR_BELEIDSDOMEIN",'||unistr('\000a')||
'"EIGENAAR_ENTITEIT",'||unistr('\000a')||
'"FIN_BELEIDSDOMEIN",'||unistr('\000a')||
'"FIN_ENTITEIT",'||unistr('\000a')||
'"SO_TOEPASSINGSMANAGER",'||unistr('\000a')||
'"VO_APPLICATIEBEHEERDER",'||unistr('\000a')||
'"ASSESSMENT",'||unistr('\000a')||
'"MIGRATIE",'||unistr('\000a')||
'"EOSL_KOST",'||unistr('\000a')||
'"PROJECT_KOST",'||unistr('\000a')||
'"TOTALE_KOST",'||unistr('\000a')||
'"MSGSTR",'||unistr('\000a')||
'"EOSL_STRATEGY",'||unistr('\000a')||
'"COMPUTER_UITDOVEND",'||unistr('\000a')||
'"COMPUTER_UITGEDOOFD",'||unistr('\000a')||
'"COMPONENT_UITDOVEND",'||unistr('\000a')||
'"COMPONENT_UITGEDOOFD",'||unistr('\000a')||
'"OS_UITDOVEND",'||unistr('\000a')||
'"OS_UITGEDO';

a1:=a1||'OFD",'||unistr('\000a')||
'"CONNECTIONS",'||unistr('\000a')||
'"COMP",'||unistr('\000a')||
'"NO_COMP",'||unistr('\000a')||
'"SW_CNT",'||unistr('\000a')||
'"SW_CNT_BOU",'||unistr('\000a')||
'"JOB_CNT",'||unistr('\000a')||
'"JOB_CNT_BOU"'||unistr('\000a')||
' from   "APPS_CHECKS" '||unistr('\000a')||
'where totale_kost > 0';

wwv_flow_api.create_worksheet(
  p_id=> 57418306102816680+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_region_id=> 57418213150816677+wwv_flow_api.g_id_offset,
  p_name=> 'APPS_CHECKS',
  p_folder_id=> null, 
  p_alias=> '',
  p_report_id_item=> '',
  p_max_row_count=> '1000000',
  p_max_row_count_message=> 'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.',
  p_no_data_found_message=> 'No data found.',
  p_max_rows_per_page=>'',
  p_search_button_label=>'',
  p_sort_asc_image=>'',
  p_sort_asc_image_attr=>'',
  p_sort_desc_image=>'',
  p_sort_desc_image_attr=>'',
  p_sql_query => a1,
  p_status=>'AVAILABLE_FOR_OWNER',
  p_allow_report_saving=>'Y',
  p_allow_save_rpt_public=>'N',
  p_allow_report_categories=>'N',
  p_show_nulls_as=>'-',
  p_pagination_type=>'ROWS_X_TO_Y',
  p_pagination_display_pos=>'BOTTOM_RIGHT',
  p_show_finder_drop_down=>'Y',
  p_show_display_row_count=>'N',
  p_show_search_bar=>'Y',
  p_show_search_textbox=>'Y',
  p_show_actions_menu=>'Y',
  p_report_list_mode=>'TABS',
  p_show_detail_link=>'Y',
  p_show_select_columns=>'Y',
  p_show_rows_per_page=>'Y',
  p_show_filter=>'Y',
  p_show_sort=>'Y',
  p_show_control_break=>'Y',
  p_show_highlight=>'Y',
  p_show_computation=>'Y',
  p_show_aggregate=>'Y',
  p_show_chart=>'Y',
  p_show_group_by=>'Y',
  p_show_notify=>'N',
  p_show_calendar=>'N',
  p_show_flashback=>'Y',
  p_show_reset=>'Y',
  p_show_download=>'Y',
  p_show_help=>'Y',
  p_download_formats=>'CSV:HTML:EMAIL',
  p_detail_link_text=>'<img src="#IMAGE_PREFIX#menu/pencil16x16.gif" alt="" />',
  p_allow_exclude_null_values=>'Y',
  p_allow_hide_extra_columns=>'Y',
  p_icon_view_enabled_yn=>'N',
  p_icon_view_use_custom=>'N',
  p_icon_view_columns_per_row=>1,
  p_detail_view_enabled_yn=>'N',
  p_owner=>'VERMEYDI',
  p_internal_uid=> 57418306102816680);
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57418420905816697+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'ID',
  p_display_order          =>1,
  p_column_identifier      =>'A',
  p_column_label           =>'Id',
  p_report_label           =>'Id',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57418505130816706+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'CMDB_ID',
  p_display_order          =>2,
  p_column_identifier      =>'B',
  p_column_label           =>'Cmdb Id',
  p_report_label           =>'Cmdb Id',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57418629204816707+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'NAAM',
  p_display_order          =>3,
  p_column_identifier      =>'C',
  p_column_label           =>'Naam',
  p_report_label           =>'Naam',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57418717477816707+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'DIENSTENTYPE',
  p_display_order          =>4,
  p_column_identifier      =>'D',
  p_column_label           =>'Dienstentype',
  p_report_label           =>'Dienstentype',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57418810235816707+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'EIGENAAR_BELEIDSDOMEIN',
  p_display_order          =>5,
  p_column_identifier      =>'E',
  p_column_label           =>'Eigenaar Beleidsdomein',
  p_report_label           =>'Eigenaar Beleidsdomein',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57418924299816708+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'EIGENAAR_ENTITEIT',
  p_display_order          =>6,
  p_column_identifier      =>'F',
  p_column_label           =>'Eigenaar Entiteit',
  p_report_label           =>'Eigenaar Entiteit',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419029132816709+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'FIN_BELEIDSDOMEIN',
  p_display_order          =>7,
  p_column_identifier      =>'G',
  p_column_label           =>'Fin Beleidsdomein',
  p_report_label           =>'Fin Beleidsdomein',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419101393816709+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'FIN_ENTITEIT',
  p_display_order          =>8,
  p_column_identifier      =>'H',
  p_column_label           =>'Fin Entiteit',
  p_report_label           =>'Fin Entiteit',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419206756816710+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'SO_TOEPASSINGSMANAGER',
  p_display_order          =>9,
  p_column_identifier      =>'I',
  p_column_label           =>'So Toepassingsmanager',
  p_report_label           =>'So Toepassingsmanager',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419320923816710+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'VO_APPLICATIEBEHEERDER',
  p_display_order          =>10,
  p_column_identifier      =>'J',
  p_column_label           =>'Vo Applicatiebeheerder',
  p_report_label           =>'Vo Applicatiebeheerder',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419429734816710+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'ASSESSMENT',
  p_display_order          =>11,
  p_column_identifier      =>'K',
  p_column_label           =>'Assessment',
  p_report_label           =>'Assessment',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_format_mask            =>'999G999G999G999G999G990',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419503483816711+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'MIGRATIE',
  p_display_order          =>12,
  p_column_identifier      =>'L',
  p_column_label           =>'Migratie',
  p_report_label           =>'Migratie',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_format_mask            =>'999G999G999G999G999G990',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419623277816711+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'EOSL_KOST',
  p_display_order          =>13,
  p_column_identifier      =>'M',
  p_column_label           =>'Eosl Kost',
  p_report_label           =>'Eosl Kost',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_format_mask            =>'999G999G999G999G999G990',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419731344816711+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'PROJECT_KOST',
  p_display_order          =>14,
  p_column_identifier      =>'N',
  p_column_label           =>'Project Kost',
  p_report_label           =>'Project Kost',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_format_mask            =>'999G999G999G999G999G990',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419810531816712+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'TOTALE_KOST',
  p_display_order          =>15,
  p_column_identifier      =>'O',
  p_column_label           =>'Totale Kost',
  p_report_label           =>'Totale Kost',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_format_mask            =>'999G999G999G999G999G990',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57419909997816712+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'MSGSTR',
  p_display_order          =>16,
  p_column_identifier      =>'P',
  p_column_label           =>'Msgstr',
  p_report_label           =>'Msgstr',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420020904816713+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'EOSL_STRATEGY',
  p_display_order          =>17,
  p_column_identifier      =>'Q',
  p_column_label           =>'Eosl Strategy',
  p_report_label           =>'Eosl Strategy',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420126733816713+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'COMPUTER_UITDOVEND',
  p_display_order          =>18,
  p_column_identifier      =>'R',
  p_column_label           =>'Computer Uitdovend',
  p_report_label           =>'Computer Uitdovend',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420227462816714+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'COMPUTER_UITGEDOOFD',
  p_display_order          =>19,
  p_column_identifier      =>'S',
  p_column_label           =>'Computer Uitgedoofd',
  p_report_label           =>'Computer Uitgedoofd',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420311755816714+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'COMPONENT_UITDOVEND',
  p_display_order          =>20,
  p_column_identifier      =>'T',
  p_column_label           =>'Component Uitdovend',
  p_report_label           =>'Component Uitdovend',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420431725816714+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'COMPONENT_UITGEDOOFD',
  p_display_order          =>21,
  p_column_identifier      =>'U',
  p_column_label           =>'Component Uitgedoofd',
  p_report_label           =>'Component Uitgedoofd',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420511244816715+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'OS_UITDOVEND',
  p_display_order          =>22,
  p_column_identifier      =>'V',
  p_column_label           =>'Os Uitdovend',
  p_report_label           =>'Os Uitdovend',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420602283816715+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'OS_UITGEDOOFD',
  p_display_order          =>23,
  p_column_identifier      =>'W',
  p_column_label           =>'Os Uitgedoofd',
  p_report_label           =>'Os Uitgedoofd',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420718494816716+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'CONNECTIONS',
  p_display_order          =>24,
  p_column_identifier      =>'X',
  p_column_label           =>'Connections',
  p_report_label           =>'Connections',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420811990816716+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'COMP',
  p_display_order          =>25,
  p_column_identifier      =>'Y',
  p_column_label           =>'Comp',
  p_report_label           =>'Comp',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57420924997816716+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'NO_COMP',
  p_display_order          =>26,
  p_column_identifier      =>'Z',
  p_column_label           =>'No Comp',
  p_report_label           =>'No Comp',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57421005864816717+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'SW_CNT',
  p_display_order          =>27,
  p_column_identifier      =>'AA',
  p_column_label           =>'Sw Cnt',
  p_report_label           =>'Sw Cnt',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57421102110816717+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'SW_CNT_BOU',
  p_display_order          =>28,
  p_column_identifier      =>'AB',
  p_column_label           =>'Sw Cnt Bou',
  p_report_label           =>'Sw Cnt Bou',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57421222777816718+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'JOB_CNT',
  p_display_order          =>29,
  p_column_identifier      =>'AC',
  p_column_label           =>'Job Cnt',
  p_report_label           =>'Job Cnt',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57421305828816718+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'JOB_CNT_BOU',
  p_display_order          =>30,
  p_column_identifier      =>'AD',
  p_column_label           =>'Job Cnt Bou',
  p_report_label           =>'Job Cnt Bou',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'RIGHT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'No help available for this page item.');
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'ID:CMDB_ID:NAAM:DIENSTENTYPE:EIGENAAR_BELEIDSDOMEIN:EIGENAAR_ENTITEIT:FIN_BELEIDSDOMEIN:FIN_ENTITEIT:SO_TOEPASSINGSMANAGER:VO_APPLICATIEBEHEERDER:ASSESSMENT:MIGRATIE:EOSL_KOST:PROJECT_KOST:TOTALE_KOST:MSGSTR:EOSL_STRATEGY:COMPUTER_UITDOVEND:COMPUTER_UITGEDOOFD:COMPONENT_UITDOVEND:COMPONENT_UITGEDOOFD:OS_UITDOVEND:OS_UITGEDOOFD:CONNECTIONS:COMP:NO_COMP:SW_CNT:SW_CNT_BOU:JOB_CNT:JOB_CNT_BOU';

wwv_flow_api.create_worksheet_rpt(
  p_id => 57421824500818330+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_worksheet_id => 57418306102816680+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_DEFAULT',
  p_report_seq              =>10,
  p_report_alias            =>'574219',
  p_status                  =>'PUBLIC',
  p_category_id             =>null+wwv_flow_api.g_id_offset,
  p_is_default              =>'Y',
  p_display_rows            =>15,
  p_report_columns          =>rc1,
  p_flashback_enabled       =>'N',
  p_calendar_display_column =>'');
end;
/
declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s := null;
wwv_flow_api.create_page_plug (
  p_id=> 57421525824816728 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 1,
  p_plug_name=> 'Breadcrumbs',
  p_region_name=>'',
  p_escape_on_http_output=>'N',
  p_plug_template=> 57408014330816279+ wwv_flow_api.g_id_offset,
  p_plug_display_sequence=> 10,
  p_plug_new_grid         => false,
  p_plug_new_grid_row     => true,
  p_plug_new_grid_column  => true,
  p_plug_display_column=> null,
  p_plug_display_point=> 'REGION_POSITION_01',
  p_plug_item_display_point=> 'ABOVE',
  p_plug_source=> s,
  p_plug_source_type=> 'M'|| to_char(57417732379816605 + wwv_flow_api.g_id_offset),
  p_menu_template_id=> 57415703007816395+ wwv_flow_api.g_id_offset,
  p_plug_query_row_template=> 1,
  p_plug_query_headings_type=> 'COLON_DELMITED_LIST',
  p_plug_query_row_count_max => 500,
  p_plug_display_condition_type => '',
  p_plug_caching=> 'NOT_CACHED',
  p_plug_comment=> '');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 1
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00002
prompt  ...PAGE 2: Netwerk Migratie
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 2
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'TS1'
 ,p_name => 'Netwerk Migratie'
 ,p_step_title => 'Netwerk Migratie'
 ,p_step_sub_title => 'Netwerk Migratie'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131106171813'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' n."ID",'||unistr('\000a')||
' n."CMDB_ID",'||unistr('\000a')||
' n."NAAM",'||unistr('\000a')||
' n."CATEGORIE",'||unistr('\000a')||
' n."SUBCATEGORIE",'||unistr('\000a')||
' n."VERHUIS_STATUS",'||unistr('\000a')||
' n."VERHUISKOST_DAGEN",'||unistr('\000a')||
' n."VERHUISKOST_LABEL",'||unistr('\000a')||
' n."VERHUISKOST_PUNTEN",'||unistr('\000a')||
' id_in_component(n.cmdb_id, c.cmdb_id) as CMDB2_Status,'||unistr('\000a')||
' n.beschrijving,'||unistr('\000a')||
' n.LIJN_CONNECTIING_DEVICE'||unistr('\000a')||
'from #OWNER#.NETWERK n'||unistr('\000a')||
'left join component c on n.cmdb_id = c.cmdb_id';

wwv_flow_api.create_report_region (
  p_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 2,
  p_name=> 'Netwerk',
  p_region_name=>'netw_rep',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_header=> '<script src="#WORKSPACE_IMAGES#jquery.htmldbHscroll-0.0.1.min.js" type="text/javascript"></script>'||unistr('\000a')||
'',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444119103894214 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>1,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444220928894217 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID',
  p_column_display_sequence=> 2,
  p_column_heading=> 'CMDB_ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444324101894217 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM',
  p_column_display_sequence=> 3,
  p_column_heading=> 'NAAM',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444400184894217 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'CATEGORIE',
  p_column_display_sequence=> 4,
  p_column_heading=> 'CATEGORIE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444503753894218 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'SUBCATEGORIE',
  p_column_display_sequence=> 5,
  p_column_heading=> 'SUBCATEGORIE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444622214894218 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 6,
  p_form_element_id=> null,
  p_column_alias=> 'VERHUIS_STATUS',
  p_column_display_sequence=> 6,
  p_column_heading=> 'VERHUIS_STATUS',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444702096894218 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 7,
  p_form_element_id=> null,
  p_column_alias=> 'VERHUISKOST_DAGEN',
  p_column_display_sequence=> 11,
  p_column_heading=> 'VERHUISKOST_DAGEN',
  p_use_as_row_header=> 'N',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_column_width=> '60',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444821831894218 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 8,
  p_form_element_id=> null,
  p_column_alias=> 'VERHUISKOST_LABEL',
  p_column_display_sequence=> 7,
  p_column_heading=> 'VERHUISKOST_LABEL',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57444905355894218 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 9,
  p_form_element_id=> null,
  p_column_alias=> 'VERHUISKOST_PUNTEN',
  p_column_display_sequence=> 12,
  p_column_heading=> 'VERHUISKOST_PUNTEN',
  p_use_as_row_header=> 'N',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_column_width=> '60',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 59861231891061886 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 10,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB2_STATUS',
  p_column_display_sequence=> 8,
  p_column_heading=> 'Cmdb2 Status',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 62037608497119383 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 11,
  p_form_element_id=> null,
  p_column_alias=> 'BESCHRIJVING',
  p_column_display_sequence=> 9,
  p_column_heading=> 'Beschrijving',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'Y',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 62037725422119390 + wwv_flow_api.g_id_offset,
  p_region_id=> 57443813067894178 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 12,
  p_form_element_id=> null,
  p_column_alias=> 'LIJN_CONNECTIING_DEVICE',
  p_column_display_sequence=> 10,
  p_column_heading=> 'Lijn Connecting Device',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'Y',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
wwv_flow_api.create_page_da_event (
  p_id => 67030009760573540 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 2
 ,p_name => 'HorScroll'
 ,p_event_sequence => 10
 ,p_triggering_element_type => 'REGION'
 ,p_triggering_region_id => 57443813067894178 + wwv_flow_api.g_id_offset
 ,p_bind_type => 'bind'
 ,p_bind_event_type => 'apexafterrefresh'
  );
wwv_flow_api.create_page_da_action (
  p_id => 67030304242573580 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 2
 ,p_event_id => 67030009760573540 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 10
 ,p_execute_on_page_init => 'Y'
 ,p_action => 'NATIVE_JAVASCRIPT_CODE'
 ,p_attribute_01 => '$("#report_netw_rep").htmldbHscroll({width:600,columns:2});'
 ,p_stop_execution_on_error => 'Y'
 );
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 2
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00003
prompt  ...PAGE 3: Geïsoleerde Servers
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 3
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'TS1'
 ,p_name => 'Geïsoleerde Servers'
 ,p_step_title => 'Geïsoleerde Servers'
 ,p_step_sub_title => 'Geïsoleerde Servers'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131106172856'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' s."CMDB_ID",'||unistr('\000a')||
' c."NAAM",'||unistr('\000a')||
' c."CI_TYPE",'||unistr('\000a')||
' c."CI_CATEGORIE",'||unistr('\000a')||
' c."STATUS",'||unistr('\000a')||
' s."MIGRATIE",'||unistr('\000a')||
' s."EOSL_KOST",'||unistr('\000a')||
' s."PROJECT_KOST",'||unistr('\000a')||
' s."TOTALE_KOST",'||unistr('\000a')||
' c."OMGEVING",'||unistr('\000a')||
' c."DIENSTENTYPE",'||unistr('\000a')||
' uf_kenmerk(c."KENMERKEN") as KENMERKEN,'||unistr('\000a')||
' c."EIGENAAR_ENTITEIT"'||unistr('\000a')||
'from #OWNER#.SYSTEM_COST s, #OWNER#.COMPONENT c'||unistr('\000a')||
'where s.cmdb_id = c.cmdb_id';

wwv_flow_api.create_report_region (
  p_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 3,
  p_name=> 'Servers',
  p_region_name=>'Servers_rep',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => true,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_header=> '<script src="#WORKSPACE_IMAGES#jquery.htmldbHscroll-0.0.1.min.js" type="text/javascript"></script>',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458008536923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'CMDB_ID',
  p_column_alignment=>'RIGHT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458109188923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM',
  p_column_display_sequence=> 2,
  p_column_heading=> 'NAAM',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458210845923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'CI_TYPE',
  p_column_display_sequence=> 12,
  p_column_heading=> 'CI_TYPE',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458317679923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'CI_CATEGORIE',
  p_column_display_sequence=> 13,
  p_column_heading=> 'CI_CATEGORIE',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458503322923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'STATUS',
  p_column_display_sequence=> 11,
  p_column_heading=> 'STATUS',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458704762923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 6,
  p_form_element_id=> null,
  p_column_alias=> 'MIGRATIE',
  p_column_display_sequence=> 3,
  p_column_heading=> 'MIGRATIE Kost',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'RIGHT',
  p_heading_alignment=>'RIGHT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_report_column_width=> '100',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458819516923325 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 7,
  p_form_element_id=> null,
  p_column_alias=> 'EOSL_KOST',
  p_column_display_sequence=> 4,
  p_column_heading=> 'EOSL Kost',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'RIGHT',
  p_heading_alignment=>'RIGHT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_report_column_width=> '100',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57458904742923326 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 8,
  p_form_element_id=> null,
  p_column_alias=> 'PROJECT_KOST',
  p_column_display_sequence=> 5,
  p_column_heading=> 'PROJECT Kost',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'RIGHT',
  p_heading_alignment=>'RIGHT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_report_column_width=> '100',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57459027029923326 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 9,
  p_form_element_id=> null,
  p_column_alias=> 'TOTALE_KOST',
  p_column_display_sequence=> 6,
  p_column_heading=> 'TOTALE Kost',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'RIGHT',
  p_heading_alignment=>'RIGHT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_report_column_width=> '100',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57459107992923326 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 10,
  p_form_element_id=> null,
  p_column_alias=> 'OMGEVING',
  p_column_display_sequence=> 7,
  p_column_heading=> 'OMGEVING',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57459232458923326 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 11,
  p_form_element_id=> null,
  p_column_alias=> 'DIENSTENTYPE',
  p_column_display_sequence=> 8,
  p_column_heading=> 'DIENSTENTYPE',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57528507501220550 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 12,
  p_form_element_id=> null,
  p_column_alias=> 'KENMERKEN',
  p_column_display_sequence=> 9,
  p_column_heading=> 'Kenmerken',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57541124477288777 + wwv_flow_api.g_id_offset,
  p_region_id=> 57457602924923277 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 13,
  p_form_element_id=> null,
  p_column_alias=> 'EIGENAAR_ENTITEIT',
  p_column_display_sequence=> 10,
  p_column_heading=> 'Eigenaar Entiteit',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
wwv_flow_api.create_page_da_event (
  p_id => 67035024875644191 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 3
 ,p_name => 'HorScroll'
 ,p_event_sequence => 10
 ,p_triggering_element_type => 'REGION'
 ,p_triggering_region_id => 57457602924923277 + wwv_flow_api.g_id_offset
 ,p_bind_type => 'bind'
 ,p_bind_event_type => 'apexafterrefresh'
  );
wwv_flow_api.create_page_da_action (
  p_id => 67035300246644247 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 3
 ,p_event_id => 67035024875644191 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 10
 ,p_execute_on_page_init => 'Y'
 ,p_action => 'NATIVE_JAVASCRIPT_CODE'
 ,p_attribute_01 => '$("#report_Servers_rep").htmldbHscroll({width:600,columns:2});'
 ,p_stop_execution_on_error => 'Y'
 );
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 3
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00005
prompt  ...PAGE 5: Server - Applicatie link
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 5
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BIJKOMENDEGEGEVENS'
 ,p_name => 'Server - Applicatie link'
 ,p_step_title => 'Server - Applicatie link'
 ,p_step_sub_title => 'Server - Applicatie link'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131016171644'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' s."ID",'||unistr('\000a')||
' s."CMDB_ID_COMP",'||unistr('\000a')||
' s."NAAM_COMP",'||unistr('\000a')||
' s."CMDB_ID_APPL",'||unistr('\000a')||
' s."NAAM_APPL"'||unistr('\000a')||
'from #OWNER#.SRV2APPS s, #OWNER#.COMPONENT c'||unistr('\000a')||
'where s.cmdb_id_comp = c.cmdb_id'||unistr('\000a')||
'and c.locatie = ''Boudewijn - Brussel/-1C Computerzaal''';

wwv_flow_api.create_report_region (
  p_id=> 57608916340660765 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 5,
  p_name=> 'Server2Apps',
  p_region_name=>'',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57609217663660825 + wwv_flow_api.g_id_offset,
  p_region_id=> 57608916340660765 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>1,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57609324978660825 + wwv_flow_api.g_id_offset,
  p_region_id=> 57608916340660765 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID_COMP',
  p_column_display_sequence=> 2,
  p_column_heading=> 'CMDB_ID_COMP',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57609412849660825 + wwv_flow_api.g_id_offset,
  p_region_id=> 57608916340660765 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM_COMP',
  p_column_display_sequence=> 3,
  p_column_heading=> 'NAAM_COMP',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57609513599660825 + wwv_flow_api.g_id_offset,
  p_region_id=> 57608916340660765 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID_APPL',
  p_column_display_sequence=> 4,
  p_column_heading=> 'CMDB_ID_APPL',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57609620736660826 + wwv_flow_api.g_id_offset,
  p_region_id=> 57608916340660765 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM_APPL',
  p_column_display_sequence=> 5,
  p_column_heading=> 'NAAM_APPL',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 5
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00006
prompt  ...PAGE 6: Afgeleide EOSL
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 6
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BIJKOMENDEGEGEVENS'
 ,p_name => 'Afgeleide EOSL'
 ,p_step_title => 'Afgeleide EOSL'
 ,p_step_sub_title => 'Afgeleide EOSL'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131015162935'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select distinct'||unistr('\000a')||
' e."CMDB_ID",'||unistr('\000a')||
' c.naam,'||unistr('\000a')||
' c.ci_type,'||unistr('\000a')||
' c.ci_categorie,'||unistr('\000a')||
' e."UITDOVEND_DATUM",'||unistr('\000a')||
' e."UITGEDOOFD_DATUM"'||unistr('\000a')||
'from #OWNER#.CONS_EOSL e, component c'||unistr('\000a')||
'where e.cmdb_id = c.cmdb_id';

wwv_flow_api.create_report_region (
  p_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 6,
  p_name=> 'Afgeleide EOSL',
  p_region_name=>'',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57626309256826425 + wwv_flow_api.g_id_offset,
  p_region_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'CMDB_ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57626913033840924 + wwv_flow_api.g_id_offset,
  p_region_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM',
  p_column_display_sequence=> 2,
  p_column_heading=> 'Naam',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57627013456840925 + wwv_flow_api.g_id_offset,
  p_region_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'CI_TYPE',
  p_column_display_sequence=> 3,
  p_column_heading=> 'Ci Type',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57627121344840925 + wwv_flow_api.g_id_offset,
  p_region_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'CI_CATEGORIE',
  p_column_display_sequence=> 4,
  p_column_heading=> 'Ci Categorie',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57626424433826425 + wwv_flow_api.g_id_offset,
  p_region_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'UITDOVEND_DATUM',
  p_column_display_sequence=> 5,
  p_column_heading=> 'UITDOVEND_DATUM',
  p_use_as_row_header=> 'N',
  p_column_format=> 'YYYY-MM-DD',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57626509219826425 + wwv_flow_api.g_id_offset,
  p_region_id=> 57625931777826403 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 6,
  p_form_element_id=> null,
  p_column_alias=> 'UITGEDOOFD_DATUM',
  p_column_display_sequence=> 6,
  p_column_heading=> 'UITGEDOOFD_DATUM',
  p_use_as_row_header=> 'N',
  p_column_format=> 'YYYY-MM-DD',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 6
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00007
prompt  ...PAGE 7: eosl_toepassingen
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 7
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'TS1'
 ,p_name => 'eosl_toepassingen'
 ,p_step_title => 'eosl_toepassingen'
 ,p_step_sub_title => 'eosl_toepassingen'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131112175050'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' "ALG_STATUS",'||unistr('\000a')||
' "ALG_OPMERKING",'||unistr('\000a')||
' "TOEP_OMG",'||unistr('\000a')||
' "EOSL",'||unistr('\000a')||
' "OMG_CMDB_REF",'||unistr('\000a')||
' "OMG_VERSIE",'||unistr('\000a')||
' "OMG_TYPE",'||unistr('\000a')||
' "OMG_STATUS",'||unistr('\000a')||
' "CI_CMDB_REF"'||unistr('\000a')||
'from APEX_USER_004.EOSL_TOEPASSINGEN';

wwv_flow_api.create_report_region (
  p_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 7,
  p_name=> 'eosl_toepassingen',
  p_region_name=>'',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68833801562606489 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'ALG_STATUS',
  p_column_display_sequence=> 1,
  p_column_heading=> 'ALG_STATUS',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68833919733606489 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'ALG_OPMERKING',
  p_column_display_sequence=> 2,
  p_column_heading=> 'ALG_OPMERKING',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68835311610606490 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'TOEP_OMG',
  p_column_display_sequence=> 3,
  p_column_heading=> 'TOEP_OMG',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68835405689606490 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'EOSL',
  p_column_display_sequence=> 4,
  p_column_heading=> 'EOSL',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68835511806606490 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'OMG_CMDB_REF',
  p_column_display_sequence=> 5,
  p_column_heading=> 'OMG_CMDB_REF',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68835605683606490 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 6,
  p_form_element_id=> null,
  p_column_alias=> 'OMG_VERSIE',
  p_column_display_sequence=> 6,
  p_column_heading=> 'OMG_VERSIE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68835713236606490 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 7,
  p_form_element_id=> null,
  p_column_alias=> 'OMG_TYPE',
  p_column_display_sequence=> 7,
  p_column_heading=> 'OMG_TYPE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68835832585606490 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 8,
  p_form_element_id=> null,
  p_column_alias=> 'OMG_STATUS',
  p_column_display_sequence=> 8,
  p_column_heading=> 'OMG_STATUS',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 68837402812606491 + wwv_flow_api.g_id_offset,
  p_region_id=> 68833401120606463 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 9,
  p_form_element_id=> null,
  p_column_alias=> 'CI_CMDB_REF',
  p_column_display_sequence=> 9,
  p_column_heading=> 'CI_CMDB_REF',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 7
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00009
prompt  ...PAGE 9: DummyPage
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 9
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BEHEERKOSTELEMENTEN'
 ,p_name => 'DummyPage'
 ,p_step_title => 'DummyPage'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_first_item => 'NO_FIRST_ITEM'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_step_template => 57407114435816253 + wwv_flow_api.g_id_offset
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131015164011'
  );
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 9
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00012
prompt  ...PAGE 12: Beheer KostElementen
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 12
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BEHEERKOSTELEMENTEN'
 ,p_name => 'Beheer KostElementen'
 ,p_step_title => 'Beheer KostElementen'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131016084034'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select "ROWID", '||unistr('\000a')||
'"ELEMENT",'||unistr('\000a')||
'"CI_CATEGORIE",'||unistr('\000a')||
'"CI_TYPE",'||unistr('\000a')||
'"COMPUTERTYPE",'||unistr('\000a')||
'"FUNCTIE",'||unistr('\000a')||
'"DATUM",'||unistr('\000a')||
'"WAARDE"'||unistr('\000a')||
'from "#OWNER#"."KOSTELEMENTEN" '||unistr('\000a')||
'  '||unistr('\000a')||
'';

wwv_flow_api.create_page_plug (
  p_id=> 57647109895005953 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_plug_name=> 'Beheer KostElementen',
  p_region_name=>'',
  p_escape_on_http_output=>'N',
  p_plug_template=> 57409123273816283+ wwv_flow_api.g_id_offset,
  p_plug_display_sequence=> 10,
  p_plug_new_grid         => false,
  p_plug_new_grid_row     => true,
  p_plug_new_grid_column  => true,
  p_plug_display_column=> null,
  p_plug_display_point=> 'BODY_3',
  p_plug_item_display_point=> 'ABOVE',
  p_plug_source=> s,
  p_plug_source_type=> 'DYNAMIC_QUERY',
  p_plug_query_row_template=> 1,
  p_plug_query_headings_type=> 'COLON_DELMITED_LIST',
  p_plug_query_row_count_max => 500,
  p_plug_display_condition_type => '',
  p_plug_caching=> 'NOT_CACHED',
  p_plug_comment=> '');
end;
/
declare
 a1 varchar2(32767) := null;
begin
a1:=a1||'select "ROWID", '||unistr('\000a')||
'"ELEMENT",'||unistr('\000a')||
'"CI_CATEGORIE",'||unistr('\000a')||
'"CI_TYPE",'||unistr('\000a')||
'"COMPUTERTYPE",'||unistr('\000a')||
'"FUNCTIE",'||unistr('\000a')||
'"DATUM",'||unistr('\000a')||
'"WAARDE"'||unistr('\000a')||
'from "#OWNER#"."KOSTELEMENTEN" '||unistr('\000a')||
'  '||unistr('\000a')||
'';

wwv_flow_api.create_worksheet(
  p_id=> 57647314866005954+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_region_id=> 57647109895005953+wwv_flow_api.g_id_offset,
  p_name=> 'Beheer KostElementen',
  p_folder_id=> null, 
  p_alias=> '',
  p_report_id_item=> '',
  p_max_row_count=> '1000000',
  p_max_row_count_message=> 'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.',
  p_no_data_found_message=> 'No data found.',
  p_max_rows_per_page=>'',
  p_search_button_label=>'',
  p_sort_asc_image=>'',
  p_sort_asc_image_attr=>'',
  p_sort_desc_image=>'',
  p_sort_desc_image_attr=>'',
  p_sql_query => a1,
  p_status=>'AVAILABLE_FOR_OWNER',
  p_allow_report_saving=>'Y',
  p_allow_save_rpt_public=>'N',
  p_allow_report_categories=>'Y',
  p_show_nulls_as=>'-',
  p_pagination_type=>'ROWS_X_TO_Y',
  p_pagination_display_pos=>'BOTTOM_RIGHT',
  p_show_finder_drop_down=>'Y',
  p_show_display_row_count=>'N',
  p_show_search_bar=>'Y',
  p_show_search_textbox=>'Y',
  p_show_actions_menu=>'Y',
  p_report_list_mode=>'TABS',
  p_show_detail_link=>'C',
  p_show_select_columns=>'Y',
  p_show_rows_per_page=>'Y',
  p_show_filter=>'Y',
  p_show_sort=>'Y',
  p_show_control_break=>'Y',
  p_show_highlight=>'Y',
  p_show_computation=>'Y',
  p_show_aggregate=>'Y',
  p_show_chart=>'Y',
  p_show_group_by=>'Y',
  p_show_notify=>'N',
  p_show_calendar=>'Y',
  p_show_flashback=>'Y',
  p_show_reset=>'Y',
  p_show_download=>'Y',
  p_show_help=>'Y',
  p_download_formats=>'CSV:HTML:EMAIL',
  p_detail_link=>'f?p=&APP_ID.:13:&APP_SESSION.::::P13_ROWID:#ROWID#',
  p_detail_link_text=>'<img src="#IMAGE_PREFIX#e2.gif"  border="0">',
  p_allow_exclude_null_values=>'Y',
  p_allow_hide_extra_columns=>'Y',
  p_icon_view_enabled_yn=>'N',
  p_icon_view_use_custom=>'N',
  p_detail_view_enabled_yn=>'N',
  p_owner=>'VERMEYDI',
  p_internal_uid=> 57647314866005954);
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57647424949005966+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'ROWID',
  p_display_order          =>1,
  p_column_identifier      =>'A',
  p_column_label           =>'ROWID',
  p_report_label           =>'ROWID',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'N',
  p_allow_filtering        =>'N',
  p_allow_highlighting     =>'N',
  p_allow_ctrl_breaks      =>'N',
  p_allow_aggregations     =>'N',
  p_allow_computations     =>'N',
  p_allow_charting         =>'N',
  p_allow_group_by         =>'N',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'OTHER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'HIDDEN',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'N',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57647528734005976+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'ELEMENT',
  p_display_order          =>2,
  p_column_identifier      =>'B',
  p_column_label           =>'Element',
  p_report_label           =>'Element',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57647612114005978+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'CI_CATEGORIE',
  p_display_order          =>3,
  p_column_identifier      =>'C',
  p_column_label           =>'Ci Categorie',
  p_report_label           =>'Ci Categorie',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57647700441005979+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'CI_TYPE',
  p_display_order          =>4,
  p_column_identifier      =>'D',
  p_column_label           =>'Ci Type',
  p_report_label           =>'Ci Type',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57647805854005979+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'COMPUTERTYPE',
  p_display_order          =>5,
  p_column_identifier      =>'E',
  p_column_label           =>'Computertype',
  p_report_label           =>'Computertype',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57647925849005980+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'FUNCTIE',
  p_display_order          =>6,
  p_column_identifier      =>'F',
  p_column_label           =>'Functie',
  p_report_label           =>'Functie',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'STRING',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57648020122005980+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'DATUM',
  p_display_order          =>7,
  p_column_identifier      =>'G',
  p_column_label           =>'Datum',
  p_report_label           =>'Datum',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'DATE',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
begin
wwv_flow_api.create_worksheet_column(
  p_id => 57648101012005981+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_db_column_name         =>'WAARDE',
  p_display_order          =>8,
  p_column_identifier      =>'H',
  p_column_label           =>'Waarde',
  p_report_label           =>'Waarde',
  p_sync_form_label        =>'Y',
  p_display_in_default_rpt =>'Y',
  p_is_sortable            =>'Y',
  p_allow_sorting          =>'Y',
  p_allow_filtering        =>'Y',
  p_allow_highlighting     =>'Y',
  p_allow_ctrl_breaks      =>'Y',
  p_allow_aggregations     =>'Y',
  p_allow_computations     =>'Y',
  p_allow_charting         =>'Y',
  p_allow_group_by         =>'Y',
  p_allow_hide             =>'Y',
  p_others_may_edit        =>'Y',
  p_others_may_view        =>'Y',
  p_column_type            =>'NUMBER',
  p_display_as             =>'TEXT',
  p_display_text_as        =>'ESCAPE_SC',
  p_heading_alignment      =>'CENTER',
  p_column_alignment       =>'LEFT',
  p_tz_dependent           =>'N',
  p_rpt_distinct_lov       =>'Y',
  p_rpt_show_filter_lov    =>'D',
  p_rpt_filter_date_ranges =>'ALL',
  p_help_text              =>'');
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'ROWID:ELEMENT:CI_CATEGORIE:CI_TYPE:COMPUTERTYPE:FUNCTIE:DATUM:WAARDE';

wwv_flow_api.create_worksheet_rpt(
  p_id => 57648309841006253+wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 12,
  p_worksheet_id => 57647314866005954+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_DEFAULT',
  p_report_seq              =>10,
  p_report_alias            =>'576484',
  p_status                  =>'PUBLIC',
  p_category_id             =>null+wwv_flow_api.g_id_offset,
  p_is_default              =>'Y',
  p_display_rows            =>15,
  p_report_columns          =>rc1,
  p_flashback_enabled       =>'N',
  p_calendar_display_column =>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57650414268102184 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 12,
  p_name=>'P12_RESET',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 10,
  p_item_plug_id => 57647109895005953+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_prompt=>'Default Waarden',
  p_display_as=> 'BUTTON',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> null,
  p_cMaxlength=> 2000,
  p_cHeight=> null,
  p_new_grid=> false,
  p_begin_on_new_line=> 'NO',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'LEFT',
  p_field_alignment=> 'LEFT',
  p_is_persistent=> 'N',
  p_button_execute_validations=>'Y',
  p_button_action => 'DEFINED_BY_DA',
  p_button_is_hot=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57885132426635899 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 12,
  p_name=>'P12_BEREKEN',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 20,
  p_item_plug_id => 57647109895005953+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_prompt=>'Bereken Scenario',
  p_source_type=> 'STATIC',
  p_display_as=> 'BUTTON',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> null,
  p_cMaxlength=> 2000,
  p_cHeight=> null,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'LEFT',
  p_field_alignment=> 'LEFT',
  p_is_persistent=> 'N',
  p_button_execute_validations=>'Y',
  p_button_action => 'DEFINED_BY_DA',
  p_button_is_hot=>'N',
  p_item_comment => '');
 
 
end;
/

 
begin
 
wwv_flow_api.create_page_da_event (
  p_id => 57651605143165796 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 12
 ,p_name => 'ResetAction'
 ,p_event_sequence => 10
 ,p_triggering_element_type => 'BUTTON'
 ,p_triggering_button_id => 57650414268102184 + wwv_flow_api.g_id_offset
 ,p_bind_type => 'bind'
 ,p_bind_event_type => 'click'
  );
wwv_flow_api.create_page_da_action (
  p_id => 57651928434165807 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 12
 ,p_event_id => 57651605143165796 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 10
 ,p_execute_on_page_init => 'N'
 ,p_action => 'NATIVE_EXECUTE_PLSQL_CODE'
 ,p_attribute_01 => 'UPDATE kostelementen k'||unistr('\000a')||
'set (waarde, datum) = '||unistr('\000a')||
'(select d.waarde, d.datum from kostelementen_def d where k.id = d.id);'
 ,p_stop_execution_on_error => 'Y'
 ,p_wait_for_result => 'Y'
 );
wwv_flow_api.create_page_da_action (
  p_id => 57653008436192508 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 12
 ,p_event_id => 57651605143165796 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 20
 ,p_execute_on_page_init => 'N'
 ,p_action => 'NATIVE_REFRESH'
 ,p_affected_elements_type => 'REGION'
 ,p_affected_region_id => 57647109895005953 + wwv_flow_api.g_id_offset
 ,p_stop_execution_on_error => 'Y'
 );
null;
 
end;
/

 
begin
 
wwv_flow_api.create_page_da_event (
  p_id => 57887518836650883 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 12
 ,p_name => 'Bereken Scenario'
 ,p_event_sequence => 20
 ,p_triggering_element_type => 'BUTTON'
 ,p_triggering_button_id => 57885132426635899 + wwv_flow_api.g_id_offset
 ,p_bind_type => 'bind'
 ,p_bind_event_type => 'click'
  );
wwv_flow_api.create_page_da_action (
  p_id => 57887812955650960 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 12
 ,p_event_id => 57887518836650883 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 10
 ,p_execute_on_page_init => 'N'
 ,p_action => 'NATIVE_EXECUTE_PLSQL_CODE'
 ,p_attribute_01 => 'DECLARE'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'p_calculate;'||unistr('\000a')||
'END;'
 ,p_stop_execution_on_error => 'Y'
 ,p_wait_for_result => 'Y'
 );
wwv_flow_api.create_page_da_action (
  p_id => 57888931988658985 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 12
 ,p_event_id => 57887518836650883 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 20
 ,p_execute_on_page_init => 'N'
 ,p_action => 'NATIVE_REFRESH'
 ,p_affected_elements_type => 'REGION'
 ,p_affected_region_id => 57647109895005953 + wwv_flow_api.g_id_offset
 ,p_stop_execution_on_error => 'Y'
 );
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 12
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00013
prompt  ...PAGE 13: Beheer KOSTELEMENTEN
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 13
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BEHEERKOSTELEMENTEN'
 ,p_name => 'Beheer KOSTELEMENTEN'
 ,p_step_title => 'Beheer KOSTELEMENTEN'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131017082724'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s := null;
wwv_flow_api.create_page_plug (
  p_id=> 57643519728005792 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 13,
  p_plug_name=> 'Beheer KOSTELEMENTEN',
  p_region_name=>'',
  p_escape_on_http_output=>'N',
  p_plug_template=> 57408721803816282+ wwv_flow_api.g_id_offset,
  p_plug_display_sequence=> 10,
  p_plug_new_grid         => false,
  p_plug_new_grid_row     => true,
  p_plug_new_grid_column  => true,
  p_plug_display_column=> null,
  p_plug_display_point=> 'BODY_3',
  p_plug_item_display_point=> 'ABOVE',
  p_plug_source=> s,
  p_plug_source_type=> 'STATIC_TEXT',
  p_plug_query_row_template=> 1,
  p_plug_query_headings_type=> 'COLON_DELMITED_LIST',
  p_plug_query_row_count_max => 500,
  p_plug_display_condition_type => '',
  p_plug_caching=> 'NOT_CACHED',
  p_plug_comment=> '');
end;
/
 
begin
 
wwv_flow_api.create_page_button(
  p_id             => 57643715602005804 + wwv_flow_api.g_id_offset,
  p_flow_id        => wwv_flow.g_flow_id,
  p_flow_step_id   => 13,
  p_button_sequence=> 30,
  p_button_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_button_name    => 'SAVE',
  p_button_action  => 'SUBMIT',
  p_button_image   => 'template:'||to_char(57414711827816373+wwv_flow_api.g_id_offset),
  p_button_is_hot=>'N',
  p_button_image_alt=> 'Apply Changes',
  p_button_position=> 'REGION_TEMPLATE_CHANGE',
  p_button_alignment=> 'RIGHT',
  p_button_redirect_url=> '',
  p_button_execute_validations=>'Y',
  p_button_condition=> 'P13_ROWID',
  p_button_condition_type=> 'ITEM_IS_NOT_NULL',
  p_database_action=>'UPDATE',
  p_required_patch => null + wwv_flow_api.g_id_offset);
 
wwv_flow_api.create_page_button(
  p_id             => 57643924339005806 + wwv_flow_api.g_id_offset,
  p_flow_id        => wwv_flow.g_flow_id,
  p_flow_step_id   => 13,
  p_button_sequence=> 10,
  p_button_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_button_name    => 'CANCEL',
  p_button_action  => 'REDIRECT_PAGE',
  p_button_image   => 'template:'||to_char(57414711827816373+wwv_flow_api.g_id_offset),
  p_button_is_hot=>'N',
  p_button_image_alt=> 'Cancel',
  p_button_position=> 'REGION_TEMPLATE_CLOSE',
  p_button_alignment=> 'RIGHT',
  p_button_redirect_url=> 'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:::',
  p_required_patch => null + wwv_flow_api.g_id_offset);
 
 
end;
/

 
begin
 
wwv_flow_api.create_page_branch(
  p_id=>57644106557005809 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_branch_name=> '',
  p_branch_action=> 'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#',
  p_branch_point=> 'AFTER_PROCESSING',
  p_branch_type=> 'REDIRECT_URL',
  p_branch_sequence=> 1,
  p_save_state_before_branch_yn=>'N',
  p_branch_comment=> '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57644323712005894 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_ROWID',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 10,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_prompt=>'Rowid',
  p_source=>'ROWID',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_HIDDEN',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> null,
  p_cMaxlength=> null,
  p_cHeight=> null,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414306093816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_attribute_01 => 'Y',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57644502176005914 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_ELEMENT',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 20,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Element',
  p_source=>'ELEMENT',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_DISPLAY_ONLY',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 60,
  p_cMaxlength=> 1020,
  p_cHeight=> 4,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'VALUE',
  p_attribute_04 => 'Y',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57644730741005918 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_CI_CATEGORIE',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 30,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Ci Categorie',
  p_source=>'CI_CATEGORIE',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_DISPLAY_ONLY',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 60,
  p_cMaxlength=> 1020,
  p_cHeight=> 4,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'VALUE',
  p_attribute_04 => 'Y',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57644914320005919 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_CI_TYPE',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 40,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Ci Type',
  p_source=>'CI_TYPE',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_DISPLAY_ONLY',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 60,
  p_cMaxlength=> 1020,
  p_cHeight=> 4,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'VALUE',
  p_attribute_04 => 'Y',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57645128804005919 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_COMPUTERTYPE',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 50,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Computertype',
  p_source=>'COMPUTERTYPE',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_DISPLAY_ONLY',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 60,
  p_cMaxlength=> 1020,
  p_cHeight=> 4,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'VALUE',
  p_attribute_04 => 'Y',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57645325389005920 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_FUNCTIE',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 60,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Functie',
  p_source=>'FUNCTIE',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_DISPLAY_ONLY',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 60,
  p_cMaxlength=> 1020,
  p_cHeight=> 4,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'VALUE',
  p_attribute_04 => 'Y',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57645508762005921 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_DATUM',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 70,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Datum',
  p_source=>'DATUM',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_DISPLAY_ONLY',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 32,
  p_cMaxlength=> 255,
  p_cHeight=> 1,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'VALUE',
  p_attribute_04 => 'Y',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57645729330005921 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 13,
  p_name=>'P13_WAARDE',
  p_data_type=> 'VARCHAR',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 80,
  p_item_plug_id => 57643519728005792+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> 'NO',
  p_item_default_type=> 'STATIC_TEXT_WITH_SUBSTITUTIONS',
  p_prompt=>'Waarde',
  p_source=>'WAARDE',
  p_source_type=> 'DB_COLUMN',
  p_display_as=> 'NATIVE_NUMBER_FIELD',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 32,
  p_cMaxlength=> 255,
  p_cHeight=> 1,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414419994816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_lov_display_extra=>'YES',
  p_protection_level => 'N',
  p_escape_on_http_output => 'Y',
  p_attribute_03 => 'right',
  p_show_quick_picks=>'N',
  p_item_comment => '');
 
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||'F|#OWNER#:KOSTELEMENTEN:P13_ROWID:ROWID';

wwv_flow_api.create_page_process(
  p_id     => 57646119457005926 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 13,
  p_process_sequence=> 10,
  p_process_point=> 'AFTER_HEADER',
  p_process_type=> 'DML_FETCH_ROW',
  p_process_name=> 'Fetch Row from KOSTELEMENTEN',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'ON_ERROR_PAGE',
  p_process_success_message=> '',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||'#OWNER#:KOSTELEMENTEN:P13_ROWID:ROWID|U';

wwv_flow_api.create_page_process(
  p_id     => 57646305087005927 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 13,
  p_process_sequence=> 30,
  p_process_point=> 'AFTER_SUBMIT',
  p_process_type=> 'DML_PROCESS_ROW',
  p_process_name=> 'Process Row of KOSTELEMENTEN',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'INLINE_IN_NOTIFICATION',
  p_process_success_message=> 'Action Processed.',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||'13';

wwv_flow_api.create_page_process(
  p_id     => 57646524461005928 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 13,
  p_process_sequence=> 40,
  p_process_point=> 'AFTER_SUBMIT',
  p_process_type=> 'CLEAR_CACHE_FOR_PAGES',
  p_process_name=> 'reset page',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'INLINE_IN_NOTIFICATION',
  p_process_success_message=> '',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 13
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00014
prompt  ...PAGE 14: Default KostElementen
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 14
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BEHEERKOSTELEMENTEN'
 ,p_name => 'Default KostElementen'
 ,p_step_title => 'Default KostElementen'
 ,p_step_sub_title => 'Default KostElementen'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131016080317'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' "ID",'||unistr('\000a')||
' "ELEMENT",'||unistr('\000a')||
' "CI_CATEGORIE",'||unistr('\000a')||
' "CI_TYPE",'||unistr('\000a')||
' "COMPUTERTYPE",'||unistr('\000a')||
' "FUNCTIE",'||unistr('\000a')||
' "DATUM",'||unistr('\000a')||
' "WAARDE"'||unistr('\000a')||
'from #OWNER#.KOSTELEMENTEN_DEF';

wwv_flow_api.create_report_region (
  p_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 14,
  p_name=> 'Default KostElementen',
  p_region_name=>'',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_plug_query_max_columns=> 60,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836011830446186 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>1,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836125929446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'ELEMENT',
  p_column_display_sequence=> 2,
  p_column_heading=> 'ELEMENT',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836217925446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'CI_CATEGORIE',
  p_column_display_sequence=> 3,
  p_column_heading=> 'CI_CATEGORIE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836302516446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'CI_TYPE',
  p_column_display_sequence=> 4,
  p_column_heading=> 'CI_TYPE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836414290446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'COMPUTERTYPE',
  p_column_display_sequence=> 5,
  p_column_heading=> 'COMPUTERTYPE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836523927446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 6,
  p_form_element_id=> null,
  p_column_alias=> 'FUNCTIE',
  p_column_display_sequence=> 6,
  p_column_heading=> 'FUNCTIE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836617136446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 7,
  p_form_element_id=> null,
  p_column_alias=> 'DATUM',
  p_column_display_sequence=> 7,
  p_column_heading=> 'DATUM',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57836720541446193 + wwv_flow_api.g_id_offset,
  p_region_id=> 57835720854446169 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 8,
  p_form_element_id=> null,
  p_column_alias=> 'WAARDE',
  p_column_display_sequence=> 8,
  p_column_heading=> 'WAARDE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 14
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00015
prompt  ...PAGE 15: Applicatie Migratie
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 15
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'TS1'
 ,p_name => 'Applicatie Migratie'
 ,p_step_title => 'Applicatie Migratie'
 ,p_step_sub_title => 'Applicatie Migratie'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131107082325'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' "ID",'||unistr('\000a')||
' "CMDB_ID",'||unistr('\000a')||
' "NAAM",'||unistr('\000a')||
' "DIENSTENTYPE",'||unistr('\000a')||
' "EIGENAAR_BELEIDSDOMEIN",'||unistr('\000a')||
' "EIGENAAR_ENTITEIT",'||unistr('\000a')||
' "FIN_BELEIDSDOMEIN",'||unistr('\000a')||
' "FIN_ENTITEIT",'||unistr('\000a')||
' "ASSESSMENT",'||unistr('\000a')||
' "MIGRATIE",'||unistr('\000a')||
' "EOSL_KOST",'||unistr('\000a')||
' "PROJECT_KOST",'||unistr('\000a')||
' "TOTALE_KOST",'||unistr('\000a')||
' f_get_eosl_status(cmdb_id)'||unistr('\000a')||
'from #OWNER#.APPS_CHECKS'||unistr('\000a')||
'where totale_kost > 0';

wwv_flow_api.create_report_region (
  p_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 15,
  p_name=> 'Applicatie Migratie',
  p_region_name=>'apps_rep_id',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_header=> '<script src="#WORKSPACE_IMAGES#jquery.htmldbHscroll-0.0.1.min.js" type="text/javascript"></script>',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411829300816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869324199542158 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'ID',
  p_column_display_sequence=> 2,
  p_column_heading=> 'ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'Y',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869412074542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'CMDB_ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869514670542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM',
  p_column_display_sequence=> 3,
  p_column_heading=> 'NAAM',
  p_use_as_row_header=> 'N',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>1,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_column_width=> '80',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869626201542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'DIENSTENTYPE',
  p_column_display_sequence=> 13,
  p_column_heading=> 'DIENSTENTYPE',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869717664542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'EIGENAAR_BELEIDSDOMEIN',
  p_column_display_sequence=> 4,
  p_column_heading=> 'EIGENAAR_BELEIDSDOMEIN',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869813279542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 6,
  p_form_element_id=> null,
  p_column_alias=> 'EIGENAAR_ENTITEIT',
  p_column_display_sequence=> 5,
  p_column_heading=> 'EIGENAAR_ENTITEIT',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57869932327542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 7,
  p_form_element_id=> null,
  p_column_alias=> 'FIN_BELEIDSDOMEIN',
  p_column_display_sequence=> 6,
  p_column_heading=> 'FIN_BELEIDSDOMEIN',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57870023772542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 8,
  p_form_element_id=> null,
  p_column_alias=> 'FIN_ENTITEIT',
  p_column_display_sequence=> 7,
  p_column_heading=> 'FIN_ENTITEIT',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'Y',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57870311560542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 9,
  p_form_element_id=> null,
  p_column_alias=> 'ASSESSMENT',
  p_column_display_sequence=> 8,
  p_column_heading=> 'ASSESSMENT',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57870420855542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 10,
  p_form_element_id=> null,
  p_column_alias=> 'MIGRATIE',
  p_column_display_sequence=> 9,
  p_column_heading=> 'MIGRATIE',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57870508373542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 11,
  p_form_element_id=> null,
  p_column_alias=> 'EOSL_KOST',
  p_column_display_sequence=> 10,
  p_column_heading=> 'EOSL_KOST',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57870622378542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 12,
  p_form_element_id=> null,
  p_column_alias=> 'PROJECT_KOST',
  p_column_display_sequence=> 11,
  p_column_heading=> 'PROJECT_KOST',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 57870701744542159 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 13,
  p_form_element_id=> null,
  p_column_alias=> 'TOTALE_KOST',
  p_column_display_sequence=> 12,
  p_column_heading=> 'TOTALE_KOST',
  p_use_as_row_header=> 'N',
  p_column_format=> '999G999G999G999G999G990',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_lov_show_nulls=> 'NO',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_lov_display_extra=> 'YES',
  p_include_in_export=> 'Y',
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 66959222019879007 + wwv_flow_api.g_id_offset,
  p_region_id=> 57869021511542130 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 14,
  p_form_element_id=> null,
  p_column_alias=> 'F_GET_EOSL_STATUS(CMDB_ID)',
  p_column_display_sequence=> 14,
  p_column_heading=> 'EOSL Status',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
wwv_flow_api.create_page_da_event (
  p_id => 67013101149249337 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 15
 ,p_name => 'HorScroll'
 ,p_event_sequence => 10
 ,p_triggering_element_type => 'REGION'
 ,p_triggering_region_id => 57869021511542130 + wwv_flow_api.g_id_offset
 ,p_bind_type => 'bind'
 ,p_bind_event_type => 'apexafterrefresh'
  );
wwv_flow_api.create_page_da_action (
  p_id => 67013426215249427 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_page_id => 15
 ,p_event_id => 67013101149249337 + wwv_flow_api.g_id_offset
 ,p_event_result => 'TRUE'
 ,p_action_sequence => 10
 ,p_execute_on_page_init => 'Y'
 ,p_action => 'NATIVE_JAVASCRIPT_CODE'
 ,p_attribute_01 => '$("#report_apps_rep_id").htmldbHscroll({width:600,columns:2});'
 ,p_stop_execution_on_error => 'Y'
 );
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 15
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00016
prompt  ...PAGE 16: Servers per Rapport
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 16
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_tab_set => 'T_BIJKOMENDEGEGEVENS'
 ,p_name => 'Servers per Rapport'
 ,p_step_title => 'Servers per Rapport'
 ,p_step_sub_title => 'Servers per Rapport'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'ON'
 ,p_page_is_public_y_n => 'N'
 ,p_cache_page_yn => 'N'
 ,p_help_text => 
'No help is available for this page.'
 ,p_last_updated_by => 'VERMEYDI'
 ,p_last_upd_yyyymmddhh24miss => '20131018111234'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s:=s||'select '||unistr('\000a')||
' s."CMDB_ID",'||unistr('\000a')||
' s."NAAM",'||unistr('\000a')||
' s."SOURCE",'||unistr('\000a')||
' s."MSG",'||unistr('\000a')||
' c.status'||unistr('\000a')||
'from #OWNER#.SYSTEM_VERIFICATION s, #OWNER#.COMPONENT c '||unistr('\000a')||
'where s.cmdb_id = c.cmdb_id';

wwv_flow_api.create_report_region (
  p_id=> 58630022442655564 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 16,
  p_name=> 'Servers per Rapport',
  p_region_name=>'',
  p_template=> 57410003985816286+ wwv_flow_api.g_id_offset,
  p_display_sequence=> 10,
  p_new_grid         => false,
  p_new_grid_row     => true,
  p_new_grid_column  => true,
  p_display_column=> null,
  p_display_point=> 'BODY_3',
  p_item_display_point=> 'ABOVE',
  p_source=> s,
  p_source_type=> 'SQL_QUERY',
  p_plug_caching=> 'NOT_CACHED',
  p_customized=> '0',
  p_translate_title=> 'Y',
  p_ajax_enabled=> 'Y',
  p_query_row_template=> 57411729106816313+ wwv_flow_api.g_id_offset,
  p_query_headings_type=> 'COLON_DELMITED_LIST',
  p_query_num_rows=> '15',
  p_query_options=> 'DERIVED_REPORT_COLUMNS',
  p_query_break_cols=> '0',
  p_query_no_data_found=> 'No data found.',
  p_query_num_rows_type=> 'ROW_RANGES_IN_SELECT_LIST',
  p_query_row_count_max=> '500',
  p_pagination_display_position=> 'BOTTOM_RIGHT',
  p_break_type_flag=> 'DEFAULT_BREAK_FORMATTING',
  p_csv_output=> 'Y',
  p_csv_output_link_text=> 'Download',
  p_query_asc_image=> 'apex/builder/dup.gif',
  p_query_asc_image_attr=> 'width="16" height="16" alt="" ',
  p_query_desc_image=> 'apex/builder/ddown.gif',
  p_query_desc_image_attr=> 'width="16" height="16" alt="" ',
  p_plug_query_strip_html=> 'Y',
  p_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 58630432418655662 + wwv_flow_api.g_id_offset,
  p_region_id=> 58630022442655564 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 1,
  p_form_element_id=> null,
  p_column_alias=> 'CMDB_ID',
  p_column_display_sequence=> 1,
  p_column_heading=> 'CMDB_ID',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 58630515833655662 + wwv_flow_api.g_id_offset,
  p_region_id=> 58630022442655564 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 2,
  p_form_element_id=> null,
  p_column_alias=> 'NAAM',
  p_column_display_sequence=> 2,
  p_column_heading=> 'NAAM',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>1,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 58630622548655663 + wwv_flow_api.g_id_offset,
  p_region_id=> 58630022442655564 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 3,
  p_form_element_id=> null,
  p_column_alias=> 'SOURCE',
  p_column_display_sequence=> 3,
  p_column_heading=> 'Rapport',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 58630729844655663 + wwv_flow_api.g_id_offset,
  p_region_id=> 58630022442655564 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 4,
  p_form_element_id=> null,
  p_column_alias=> 'MSG',
  p_column_display_sequence=> 4,
  p_column_heading=> 'Opmerking',
  p_column_alignment=>'LEFT',
  p_default_sort_column_sequence=>0,
  p_disable_sort_column=>'N',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
declare
  s varchar2(32767) := null;
begin
s := null;
wwv_flow_api.create_report_columns (
  p_id=> 58659208413733258 + wwv_flow_api.g_id_offset,
  p_region_id=> 58630022442655564 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_query_column_id=> 5,
  p_form_element_id=> null,
  p_column_alias=> 'STATUS',
  p_column_display_sequence=> 5,
  p_column_heading=> 'Status',
  p_column_alignment=>'LEFT',
  p_heading_alignment=>'CENTER',
  p_disable_sort_column=>'Y',
  p_sum_column=> 'N',
  p_hidden_column=> 'N',
  p_display_as=>'ESCAPE_SC',
  p_is_required=> false,
  p_pk_col_source=> s,
  p_column_comment=>'');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 16
--
 
begin
 
null;
end;
null;
 
end;
/

 
--application/pages/page_00101
prompt  ...PAGE 101: Login
--
 
begin
 
wwv_flow_api.create_page (
  p_flow_id => wwv_flow.g_flow_id
 ,p_id => 101
 ,p_user_interface_id => 57416427031816450 + wwv_flow_api.g_id_offset
 ,p_name => 'Login'
 ,p_alias => 'LOGIN_DESKTOP'
 ,p_step_title => 'Login'
 ,p_step_sub_title_type => 'TEXT_WITH_SUBSTITUTIONS'
 ,p_first_item => 'AUTO_FIRST_ITEM'
 ,p_include_apex_css_js_yn => 'Y'
 ,p_autocomplete_on_off => 'OFF'
 ,p_step_template => 57405617771816184 + wwv_flow_api.g_id_offset
 ,p_page_is_public_y_n => 'Y'
 ,p_cache_page_yn => 'N'
 ,p_last_upd_yyyymmddhh24miss => '20131015133733'
  );
null;
 
end;
/

declare
  s varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
s := null;
wwv_flow_api.create_page_plug (
  p_id=> 57416922356816522 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_page_id=> 101,
  p_plug_name=> 'Login',
  p_region_name=>'',
  p_escape_on_http_output=>'N',
  p_plug_template=> 57408721803816282+ wwv_flow_api.g_id_offset,
  p_plug_display_sequence=> 10,
  p_plug_new_grid         => false,
  p_plug_new_grid_row     => true,
  p_plug_new_grid_column  => true,
  p_plug_display_column=> null,
  p_plug_display_point=> 'BODY_3',
  p_plug_item_display_point=> 'ABOVE',
  p_plug_source=> s,
  p_plug_source_type=> 'STATIC_TEXT',
  p_plug_query_row_template=> 1,
  p_plug_query_headings_type=> 'COLON_DELMITED_LIST',
  p_plug_query_row_count_max => 500,
  p_plug_display_condition_type => '',
  p_plug_caching=> 'NOT_CACHED',
  p_plug_comment=> '');
end;
/
 
begin
 
null;
 
end;
/

 
begin
 
null;
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57417014740816538 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 101,
  p_name=>'P101_USERNAME',
  p_data_type=> '',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 10,
  p_item_plug_id => 57416922356816522+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> '',
  p_prompt=>'Username',
  p_display_as=> 'NATIVE_TEXT_FIELD',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 40,
  p_cMaxlength=> 100,
  p_cHeight=> null,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414306093816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_attribute_01 => 'N',
  p_attribute_02 => 'N',
  p_attribute_03 => 'N',
  p_attribute_04 => 'TEXT',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57417125210816568 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 101,
  p_name=>'P101_PASSWORD',
  p_data_type=> '',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 20,
  p_item_plug_id => 57416922356816522+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> '',
  p_prompt=>'Password',
  p_display_as=> 'NATIVE_PASSWORD',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> 40,
  p_cMaxlength=> 100,
  p_cHeight=> null,
  p_new_grid=> false,
  p_begin_on_new_line=> 'YES',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'RIGHT',
  p_field_alignment=> 'LEFT',
  p_field_template=> 57414306093816365+wwv_flow_api.g_id_offset,
  p_is_persistent=> 'Y',
  p_attribute_01 => 'Y',
  p_attribute_02 => 'Y',
  p_item_comment => '');
 
 
end;
/

declare
    h varchar2(32767) := null;
begin
wwv_flow_api.create_page_item(
  p_id=>57417202170816583 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id=> 101,
  p_name=>'P101_LOGIN',
  p_data_type=> '',
  p_is_required=> false,
  p_accept_processing=> 'REPLACE_EXISTING',
  p_item_sequence=> 30,
  p_item_plug_id => 57416922356816522+wwv_flow_api.g_id_offset,
  p_use_cache_before_default=> '',
  p_item_default=> 'Login',
  p_prompt=>'Login',
  p_source=>'LOGIN',
  p_source_type=> 'STATIC',
  p_display_as=> 'BUTTON',
  p_lov_display_null=> 'NO',
  p_lov_translated=> 'N',
  p_cSize=> null,
  p_cMaxlength=> null,
  p_cHeight=> null,
  p_tag_attributes  => 'template:'||to_char(57414711827816373 + wwv_flow_api.g_id_offset),
  p_new_grid=> false,
  p_begin_on_new_line=> 'NO',
  p_begin_on_new_field=> 'YES',
  p_colspan=> null,
  p_rowspan=> null,
  p_grid_column=> null,
  p_label_alignment=> 'LEFT',
  p_field_alignment=> 'LEFT',
  p_is_persistent=> 'Y',
  p_button_action => 'SUBMIT',
  p_button_is_hot=>'Y',
  p_item_comment => '');
 
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||'apex_authentication.send_login_username_cookie ('||unistr('\000a')||
'    p_username => lower(:P101_USERNAME) );';

wwv_flow_api.create_page_process(
  p_id     => 57417428291816604 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 101,
  p_process_sequence=> 10,
  p_process_point=> 'AFTER_SUBMIT',
  p_process_type=> 'PLSQL',
  p_process_name=> 'Set Username Cookie',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'INLINE_IN_NOTIFICATION',
  p_process_success_message=> '',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||'apex_authentication.login('||unistr('\000a')||
'    p_username => :P101_USERNAME,'||unistr('\000a')||
'    p_password => :P101_PASSWORD );';

wwv_flow_api.create_page_process(
  p_id     => 57417308101816586 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 101,
  p_process_sequence=> 20,
  p_process_point=> 'AFTER_SUBMIT',
  p_process_type=> 'PLSQL',
  p_process_name=> 'Login',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'INLINE_IN_NOTIFICATION',
  p_process_success_message=> '',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||'101';

wwv_flow_api.create_page_process(
  p_id     => 57417606825816605 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 101,
  p_process_sequence=> 30,
  p_process_point=> 'AFTER_SUBMIT',
  p_process_type=> 'CLEAR_CACHE_FOR_PAGES',
  p_process_name=> 'Clear Page(s) Cache',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'INLINE_IN_NOTIFICATION',
  p_process_success_message=> '',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
declare
  p varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
p:=p||':P101_USERNAME := apex_authentication.get_login_username_cookie;';

wwv_flow_api.create_page_process(
  p_id     => 57417525959816604 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_flow_step_id => 101,
  p_process_sequence=> 10,
  p_process_point=> 'BEFORE_HEADER',
  p_process_type=> 'PLSQL',
  p_process_name=> 'Get Username Cookie',
  p_process_sql_clob => p,
  p_process_error_message=> '',
  p_error_display_location=> 'ON_ERROR_PAGE',
  p_process_success_message=> '',
  p_process_is_stateful_y_n=>'N',
  p_process_comment=>'');
end;
null;
 
end;
/

 
begin
 
---------------------------------------
-- ...updatable report columns for page 101
--
 
begin
 
null;
end;
null;
 
end;
/

prompt  ...lists
--
--application/shared_components/navigation/breadcrumbs
prompt  ...breadcrumbs
--
 
begin
 
wwv_flow_api.create_menu (
  p_id=> 57417732379816605 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=> ' Breadcrumb');
 
wwv_flow_api.create_menu_option (
  p_id=>57421402146816720 + wwv_flow_api.g_id_offset,
  p_menu_id=>57417732379816605 + wwv_flow_api.g_id_offset,
  p_parent_id=>0,
  p_option_sequence=>10,
  p_short_name=>'Apps Checks',
  p_long_name=>'',
  p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.',
  p_page_id=>1,
  p_also_current_for_pages=> '');
 
null;
 
end;
/

prompt  ...page templates for application: 175
--
--application/shared_components/user_interface/templates/page/login
prompt  ......Page template 57405617771816184
 
begin
 
wwv_flow_api.create_template (
  p_id => 57405617771816184 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Login'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD# id="uLogin">'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<div id="uLoginContainer">'||unistr('\000a')||
'  #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_03#'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVASCRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_notification_message => '<section class="uSingleAlertMessage red" id="uNotificationMessage">'||unistr('\000a')||
'	<p>#MESSAGE#</p>'||unistr('\000a')||
'	<a href="javascript:void(0)" class="closeMessage" onclick="$x_Remove(''uNotificationMessage'')"></a>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0"'
 ,p_theme_class_id => 6
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
 ,p_template_comment => '18'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/minimal_page
prompt  ......Page template 57405724640816220
 
begin
 
wwv_flow_api.create_template (
  p_id => 57405724640816220 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Minimal Page'
 ,p_is_popup => false
 ,p_header_template => '<!DOCTYPE html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer" class="minimalPage">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#TITLE#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<di'||
'v id="uOneCol">'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_03#'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #APP_VERSION#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVASCRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 3
 ,p_error_page_template => '<section class="uRegion uNoHeading uErrorRegion">'||unistr('\000a')||
'  <div class="uRegionContent">'||unistr('\000a')||
'    <p><strong>#MESSAGE#</strong></p>'||unistr('\000a')||
'    <p>#ADDITIONAL_INFO#</p>'||unistr('\000a')||
'    <div class="uErrorTechInfo">#TECHNICAL_INFO#</div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      <a href="#BACK_LINK#" class="uButtonLarge uHotButton"><span>#OK#</span></a>'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/no_tabs_left_sidebar
prompt  ......Page template 57405819120816224
 
begin
 
wwv_flow_api.create_template (
  p_id => 57405819120816224 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'No Tabs - Left Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<tab'||
'le id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uLeftCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => 'summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 17
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/no_tabs_left_and_right_sidebar
prompt  ......Page template 57405920920816226
 
begin
 
wwv_flow_api.create_template (
  p_id => 57405920920816226 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'No Tabs - Left and Right Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<tab'||
'le id="uPageCols" class="uThreeCol"><tr>'||unistr('\000a')||
'  <td id="uLeftCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => 'summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 17
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/no_tabs_no_sidebar
prompt  ......Page template 57406021475816227
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406021475816227 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'No Tabs - No Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div'||
' id="uOneCol">'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_03#'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 3
 ,p_error_page_template => '<section class="uRegion uNoHeading uErrorRegion">'||unistr('\000a')||
'  <div class="uRegionContent">'||unistr('\000a')||
'    <p><strong>#MESSAGE#</strong></p>'||unistr('\000a')||
'    <p>#ADDITIONAL_INFO#</p>'||unistr('\000a')||
'    <div class="uErrorTechInfo">#TECHNICAL_INFO#</div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      <a href="#BACK_LINK#" class="uButtonLarge uHotButton"><span>#OK#</span></a>'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/no_tabs_right_sidebar
prompt  ......Page template 57406117095816229
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406117095816229 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'No Tabs - Right Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<tab'||
'le id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 3
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_content_frame
prompt  ......Page template 57406224007816231
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406224007816231 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - Content Frame'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uOneCol">'||unistr('\000a')||
'<section class="uRegion uRegionNoPadding clearfix uRegionFrame">'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'		#REGION_POSITION_02#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFrameContent">'||unistr('\000a')||
'	<div class="uFrameMain">'||unistr('\000a')||
'		#BOX_BODY#'||unistr('\000a')||
'	</div>'||unistr('\000a')||
'	<div class="uFrameSide">'||unistr('\000a')||
'		#REG'||
'ION_POSITION_03#'||unistr('\000a')||
'	</div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 9
 ,p_grid_type => 'TABLE'
 ,p_grid_always_use_max_columns => false
 ,p_grid_has_column_span => true
 ,p_grid_emit_empty_leading_cols => true
 ,p_grid_emit_empty_trail_cols => false
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_left_sidebar
prompt  ......Page template 57406332484816233
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406332484816233 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - Left Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uTwoColumns">'||unistr('\000a')||
'<table id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uLeftCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 16
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_left_and_right_sidebar
prompt  ......Page template 57406420442816236
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406420442816236 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - Left and Right Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uThreeColumns">'||unistr('\000a')||
'<table id="uPageCols" class="uThreeCol"><tr>'||unistr('\000a')||
'  <td id="uLeftCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a class="active" href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 16
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_no_sidebar
prompt  ......Page template 57406532479816241
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406532479816241 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - No Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uOneCol">'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_03#'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => 'class="regionColumns"'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 1
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_right_sidebar
prompt  ......Page template 57406615653816243
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406615653816243 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - Right Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uTwoColumns">'||unistr('\000a')||
'<table id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 16
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_search_filter_bar
prompt  ......Page template 57406720764816244
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406720764816244 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - Search Filter Bar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
''||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="body" class="uSearchContainer">'||unistr('\000a')||
'  <table class="tbl-body" cellspacing="0" cellpadding="0" border="0" summary=""  width="100%">'||unistr('\000a')||
'    <tbody>'||unistr('\000a')||
'      <tr>'||unistr('\000a')||
'        <td class="tbl-sidebar" style="vertical-align:top">'||unistr('\000a')||
'          <div class="ebaSearchFilterBar">#REGION_POSITION_02#</div>'||unistr('\000a')||
'        </td>'||unistr('\000a')||
'        <td class="tbl-'||
'main">#BOX_BODY##REGION_POSITION_03#</td>'||unistr('\000a')||
'      </tr>'||unistr('\000a')||
'    </tbody>'||unistr('\000a')||
'  </table>'||unistr('\000a')||
'</div>'||unistr('\000a')||
''
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'||unistr('\000a')||
''
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<div class="notification" id="notification-message">'||unistr('\000a')||
'  <img src="#IMAGE_PREFIX#delete.gif" onclick="$x_Remove(''notification-message'')"  style="float:right;" class="remove-message" alt="" />#MESSAGE#'||unistr('\000a')||
'</div>'
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 9
 ,p_grid_type => 'TABLE'
 ,p_grid_always_use_max_columns => false
 ,p_grid_has_column_span => true
 ,p_grid_emit_empty_leading_cols => true
 ,p_grid_emit_empty_trail_cols => false
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/one_level_tabs_wizard_page
prompt  ......Page template 57406832241816246
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406832241816246 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'One Level Tabs - Wizard Page'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION'||
'_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uOneCol">'||unistr('\000a')||
''||unistr('\000a')||
'<div class="cWizard">'||unistr('\000a')||
'	<div class="cWizardHeader">'||unistr('\000a')||
'		#REGION_POSITION_02#'||unistr('\000a')||
'	</div>'||unistr('\000a')||
'    <div class="cWizardContentContainer">'||unistr('\000a')||
'    <div class="cWizardContent">'||unistr('\000a')||
'        #BOX_BODY##REGION_POSITION_03#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'    <div class="clear"></div>'||unistr('\000a')||
'</div>'||unistr('\000a')||
''||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 8
 ,p_grid_type => 'TABLE'
 ,p_grid_always_use_max_columns => false
 ,p_grid_has_column_span => true
 ,p_grid_emit_empty_leading_cols => true
 ,p_grid_emit_empty_trail_cols => false
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/popup
prompt  ......Page template 57406919447816247
 
begin
 
wwv_flow_api.create_template (
  p_id => 57406919447816247 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Popup'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD# id="uPopup">'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<table id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'  #REGION_POSITION_01#'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'  #REGION_POSITION_05#'||unistr('\000a')||
'  #REGION_POSITION_06#'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'
 ,p_footer_template => 
'<div id="uHiddenItems">'||unistr('\000a')||
'  #REGION_POSITION_08#'||unistr('\000a')||
'</div>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVASCRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_theme_class_id => 4
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/printer_friendly
prompt  ......Page template 57407016034816248
 
begin
 
wwv_flow_api.create_template (
  p_id => 57407016034816248 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Printer Friendly'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD# id="uPrinterFriendly">'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div'||
' id="uOneCol">'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_03#'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
''
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<li><a href="#LINK#">#TEXT#</a>#EDIT#</li>'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_theme_class_id => 5
 ,p_grid_type => 'TABLE'
 ,p_grid_always_use_max_columns => false
 ,p_grid_has_column_span => true
 ,p_grid_emit_empty_leading_cols => true
 ,p_grid_emit_empty_trail_cols => false
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
 ,p_template_comment => '3'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/two_level_tabs_left_sidebar
prompt  ......Page template 57407114435816253
 
begin
 
wwv_flow_api.create_template (
  p_id => 57407114435816253 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Two Level Tabs - Left Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <div class="uParentTabs">'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #PARENT_TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'   '||
' </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uTwoColumns">'||unistr('\000a')||
'<table id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uLeftCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_non_curr_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 18
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/two_level_tabs_left_and_right_sidebar
prompt  ......Page template 57407209556816254
 
begin
 
wwv_flow_api.create_template (
  p_id => 57407209556816254 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Two Level Tabs - Left and Right Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <div class="uParentTabs">'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #PARENT_TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'   '||
' </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uThreeColumns">'||unistr('\000a')||
'<table id="uPageCols" class="uThreeCol"><tr>'||unistr('\000a')||
'  <td id="uLeftCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITI'||
'ON_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_current_tab => '<li><a class="active" href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_current_tab => '<li><a class="active" href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_non_curr_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_sidebar_def_reg_pos => 'REGION_POSITION_02'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 18
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/two_level_tabs_no_sidebar
prompt  ......Page template 57407314697816255
 
begin
 
wwv_flow_api.create_template (
  p_id => 57407314697816255 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Two Level Tabs - No Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <div class="uParentTabs">'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #PARENT_TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'   '||
' </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uOneCol">'||unistr('\000a')||
'  #REGION_POSITION_02#'||unistr('\000a')||
'  #BOX_BODY#'||unistr('\000a')||
'  #REGION_POSITION_03#'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<div class="success" id="success-message"><section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'||unistr('\000a')||
'  <img src="#IMAGE_PREFIX#delete.gif" onclick="$x_Remove(''success-message'')" style="float:right;" class="remove-message" alt="" />'||unistr('\000a')||
'  #SUCCESS_MESSAGE#'||unistr('\000a')||
'</div>'
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_non_curr_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 2
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/page/two_level_tabs_right_sidebar
prompt  ......Page template 57407419226816256
 
begin
 
wwv_flow_api.create_template (
  p_id => 57407419226816256 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_theme_id => 26
 ,p_name => 'Two Level Tabs - Right Sidebar'
 ,p_is_popup => false
 ,p_header_template => '<!--[if HTML5]><![endif]-->'||unistr('\000a')||
'<!doctype html>'||unistr('\000a')||
'<!--[if lt IE 7 ]> <html class="ie6 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 7 ]>    <html class="ie7 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 8 ]>    <html class="ie8 no-css3" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if IE 9 ]>    <html class="ie9" lang="&BROWSER_LANGUAGE."> <![endif]-->'||unistr('\000a')||
'<!--[if (gt IE 9)|!(IE)]><!--> <html lang="&BROWSER_LANGUAGE."> <!--<![endif]-->'||unistr('\000a')||
'<head>'||unistr('\000a')||
'<!--[if !HTML5]>'||unistr('\000a')||
'  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">'||unistr('\000a')||
'<![endif]-->'||unistr('\000a')||
'  <meta charset="UTF-8">'||unistr('\000a')||
'  <title>#TITLE#</title>'||unistr('\000a')||
'  <link rel="icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  <link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">'||unistr('\000a')||
'  #APEX_CSS#'||unistr('\000a')||
'#TEMPLATE_CSS#'||unistr('\000a')||
'#THEME_CSS#'||unistr('\000a')||
'#PAGE_CSS#'||unistr('\000a')||
'#APEX_JAVASCRIPT#'||unistr('\000a')||
'#TEMPLATE_JAVASCRIPT#'||unistr('\000a')||
'#APPLICATION_JAVASCRIPT#'||unistr('\000a')||
'#PAGE_JAVASCRIPT#'||unistr('\000a')||
'#HEAD#'||unistr('\000a')||
'  <meta name="viewport" content="width=device-width, initial-scale=1.0">'||unistr('\000a')||
'  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#?v=2">'||unistr('\000a')||
'  <script src="#IMAGE_PREFIX#themes/theme_26/js/4_2.js?v=#APEX_VERSION#"></script>'||unistr('\000a')||
'</head>'||unistr('\000a')||
'<body #ONLOAD#>'||unistr('\000a')||
'  <!--[if lte IE 6]><div id="outdated-browser">#OUTDATED_BROWSER#</div><![endif]-->'||unistr('\000a')||
'  #FORM_OPEN#'||unistr('\000a')||
'  <div id="uBodyContainer">'
 ,p_box => 
'<header id="uHeader">'||unistr('\000a')||
'  #REGION_POSITION_07#'||unistr('\000a')||
'  <hgroup>'||unistr('\000a')||
'    <a href="#HOME_LINK#" id="uLogo">#LOGO#</a>'||unistr('\000a')||
'    <div class="userBlock">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="navIcon user" alt="">'||unistr('\000a')||
'      <span>&APP_USER.</span>'||unistr('\000a')||
'      #NAVIGATION_BAR#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </hgroup>'||unistr('\000a')||
'  <div class="uParentTabs">'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #PARENT_TAB_CELLS#'||unistr('\000a')||
'    </ul>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <nav>'||unistr('\000a')||
'    <ul>'||unistr('\000a')||
'      #TAB_CELLS#'||unistr('\000a')||
'   '||
' </ul>'||unistr('\000a')||
'    #REGION_POSITION_08#'||unistr('\000a')||
'  </nav>'||unistr('\000a')||
'  #REGION_POSITION_04#'||unistr('\000a')||
'</header>'||unistr('\000a')||
'#REGION_POSITION_01#'||unistr('\000a')||
'#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#'||unistr('\000a')||
'<div id="uTwoColumns">'||unistr('\000a')||
'<table id="uPageCols" class="uTwoCol"><tr>'||unistr('\000a')||
'  <td id="uMidCol">'||unistr('\000a')||
'    #REGION_POSITION_02#'||unistr('\000a')||
'    #BOX_BODY#'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'  <td id="uRightCol">'||unistr('\000a')||
'    <aside>'||unistr('\000a')||
'    #REGION_POSITION_03#'||unistr('\000a')||
'    </aside>'||unistr('\000a')||
'  </td>'||unistr('\000a')||
'</tr></table>'||unistr('\000a')||
'</div>'
 ,p_footer_template => 
'<footer id="uFooter">'||unistr('\000a')||
'  <div class="uFooterContent">'||unistr('\000a')||
'    <div id="customize">#CUSTOMIZE#</div>'||unistr('\000a')||
'    #REGION_POSITION_05#'||unistr('\000a')||
'    #SCREEN_READER_TOGGLE#'||unistr('\000a')||
'    <span class="uFooterVersion">'||unistr('\000a')||
'      #APP_VERSION#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uFooterBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</footer>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'#FORM_CLOSE#'||unistr('\000a')||
'#DEVELOPER_TOOLBAR#'||unistr('\000a')||
'#GENERATED_CSS#'||unistr('\000a')||
'#GENERATED_JAVAS'||
'CRIPT#'||unistr('\000a')||
'</body>'||unistr('\000a')||
'</html>'
 ,p_success_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uSuccessMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uSuccessMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uCheckmarkIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #SUCCESS_MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_non_current_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_current_tab => '<li><a href="#TAB_LINK#" class="active">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_top_non_curr_tab => '<li><a href="#TAB_LINK#">#TAB_LABEL#</a>#TAB_INLINE_EDIT#</li>'
 ,p_notification_message => '<section class="uRegion uWhiteRegion uMessageRegion clearfix" id="uNotificationMessage">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <a href="javascript:void(0)" onclick="$x_Remove(''uNotificationMessage'')" class="uCloseMessage"></a>'||unistr('\000a')||
'    <img src="#IMAGE_PREFIX#f_spacer.gif" class="uWarningIcon" alt="" />'||unistr('\000a')||
'    <div class="uMessageText">'||unistr('\000a')||
'      #MESSAGE#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_navigation_bar => '#BAR_BODY#'
 ,p_navbar_entry => '<a href="#LINK#">#TEXT#</a>#EDIT#'
 ,p_region_table_cattributes => ' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
 ,p_breadcrumb_def_reg_pos => 'REGION_POSITION_01'
 ,p_theme_class_id => 2
 ,p_grid_type => 'TABLE'
 ,p_has_edit_links => true
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

prompt  ...button templates
--
--application/shared_components/user_interface/templates/button/button
prompt  ......Button Template 57414711827816373
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57414711827816373 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Button'
 ,p_template => 
'<a href="#LINK#" class="uButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButton uHotButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 1
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/interactive_report_button
prompt  ......Button Template 57414806575816389
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57414806575816389 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Interactive Report Button'
 ,p_template => 
'<a href="#LINK#" class="uButtonIR #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButtonIR uHotButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 2
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/interactive_report_button_next
prompt  ......Button Template 57414926953816389
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57414926953816389 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Interactive Report Button (Next)'
 ,p_template => 
'<a href="#LINK#" class="uButtonIR nextButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#<img src="#IMAGE_PREFIX#f_spacer.gif" class="uButtonIcon nextIcon" alt=""></span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButtonIR uHotButton nextButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#<img src="#IMAGE_PREFIX#f_spacer.gif" class="uButtonIcon nextIcon" alt=""></span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 5
 ,p_template_comment => 'Standard Button'
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/large_button
prompt  ......Button Template 57415009633816389
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415009633816389 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Large Button'
 ,p_template => 
'<a href="#LINK#" class="uButtonLarge #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButtonLarge uHotButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 5
 ,p_template_comment => 'Standard Button'
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/large_button_next
prompt  ......Button Template 57415126351816390
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415126351816390 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Large Button (Next)'
 ,p_template => 
'<a href="#LINK#" class="uButtonLarge nextButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#<img src="#IMAGE_PREFIX#f_spacer.gif" class="uButtonIcon nextIcon" alt=""></span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButtonLarge uHotButton nextButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#<img src="#IMAGE_PREFIX#f_spacer.gif" class="uButtonIcon nextIcon" alt=""></span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 5
 ,p_template_comment => 'Standard Button'
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/large_button_previous
prompt  ......Button Template 57415219754816390
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415219754816390 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Large Button (Previous)'
 ,p_template => 
'<a href="#LINK#" class="uButtonLarge prevButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button" title="#LABEL#"><span><img src="#IMAGE_PREFIX#f_spacer.gif" class="uButtonIcon prevIcon" alt="#LABEL#"></span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButtonLarge utHotButton prevButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button" title="#LABEL#"><span><img src="#IMAGE_PREFIX#f_spacer.gif" class="uButtonIcon prevIcon" alt="#LABEL#"></span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 5
 ,p_template_comment => 'Standard Button'
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/small_button
prompt  ......Button Template 57415326625816390
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415326625816390 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => 'Small Button'
 ,p_template => 
'<a href="#LINK#" class="uButtonSmall #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_hot_template => 
'<a href="#LINK#" class="uButtonSmall uHotButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a> '
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 4
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/add_button
prompt  ......Button Template 57415401598816390
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415401598816390 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => '[ + ] Add Button'
 ,p_template => 
'<a href="#LINK#" class="uIconButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# title="#LABEL#" role="button"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="#LABEL#" class="addIcon" /></a>'
 ,p_hot_template => 
'<a href="#LINK#" class="uIconButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# title="#LABEL#" role="button"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="#LABEL#"  class="addIcon"/></a>'
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 1
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/go_to_button
prompt  ......Button Template 57415505016816390
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415505016816390 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => '[ > ] Go To Button'
 ,p_template => 
'<a href="#LINK#" class="uIconButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# title="#LABEL#" role="button"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="#LABEL#" class="gotoIcon" /></a>'
 ,p_hot_template => 
'<a href="#LINK#" class="uIconButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# title="#LABEL#" role="button"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="#LABEL#" class="gotoIcon"/></a>'
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 1
 ,p_theme_id => 26
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/button/text_button
prompt  ......Button Template 57415623835816392
 
begin
 
wwv_flow_api.create_button_templates (
  p_id => 57415623835816392 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_template_name => '[ Text ] Button'
 ,p_template => 
'<a href="#LINK#" class="uIconButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a>'
 ,p_hot_template => 
'<a href="#LINK#" class="uIconButton #BUTTON_CSS_CLASSES#" id="#BUTTON_ID#" #BUTTON_ATTRIBUTES# role="button"><span>#LABEL#</span></a>'
 ,p_translate_this_template => 'N'
 ,p_theme_class_id => 1
 ,p_theme_id => 26
  );
null;
 
end;
/

---------------------------------------
prompt  ...region templates
--
--application/shared_components/user_interface/templates/region/accessible_region_with_heading
prompt  ......region template 57407522805816262
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57407522805816262 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#BUTTON_CSS_CLASSES#">'||unistr('\000a')||
'  <h1 class="visuallyhidden">#TITLE#</h1>'||unistr('\000a')||
'  #BODY#'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Accessible Region with Heading'
 ,p_theme_id => 26
 ,p_theme_class_id => 21
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/alert_region
prompt  ......region template 57407618161816277
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57407618161816277 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uWhiteRegion uAlertRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Alert Region'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 10
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Used for alerts and confirmations.  Please use a region image for the success/warning icon'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/borderless_region
prompt  ......region template 57407726087816278
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57407726087816278 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uBorderlessRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Borderless Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 7
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Use this region template when you want to contain content without a border.'||unistr('\000a')||
''||unistr('\000a')||
'TITLE=YES'||unistr('\000a')||
'BUTTONS=YES'||unistr('\000a')||
'100% WIDTH=NO'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/borderless_region_no_heading
prompt  ......region template 57407816320816279
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57407816320816279 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uBorderlessRegion clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Borderless Region (no heading)'
 ,p_theme_id => 26
 ,p_theme_class_id => 7
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Use this region template when you want to contain content without a border.'||unistr('\000a')||
''||unistr('\000a')||
'TITLE=YES'||unistr('\000a')||
'BUTTONS=YES'||unistr('\000a')||
'100% WIDTH=NO'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/bracketed_region
prompt  ......region template 57407915346816279
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57407915346816279 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uBracketedRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Bracketed Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 18
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Use this region template when you want to contain content with a bracket UI.'||unistr('\000a')||
''||unistr('\000a')||
'TITLE=YES'||unistr('\000a')||
'BUTTONS=YES'||unistr('\000a')||
'100% WIDTH=NO'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/breadcrumb_region
prompt  ......region template 57408014330816279
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408014330816279 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<div id="uBreadcrumbs" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">'||unistr('\000a')||
'  #BODY#'||unistr('\000a')||
'  <div class="uBreadcrumbsBG">'||unistr('\000a')||
'    <div class="uLeft"></div>'||unistr('\000a')||
'    <div class="uRight"></div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</div>'
 ,p_page_plug_template_name => 'Breadcrumb Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 6
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Use this region template to contain breadcrumb menus.  Breadcrumb menus are implemented using breadcrumbs.  Breadcrumb menus are designed to displayed in #REGION_POSITION_01#'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/button_region_with_title
prompt  ......region template 57408117187816280
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408117187816280 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uButtonRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uButtonRegionContentContainer">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Button Region with Title'
 ,p_theme_id => 26
 ,p_theme_class_id => 4
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/button_region_without_title
prompt  ......region template 57408222722816280
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408222722816280 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uButtonRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uButtonRegionContentContainer">'||unistr('\000a')||
'    <div class="uButtonRegionContent">#BODY#</div>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Button Region without Title'
 ,p_theme_id => 26
 ,p_theme_class_id => 17
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/chart_list
prompt  ......region template 57408326731816280
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408326731816280 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Chart List'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 29
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/chart_region
prompt  ......region template 57408415262816281
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408415262816281 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Chart Region'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 30
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/content_frame_body_container
prompt  ......region template 57408512734816281
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408512734816281 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'#SUB_REGION_HEADERS#'||unistr('\000a')||
'#BODY#'||unistr('\000a')||
'<div class="uFrameContainer" class="#REGION_CSS_CLASSES#">'||unistr('\000a')||
'#SUB_REGIONS#'||unistr('\000a')||
'</div>'
 ,p_sub_plug_header_template => '<div class="uFrameRegionSelector clearfix">'||unistr('\000a')||
'  <ul>'||unistr('\000a')||
'    <li><a href="javascript:void(0);" class="showAllLink active"><span>Show All</span></a></li>'||unistr('\000a')||
'    #ENTRIES#'||unistr('\000a')||
'  </ul>'||unistr('\000a')||
'</div>'
 ,p_sub_plug_header_entry_templ => '<li><a href="javascript:void(0);" id="sub_#SUB_REGION_ID#"><span>#SUB_REGION_TITLE#</span></a></li>'
 ,p_page_plug_template_name => 'Content Frame Body Container'
 ,p_theme_id => 26
 ,p_theme_class_id => 7
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/div_region_with_id
prompt  ......region template 57408624862816282
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408624862816282 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> '||unistr('\000a')||
'#BODY#'||unistr('\000a')||
'#CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'</div>'
 ,p_page_plug_template_name => 'DIV Region with ID'
 ,p_theme_id => 26
 ,p_theme_class_id => 22
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/form_region
prompt  ......region template 57408721803816282
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408721803816282 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Form Region'
 ,p_plug_table_bgcolor => '#f7f7e7'
 ,p_theme_id => 26
 ,p_theme_class_id => 8
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/hide_and_show_region
prompt  ......region template 57408830723816282
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408830723816282 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uHideShowRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>'||unistr('\000a')||
'      <a href="javascript:void(0)" class="uRegionControl"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="Hide/Show"/></a>'||unistr('\000a')||
'      #TITLE#'||unistr('\000a')||
'    </h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE'||
'2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Hide and Show Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 1
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/hide_and_show_region_hidden_first_borderless
prompt  ......region template 57408900372816282
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57408900372816282 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uBorderlessRegion uHideShowRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>'||unistr('\000a')||
'      <a href="javascript:void(0)" class="uRegionControl uRegionCollapsed"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="Hide/Show"/></a>'||unistr('\000a')||
'      #TITLE#'||unistr('\000a')||
'    </h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##D'||
'ELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix" style="display: none;">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Hide and Show Region (Hidden First) - Borderless'
 ,p_theme_id => 26
 ,p_theme_class_id => 1
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/hide_and_show_region_borderless
prompt  ......region template 57409009156816283
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409009156816283 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uBorderlessRegion uHideShowRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>'||unistr('\000a')||
'      <a href="javascript:void(0)" class="uRegionControl"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="Hide/Show"/></a>'||unistr('\000a')||
'      #TITLE#'||unistr('\000a')||
'    </h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHAN'||
'GE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Hide and Show Region - Borderless'
 ,p_theme_id => 26
 ,p_theme_class_id => 1
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/interactive_report_region
prompt  ......region template 57409123273816283
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409123273816283 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uIRRegion" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">'||unistr('\000a')||
'  <h1 class="visuallyhidden">#TITLE#</h1>'||unistr('\000a')||
'  #BODY#'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Interactive Report Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 21
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/login_region
prompt  ......region template 57409225223816283
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409225223816283 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uRegionNoPadding uLoginRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uLoginHeading">'||unistr('\000a')||
'    <span class="bgArrow"></span>'||unistr('\000a')||
'    <div class="appIcon">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="appIcon #REGION_STATIC_ID#" alt=""/>'||unistr('\000a')||
'    </div> '||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uLoginBody clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'   '||
' <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Login Region'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 9
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/modal_region
prompt  ......region template 57409308581816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409308581816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uWhiteRegion uModalRegion uAlertRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'</s'||
'ection>'
 ,p_page_plug_template_name => 'Modal Region'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 9
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/navigation_region
prompt  ......region template 57409423021816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409423021816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Navigation Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 5
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/navigation_region_heading_inside
prompt  ......region template 57409505485816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409505485816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uWhiteRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Navigation Region - Heading Inside'
 ,p_theme_id => 26
 ,p_theme_class_id => 16
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/region_without_buttons_and_titles
prompt  ......region template 57409632568816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409632568816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uNoHeading #REGION_CSS_CLASSES# clearfix">'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Region without Buttons and Titles'
 ,p_theme_id => 26
 ,p_theme_class_id => 19
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/region_without_title
prompt  ......region template 57409703430816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409703430816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uNoHeading #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Region without Title'
 ,p_theme_id => 26
 ,p_theme_class_id => 11
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/report_filter_single_row
prompt  ......region template 57409804795816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409804795816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uButtonRegion uNoHeading uReportFilter #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    <div class="uReportFilterRow">'||unistr('\000a')||
'    <img src="#IM'||
'AGE_PREFIX#f_spacer.gif" class="uSearchIcon" alt="" />'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'    </div>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Report Filter - Single Row'
 ,p_theme_id => 26
 ,p_theme_class_id => 31
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/report_list
prompt  ......region template 57409924289816285
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57409924289816285 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Report List'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 29
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/reports_region
prompt  ......region template 57410003985816286
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410003985816286 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Reports Region'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 9
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/reports_region_100_width
prompt  ......region template 57410116809816286
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410116809816286 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uRegionNoPadding #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Reports Region - 100% Width'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 13
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/reports_region_heading_inside
prompt  ......region template 57410220497816286
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410220497816286 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uWhiteRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Reports Region - Heading Inside'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 10
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/scrollable_content_region
prompt  ......region template 57410320826816286
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410320826816286 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix"  style="height: 400px; overflow:scroll">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</'||
'section>'
 ,p_page_plug_template_name => 'Scrollable Content Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 21
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_reference_id => 1826089610826571714
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/search_filter_region
prompt  ......region template 57410403191816286
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410403191816286 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uFilterRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'    <span class="uButtonContainer">#CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Search Filter Region'
 ,p_plug_table_bgcolor => '#ffffff'
 ,p_theme_id => 26
 ,p_theme_class_id => 9
 ,p_plug_heading_bgcolor => '#ffffff'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => 'Red Theme'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/sidebar_region
prompt  ......region template 57410517706816286
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410517706816286 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Sidebar Region'
 ,p_plug_table_bgcolor => '#f7f7e7'
 ,p_theme_id => 26
 ,p_theme_class_id => 2
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
 ,p_template_comment => '<table border="0" cellpadding="0" cellspacing="0">'||unistr('\000a')||
'        <tr>'||unistr('\000a')||
'          <td rowspan="2" valign="top" width="4" bgcolor="#FF0000"><img src="#IMAGE_PREFIX#tl_img.gif" border="0" width="4" height="18" alt="" /></td>'||unistr('\000a')||
'          <td bgcolor="#000000" height="1"><img src="#IMAGE_PREFIX#stretch.gif" width="142" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'          <td rowspan="2" valign="top" width="4" bgcolor="#FF0000"><img src="#IMAGE_PREFIX#tr_img.gif" border="0" width="4" height="18" alt="" /></td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'        <tr>'||unistr('\000a')||
'          <td bgcolor="#FF0000" height="16">'||unistr('\000a')||
'            <table border="0" cellpadding="0" cellspacing="0" width="100%">'||unistr('\000a')||
'              <tr>'||unistr('\000a')||
'                <td align=middle valign="top">'||unistr('\000a')||
'                  <div align="center">'||unistr('\000a')||
'                     <font color="#ffffff" face="Arial, Helvetica, sans-serif" size="1">'||unistr('\000a')||
'                      <b>#TITLE# </b></font></div>'||unistr('\000a')||
'                </td>'||unistr('\000a')||
'              </tr>'||unistr('\000a')||
'            </table>'||unistr('\000a')||
'          </td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<table border="0" cellpadding="0" cellspacing="0">'||unistr('\000a')||
'   <tr>'||unistr('\000a')||
'   <td bgcolor="#000000" width="1" height="96"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'   <td valign="top" height="96"><img src="#IMAGE_PREFIX#stretch.gif" width="146" height="1" border="0" alt="" /><br />'||unistr('\000a')||
'            <table border="0" cellpadding="1" cellspacing="0" width="146" summary="">'||unistr('\000a')||
'              <tr>'||unistr('\000a')||
'                <td colspan="2">'||unistr('\000a')||
'                  <table border="0" cellpadding="2" cellspacing="0" width="124" summary="">'||unistr('\000a')||
'                    <tr>'||unistr('\000a')||
'                      <td>&nbsp;</td>'||unistr('\000a')||
'                      <td valign="top" width="106">'||unistr('\000a')||
'                        <P><FONT face="arial, helvetica" size="1">'||unistr('\000a')||
'                            #BODY#'||unistr('\000a')||
'                           </font>'||unistr('\000a')||
'                        </P>'||unistr('\000a')||
'                      </td>'||unistr('\000a')||
'                    </tr>'||unistr('\000a')||
'                  </table>'||unistr('\000a')||
'            </table>'||unistr('\000a')||
'          </td>'||unistr('\000a')||
'          <td bgcolor="#000000" width="1" height="96"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'          <td bgcolor="#9a9c9a" width="1" height="96"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'          <td bgcolor="#b3b4b3" width="1" height="96"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'      </table>'||unistr('\000a')||
'      <table border="0" cellpadding="0" cellspacing="0">'||unistr('\000a')||
'        <tr>'||unistr('\000a')||
'          <td rowspan="4" valign="top" width="4"><img src="#IMAGE_PREFIX#bl_img.gif" border="0" width="4" height="6" alt="" /></td>'||unistr('\000a')||
'          <td bgcolor="#ffffff" height="2"><img src="#IMAGE_PREFIX#stretch.gif" width="142" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'          <td rowspan="4" valign="top" width="4"><img src="#IMAGE_PREFIX#br_img.gif" border="0" width="4" height="6" alt="" /></td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'        <tr>'||unistr('\000a')||
'          <td bgcolor="#000000" width="1"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'        <tr>'||unistr('\000a')||
'          <td bgcolor="#9a9c9a" width="1"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'        <tr>'||unistr('\000a')||
'          <td bgcolor="#b3b4b3" width="1" height="2"><img src="#IMAGE_PREFIX#stretch.gif" width="1" height="1" border="0" alt="" /></td>'||unistr('\000a')||
'        </tr>'||unistr('\000a')||
'</table>'||unistr('\000a')||
''
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/sidebar_region_heading_inside
prompt  ......region template 57410621685816291
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410621685816291 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion uWhiteRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Sidebar Region - Heading Inside'
 ,p_plug_table_bgcolor => '#f7f7e7'
 ,p_theme_id => 26
 ,p_theme_class_id => 3
 ,p_plug_heading_bgcolor => '#f7f7e7'
 ,p_plug_font_size => '-1'
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/wizard_buttons
prompt  ......region template 57410731399816291
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410731399816291 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<div class="cWizardButtons cWizardButtonsLeft">'||unistr('\000a')||
'#PREVIOUS##CLOSE#'||unistr('\000a')||
'</div>'||unistr('\000a')||
'<div class="cWizardButtons cWizardButtonsRight">'||unistr('\000a')||
'#NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'</div>'
 ,p_page_plug_template_name => 'Wizard Buttons'
 ,p_theme_id => 26
 ,p_theme_class_id => 21
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/wizard_region
prompt  ......region template 57410801908816291
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410801908816291 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Wizard Region'
 ,p_theme_id => 26
 ,p_theme_class_id => 12
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/wizard_region_with_icon
prompt  ......region template 57410904731816291
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57410904731816291 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<section class="uRegion #REGION_CSS_CLASSES# clearfix" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#>'||unistr('\000a')||
'  <div class="uRegionHeading">'||unistr('\000a')||
'    <h1>#TITLE#</h1>'||unistr('\000a')||
'    <span class="uButtonContainer">'||unistr('\000a')||
'      #CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#'||unistr('\000a')||
'    </span>'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'  <div class="uRegionContent clearfix">'||unistr('\000a')||
'    #BODY#'||unistr('\000a')||
'  </div>'||unistr('\000a')||
'</section>'
 ,p_page_plug_template_name => 'Wizard Region with Icon'
 ,p_theme_id => 26
 ,p_theme_class_id => 20
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

--application/shared_components/user_interface/templates/region/jquery_modal_region_template
prompt  ......region template 57411024485816291
 
begin
 
wwv_flow_api.create_plug_template (
  p_id => 57411024485816291 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_layout => 'TABLE'
 ,p_template => 
'<div id="#REGION_STATIC_ID#" style="display:none" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#">'||unistr('\000a')||
'#BODY#'||unistr('\000a')||
'</div>'
 ,p_page_plug_template_name => 'jQuery Modal Region Template'
 ,p_theme_id => 26
 ,p_theme_class_id => 22
 ,p_default_label_alignment => 'RIGHT'
 ,p_default_field_alignment => 'LEFT'
 ,p_translate_this_template => 'N'
  );
null;
 
end;
/

prompt  ...List Templates
--
--application/shared_components/user_interface/templates/list/button_list
prompt  ......list template 57412225909816321
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<a href="#LINK#" class="uButtonSmall uHotButton" #A01# role="button"><span>#TEXT#</span></a> ';

t2:=t2||'<a href="#LINK#" class="uButtonSmall" #A01# role="button"><span>#TEXT#</span></a> ';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57412225909816321 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Button List',
  p_theme_id  => 26,
  p_theme_class_id => 6,
  p_list_template_before_rows=>'<div class="uButtonList">',
  p_list_template_after_rows=>'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/dhtml_tree
prompt  ......list template 57412323553816332
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3:=t3||'<li><a href="#LINK#">#TEXT#</a></li>';

t4:=t4||'<li><a href="#LINK#">#TEXT#</a></li>';

t5:=t5||'<li><a href="#LINK#">#TEXT#</a></li>';

t6:=t6||'<li><a href="#LINK#">#TEXT#</a></li>';

t7:=t7||'<li><a href="#LINK#">#TEXT#</a></li>';

t8:=t8||'<li><a href="#LINK#">#TEXT#</a></li>';

wwv_flow_api.create_list_template (
  p_id=>57412323553816332 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'DHTML Tree',
  p_theme_id  => 26,
  p_theme_class_id => 23,
  p_list_template_before_rows=>'<ul class="dhtmlTree">',
  p_list_template_after_rows=>'</ul><br style="clear:both;"/><br style="clear:both;"/>',
  p_before_sub_list=>'<ul id="#PARENT_LIST_ITEM_ID#" htmldb:listlevel="#LEVEL#">',
  p_after_sub_list=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/featured_list_with_subtext
prompt  ......list template 57412409159816333
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li>'||unistr('\000a')||
'  <a href="#LINK#">'||unistr('\000a')||
'    <h3>#TEXT#</h3>'||unistr('\000a')||
'    <p>#A01#</p>'||unistr('\000a')||
'  </a>'||unistr('\000a')||
'</li>';

t2:=t2||'<li>'||unistr('\000a')||
'  <a href="#LINK#">'||unistr('\000a')||
'    <h3>#TEXT#</h3>'||unistr('\000a')||
'    <p>#A01#</p>'||unistr('\000a')||
'  </a>'||unistr('\000a')||
'</li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57412409159816333 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Featured List with Subtext',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_list_template_before_rows=>'<ul class="featuredLinksList">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/hierarchical_expanding
prompt  ......list template 57412505093816333
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li><img src="#IMAGE_PREFIX#themes/theme_13/node.gif" align="middle" alt="" /><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><img src="#IMAGE_PREFIX#themes/theme_13/node.gif" align="middle"  alt="" /><a href="#LINK#">#TEXT#</a></li>';

t3:=t3||'<li><img src="#IMAGE_PREFIX#themes/theme_13/node.gif" align="middle"  alt="" /><a href="#LINK#">#TEXT#</a></li>';

t4:=t4||'<li><img src="#IMAGE_PREFIX#themes/theme_13/node.gif"  align="middle" alt="" /><a href="#LINK#">#TEXT#</a></li>';

t5:=t5||'<li><img src="#IMAGE_PREFIX#themes/theme_13/plus.gif" align="middle"  onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" class="pseudoButtonInactive" alt="" /><a href="#LINK#">#TEXT#</a></li>';

t6:=t6||'<li><img src="#IMAGE_PREFIX#themes/theme_13/plus.gif" align="middle"  onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" class="pseudoButtonInactive" alt="" /><a href="#LINK#">#TEXT#</a></li>';

t7:=t7||'<li><img src="#IMAGE_PREFIX#themes/theme_13/plus.gif" onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" align="middle" class="pseudoButtonInactive" alt="" /><a href="#LINK#">#TEXT#</a></li>';

t8:=t8||'<li><img src="#IMAGE_PREFIX#themes/theme_13/plus.gif" onclick="htmldb_ToggleWithImage(this,''#LIST_ITEM_ID#'')" align="middle" class="pseudoButtonInactive" alt="" /><a href="#LINK#">#TEXT#</a></li>';

wwv_flow_api.create_list_template (
  p_id=>57412505093816333 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Hierarchical Expanding',
  p_theme_id  => 26,
  p_theme_class_id => 22,
  p_list_template_before_rows=>'<ul class="dhtmlTree">',
  p_list_template_after_rows=>'</ul><br style="clear:both;"/><br style="clear:both;"/>',
  p_before_sub_list=>'<ul id="#PARENT_LIST_ITEM_ID#" htmldb:listlevel="#LEVEL#" style="display:none;" class="dhtmlTree">',
  p_after_sub_list=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/horizontal_images_with_label_list
prompt  ......list template 57412626495816333
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'    <li class="active">'||unistr('\000a')||
'      <a href="#LINK#">'||unistr('\000a')||
'        <img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR# alt="" />'||unistr('\000a')||
'        <span>#TEXT#</span>'||unistr('\000a')||
'      </a>'||unistr('\000a')||
'    </li>';

t2:=t2||'    <li>'||unistr('\000a')||
'      <a href="#LINK#">'||unistr('\000a')||
'        <img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR# alt="" />'||unistr('\000a')||
'        <span>#TEXT#</span>'||unistr('\000a')||
'      </a>'||unistr('\000a')||
'    </li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57412626495816333 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Horizontal Images with Label List',
  p_theme_id  => 26,
  p_theme_class_id => 4,
  p_list_template_before_rows=>'<div class="uImagesList uHorizontalImagesList clearfix">'||unistr('\000a')||
'  <ul>',
  p_list_template_after_rows=>'  </ul>'||unistr('\000a')||
'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/horizontal_links_list
prompt  ......list template 57412713816816333
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li> ';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li> ';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57412713816816333 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Horizontal Links List',
  p_theme_id  => 26,
  p_theme_class_id => 3,
  p_list_template_before_rows=>'<ul class="uHorizontalLinksList">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/horizontal_wizard_progress_list
prompt  ......list template 57412823241816334
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'    <li class="#LIST_STATUS#">'||unistr('\000a')||
'      <span>#TEXT#</span>'||unistr('\000a')||
'    </li>';

t2:=t2||'    <li class="#LIST_STATUS#">'||unistr('\000a')||
'      <span>#TEXT#</span>'||unistr('\000a')||
'    </li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57412823241816334 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Horizontal Wizard Progress List',
  p_theme_id  => 26,
  p_theme_class_id => 17,
  p_list_template_before_rows=>'<div class="uHorizontalProgressList">'||unistr('\000a')||
'  <ul>',
  p_list_template_after_rows=>'  </ul>'||unistr('\000a')||
'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/page_level_tabs_list
prompt  ......list template 57412924019816334
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li><a href="#LINK#" class="active">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57412924019816334 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Page Level Tabs List',
  p_theme_id  => 26,
  p_theme_class_id => 7,
  p_list_template_before_rows=>'<nav class="uPageTabs">'||unistr('\000a')||
'<ul>',
  p_list_template_after_rows=>'</ul>'||unistr('\000a')||
'</nav>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/pull_down_menu
prompt  ......list template 57413030621816334
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="dhtmlMenuItem"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li class="dhtmlMenuItem"><a href="#LINK#">#TEXT#</a></li>';

t3:=t3||'<li class="dhtmlMenuSep2"><img src="#IMAGE_PREFIX#f_spacer.gif"  width="1" height="1" alt="" class="dhtmlMenuSep2" /></li>';

t4:=t4||'<li><a href="#LINK#" class="dhtmlSubMenuN" onmouseover="dhtml_CloseAllSubMenusL(this)">#TEXT#</a></li>';

t5:=t5||'<li class="dhtmlMenuItem1"><a href="#LINK#">#TEXT#</a><img src="#IMAGE_PREFIX#arrow_down_gray_dark.gif" alt="Expand" onclick="app_AppMenuMultiOpenBottom2(this,''#LIST_ITEM_ID#'',false)" />'||unistr('\000a')||
'</li>';

t6:=t6||'<li class="dhtmlMenuItem1"><a href="#LINK#">#TEXT#</a><img src="#IMAGE_PREFIX#arrow_down_gray_dark.gif" alt="Expand" onclick="app_AppMenuMultiOpenBottom2(this,''#LIST_ITEM_ID#'',false)" /></li>';

t7:=t7||'<li class="dhtmlSubMenuS"><a href="#LINK#" class="dhtmlSubMenuS" onmouseover="dhtml_MenuOpen(this,''#LIST_ITEM_ID#'',true,''Left'')"><span style="float:left;">#TEXT#</span><img class="t13MIMG" src="#IMAGE_PREFIX#menu_open_right2.gif" alt="" /></a></li>';

t8:=t8||'<li class="dhtmlSubMenuS"><a href="#LINK#" class="dhtmlSubMenuS" onmouseover="dhtml_MenuOpen(this,''#LIST_ITEM_ID#'',true,''Left'')"><span style="float:left;">#TEXT#</span><img class="t13MIMG" src="#IMAGE_PREFIX#menu_open_right2.gif" alt="" / ></a></li>';

wwv_flow_api.create_list_template (
  p_id=>57413030621816334 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Pull Down Menu',
  p_theme_id  => 26,
  p_theme_class_id => 20,
  p_list_template_before_rows=>'<ul class="dhtmlMenuLG2">',
  p_list_template_after_rows=>'</ul><br style="clear:both;"/><br style="clear:both;"/>',
  p_before_sub_list=>'<ul id="#PARENT_LIST_ITEM_ID#" htmldb:listlevel="#LEVEL#" class="dhtmlSubMenu2" style="display:none;">',
  p_after_sub_list=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/pull_down_menu_with_image
prompt  ......list template 57413130675816334
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<div class="dhtmlMenuItem"><a href="#LINK#" id="#LIST_ITEM_ID#"><img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR#  /></a><img src="#IMAGE_PREFIX#menu/drop_down_nochild.png" width="20" height="128" alt="" /><a href="#LINK#" class="dhtmlBottom">#TEXT#</a></div>';

t2:=t2||'<div class="dhtmlMenuItem"><a href="#LINK#" id="#LIST_ITEM_ID#"><img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR#  "/></a><img src="#IMAGE_PREFIX#menu/drop_down_nochild.png" width="20" height="128" alt="" /><a href="#LINK#" class="dhtmlBottom">#TEXT#</a></div>';

t3:=t3||'<li class="dhtmlMenuSep"><img src="#IMAGE_PREFIX#themes/theme_13/1px_trans.gif"  width="1" height="1" alt=""  class="dhtmlMenuSep" /></li>';

t4:=t4||'<li><a href="#LINK#" class="dhtmlSubMenuN" onmouseover="dhtml_CloseAllSubMenusL(this)">#TEXT#</a></li>';

t5:=t5||'<div class="dhtmlMenuItem"><a href="#LINK#" id="#LIST_ITEM_ID#"><img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR#  /></a><img src="#IMAGE_PREFIX#menu/drop_down.png" width="20" height="128" alt="" class="dhtmlMenu" onclick="app_AppMenuMultiOpenBottom3(this,''S#LIST_ITEM_ID#'',''#LIST_ITEM_ID#'',false)" />'||unistr('\000a')||
'<a href="#LINK#" class="dhtmlBottom">#TEXT#</a>'||unistr('\000a')||
'</div>';

t6:=t6||'<div class="dhtmlMenuItem"><a href="#LINK#" id="#LIST_ITEM_ID#"><img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR#  /></a><img src="#IMAGE_PREFIX#menu/drop_down.png" width="20" height="128" alt=""  class="dhtmlMenu" onclick="app_AppMenuMultiOpenBottom3(this,''S#LIST_ITEM_ID#'',''#LIST_ITEM_ID#'',false)" />'||unistr('\000a')||
'<a href="#LINK#" class="dhtmlBottom">#TEXT#</a>'||unistr('\000a')||
'</div>';

t7:=t7||'<li class="dhtmlSubMenuS"><a href="#LINK#" class="dhtmlSubMenuS" onmouseover="dhtml_MenuOpen(this,''S#LIST_ITEM_ID#'',true,''Left'')"><span style="float:left;">#TEXT#</span><img class="t13MIMG" src="#IMAGE_PREFIX#menu_open_right2.gif" /></a></li>';

t8:=t8||'<li class="dhtmlSubMenuS"><a href="#LINK#" class="dhtmlSubMenuS" onmouseover="dhtml_MenuOpen(this,''S#LIST_ITEM_ID#'',true,''Left'')"><span style="float:left;">#TEXT#</span><img class="t13MIMG" src="#IMAGE_PREFIX#menu_open_right2.gif" /></a></li>';

wwv_flow_api.create_list_template (
  p_id=>57413130675816334 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Pull Down Menu with Image',
  p_theme_id  => 26,
  p_theme_class_id => 21,
  p_list_template_before_rows=>'<div class="dhtmlMenuLG">',
  p_list_template_after_rows=>'</div><br style="clear:both;"/><br style="clear:both;"/>',
  p_before_sub_list=>'<ul id="S#PARENT_LIST_ITEM_ID#" htmldb:listlevel="#LEVEL#" class="dhtmlSubMenu2" style="display:none;"><li class="dhtmlSubMenuP" onmouseover="dhtml_CloseAllSubMenusL(this)">#PARENT_TEXT#</li>',
  p_after_sub_list=>'</ul>',
  p_sub_list_item_current=> t3,
  p_sub_list_item_noncurrent=> t4,
  p_item_templ_curr_w_child=> t5,
  p_item_templ_noncurr_w_child=> t6,
  p_sub_templ_curr_w_child=> t7,
  p_sub_templ_noncurr_w_child=> t8,
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/search_filter_tabs
prompt  ......list template 57413209547816338
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413209547816338 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Search Filter Tabs',
  p_theme_id  => 26,
  p_theme_class_id => 19,
  p_list_template_before_rows=>'<ul class="ebaViewTabs">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/tabbed_navigation_list
prompt  ......list template 57413303603816338
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413303603816338 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Tabbed Navigation List',
  p_theme_id  => 26,
  p_theme_class_id => 7,
  p_list_template_before_rows=>'<div class="uHorizontalTabs">'||unistr('\000a')||
'<ul>',
  p_list_template_after_rows=>'</ul>'||unistr('\000a')||
'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_images_list
prompt  ......list template 57413402684816338
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'    <li class="active">'||unistr('\000a')||
'      <a href="#LINK#">'||unistr('\000a')||
'        <img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR# alt="" />'||unistr('\000a')||
'        <span>#TEXT#</span>'||unistr('\000a')||
'      </a>'||unistr('\000a')||
'    </li>';

t2:=t2||'    <li>'||unistr('\000a')||
'      <a href="#LINK#">'||unistr('\000a')||
'        <img src="#IMAGE_PREFIX##IMAGE#" #IMAGE_ATTR# alt="" />'||unistr('\000a')||
'        <span>#TEXT#</span>'||unistr('\000a')||
'      </a>'||unistr('\000a')||
'    </li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413402684816338 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Images List',
  p_theme_id  => 26,
  p_theme_class_id => 5,
  p_list_template_before_rows=>'<div class="uImagesList uVerticalImagesList clearfix">'||unistr('\000a')||
'  <ul>',
  p_list_template_after_rows=>'  </ul>'||unistr('\000a')||
'</div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_list_with_subtext_and_icon
prompt  ......list template 57413506329816339
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'  <li>'||unistr('\000a')||
'    <a href="#LINK#">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="#A02#" alt="#LIST_LABEL#"/>'||unistr('\000a')||
'      <h3>#TEXT#</h3>'||unistr('\000a')||
'      <h4>#A01#</h4>'||unistr('\000a')||
'    </a>'||unistr('\000a')||
'  </li>';

t2:=t2||'  <li>'||unistr('\000a')||
'    <a href="#LINK#">'||unistr('\000a')||
'      <img src="#IMAGE_PREFIX#f_spacer.gif" class="#A02#" alt="#LIST_LABEL#"/>'||unistr('\000a')||
'      <h3>#TEXT#</h3>'||unistr('\000a')||
'      <h4>#A01#</h4>'||unistr('\000a')||
'    </a>'||unistr('\000a')||
'  </li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413506329816339 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical List with Subtext and Icon',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_list_template_before_rows=>'<ul class="largeLinkList">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_ordered_list
prompt  ......list template 57413615596816339
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413615596816339 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Ordered List',
  p_theme_id  => 26,
  p_theme_class_id => 2,
  p_list_template_before_rows=>'<ol class="uNumberedList">',
  p_list_template_after_rows=>'</ol>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_sidebar_list
prompt  ......list template 57413715877816339
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413715877816339 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Sidebar List',
  p_theme_id  => 26,
  p_theme_class_id => 19,
  p_list_template_before_rows=>'<ul class="uVerticalSidebarList">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_unordered_list_with_bullets
prompt  ......list template 57413821451816340
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413821451816340 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Unordered List with Bullets',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_list_template_before_rows=>'<ul class="uVerticalList">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/vertical_unordered_list_without_bullets
prompt  ......list template 57413921227816340
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="active"><a href="#LINK#">#TEXT#</a></li>';

t2:=t2||'<li><a href="#LINK#">#TEXT#</a></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57413921227816340 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Vertical Unordered List without Bullets',
  p_theme_id  => 26,
  p_theme_class_id => 18,
  p_list_template_before_rows=>'<ul class="uVerticalList noBullets">',
  p_list_template_after_rows=>'</ul>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/list/wizard_progress_list_vertical
prompt  ......list template 57414008911816341
 
begin
 
declare
  t varchar2(32767) := null;
  t2 varchar2(32767) := null;
  t3 varchar2(32767) := null;
  t4 varchar2(32767) := null;
  t5 varchar2(32767) := null;
  t6 varchar2(32767) := null;
  t7 varchar2(32767) := null;
  t8 varchar2(32767) := null;
  l_clob clob;
  l_clob2 clob;
  l_clob3 clob;
  l_clob4 clob;
  l_clob5 clob;
  l_clob6 clob;
  l_clob7 clob;
  l_clob8 clob;
  l_length number := 1;
begin
t:=t||'<li class="#LIST_STATUS#"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /><span>#TEXT#</span></li>';

t2:=t2||'<li class="#LIST_STATUS#"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /><span>#TEXT#</span></li>';

t3 := null;
t4 := null;
t5 := null;
t6 := null;
t7 := null;
t8 := null;
wwv_flow_api.create_list_template (
  p_id=>57414008911816341 + wwv_flow_api.g_id_offset,
  p_flow_id=>wwv_flow.g_flow_id,
  p_list_template_current=>t,
  p_list_template_noncurrent=> t2,
  p_list_template_name=>'Wizard Progress List - Vertical',
  p_theme_id  => 26,
  p_theme_class_id => 17,
  p_list_template_before_rows=>'<div class="uVerticalProgressList" id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES#><ul>',
  p_list_template_after_rows=>'</ul></div>',
  p_translate_this_template => 'N',
  p_list_template_comment=>'');
end;
null;
 
end;
/

prompt  ...report templates
--
--application/shared_components/user_interface/templates/report/borderless_report
prompt  ......report template 57411111865816296
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411111865816296 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Borderless Report',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<table class="uReportContainer uBorderlessReportContainer" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" summary="">'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#TOP_PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportBody">'||unistr('\000a')||
'<tr><td>'||unistr('\000a')||
'<table summary="#REGION_TITLE#" class="uReport uReportBorderless">',
  p_row_template_after_rows =>'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<div class="uReportDownloadLinks">#EXTERNAL_LINK##CSV_LINK#</div>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_before_column_heading=>'<thead>',
  p_column_heading_template=>'<th #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>',
  p_after_column_heading=>'</thead>'||unistr('\000a')||
'<tbody>',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_page_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT_SET# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_set_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#F0F0F0',
  p_row_style_checked=>'#E8E8E8',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 57411111865816296 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/comment_bubbles
prompt  ......report template 57411220275816309
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<li class="#1#">'||unistr('\000a')||
'<div>'||unistr('\000a')||
'	<em>#2#</em>'||unistr('\000a')||
'	#3##4##5##6##7#'||unistr('\000a')||
'</div>'||unistr('\000a')||
'<span>'||unistr('\000a')||
'	#8# (#9#) #10#'||unistr('\000a')||
'</span>'||unistr('\000a')||
'</li>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411220275816309 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Comment Bubbles',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<ul class="commentBubbles">',
  p_row_template_after_rows =>'</ul>'||unistr('\000a')||
'<table class="uPaginationTable">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</table>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'NAMED_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="sPaginationNext">#PAGINATION_NEXT#</a>',
  p_previous_page_template=>'<a href="#LINK#" class="sPaginationPrev">#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="sPaginationNext">#PAGINATION_NEXT_SET#</a>',
  p_previous_set_template=>'<a href="#LINK#" class="sPaginationPrev">#PAGINATION_PREVIOUS_SET#</a>',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/fixed_headers
prompt  ......report template 57411328050816309
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td #ALIGNMENT# headers="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_VALUE#</td>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411328050816309 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Fixed Headers',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<table class="uReportContainer" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" summary="">'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#TOP_PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportBody">'||unistr('\000a')||
'<tr><td>'||unistr('\000a')||
'<div class="uFixedHeadersContainer">'||unistr('\000a')||
'<table summary="#REGION_TITLE#" class="uReport uReportFixedHeaders">',
  p_row_template_after_rows =>'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'</div>'||unistr('\000a')||
'</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<div class="uReportDownloadLinks">#EXTERNAL_LINK##CSV_LINK#</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_before_column_heading=>'<thead>'||unistr('\000a')||
'',
  p_column_heading_template=>'<th #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>',
  p_after_column_heading=>'</thead>'||unistr('\000a')||
'<tbody>'||unistr('\000a')||
'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_page_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT_SET# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_set_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#F0F0F0',
  p_row_style_checked=>'#E8E8E8',
  p_theme_id  => 26,
  p_theme_class_id => 7,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 57411328050816309 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr>',
  p_row_template_after_last =>'</tr>'||unistr('\000a')||
'');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/horizontal_border
prompt  ......report template 57411420663816310
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411420663816310 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Horizontal Border',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<table class="uReportContainer" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" summary="">'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#TOP_PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportBody">'||unistr('\000a')||
'<tr><td>'||unistr('\000a')||
'<table summary="#REGION_TITLE#" class="uReport uReportHorizontal">',
  p_row_template_after_rows =>'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<div class="uReportDownloadLinks">#EXTERNAL_LINK##CSV_LINK#</div>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_before_column_heading=>'<thead>',
  p_column_heading_template=>'<th #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>',
  p_after_column_heading=>'</thead>'||unistr('\000a')||
'<tbody>',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_page_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT_SET# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_set_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#F0F0F0',
  p_row_style_checked=>'#E8E8E8',
  p_theme_id  => 26,
  p_theme_class_id => 2,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 57411420663816310 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/one_column_unordered_list
prompt  ......report template 57411508723816312
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<li>#COLUMN_VALUE#</li>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411508723816312 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'One Column Unordered List',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<table class="uReportList" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" summary="">'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#TOP_PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportBody">'||unistr('\000a')||
'<tr><td>'||unistr('\000a')||
'<ul class="uReportList">',
  p_row_template_after_rows =>'</ul>'||unistr('\000a')||
'</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<div class="uReportDownloadLinks">#EXTERNAL_LINK##CSV_LINK#</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'NOT_CONDITIONAL',
  p_row_template_display_cond2=>'NOT_CONDITIONAL',
  p_row_template_display_cond3=>'NOT_CONDITIONAL',
  p_row_template_display_cond4=>'NOT_CONDITIONAL',
  p_next_page_template=>'<a href="#LINK#" class="sPaginationNext">#PAGINATION_NEXT#</a>',
  p_previous_page_template=>'<a href="#LINK#" class="sPaginationPrev">#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="sPaginationNext">#PAGINATION_NEXT_SET#</a>',
  p_previous_set_template=>'<a href="#LINK#" class="sPaginationPrev">#PAGINATION_PREVIOUS_SET#</a>',
  p_theme_id  => 26,
  p_theme_class_id => 3,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 57411508723816312 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'OMIT',
  p_row_template_after_last =>'OMIT');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/search_results_report_select_link_text_link_target_detail1_detail2_last_modified
prompt  ......report template 57411629500816312
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<li>'||unistr('\000a')||
'<span class="title"><a href="#2#">#1#</a></span>'||unistr('\000a')||
'<span class="description"><span class="last_modified">#5#</span>#3#</span>'||unistr('\000a')||
'<span class="type">#4#</span>'||unistr('\000a')||
'</li>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411629500816312 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Search Results Report (SELECT link_text, link_target, detail1, detail2, last_modified)',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<ul class="sSearchResultsReport">',
  p_row_template_after_rows =>'</ul>'||unistr('\000a')||
'<table class="uPaginationTable">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</table>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'NAMED_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="sPaginationNext">#PAGINATION_NEXT#</a>',
  p_previous_page_template=>'<a href="#LINK#" class="sPaginationPrev">#PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="sPaginationNext">#PAGINATION_NEXT_SET#</a>',
  p_previous_set_template=>'<a href="#LINK#" class="sPaginationPrev">#PAGINATION_PREVIOUS_SET#</a>',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/standard
prompt  ......report template 57411729106816313
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411729106816313 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Standard',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<table class="uReportContainer" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" summary="">'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#TOP_PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportBody">'||unistr('\000a')||
'<tr><td>'||unistr('\000a')||
'<table summary="#REGION_TITLE#" class="uReport uReportStandard">',
  p_row_template_after_rows =>'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<div class="uReportDownloadLinks">#EXTERNAL_LINK##CSV_LINK#</div>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_before_column_heading=>'<thead>',
  p_column_heading_template=>'<th #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>',
  p_after_column_heading=>'</thead>'||unistr('\000a')||
'<tbody>',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_page_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT_SET# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_set_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS_SET#</a>',
  p_row_style_mouse_over=>'#F0F0F0',
  p_row_style_checked=>'#E8E8E8',
  p_theme_id  => 26,
  p_theme_class_id => 4,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 57411729106816313 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr>',
  p_row_template_after_last =>'</tr>');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/standard_alternative
prompt  ......report template 57411829300816313
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<td #ALIGNMENT# headers="#COLUMN_HEADER_NAME#">#COLUMN_VALUE#</td>';

c2 := null;
c3:=c3||'<td #ALIGNMENT# headers="#COLUMN_HEADER_NAME#" class="uOddRow">#COLUMN_VALUE#</td>';

c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411829300816313 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Standard - Alternative',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<table class="uReportContainer" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" summary="">'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#TOP_PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportBody">'||unistr('\000a')||
'<tr><td>'||unistr('\000a')||
'<table summary="#REGION_TITLE#" class="uReport uReportAlternative">',
  p_row_template_after_rows =>'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'<tbody class="uReportPagination">'||unistr('\000a')||
'#PAGINATION#'||unistr('\000a')||
'</tbody>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'<div class="uReportDownloadLinks">#EXTERNAL_LINK##CSV_LINK#</div>',
  p_row_template_table_attr =>'OMIT',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_before_column_heading=>'<thead>',
  p_column_heading_template=>'<th #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>',
  p_after_column_heading=>'</thead>'||unistr('\000a')||
'<tbody>',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'ODD_ROW_NUMBERS',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_next_page_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_page_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS#</a>',
  p_next_set_template=>'<a href="#LINK#" class="uPaginationNext">#PAGINATION_NEXT_SET# <img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /></a>',
  p_previous_set_template=>'<a href="#LINK#" class="uPaginationPrev"><img src="#IMAGE_PREFIX#f_spacer.gif" alt="" /> #PAGINATION_PREVIOUS_SET#</a>',
  p_theme_id  => 26,
  p_theme_class_id => 5,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

 
begin
 
begin
wwv_flow_api.create_row_template_patch (
  p_id => 57411829300816313 + wwv_flow_api.g_id_offset,
  p_row_template_before_first =>'<tr>',
  p_row_template_after_last =>'</tr>'||unistr('\000a')||
'');
exception when others then null;
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/two_column_portlet
prompt  ......report template 57411916403816313
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<li>'||unistr('\000a')||
'  <span class="uValueHeading">'||unistr('\000a')||
'    #1#'||unistr('\000a')||
'  </span>'||unistr('\000a')||
'  <span class="uValue">'||unistr('\000a')||
'    #2#'||unistr('\000a')||
'  </span>'||unistr('\000a')||
'</li>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57411916403816313 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Two Column Portlet',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<ul class="uValuePairs" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#">',
  p_row_template_after_rows =>'</ul>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'NAMED_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_theme_id  => 26,
  p_theme_class_id => 7,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/value_attribute_pairs
prompt  ......report template 57412000752816313
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<li>'||unistr('\000a')||
'  <span class="uValueHeading">'||unistr('\000a')||
'    #COLUMN_HEADER#'||unistr('\000a')||
'  </span>'||unistr('\000a')||
'  <span class="uValue">'||unistr('\000a')||
'    #COLUMN_VALUE#'||unistr('\000a')||
'  </span>'||unistr('\000a')||
'</li>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57412000752816313 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Value Attribute Pairs',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<ul class="uValuePairs" #REPORT_ATTRIBUTES#>',
  p_row_template_after_rows =>'</ul>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_theme_id  => 26,
  p_theme_class_id => 6,
  p_translate_this_template => 'N',
  p_row_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/report/value_attribute_pairs_left_aligned
prompt  ......report template 57412125495816314
 
begin
 
declare
  c1 varchar2(32767) := null;
  c2 varchar2(32767) := null;
  c3 varchar2(32767) := null;
  c4 varchar2(32767) := null;
begin
c1:=c1||'<li>'||unistr('\000a')||
'  <label>'||unistr('\000a')||
'    #COLUMN_HEADER#'||unistr('\000a')||
'  </label>'||unistr('\000a')||
'  <span>'||unistr('\000a')||
'    #COLUMN_VALUE#'||unistr('\000a')||
'  </span>'||unistr('\000a')||
'</li>';

c2 := null;
c3 := null;
c4 := null;
wwv_flow_api.create_row_template (
  p_id=> 57412125495816314 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_row_template_name=> 'Value Attribute Pairs - Left Aligned',
  p_row_template1=> c1,
  p_row_template_condition1=> '',
  p_row_template2=> c2,
  p_row_template_condition2=> '',
  p_row_template3=> c3,
  p_row_template_condition3=> '',
  p_row_template4=> c4,
  p_row_template_condition4=> '',
  p_row_template_before_rows=>'<ul class="vapList tableBased" #REPORT_ATTRIBUTES# id="report_#REPORT_STATIC_ID#">',
  p_row_template_after_rows =>'</ul>',
  p_row_template_table_attr =>'',
  p_row_template_type =>'GENERIC_COLUMNS',
  p_column_heading_template=>'',
  p_row_template_display_cond1=>'0',
  p_row_template_display_cond2=>'0',
  p_row_template_display_cond3=>'0',
  p_row_template_display_cond4=>'0',
  p_theme_id  => 26,
  p_theme_class_id => 6,
  p_translate_this_template => 'N',
  p_row_template_comment=> 'shrahman 03/12/2012 Making table based ');
end;
null;
 
end;
/

prompt  ...label templates
--
--application/shared_components/user_interface/templates/label/hidden_label_read_by_screen_reader
prompt  ......label template 57414128445816347
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 57414128445816347 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Hidden label, read by screen reader',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" tabindex="999" class="hideMeButHearMe">',
  p_template_body2=>'</label>',
  p_before_item=>'',
  p_after_item=>'',
  p_on_error_before_label=>'',
  p_on_error_after_label=>'<br/>#ERROR_MESSAGE#',
  p_theme_id  => 26,
  p_theme_class_id => 13,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/no_label
prompt  ......label template 57414223379816365
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 57414223379816365 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'No Label',
  p_template_body1=>'<span class="uNoLabel">',
  p_template_body2=>'</span>',
  p_before_item=>'',
  p_after_item=>'',
  p_on_error_before_label=>'',
  p_on_error_after_label=>'<span class="uLabelError">#ERROR_MESSAGE#</span>',
  p_theme_id  => 26,
  p_theme_class_id => 13,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/optional
prompt  ......label template 57414306093816365
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 57414306093816365 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Optional',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" class="uOptional">',
  p_template_body2=>'</label>',
  p_before_item=>'',
  p_after_item=>'',
  p_on_error_before_label=>'',
  p_on_error_after_label=>'<span class="uLabelError">#ERROR_MESSAGE#</span>',
  p_theme_id  => 26,
  p_theme_class_id => 3,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/optional_with_help
prompt  ......label template 57414419994816365
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 57414419994816365 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Optional with help',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" class="uOptional"><a class="uHelpLink" href="javascript:popupFieldHelp(''#CURRENT_ITEM_ID#'',''&SESSION.'')" tabindex="999">',
  p_template_body2=>'</a></label>',
  p_before_item=>'',
  p_after_item=>'',
  p_on_error_before_label=>'',
  p_on_error_after_label=>'<span class="uLabelError">#ERROR_MESSAGE#</span>',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/required
prompt  ......label template 57414529330816366
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 57414529330816366 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Required',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" class="uRequired">',
  p_template_body2=>' <img src="#IMAGE_PREFIX#f_spacer.gif" alt="#VALUE_REQUIRED#" class="uAsterisk" /></label>',
  p_before_item=>'',
  p_after_item=>'',
  p_on_error_before_label=>'',
  p_on_error_after_label=>'<span class="uLabelError">#ERROR_MESSAGE#</span>',
  p_theme_id  => 26,
  p_theme_class_id => 4,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/label/required_with_help
prompt  ......label template 57414623444816367
 
begin
 
begin
wwv_flow_api.create_field_template (
  p_id=> 57414623444816367 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_template_name=>'Required with help',
  p_template_body1=>'<label for="#CURRENT_ITEM_NAME#" class="uRequired"><a class="uHelpLink" href="javascript:popupFieldHelp(''#CURRENT_ITEM_ID#'',''&SESSION.'')" tabindex="999">',
  p_template_body2=>'</a> <img src="#IMAGE_PREFIX#f_spacer.gif" alt="#VALUE_REQUIRED#" class="uAsterisk" /></label>',
  p_before_item=>'',
  p_after_item=>'',
  p_on_error_before_label=>'',
  p_on_error_after_label=>'<span class="uLabelError">#ERROR_MESSAGE#</span>',
  p_theme_id  => 26,
  p_theme_class_id => 2,
  p_translate_this_template=> 'N',
  p_template_comment=> '');
end;
null;
 
end;
/

prompt  ...breadcrumb templates
--
--application/shared_components/user_interface/templates/breadcrumb/breadcrumb_menu
prompt  ......template 57415703007816395
 
begin
 
begin
wwv_flow_api.create_menu_template (
  p_id=> 57415703007816395 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=>'Breadcrumb Menu',
  p_before_first=>'<ul>',
  p_current_page_option=>'<li class="active"><span>#NAME#</span></li> ',
  p_non_current_page_option=>'<li><a href="#LINK#">#NAME#</a></li> ',
  p_menu_link_attributes=>'',
  p_between_levels=>'<li class="uSeparator"><img src="#IMAGE_PREFIX#f_spacer.gif" class="uBreadcrumbSeparator" alt="" /></li> ',
  p_after_last=>'</ul>',
  p_max_levels=>12,
  p_start_with_node=>'PARENT_TO_LEAF',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_template_comments=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/breadcrumb/hierarchical_menu
prompt  ......template 57415826679816404
 
begin
 
begin
wwv_flow_api.create_menu_template (
  p_id=> 57415826679816404 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_name=>'Hierarchical Menu',
  p_before_first=>'<ul class="t1HierarchicalMenu">',
  p_current_page_option=>'<li class="t1current">#NAME#</li>',
  p_non_current_page_option=>'<li><a href="#LINK#">#NAME#</a></li>',
  p_menu_link_attributes=>'',
  p_between_levels=>'',
  p_after_last=>'</ul>',
  p_max_levels=>11,
  p_start_with_node=>'CHILD_MENU',
  p_theme_id  => 26,
  p_theme_class_id => 2,
  p_translate_this_template => 'N',
  p_template_comments=>'');
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/popuplov
prompt  ...popup list of values templates
--
prompt  ......template 57416212291816423
 
begin
 
begin
wwv_flow_api.create_popup_lov_template (
  p_id=> 57416212291816423 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_popup_icon=>'#IMAGE_PREFIX#f_spacer.gif',
  p_popup_icon_attr=>'alt="#LIST_OF_VALUES#" title="#LIST_OF_VALUES#" class="uPopupLOVIcon"',
  p_popup_icon2=>'',
  p_popup_icon_attr2=>'',
  p_page_name=>'winlov',
  p_page_title=>'Search Dialog',
  p_page_html_head=>'<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge" /><![endif]-->'||unistr('\000a')||
'<link rel="shortcut icon" href="#IMAGE_PREFIX#favicon.ico" type="image/x-icon">  <link rel="stylesheet" href="#IMAGE_PREFIX#themes/theme_26/css/4_2.css?v=#APEX_VERSION#" type="text/css" media="all"/>'||unistr('\000a')||
'#THEME_CSS#',
  p_page_body_attr=>'class="uPopUpLOV"',
  p_before_field_text=>'<div class="uActionBar">',
  p_page_heading_text=>'',
  p_page_footer_text =>'',
  p_filter_width     =>'20',
  p_filter_max_width =>'100',
  p_filter_text_attr =>'class="searchField"',
  p_find_button_text =>'Search',
  p_find_button_image=>'',
  p_find_button_attr =>'class="smallButton"',
  p_close_button_text=>'Close',
  p_close_button_image=>'',
  p_close_button_attr=>'class="smallButton hotButton"',
  p_next_button_text =>'Next >',
  p_next_button_image=>'',
  p_next_button_attr =>'class="smallButton"',
  p_prev_button_text =>'< Previous',
  p_prev_button_image=>'',
  p_prev_button_attr =>'class="smallButton"',
  p_after_field_text=>'</div>',
  p_scrollbars=>'1',
  p_resizable=>'1',
  p_width =>'400',
  p_height=>'450',
  p_result_row_x_of_y=>'<div class="lovPagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>',
  p_result_rows_per_pg=>500,
  p_before_result_set=>'<div class="lovLinks">',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_translate_this_template => 'N',
  p_after_result_set   =>'</div>');
end;
null;
 
end;
/

prompt  ...calendar templates
--
--application/shared_components/user_interface/templates/calendar/calendar
prompt  ......template 57415911164816406
 
begin
 
begin
wwv_flow_api.create_calendar_template(
  p_id=> 57415911164816406 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_cal_template_name=>'Calendar',
  p_translate_this_template=> 'N',
  p_day_of_week_format=> '<th valign="bottom" class="DayOfWeek">#IDAY#</th>',
  p_month_title_format=> '<table cellspacing="0" cellpadding="0" border="0" summary="" class="CalendarAlternative1Holder"> '||unistr('\000a')||
' <tr>'||unistr('\000a')||
'   <td class="MonthTitle">#IMONTH# #YYYY#</td>'||unistr('\000a')||
' </tr>'||unistr('\000a')||
' <tr>'||unistr('\000a')||
' <td>',
  p_month_open_format=> '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="CalendarAlternative1">',
  p_month_close_format=> '</table></td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'',
  p_day_title_format=> '<div class="DayTitle">#DD#</div>',
  p_day_open_format=> '<td class="Day" valign="top" height="100" height="100">#TITLE_FORMAT##DATA#',
  p_day_close_format=> '</td>',
  p_today_open_format=> '<td valign="top" class="Today">#TITLE_FORMAT##DATA#',
  p_weekend_title_format=> '<div class="WeekendDayTitle">#DD#</div>',
  p_weekend_open_format => '<td valign="top" class="WeekendDay">#TITLE_FORMAT##DATA#',
  p_weekend_close_format => '</td>',
  p_nonday_title_format => '<div class="NonDayTitle">#DD#</div>',
  p_nonday_open_format => '<td class="NonDay" valign="top">',
  p_nonday_close_format => '</td>',
  p_week_title_format => '',
  p_week_open_format => '<tr>',
  p_week_close_format => '</tr> ',
  p_daily_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>',
  p_daily_open_format => '<tr>',
  p_daily_close_format => '</tr>',
  p_weekly_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="WeekCalendarAlternative1Holder">'||unistr('\000a')||
'<tr>'||unistr('\000a')||
'<td class="MonthTitle">#WTITLE#</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'<tr>'||unistr('\000a')||
'<td>',
  p_weekly_day_of_week_format => '<th class="DayOfWeek">#IDAY#<br>#MM#/#DD#</th>',
  p_weekly_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="WeekCalendarAlternative1">',
  p_weekly_month_close_format => '</table></td></tr></table>',
  p_weekly_day_title_format => '',
  p_weekly_day_open_format => '<td class="Day" valign="top">',
  p_weekly_day_close_format => '<br /></td>',
  p_weekly_today_open_format => '<td class="Today" valign="top">',
  p_weekly_weekend_title_format => '',
  p_weekly_weekend_open_format => '<td valign="top" class="NonDay">',
  p_weekly_weekend_close_format => '<br /></td>',
  p_weekly_time_open_format => '<th class="Hour">',
  p_weekly_time_close_format => '<br /></th>',
  p_weekly_time_title_format => '#TIME#',
  p_weekly_hour_open_format => '<tr>',
  p_weekly_hour_close_format => '</tr>',
  p_daily_day_of_week_format => '<th class="DayOfWeek">#IDAY# #DD#/#MM#</th>',
  p_daily_month_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="DayCalendarAlternative1Holder"> <tr><td class="MonthTitle">#IMONTH# #DD#, #YYYY#</td></tr><tr><td>'||unistr('\000a')||
'',
  p_daily_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="DayCalendarAlternative1">',
  p_daily_month_close_format => '</table></td> </tr> </table>',
  p_daily_day_title_format => '',
  p_daily_day_open_format => '<td valign="top" class="Day">',
  p_daily_day_close_format => '<br /></td>',
  p_daily_today_open_format => '<td valign="top" class="Today">',
  p_daily_time_open_format => '<th class="Hour">',
  p_daily_time_close_format => '<br /></th>',
  p_daily_time_title_format => '#TIME#',
  p_daily_hour_open_format => '<tr>',
  p_daily_hour_close_format => '</tr>',
  p_cust_month_title_format => '',
  p_cust_day_of_week_format => '',
  p_cust_month_open_format => '',
  p_cust_month_close_format => '',
  p_cust_week_title_format => '',
  p_cust_week_open_format => '',
  p_cust_week_close_format => '',
  p_cust_day_title_format => '',
  p_cust_day_open_format => '',
  p_cust_day_close_format => '',
  p_cust_today_open_format => '',
  p_cust_daily_title_format => '',
  p_cust_daily_open_format => '',
  p_cust_daily_close_format => '',
  p_cust_nonday_title_format => '',
  p_cust_nonday_open_format => '',
  p_cust_nonday_close_format => '',
  p_cust_weekend_title_format => '',
  p_cust_weekend_open_format => '',
  p_cust_weekend_close_format => '',
  p_cust_hour_open_format => '',
  p_cust_hour_close_format => '',
  p_cust_time_title_format => '',
  p_cust_time_open_format => '',
  p_cust_time_close_format => '',
  p_cust_wk_month_title_format => '',
  p_cust_wk_day_of_week_format => '',
  p_cust_wk_month_open_format => '',
  p_cust_wk_month_close_format => '',
  p_cust_wk_week_title_format => '',
  p_cust_wk_week_open_format => '',
  p_cust_wk_week_close_format => '',
  p_cust_wk_day_title_format => '',
  p_cust_wk_day_open_format => '',
  p_cust_wk_day_close_format => '',
  p_cust_wk_today_open_format => '',
  p_cust_wk_weekend_title_format => '',
  p_cust_wk_weekend_open_format => '',
  p_cust_wk_weekend_close_format => '',
  p_cust_month_day_height_pix => '',
  p_cust_month_day_height_per => '',
  p_cust_week_day_width_pix => '',
  p_cust_week_day_width_per => '',
  p_agenda_format => '',
  p_agenda_past_day_format => '',
  p_agenda_today_day_format => '',
  p_agenda_future_day_format => '',
  p_agenda_past_entry_format => '',
  p_agenda_today_entry_format => '',
  p_agenda_future_entry_format => '',
  p_month_data_format => '#DAYS#',
  p_month_data_entry_format => '#DATA#',
  p_theme_id  => 26,
  p_theme_class_id => 1,
  p_reference_id=> null);
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/calendar/calendar_alternative
prompt  ......template 57416016005816418
 
begin
 
begin
wwv_flow_api.create_calendar_template(
  p_id=> 57416016005816418 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_cal_template_name=>'Calendar - Alternative',
  p_translate_this_template=> 'N',
  p_day_of_week_format=> '<th class="DayOfWeek">#IDAY#</th>',
  p_month_title_format=> '<table cellspacing="0" cellpadding="0" border="0" summary="" class="CalendarHolder"> '||unistr('\000a')||
' <tr>'||unistr('\000a')||
'   <td class="MonthTitle">#IMONTH# #YYYY#</td>'||unistr('\000a')||
' </tr>'||unistr('\000a')||
' <tr>'||unistr('\000a')||
' <td>',
  p_month_open_format=> '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="Calendar">',
  p_month_close_format=> '</table></td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'</table>'||unistr('\000a')||
'',
  p_day_title_format=> '<div class="DayTitle">#DD#</div>',
  p_day_open_format=> '<td class="Day" valign="top">#TITLE_FORMAT##DATA#',
  p_day_close_format=> '</td>',
  p_today_open_format=> '<td valign="top" class="Today">#TITLE_FORMAT##DATA#',
  p_weekend_title_format=> '<div class="WeekendDayTitle">#DD#</div>',
  p_weekend_open_format => '<td valign="top" class="WeekendDay">#TITLE_FORMAT##DATA#',
  p_weekend_close_format => '</td>',
  p_nonday_title_format => '<div class="NonDayTitle">#DD#</div>',
  p_nonday_open_format => '<td class="NonDay" valign="top">',
  p_nonday_close_format => '</td>',
  p_week_title_format => '',
  p_week_open_format => '<tr>',
  p_week_close_format => '</tr> ',
  p_daily_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>',
  p_daily_open_format => '<tr>',
  p_daily_close_format => '</tr>',
  p_weekly_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="WeekCalendarHolder">'||unistr('\000a')||
'<tr>'||unistr('\000a')||
'<td class="MonthTitle" id="test">#WTITLE#</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'<tr>'||unistr('\000a')||
'<td>',
  p_weekly_day_of_week_format => '<th class="DayOfWeek">#IDAY#<br>#MM#/#DD#</th>',
  p_weekly_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="WeekCalendar">',
  p_weekly_month_close_format => '</table></td></tr></table>',
  p_weekly_day_title_format => '',
  p_weekly_day_open_format => '<td class="Day" valign="top">',
  p_weekly_day_close_format => '<br /></td>',
  p_weekly_today_open_format => '<td class="Today" valign="top">',
  p_weekly_weekend_title_format => '',
  p_weekly_weekend_open_format => '<td valign="top" class="NonDay">',
  p_weekly_weekend_close_format => '<br /></td>',
  p_weekly_time_open_format => '<th class="Hour">',
  p_weekly_time_close_format => '<br /></th>',
  p_weekly_time_title_format => '#TIME#',
  p_weekly_hour_open_format => '<tr>',
  p_weekly_hour_close_format => '</tr>',
  p_daily_day_of_week_format => '<th class="DayOfWeek">#IDAY# #DD#/#MM#</th>',
  p_daily_month_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'||unistr('\000a')||
'',
  p_daily_month_open_format => '<table border="0" cellpadding="2" cellspacing="0" summary="0" class="DayCalendar">',
  p_daily_month_close_format => '</table></td> </tr> </table>',
  p_daily_day_title_format => '',
  p_daily_day_open_format => '<td valign="top" class="Day">',
  p_daily_day_close_format => '<br /></td>',
  p_daily_today_open_format => '<td valign="top" class="Today">',
  p_daily_time_open_format => '<th class="Hour">',
  p_daily_time_close_format => '<br /></th>',
  p_daily_time_title_format => '#TIME#',
  p_daily_hour_open_format => '<tr>',
  p_daily_hour_close_format => '</tr>',
  p_cust_month_title_format => '',
  p_cust_day_of_week_format => '',
  p_cust_month_open_format => '',
  p_cust_month_close_format => '',
  p_cust_week_title_format => '',
  p_cust_week_open_format => '',
  p_cust_week_close_format => '',
  p_cust_day_title_format => '',
  p_cust_day_open_format => '',
  p_cust_day_close_format => '',
  p_cust_today_open_format => '',
  p_cust_daily_title_format => '',
  p_cust_daily_open_format => '',
  p_cust_daily_close_format => '',
  p_cust_nonday_title_format => '',
  p_cust_nonday_open_format => '',
  p_cust_nonday_close_format => '',
  p_cust_weekend_title_format => '',
  p_cust_weekend_open_format => '',
  p_cust_weekend_close_format => '',
  p_cust_hour_open_format => '',
  p_cust_hour_close_format => '',
  p_cust_time_title_format => '',
  p_cust_time_open_format => '',
  p_cust_time_close_format => '',
  p_cust_wk_month_title_format => '',
  p_cust_wk_day_of_week_format => '',
  p_cust_wk_month_open_format => '',
  p_cust_wk_month_close_format => '',
  p_cust_wk_week_title_format => '',
  p_cust_wk_week_open_format => '',
  p_cust_wk_week_close_format => '',
  p_cust_wk_day_title_format => '',
  p_cust_wk_day_open_format => '',
  p_cust_wk_day_close_format => '',
  p_cust_wk_today_open_format => '',
  p_cust_wk_weekend_title_format => '',
  p_cust_wk_weekend_open_format => '',
  p_cust_wk_weekend_close_format => '',
  p_cust_month_day_height_pix => '',
  p_cust_month_day_height_per => '',
  p_cust_week_day_width_pix => '',
  p_cust_week_day_width_per => '',
  p_agenda_format => '',
  p_agenda_past_day_format => '',
  p_agenda_today_day_format => '',
  p_agenda_future_day_format => '',
  p_agenda_past_entry_format => '',
  p_agenda_today_entry_format => '',
  p_agenda_future_entry_format => '',
  p_month_data_format => '#DAYS#',
  p_month_data_entry_format => '#DATA#',
  p_theme_id  => 26,
  p_theme_class_id => 2,
  p_reference_id=> null);
end;
null;
 
end;
/

--application/shared_components/user_interface/templates/calendar/small_calendar
prompt  ......template 57416102684816418
 
begin
 
begin
wwv_flow_api.create_calendar_template(
  p_id=> 57416102684816418 + wwv_flow_api.g_id_offset,
  p_flow_id=> wwv_flow.g_flow_id,
  p_cal_template_name=>'Small Calendar',
  p_translate_this_template=> 'N',
  p_day_of_week_format=> '<th scope="col">#DY#</th>',
  p_month_title_format=> '<table class="uCalendarSmall" summary="#IMONTH# #YYYY#">'||unistr('\000a')||
'  <caption>#IMONTH# #YYYY#</caption>',
  p_month_open_format=> '',
  p_month_close_format=> '  </tbody>'||unistr('\000a')||
'</table>',
  p_day_title_format=> '#DD#',
  p_day_open_format=> '<td>#TITLE_FORMAT##DATA#',
  p_day_close_format=> '</td>',
  p_today_open_format=> '<td class="today">#TITLE_FORMAT##DATA#',
  p_weekend_title_format=> '#DD#',
  p_weekend_open_format => '<td class="weekend">#TITLE_FORMAT##DATA#',
  p_weekend_close_format => '</td>',
  p_nonday_title_format => '#DD#',
  p_nonday_open_format => '<td class="inactive">',
  p_nonday_close_format => '</td>',
  p_week_title_format => '',
  p_week_open_format => '<tr>',
  p_week_close_format => '</tr> ',
  p_daily_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>',
  p_daily_open_format => '<tr>',
  p_daily_close_format => '</tr>',
  p_weekly_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="SmallWeekCalendarHolder">'||unistr('\000a')||
'<tr>'||unistr('\000a')||
'<td class="MonthTitle" id="test">#WTITLE#</td>'||unistr('\000a')||
'</tr>'||unistr('\000a')||
'<tr>'||unistr('\000a')||
'<td>',
  p_weekly_day_of_week_format => '<th class="DayOfWeek">#DY#<br />#MM#/#DD#</th>',
  p_weekly_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="SmallWeekCalendar">',
  p_weekly_month_close_format => '</table></td></tr></table>',
  p_weekly_day_title_format => '',
  p_weekly_day_open_format => '<td class="Day" valign="top"><div class="inner">',
  p_weekly_day_close_format => '</div></td>',
  p_weekly_today_open_format => '<td class="t1Today" valign="top"><div class="inner">',
  p_weekly_weekend_title_format => '',
  p_weekly_weekend_open_format => '<td valign="top" class="NonDay"><div class="inner">',
  p_weekly_weekend_close_format => '</div></td>',
  p_weekly_time_open_format => '<th class="Hour">',
  p_weekly_time_close_format => '<br /></th>',
  p_weekly_time_title_format => '#TIME#',
  p_weekly_hour_open_format => '<tr>',
  p_weekly_hour_close_format => '</tr>',
  p_daily_day_of_week_format => '<th class="DayOfWeek">#DY# #DD#/#MM#</th>',
  p_daily_month_title_format => '<table cellspacing="0" cellpadding="0" border="0" summary="" class="SmallDayCalendarHolder"> <tr> <td class="MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr><tr><td>'||unistr('\000a')||
'',
  p_daily_month_open_format => '<table border="0" cellpadding="0" cellspacing="0" summary="0" class="SmallDayCalendar">',
  p_daily_month_close_format => '</table></td></tr></table>',
  p_daily_day_title_format => '',
  p_daily_day_open_format => '<td valign="top" class="Day">',
  p_daily_day_close_format => '<br /></td>',
  p_daily_today_open_format => '<td valign="top" class="Today">',
  p_daily_time_open_format => '<th class="Hour">',
  p_daily_time_close_format => '<br /></th>',
  p_daily_time_title_format => '#TIME#',
  p_daily_hour_open_format => '<tr>',
  p_daily_hour_close_format => '</tr>',
  p_cust_month_title_format => '',
  p_cust_day_of_week_format => '',
  p_cust_month_open_format => '',
  p_cust_month_close_format => '',
  p_cust_week_title_format => '',
  p_cust_week_open_format => '',
  p_cust_week_close_format => '',
  p_cust_day_title_format => '',
  p_cust_day_open_format => '',
  p_cust_day_close_format => '',
  p_cust_today_open_format => '',
  p_cust_daily_title_format => '',
  p_cust_daily_open_format => '',
  p_cust_daily_close_format => '',
  p_cust_nonday_title_format => '',
  p_cust_nonday_open_format => '',
  p_cust_nonday_close_format => '',
  p_cust_weekend_title_format => '',
  p_cust_weekend_open_format => '',
  p_cust_weekend_close_format => '',
  p_cust_hour_open_format => '',
  p_cust_hour_close_format => '',
  p_cust_time_title_format => '',
  p_cust_time_open_format => '',
  p_cust_time_close_format => '',
  p_cust_wk_month_title_format => '',
  p_cust_wk_day_of_week_format => '',
  p_cust_wk_month_open_format => '',
  p_cust_wk_month_close_format => '',
  p_cust_wk_week_title_format => '',
  p_cust_wk_week_open_format => '',
  p_cust_wk_week_close_format => '',
  p_cust_wk_day_title_format => '',
  p_cust_wk_day_open_format => '',
  p_cust_wk_day_close_format => '',
  p_cust_wk_today_open_format => '',
  p_cust_wk_weekend_title_format => '',
  p_cust_wk_weekend_open_format => '',
  p_cust_wk_weekend_close_format => '',
  p_cust_month_day_height_pix => '',
  p_cust_month_day_height_per => '',
  p_cust_week_day_width_pix => '',
  p_cust_week_day_width_per => '',
  p_agenda_format => '',
  p_agenda_past_day_format => '',
  p_agenda_today_day_format => '',
  p_agenda_future_day_format => '',
  p_agenda_past_entry_format => '',
  p_agenda_today_entry_format => '',
  p_agenda_future_entry_format => '',
  p_month_data_format => '#DAYS#',
  p_month_data_entry_format => '#DATA#',
  p_theme_id  => 26,
  p_theme_class_id => 3,
  p_reference_id=> null);
end;
null;
 
end;
/

prompt  ...application themes
--
--application/shared_components/user_interface/themes/productivity_applications
prompt  ......theme 57416319336816442
begin
wwv_flow_api.create_theme (
  p_id =>57416319336816442 + wwv_flow_api.g_id_offset,
  p_flow_id =>wwv_flow.g_flow_id,
  p_theme_id  => 26,
  p_theme_name=>'Productivity Applications',
  p_ui_type_name=>'DESKTOP',
  p_is_locked=>false,
  p_default_page_template=>57407419226816256 + wwv_flow_api.g_id_offset,
  p_error_template=>57406021475816227 + wwv_flow_api.g_id_offset,
  p_printer_friendly_template=>57407016034816248 + wwv_flow_api.g_id_offset,
  p_breadcrumb_display_point=>'REGION_POSITION_01',
  p_sidebar_display_point=>'REGION_POSITION_02',
  p_login_template=>57405617771816184 + wwv_flow_api.g_id_offset,
  p_default_button_template=>57414711827816373 + wwv_flow_api.g_id_offset,
  p_default_region_template=>57410003985816286 + wwv_flow_api.g_id_offset,
  p_default_chart_template =>57408415262816281 + wwv_flow_api.g_id_offset,
  p_default_form_template  =>57408721803816282 + wwv_flow_api.g_id_offset,
  p_default_reportr_template   =>57410003985816286 + wwv_flow_api.g_id_offset,
  p_default_tabform_template=>57410003985816286 + wwv_flow_api.g_id_offset,
  p_default_wizard_template=>57410801908816291 + wwv_flow_api.g_id_offset,
  p_default_menur_template=>57408014330816279 + wwv_flow_api.g_id_offset,
  p_default_listr_template=>57408326731816280 + wwv_flow_api.g_id_offset,
  p_default_irr_template=>57409123273816283 + wwv_flow_api.g_id_offset,
  p_default_report_template   =>57411729106816313 + wwv_flow_api.g_id_offset,
  p_default_label_template=>57414306093816365 + wwv_flow_api.g_id_offset,
  p_default_menu_template=>57415703007816395 + wwv_flow_api.g_id_offset,
  p_default_calendar_template=>57415911164816406 + wwv_flow_api.g_id_offset,
  p_default_list_template=>57413821451816340 + wwv_flow_api.g_id_offset,
  p_default_option_label=>57414419994816365 + wwv_flow_api.g_id_offset,
  p_default_header_template=>null + wwv_flow_api.g_id_offset,
  p_default_footer_template=>null + wwv_flow_api.g_id_offset,
  p_default_page_transition=>'NONE',
  p_default_popup_transition=>'NONE',
  p_default_required_label=>57414623444816367 + wwv_flow_api.g_id_offset);
end;
/
 
prompt  ...theme styles
--
 
begin
 
null;
 
end;
/

prompt  ...theme display points
--
 
begin
 
null;
 
end;
/

prompt  ...build options
--
 
begin
 
null;
 
end;
/

--application/shared_components/globalization/language
prompt  ...Language Maps for Application 175
--
 
begin
 
null;
 
end;
/

--application/shared_components/globalization/messages
prompt  ...text messages
--
--application/shared_components/globalization/dyntranslations
prompt  ...dynamic translations
--
prompt  ...Shortcuts
--
--application/shared_components/user_interface/shortcuts/delete_confirm_msg
 
begin
 
declare
  c1 varchar2(32767) := null;
  l_clob clob;
  l_length number := 1;
begin
c1:=c1||'Would you like to perform this delete action?';

wwv_flow_api.create_shortcut (
 p_id=> 57638910777966642 + wwv_flow_api.g_id_offset,
 p_flow_id=> wwv_flow.g_flow_id,
 p_shortcut_name=> 'DELETE_CONFIRM_MSG',
 p_shortcut_type=> 'TEXT_ESCAPE_JS',
 p_shortcut=> c1);
end;
null;
 
end;
/

prompt  ...web services (9iR2 or better)
--
prompt  ...shared queries
--
prompt  ...report layouts
--
prompt  ...authentication schemes
--
--application/shared_components/security/authentication/no_authentication
prompt  ......authentication 57416603226816496
 
begin
 
wwv_flow_api.create_authentication (
  p_id => 57416603226816496 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_name => 'No Authentication'
 ,p_scheme_type => 'NATIVE_DAD'
 ,p_use_secure_cookie_yn => 'N'
  );
null;
 
end;
/

--application/shared_components/security/authentication/ldap_authentication
prompt  ......authentication 59509031821229301
 
begin
 
wwv_flow_api.create_authentication (
  p_id => 59509031821229301 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_name => 'ldap_authentication'
 ,p_scheme_type => 'NATIVE_CUSTOM'
 ,p_attribute_03 => 'LDAP_AUTHENTICATE'
 ,p_attribute_05 => 'N'
 ,p_use_secure_cookie_yn => 'N'
  );
null;
 
end;
/

prompt  ...ui types
--
 
begin
 
null;
 
end;
/

prompt  ...plugins
--
prompt  ...data loading
--
--application/deployment/definition
prompt  ...application deployment
--
 
begin
 
declare
    s varchar2(32767) := null;
    l_clob clob;
begin
s := null;
wwv_flow_api.create_install (
  p_id => 57642914643979300 + wwv_flow_api.g_id_offset,
  p_flow_id => wwv_flow.g_flow_id,
  p_include_in_export_yn => 'Y',
  p_deinstall_message=> '');
end;
 
 
end;
/

--application/deployment/install
prompt  ...application install scripts
--
 
begin
 
declare
    s varchar2(32767) := null;
    l_clob clob;
    l_length number := 1;
begin
s:=s||'CREATE TABLE  "APPS_CHECKS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DIENSTENTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_BELEIDSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_BELEIDSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SO_TOEPASSINGSMANAGER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VO_APPLICATIEBEHEERD';

s:=s||'ER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "ASSESSMENT" NUMBER, '||unistr('\000a')||
'    "MIGRATIE" NUMBER, '||unistr('\000a')||
'    "EOSL_KOST" NUMBER, '||unistr('\000a')||
'    "PROJECT_KOST" NUMBER, '||unistr('\000a')||
'    "TOTALE_KOST" NUMBER, '||unistr('\000a')||
'    "MSGSTR" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EOSL_STRATEGY" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMPUTER_UITDOVEND" DATE, '||unistr('\000a')||
'    "COMPUTER_UITGEDOOFD" DATE, '||unistr('\000a')||
'    "COMPONENT_UITDOVEND" DATE, '||unistr('\000a')||
'    "COMPONENT_UITGEDOOFD" DATE, '||unistr('\000a')||
'    "OS_UITDOVEND" DATE, '||unistr('\000a')||
'    "OS_UITG';

s:=s||'EDOOFD" DATE, '||unistr('\000a')||
'    "CONNECTIONS" NUMBER, '||unistr('\000a')||
'    "COMP" NUMBER, '||unistr('\000a')||
'    "NO_COMP" NUMBER, '||unistr('\000a')||
'    "SW_CNT" NUMBER, '||unistr('\000a')||
'    "SW_CNT_BOU" NUMBER, '||unistr('\000a')||
'    "JOB_CNT" NUMBER, '||unistr('\000a')||
'    "JOB_CNT_BOU" NUMBER, '||unistr('\000a')||
'     CONSTRAINT "APPS_CHECKS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "APPS_CIS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID_SRC" NUMBER, '||unistr('\000a')||
'    "NAAM_SRC" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CMDB_ID_TGT" NUMBER, '||unistr('\000a')||
'    "NAAM_TGT';

s:=s||'" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE_TGT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE_TGT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "APPS_CIS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "CMWBT0011" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "TOEPASSINGOMGEVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "STATUS_TOEPASSINGOMGEVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CMDB_REFERENTIE_OMGEVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERSIE" VARCHAR2(255 CHAR)';

s:=s||', '||unistr('\000a')||
'    "TYPE_OMGEVING" VARCHAR2(4 CHAR), '||unistr('\000a')||
'    "DATUM_IN_GEBRUIK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM_BUITEN_GEBRUIK" VARCHAR2(120 CHAR), '||unistr('\000a')||
'    "CMDB_REFERENTIE_BEDRIJFSTOEPAS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "NAAM_BEDRIJFSTOEPASSING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "NUMMER_BEDRIJFSTOEPASSING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DIENSTENTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FINANCIEEL_BEHEERDER_BELEIDSD" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FI';

s:=s||'NANCIEEL_BEHEERDER_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_BELEIDSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "STATUS_BEDRIJFSTOEPASSING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "BT_DATUM_IN_GEBRUIK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "BT_DATUM_BUITEN_GEBRUIK" VARCHAR2(120 CHAR), '||unistr('\000a')||
'    "SO_TOEPASSINGSMANAGERS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VO_APPLICATIEBEHEERDERS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'   ';

s:=s||' "RELATIE" VARCHAR2(120 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CMDB_REFERENTIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_SYSTEEMNAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_STATUS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_EIGENAAR" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCENT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SW_VERSIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OS" VARCHAR2(25';

s:=s||'5 CHAR), '||unistr('\000a')||
'    "VERSIE_OS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "HWSW" VARCHAR2(120 CHAR), '||unistr('\000a')||
'    "LOCATIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "KENMERKEN" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "DIENST_SLA" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "TP_FINANCIEEL_BEHEERDER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "UITDOVEND_DATUM" VARCHAR2(120 CHAR), '||unistr('\000a')||
'    "UITGEDOOFD_DATUM" VARCHAR2(120 CHAR), '||unistr('\000a')||
'    "OMGEVING" VARCHAR2(120 CHAR), '||unistr('\000a')||
'     CONSTRAINT "CMWBT0011_PK" PRIM';

s:=s||'ARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "COMPONENT" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "BT_NUMMER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CLASS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM_BUITEN_GEBRUIK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM_IN_GEBRUIK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DIENSTENTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_BELEI';

s:=s||'DSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_BELEIDSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "HW_SW_FLAG" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "LOCATIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OMGEVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OS_VERSIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCENT" VARCHAR2(255 CH';

s:=s||'AR), '||unistr('\000a')||
'    "PRODUCT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SO_TOEPASSINGSMANAGER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "STATUS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERSIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VO_APPLICATIEBEHEERDER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "KENMERKEN" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "UITDOVEND_DATUM" DATE, '||unistr('\000a')||
'    "UITGEDOOFD_DATUM" DATE, '||unistr('\000a')||
'     CONSTRAINT "COMPONENT_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "COMPONENT_SAFE" ';

s:=s||''||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "BT_NUMMER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CLASS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM_BUITEN_GEBRUIK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM_IN_GEBRUIK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DIENSTENTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_BELEIDSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR_ENTITEIT" ';

s:=s||'VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_BELEIDSDOMEIN" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_ENTITEIT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "HW_SW_FLAG" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "LOCATIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OMGEVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "OS_VERSIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCENT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SO_TOEPAS';

s:=s||'SINGSMANAGER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "STATUS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERSIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VO_APPLICATIEBEHEERDER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "KENMERKEN" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "UITDOVEND_DATUM" DATE, '||unistr('\000a')||
'    "UITGEDOOFD_DATUM" DATE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "CONS_CIS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID_SRC" NUMBER, '||unistr('\000a')||
'    "NAAM_SRC" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CMDB_ID_TGT" NUMBER, '||unistr('\000a')||
'    "NA';

s:=s||'AM_TGT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE_TGT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE_TGT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "CONS_CIS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "CONS_EOSL" '||unistr('\000a')||
'   (    "ID" NUMBER NOT NULL ENABLE, '||unistr('\000a')||
'    "CMDB_ID" NUMBER NOT NULL ENABLE, '||unistr('\000a')||
'    "UITDOVEND_DATUM" DATE, '||unistr('\000a')||
'    "UITGEDOOFD_DATUM" DATE, '||unistr('\000a')||
'     CONSTRAINT "CONS_EOSL_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'';

s:=s||'/'||unistr('\000a')||
'CREATE TABLE  "DERIVED_LOCATIONS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "LOCATIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "DERIVED_LOCATIONS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "EOSL_TOEPASSINGEN" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "ALG_STATUS" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "ALG_OPMERKING" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "STOP_DATUM" DATE, '||unistr('\000a')||
'    "STOP_OPMERKING" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "UPG';

s:=s||'_WA_OS" VARCHAR2(10 CHAR), '||unistr('\000a')||
'    "UPG_STATUS_PROJ" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "UPG_START_DATUM_PROJ" DATE, '||unistr('\000a')||
'    "UPG_EIND_DATUM_PROJ" DATE, '||unistr('\000a')||
'    "UPG_DATUM_STOP" DATE, '||unistr('\000a')||
'    "UPG_OPMERKING" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "EXC_DATUM_OP" DATE, '||unistr('\000a')||
'    "EXC_DATUM_TOT" DATE, '||unistr('\000a')||
'    "EXC_OPMERKING" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "EXC_RB" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "EXC_E_IB_BEOORDELING" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'    "TOEP_OMG" V';

s:=s||'ARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EOSL" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "OMG_CMDB_REF" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "OMG_VERSIE" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "OMG_TYPE" VARCHAR2(1 CHAR), '||unistr('\000a')||
'    "OMG_STATUS" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "OMG_DATUM_IN_GEBRUIK" DATE, '||unistr('\000a')||
'    "OMG_DATUM_BUITEN_GEBRUIK" DATE, '||unistr('\000a')||
'    "BEDR_TOEP_CMDB_REF" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_NUMMER" VARCHAR2(30 CHAR), '||unistr('\000a')||
'';

s:=s||'    "BEDR_TOEP_DIENSTENTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_FIN_BEH_BD" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_FIN_BEH_ENT" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_EIGENAAR_BD" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_EIGENAAR_ENT" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_STATUS" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_DATUM_IN_GEBRUIK" DATE, '||unistr('\000a')||
'    "BEDR_TOEP_DATUM_BUITEN_GEBRUIK" DATE, '||unistr('\000a')||
'    "BEDR_TOEP_SO_TOEP_MNGR" VA';

s:=s||'RCHAR2(255 CHAR), '||unistr('\000a')||
'    "BEDR_TOEP_VO_APP_BEH" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CMDB_REF" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "CI_SYSTEEM_NAAM" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "CI_STATUS" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "PRODUCENT" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "PRODUCT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERSIE" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "CI_DIENST" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_EIGENAAR" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "BD_FIN_BEH" VARCHAR2(30 CHAR), '||unistr('\000a')||
' ';

s:=s||'   "ENT_FIN_BEH" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "SHARED_PLATFORM" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "REL_DATUM" DATE, '||unistr('\000a')||
'    "END_OF_LIFE_DATUM" DATE, '||unistr('\000a')||
'    "END_OF_SERVICE_LIFE" DATE, '||unistr('\000a')||
'    "END_OF_EXT_LIFE_DATUM" DATE, '||unistr('\000a')||
'    "ONDERL_HW_OL" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CATEGORIE_OL" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "OS_OL" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "VERSIE_OL" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "EOSL_STATUS" VARCHAR2(1 CHAR), '||unistr('\000a')||
'    "DIENSTENTY';

s:=s||'PE_OL" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FIN_BEH_OL" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "EINDDATUM_BHV_OL" DATE, '||unistr('\000a')||
'    "PV_DATUM_OL" DATE, '||unistr('\000a')||
'    "UPG_WA_OS_MP" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EOSL_TYPE" VARCHAR2(2 CHAR), '||unistr('\000a')||
'    "AANGEPAST_DOOR" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "AANGEPAST_OP" TIMESTAMP (6), '||unistr('\000a')||
'    "BHV_NR" VARCHAR2(20 CHAR), '||unistr('\000a')||
'    "BHV" VARCHAR2(1 CHAR), '||unistr('\000a')||
'    "OS" VARCHAR2(30 CHAR), '||unistr('\000a')||
'    "OS_VERSIE" VARCHAR2(30 CHAR), '||unistr('\000a')||
'  ';

s:=s||'  "END_OF_EXT_SERV_LIFE_DATUM" DATE, '||unistr('\000a')||
'    "EXC_GOEDGEKEURD_OP" DATE, '||unistr('\000a')||
'    "EXC_GOEDGEKEURD_TOT" DATE, '||unistr('\000a')||
'    "EXC_GOEDGEKEURD_OPM" VARCHAR2(500 CHAR), '||unistr('\000a')||
'    "BEH_TOEPASSING" VARCHAR2(5 CHAR)'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "EXT_CMWBT0011" '||unistr('\000a')||
'   (    "TOEPASSINGOMGEVING" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "STATUS_TOEPASSINGOMGEVING" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "CMDB_REFERENTIE_OMGEVING" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "VERSIE" VARCHA';

s:=s||'R2(600 CHAR), '||unistr('\000a')||
'    "TYPE_OMGEVING" VARCHAR2(250 CHAR), '||unistr('\000a')||
'    "DATUM_IN_GEBRUIK" VARCHAR2(500 CHAR), '||unistr('\000a')||
'    "DATUM_BUITEN_GEBRUIK" VARCHAR2(100 CHAR), '||unistr('\000a')||
'    "CMDB_REFERENTIE_BEDRIJFSTOEPAS" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "NAAM_BEDRIJFSTOEPASSING" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "NUMMER_BEDRIJFSTOEPASSING" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "DIENSTENTYPE" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "FINANCIEEL_BEHEERDER_BELEIDSD" VARCHAR2(600 C';

s:=s||'HAR), '||unistr('\000a')||
'    "FINANCIEEL_BEHEERDER_ENTITEIT" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "EIGENAAR_BELEIDSDOMEIN" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "EIGENAAR_ENTITEIT" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "STATUS_BEDRIJFSTOEPASSING" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "SO_TOEPASSINGSMANAGERS" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "VO_APPLICATIEBEHEERDERS" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "RELATIE" VARCHAR2(100 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "CI_TYPE';

s:=s||'" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "CI_CMDB_REFERENTIE" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "CI_SYSTEEMNAAM" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "CI_STATUS" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "CI_EIGENAAR" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "PRODUCENT" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "PRODUCT" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "SW_VERSIE" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "OS" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "VERSIE_OS" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "HWSW" VARCHAR2(100 CHAR), '||unistr('\000a')||
'    "';

s:=s||'LOCATIE" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "KENMERKEN" VARCHAR2(2000 CHAR), '||unistr('\000a')||
'    "DIENST_SLA" VARCHAR2(2000 CHAR), '||unistr('\000a')||
'    "TP_FINANCIEEL_BEHEERDER" VARCHAR2(600 CHAR), '||unistr('\000a')||
'    "UITDOVEND_DATUM" VARCHAR2(100 CHAR), '||unistr('\000a')||
'    "UITGEDOOFD_DATUM" VARCHAR2(100 CHAR), '||unistr('\000a')||
'    "OMGEVING" VARCHAR2(100 CHAR)'||unistr('\000a')||
'   ) '||unistr('\000a')||
'   ORGANIZATION EXTERNAL '||unistr('\000a')||
'    ( TYPE ORACLE_LOADER'||unistr('\000a')||
'      DEFAULT DIRECTORY "CONCESSIE_IN"'||unistr('\000a')||
'      ACCESS PARAMETERS'||unistr('\000a')||
' ';

s:=s||'     ( RECORDS DELIMITED BY 0X''0A'' CHARACTERSET WE8MSWIN1252'||unistr('\000a')||
'        SKIP 1'||unistr('\000a')||
'        FIELDS TERMINATED BY 0X''09'' OPTIONALLY ENCLOSED BY ''"'''||unistr('\000a')||
'        MISSING FIELD VALUES are null'||unistr('\000a')||
'                )'||unistr('\000a')||
'      LOCATION'||unistr('\000a')||
'       ( ''CMWBT0011_OR_Inventaris_HW-SW_configuratie_per_toepassingomgeving.csv'''||unistr('\000a')||
'       )'||unistr('\000a')||
'    )'||unistr('\000a')||
'   REJECT LIMIT UNLIMITED'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "JOB_CHECKS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "SW_ID" NUMB';

s:=s||'ER, '||unistr('\000a')||
'    "SW_NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SW_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SW_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_ID" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CONNECTIONS" NUMBER, '||unistr('\000a')||
'    "ASSESSMENT" NUMBER, '||unistr('\000a')||
'    "MIGRATIE" NUMBER, '||unistr('\000a')||
'    "MSGSTR" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'     CONSTRAINT "JOB_C';

s:=s||'HECKS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "KOSTELEMENTEN" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "ELEMENT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMPUTERTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FUNCTIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM" DATE, '||unistr('\000a')||
'    "WAARDE" NUMBER, '||unistr('\000a')||
'     CONSTRAINT "KOSTELEMENTEN_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TAB';

s:=s||'LE  "KOSTELEMENTEN_DEF" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "ELEMENT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMPUTERTYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FUNCTIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DATUM" DATE, '||unistr('\000a')||
'    "WAARDE" NUMBER'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "LOGTBL" '||unistr('\000a')||
'   (    "EVT_IDX" NUMBER NOT NULL ENABLE, '||unistr('\000a')||
'    "EVT_TIME" TIMESTAMP (6), '||unistr('\000a')||
'    "EVT_PROC" VARCHAR2(';

s:=s||'255 CHAR), '||unistr('\000a')||
'    "EVT_SEV" VARCHAR2(1 CHAR), '||unistr('\000a')||
'    "EVT_MSG" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "LOGTBL_PK" PRIMARY KEY ("EVT_IDX") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "NETWERK" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SUBCATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERHUIS_STATUS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERHUISKOST_DAGEN" NUMBER, '||unistr('\000a')||
'';

s:=s||'    "VERHUISKOST_LABEL" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "VERHUISKOST_PUNTEN" NUMBER, '||unistr('\000a')||
'    "BESCHRIJVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "LIJN_CONNECTIING_DEVICE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "NETWERK_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "RELATIONS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID_SOURCE" NUMBER, '||unistr('\000a')||
'    "NAAM_SOURCE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE_SOURCE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_';

s:=s||'CATEGORIE_SOURCE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "RELATION" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CMDB_ID_TARGET" NUMBER, '||unistr('\000a')||
'    "NAAM_TARGET" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE_TARGET" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE_TARGET" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "RELATIONS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "RELATIONS_SAFE" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID_SOURCE" NUMBER, '||unistr('\000a')||
'    "NAAM_SOURCE" V';

s:=s||'ARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE_SOURCE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE_SOURCE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "RELATION" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CMDB_ID_TARGET" NUMBER, '||unistr('\000a')||
'    "NAAM_TARGET" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE_TARGET" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE_TARGET" VARCHAR2(255 CHAR)'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "SRV2APPS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID_COMP" NUMBER, '||unistr('\000a')||
'    "NAAM_COMP" ';

s:=s||'VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CMDB_ID_APPL" NUMBER, '||unistr('\000a')||
'    "NAAM_APPL" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "SRV2APPS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "SW_CHECKS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "SW_ID" NUMBER, '||unistr('\000a')||
'    "SW_NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SW_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SW_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_ID" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_NAAM" VARCHAR2(255 CHAR), ';

s:=s||''||unistr('\000a')||
'    "COMP_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "COMP_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CONNECTIONS" NUMBER, '||unistr('\000a')||
'    "ASSESSMENT" NUMBER, '||unistr('\000a')||
'    "MIGRATIE" NUMBER, '||unistr('\000a')||
'    "MSGSTR" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'     CONSTRAINT "SW_CHECKS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "SYSTEM_CHECKS" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
' ';

s:=s||'   "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCENT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "PRODUCT" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "LOCATIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "SW_CNT" NUMBER, '||unistr('\000a')||
'    "JOB_CNT" NUMBER, '||unistr('\000a')||
'    "CONNECTIONS" NUMBER, '||unistr('\000a')||
'    "MSGSTR" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "STATUS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "SYSTEM_CHECKS_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "SYSTEM_COST" '||unistr('\000a')||
'   (    "ID" NUMB';

s:=s||'ER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_TYPE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CI_CATEGORIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "LOCATIE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "STATUS" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "CONNECTIONS" NUMBER, '||unistr('\000a')||
'    "MIGRATIE" NUMBER, '||unistr('\000a')||
'    "EOSL_KOST" NUMBER, '||unistr('\000a')||
'    "PROJECT_KOST" NUMBER, '||unistr('\000a')||
'    "TOTALE_KOST" NUMBER, '||unistr('\000a')||
'    "OMGEVING" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "DIENSTENTYPE" VARCHAR2(2';

s:=s||'55 CHAR), '||unistr('\000a')||
'    "KENMERK" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "UITDOVEND_DATUM" DATE, '||unistr('\000a')||
'    "UITGEDOOFD_DATUM" DATE, '||unistr('\000a')||
'    "FUNCTIONELE_NAAM" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "FINANCIEEL_BEHEERDER" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "EIGENAAR" VARCHAR2(255 CHAR), '||unistr('\000a')||
'     CONSTRAINT "SYSTEM_COST_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE TABLE  "SYSTEM_VERIFICATION" '||unistr('\000a')||
'   (    "ID" NUMBER, '||unistr('\000a')||
'    "CMDB_ID" NUMBER, '||unistr('\000a')||
'    "NAAM" VARCHAR2';

s:=s||'(255 CHAR), '||unistr('\000a')||
'    "SOURCE" VARCHAR2(255 CHAR), '||unistr('\000a')||
'    "MSG" VARCHAR2(1000 CHAR), '||unistr('\000a')||
'     CONSTRAINT "SYSTEM_VERIFICATION_PK" PRIMARY KEY ("ID") ENABLE'||unistr('\000a')||
'   )'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE FUNCTION  "F_GET_EOSL_STATUS" (comp_id IN component.cmdb_id%TYPE)'||unistr('\000a')||
'    RETURN varchar2'||unistr('\000a')||
'IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''f_get_eosl_status'';'||unistr('\000a')||
'    TYPE status_tx_type IS TABLE OF varchar2(255) INDEX BY varchar2(255)';

s:=s||';'||unistr('\000a')||
'    status_tx status_tx_type;'||unistr('\000a')||
'    eosl_status_val varchar2(255) := ''InitValue'';'||unistr('\000a')||
'    aangepast_op_val apex_user_004.eosl_toepassingen.aangepast_op%TYPE;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    '||unistr('\000a')||
'    status_tx(''KEGU'') := ''Klant Exceptie - Geen Plan Upgrade'';'||unistr('\000a')||
'    status_tx(''KEPU'') := ''Klant Exceptie - Plan Upgrade'';'||unistr('\000a')||
'    status_tx(''KEPU04'') := ''Klant Exceptie - P';

s:=s||'lan Upgrade zonder datum'';'||unistr('\000a')||
'    status_tx(''Open'') := ''Open'';'||unistr('\000a')||
'    status_tx(''OPGL'') := ''Opgelost'';'||unistr('\000a')||
'    status_tx(''STZP'') := ''Stopzetting'';'||unistr('\000a')||
'    -- First get most recent EOSL STATUS'||unistr('\000a')||
'    select ALG_STATUS'||unistr('\000a')||
'    into eosl_status_val'||unistr('\000a')||
'    from apex_user_004.eosl_toepassingen'||unistr('\000a')||
'        where (omg_cmdb_ref = to_char(comp_id))'||unistr('\000a')||
'        and (aangepast_op = ('||unistr('\000a')||
'            select max(aangepast_op)'||unistr('\000a')||
'            from ap';

s:=s||'ex_user_004.eosl_toepassingen'||unistr('\000a')||
'            where (omg_cmdb_ref = to_char(comp_id))))'||unistr('\000a')||
'      and (rownum <= 1);'||unistr('\000a')||
'    IF status_tx.EXISTS(eosl_status_val) THEN'||unistr('\000a')||
'        eosl_status_val := status_tx(eosl_status_val);'||unistr('\000a')||
'    ELSE'||unistr('\000a')||
'        eosl_status_val := eosl_status_val || '' (vertaling!)'';'||unistr('\000a')||
'    END IF;'||unistr('\000a')||
'        '||unistr('\000a')||
'    RETURN eosl_status_val;'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'        RETURN '''';'||unistr('\000a')||
'    WHEN OTH';

s:=s||'ERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'        RETURN ''Error - See Log'';'||unistr('\000a')||
'END;'||unistr('\000a')||
'    '||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE FUNCTION  "ID_IN_COMPONENT" (netw_id IN netwerk.cmdb_id%TYPE, comp_id IN component.cmdb_id%TYPE)'||unistr('\000a')||
'    RETURN';

s:=s||' varchar2'||unistr('\000a')||
'IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''id_in_component'';'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    if (length(netw_id) is null) THEN'||unistr('\000a')||
'        RETURN '''';'||unistr('\000a')||
'    ELSIF (length(comp_id) is null) THEN'||unistr('\000a')||
'        RETURN ''Niet gevonden in CMDB2'';'||unistr('\000a')||
'    ELSE'||unistr('\000a')||
'        RETURN ''In CMDB2'';'||unistr('\000a')||
'    END IF;'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLE';

s:=s||'RRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'        RETURN '''';'||unistr('\000a')||
'END;'||unistr('\000a')||
'    '||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE FUNCTION  "LDAP_AUTHENTICATE" '||unistr('\000a')||
'(p_username in VARCHAR2, p_password in VARCHAR2) '||unistr('\000a')||
'return boolean'||unistr('\000a')||
'is'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''LDAP_AUTHENTI';

s:=s||'CATE'';'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    l_ldap_host VARCHAR2(256) := ''ldapp.vlaanderen.be'';'||unistr('\000a')||
'    l_ldap_port VARCHAR2(256) := ''389'';'||unistr('\000a')||
'    l_session DBMS_LDAP.session;'||unistr('\000a')||
'    l_session2 DBMS_LDAP.session;'||unistr('\000a')||
'    l_retval PLS_INTEGER; '||unistr('\000a')||
'    l_ldap_user VARCHAR2(256) := ''uid=et_ivo21_app,ou=admins,o=vlaanderen,c=be'';'||unistr('\000a')||
'    l_ldap_base VARCHAR2(256) := ''o=vlaanderen,c=be'';'||unistr('\000a')||
'';

s:=s||'    l_dn VARCHAR2(256);'||unistr('\000a')||
'    l_attrs DBMS_LDAP.string_collection;'||unistr('\000a')||
'    l_message DBMS_LDAP.message;'||unistr('\000a')||
'    l_deleted_in_db VARCHAR2(1); '||unistr('\000a')||
'    l_present_in_db VARCHAR2(1); '||unistr('\000a')||
'    cte number;'||unistr('\000a')||
'    v_aantal number;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Trying to authenticate User: '' || p_username);'||unistr('\000a')||
'    DBMS_LDAP.USE_EXCEPTION := TRUE; '||unistr('\000a')||
'    --We halen via een admin de dn van de te valideren gebruiker op.'||unistr('\000a')||
'    l_sess';

s:=s||'ion := DBMS_LDAP.init(hostname => l_ldap_host,'||unistr('\000a')||
'                                portnum => l_ldap_port);'||unistr('\000a')||
'    l_retval := DBMS_LDAP.simple_bind_s(ld => l_session,'||unistr('\000a')||
'                                        dn => l_ldap_user,'||unistr('\000a')||
'                                        passwd => NULL);'||unistr('\000a')||
'    l_attrs(1) := ''inr'';'||unistr('\000a')||
'    l_retval := DBMS_LDAP.search_s(ld => l_session, '||unistr('\000a')||
'                                   base => l_';

s:=s||'ldap_base, '||unistr('\000a')||
'                                   scope => DBMS_LDAP.SCOPE_SUBTREE,'||unistr('\000a')||
'                                   filter => ''uid='' || p_username,'||unistr('\000a')||
'                                   attrs => l_attrs,'||unistr('\000a')||
'                                   attronly => 1,'||unistr('\000a')||
'                                   res => l_message);'||unistr('\000a')||
'    IF DBMS_LDAP.count_entries(ld => l_session, msg => l_message) > 0 THEN '||unistr('\000a')||
'        l_dn := DBM';

s:=s||'S_LDAP.get_dn(ld => l_session, ldapEntry => DBMS_LDAP.first_entry(ld => l_session, msg => l_message));'||unistr('\000a')||
'    ELSE'||unistr('\000a')||
'        p_log(proc_name, ''I'', ''User : '' || p_username || '' failed to authenticate.'');'||unistr('\000a')||
'        return false;'||unistr('\000a')||
'    END IF;'||unistr('\000a')||
'    l_retval := DBMS_LDAP.unbind_s(ld => l_session);'||unistr('\000a')||
'    --We checken of de combinatie gebruikernaam/paswoord juist is '||unistr('\000a')||
'    l_session := DBMS_LDAP.init(hostname => l_ld';

s:=s||'ap_host,'||unistr('\000a')||
'                                portnum => l_ldap_port);'||unistr('\000a')||
'    l_retval := DBMS_LDAP.simple_bind_s(ld => l_session,'||unistr('\000a')||
'                                        dn => l_dn,'||unistr('\000a')||
'                                        passwd => p_password); '||unistr('\000a')||
'    l_retval := DBMS_LDAP.unbind_s(ld => l_session);'||unistr('\000a')||
'-- Test of de aangelogde gebruiker gekend is in de '||unistr('\000a')||
'-- gebruikerstabel van de toepassing '||unistr('\000a')||
'-- deze gebruikers';

s:=s||'tabel moet kolommen LDAP en ACTIEF hebben!!'||unistr('\000a')||
'--Select count(*) '||unistr('\000a')||
'--into v_Aantal '||unistr('\000a')||
'--from LDAP_GEBRUIKERS'||unistr('\000a')||
'--where upper(LDAP) = upper(p_username) '||unistr('\000a')||
'--and actief = ''J'';'||unistr('\000a')||
'--If v_aantal != 1 then'||unistr('\000a')||
'--return false;'||unistr('\000a')||
'--end if;'||unistr('\000a')||
'--'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''User : '' || p_username || '' successful authentication.'');'||unistr('\000a')||
'    return true;'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        l_retval := DBMS_LDAP.unbind_s(ld => l_ses';

s:=s||'sion);'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'    RETURN false;'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE FUNCTION  "UF_KENMERK" (kenmerk IN component.kenmerken%TYPE)'||unistr('\000a')||
'    RETURN component.kenmerken%TYPE'||unistr('\000a')||
'IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.';

s:=s||'evt_proc%TYPE := ''uf_kenmerk'';'||unistr('\000a')||
'    TYPE kenm_array IS VARRAY(6) OF varchar2(255);'||unistr('\000a')||
'    kenm kenm_array := kenm_array'||unistr('\000a')||
'        (''CENTRALE BACKUP FACILITEIT BRUSSEL;'','||unistr('\000a')||
'         ''CENTRALE BACKUP FACILITEIT BRUSSEL'','||unistr('\000a')||
'         ''BUR-ANDERE;'',''BUR-ANDERE'','||unistr('\000a')||
'         ''MONITORING MOM;'',''MONITORING MOM'');'||unistr('\000a')||
'    v_kenm component.kenmerken%TYPE;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'B';

s:=s||'EGIN'||unistr('\000a')||
'    v_kenm := kenmerk;'||unistr('\000a')||
'    IF (length(v_kenm) is null) THEN'||unistr('\000a')||
'        RETURN v_kenm;'||unistr('\000a')||
'    END IF;'||unistr('\000a')||
'    FOR cnt IN 1..kenm.COUNT LOOP'||unistr('\000a')||
'        v_kenm := REPLACE(v_kenm, kenm(cnt));'||unistr('\000a')||
'    END LOOP;'||unistr('\000a')||
'    RETURN v_kenm;'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn';

s:=s||': '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'        RETURN v_kenm;'||unistr('\000a')||
'END;'||unistr('\000a')||
'    '||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE UNIQUE INDEX  "CMWBT0011_PK" ON  "CMWBT0011" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "LOGTBL_PK" ON  "LOGTBL" ("EVT_IDX")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "COMPONENT_PK" ON  "COMPONENT" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "RELATIONS_PK" ON  "RELATIONS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "JOB_CHECKS_PK" ON  "JOB_CHECKS" ("ID';

s:=s||'")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "SW_CHECKS_PK" ON  "SW_CHECKS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "KOSTELEMENTEN_PK" ON  "KOSTELEMENTEN" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "SYSTEM_CHECKS_PK" ON  "SYSTEM_CHECKS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "CONS_CIS_PK" ON  "CONS_CIS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "DERIVED_LOCATIONS_PK" ON  "DERIVED_LOCATIONS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "CONS_EOSL_PK" ON  "CONS_EOSL" ("ID")'||unistr('\000a')||
'/';

s:=s||''||unistr('\000a')||
'CREATE UNIQUE INDEX  "APPS_CHECKS_PK" ON  "APPS_CHECKS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "APPS_CIS_PK" ON  "APPS_CIS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "NETWERK_PK" ON  "NETWERK" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "SYSTEM_COST_PK" ON  "SYSTEM_COST" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "SYSTEM_VERIFICATION_PK" ON  "SYSTEM_VERIFICATION" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE UNIQUE INDEX  "SRV2APPS_PK" ON  "SRV2APPS" ("ID")'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REP';

s:=s||'LACE PACKAGE  "STRING_FNC" '||unistr('\000a')||
'IS '||unistr('\000a')||
'TYPE t_array IS TABLE OF VARCHAR2(255) '||unistr('\000a')||
'   INDEX BY BINARY_INTEGER; '||unistr('\000a')||
'FUNCTION SPLIT (p_in_string VARCHAR2, p_delim VARCHAR2) RETURN t_array; '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE PACKAGE BODY  "STRING_FNC" '||unistr('\000a')||
'IS '||unistr('\000a')||
'   -- Copy from http://www.dbforums.com/oracle/998642-pl-sql-splitting-string-into-array.html'||unistr('\000a')||
'    '||unistr('\000a')||
'   FUNCTION SPLIT (p_in_string VARCHAR2, p_delim VARCHAR2) RETURN t_ar';

s:=s||'ray  '||unistr('\000a')||
'   IS '||unistr('\000a')||
'    '||unistr('\000a')||
'      i       number :=0; '||unistr('\000a')||
'      pos     number :=0; '||unistr('\000a')||
'      cnt     number;'||unistr('\000a')||
'      lv_str  varchar2(1000) := p_in_string; '||unistr('\000a')||
'       '||unistr('\000a')||
'   strings t_array; '||unistr('\000a')||
'    '||unistr('\000a')||
'   BEGIN '||unistr('\000a')||
'       '||unistr('\000a')||
'      -- Return empty array if empty string was the input'||unistr('\000a')||
'      IF (length(lv_str) IS NULL) THEN'||unistr('\000a')||
'         RETURN strings;'||unistr('\000a')||
'      END IF;'||unistr('\000a')||
'    '||unistr('\000a')||
'      -- determine first chuck of string   '||unistr('\000a')||
'      pos := instr(lv_s';

s:=s||'tr,p_delim,1,1); '||unistr('\000a')||
'    '||unistr('\000a')||
'      -- while there are chunks left, loop  '||unistr('\000a')||
'      WHILE ( pos != 0) LOOP '||unistr('\000a')||
'          '||unistr('\000a')||
'         -- increment counter  '||unistr('\000a')||
'         i := i + 1; '||unistr('\000a')||
'          '||unistr('\000a')||
'         -- create array element for chuck of string'||unistr('\000a')||
'         strings(i) := trim(substr(lv_str,1,pos-1)); '||unistr('\000a')||
'          '||unistr('\000a')||
'         -- remove chunk from string  '||unistr('\000a')||
'         lv_str := substr(lv_str,pos+1,length(lv_str)); '||unistr('\000a')||
'          '||unistr('\000a')||
' ';

s:=s||'        -- determine next chunk  '||unistr('\000a')||
'         pos := instr(lv_str,p_delim,1,1); '||unistr('\000a')||
'          '||unistr('\000a')||
'      END LOOP; '||unistr('\000a')||
'      -- add last (or only) chunk to array  '||unistr('\000a')||
'      IF pos = 0 THEN'||unistr('\000a')||
'          '||unistr('\000a')||
'         cnt := strings.COUNT;'||unistr('\000a')||
'         strings(cnt+1) := trim(lv_str); '||unistr('\000a')||
'      '||unistr('\000a')||
'      END IF; '||unistr('\000a')||
'       '||unistr('\000a')||
'      -- return array  '||unistr('\000a')||
'      RETURN strings; '||unistr('\000a')||
'       '||unistr('\000a')||
'   END SPLIT; '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "LOADE';

s:=s||'XTCMDB" '||unistr('\000a')||
'IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''LOADEXTCMDB'';'||unistr('\000a')||
'--    v_naam varchar2(255);'||unistr('\000a')||
'--    v_loopcnt number := 0;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table cmwbt0011'';'||unistr('\000a')||
'    FOR c1 IN (SELECT '||unistr('\000a')||
'    "TOEPASSINGOMGEVING", '||unistr('\000a')||
'    "STATUS_TOEPASSINGOMGEVING", '||unistr('\000a')||
'    "CMDB_REFERENTIE_OMGEVING", '||unistr('\000a')||
'    "VERSIE", '||unistr('\000a')||
'    "TYPE_OMGEVING", '||unistr('\000a')||
'    "DATUM_IN';

s:=s||'_GEBRUIK", '||unistr('\000a')||
'    "DATUM_BUITEN_GEBRUIK", '||unistr('\000a')||
'    "CMDB_REFERENTIE_BEDRIJFSTOEPAS", '||unistr('\000a')||
'    "NAAM_BEDRIJFSTOEPASSING", '||unistr('\000a')||
'    "NUMMER_BEDRIJFSTOEPASSING", '||unistr('\000a')||
'    "DIENSTENTYPE", '||unistr('\000a')||
'    "FINANCIEEL_BEHEERDER_BELEIDSD", '||unistr('\000a')||
'    "FINANCIEEL_BEHEERDER_ENTITEIT", '||unistr('\000a')||
'    "EIGENAAR_BELEIDSDOMEIN", '||unistr('\000a')||
'    "EIGENAAR_ENTITEIT", '||unistr('\000a')||
'    "STATUS_BEDRIJFSTOEPASSING", '||unistr('\000a')||
'    "SO_TOEPASSINGSMANAGERS", '||unistr('\000a')||
'    "VO_APPLICATIEBEHEERDERS", '||unistr('\000a')||
'   ';

s:=s||' "RELATIE", '||unistr('\000a')||
'    "CI_CATEGORIE", '||unistr('\000a')||
'    "CI_TYPE", '||unistr('\000a')||
'    "CI_CMDB_REFERENTIE", '||unistr('\000a')||
'    "CI_SYSTEEMNAAM", '||unistr('\000a')||
'    "CI_STATUS", '||unistr('\000a')||
'    "CI_EIGENAAR", '||unistr('\000a')||
'    "PRODUCENT", '||unistr('\000a')||
'    "PRODUCT", '||unistr('\000a')||
'    "SW_VERSIE", '||unistr('\000a')||
'    "OS", '||unistr('\000a')||
'    "VERSIE_OS", '||unistr('\000a')||
'    "HWSW", '||unistr('\000a')||
'    "LOCATIE", '||unistr('\000a')||
'    "KENMERKEN", '||unistr('\000a')||
'    "DIENST_SLA", '||unistr('\000a')||
'    "TP_FINANCIEEL_BEHEERDER", '||unistr('\000a')||
'    "UITDOVEND_DATUM", '||unistr('\000a')||
'    "UITGEDOOFD_DATUM", '||unistr('\000a')||
'    "OMGEVING"'||unistr('\000a')||
'    FROM EXT_CMWBT0';

s:=s||'011)'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'--        v_naam := REPLACE (c1.CI_SYSTEEMNAAM, CHR(0), '''');'||unistr('\000a')||
'--        p_log(proc_name, ''T'', ''Converting: '' || v_naam);'||unistr('\000a')||
'        INSERT INTO CMWBT0011 ('||unistr('\000a')||
'    TOEPASSINGOMGEVING, '||unistr('\000a')||
'    STATUS_TOEPASSINGOMGEVING, '||unistr('\000a')||
'    CMDB_REFERENTIE_OMGEVING, '||unistr('\000a')||
'    VERSIE, '||unistr('\000a')||
'    TYPE_OMGEVING, '||unistr('\000a')||
'    DATUM_IN_GEBRUIK, '||unistr('\000a')||
'    DATUM_BUITEN_GEBRUIK, '||unistr('\000a')||
'    CMDB_REFERENTIE_BEDRIJFSTOEPAS, '||unistr('\000a')||
'    NAAM_BEDRIJFSTOEPASSIN';

s:=s||'G, '||unistr('\000a')||
'    NUMMER_BEDRIJFSTOEPASSING, '||unistr('\000a')||
'    DIENSTENTYPE, '||unistr('\000a')||
'    FINANCIEEL_BEHEERDER_BELEIDSD, '||unistr('\000a')||
'    FINANCIEEL_BEHEERDER_ENTITEIT, '||unistr('\000a')||
'    EIGENAAR_BELEIDSDOMEIN, '||unistr('\000a')||
'    EIGENAAR_ENTITEIT, '||unistr('\000a')||
'    STATUS_BEDRIJFSTOEPASSING, '||unistr('\000a')||
'    SO_TOEPASSINGSMANAGERS, '||unistr('\000a')||
'    VO_APPLICATIEBEHEERDERS, '||unistr('\000a')||
'    RELATIE, '||unistr('\000a')||
'    CI_CATEGORIE, '||unistr('\000a')||
'    CI_TYPE, '||unistr('\000a')||
'    CI_CMDB_REFERENTIE, '||unistr('\000a')||
'    CI_SYSTEEMNAAM, '||unistr('\000a')||
'    CI_STATUS, '||unistr('\000a')||
'    CI_EIGENAAR, '||unistr('\000a')||
'  ';

s:=s||'  PRODUCENT, '||unistr('\000a')||
'    PRODUCT, '||unistr('\000a')||
'    SW_VERSIE, '||unistr('\000a')||
'    OS, '||unistr('\000a')||
'    VERSIE_OS, '||unistr('\000a')||
'    HWSW, '||unistr('\000a')||
'    LOCATIE, '||unistr('\000a')||
'    KENMERKEN, '||unistr('\000a')||
'    DIENST_SLA, '||unistr('\000a')||
'    TP_FINANCIEEL_BEHEERDER, '||unistr('\000a')||
'    UITDOVEND_DATUM, '||unistr('\000a')||
'    UITGEDOOFD_DATUM, '||unistr('\000a')||
'    OMGEVING)'||unistr('\000a')||
'        VALUES('||unistr('\000a')||
'    REPLACE (c1.TOEPASSINGOMGEVING, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.STATUS_TOEPASSINGOMGEVING, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CMDB_REFERENTIE_OMGEVING, CHR(0), ''''), '||unistr('\000a')||
'    R';

s:=s||'EPLACE (c1.VERSIE, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.TYPE_OMGEVING, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.DATUM_IN_GEBRUIK, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.DATUM_BUITEN_GEBRUIK, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CMDB_REFERENTIE_BEDRIJFSTOEPAS, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.NAAM_BEDRIJFSTOEPASSING, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.NUMMER_BEDRIJFSTOEPASSING, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.DIENSTENTYPE, CHR(0), ''''), '||unistr('\000a')||
'    ';

s:=s||'REPLACE (c1.FINANCIEEL_BEHEERDER_BELEIDSD, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.FINANCIEEL_BEHEERDER_ENTITEIT, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.EIGENAAR_BELEIDSDOMEIN, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.EIGENAAR_ENTITEIT, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.STATUS_BEDRIJFSTOEPASSING, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.SO_TOEPASSINGSMANAGERS, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.VO_APPLICATIEBEHEERDERS, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (';

s:=s||'c1.RELATIE, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CI_CATEGORIE, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CI_TYPE, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CI_CMDB_REFERENTIE, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CI_SYSTEEMNAAM, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CI_STATUS, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.CI_EIGENAAR, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.PRODUCENT, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.PRODUCT, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.SW_VERSIE, CHR(';

s:=s||'0), ''''), '||unistr('\000a')||
'    REPLACE (c1.OS, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.VERSIE_OS, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.HWSW, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.LOCATIE, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.KENMERKEN, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.DIENST_SLA, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.TP_FINANCIEEL_BEHEERDER, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.UITDOVEND_DATUM, CHR(0), ''''), '||unistr('\000a')||
'    REPLACE (c1.UITGEDOOFD_DATUM, CHR(0), ''''), '||unistr('\000a')||
'    REP';

s:=s||'LACE (c1.OMGEVING, CHR(0), '''')'||unistr('\000a')||
'  );'||unistr('\000a')||
'    END LOOP;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_APPS_CHECK" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_apps_check'';'||unistr('\000a')||
'    limitcnt number := 0;'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR apps_cursor IS'||unistr('\000a')||
'    select *'||unistr('\000a')||
'    from COMPONENT'||unistr('\000a')||
'    where CI_class = ''toepassingcomponentinstallatie'';'||unistr('\000a')||
'    apps component%ROWTYPE;'||unistr('\000a')||
'    TYPE re';

wwv_flow_api.create_install_script(
  p_id => 71349331904163432 + wwv_flow_api.g_id_offset,
  p_flow_id => wwv_flow.g_flow_id,
  p_install_id=> 57642914643979300 + wwv_flow_api.g_id_offset,
  p_name => 'Raming_DC_Migratie',
  p_sequence=> 10,
  p_script_type=> 'INSTALL',
  p_script_clob=> s);
end;
 
 
end;
/

 
begin
 
declare
    s varchar2(32767) := null;
begin
s:=s||'l_rec IS RECORD ('||unistr('\000a')||
'        cmdb_id component.cmdb_id%TYPE,'||unistr('\000a')||
'        naam component.naam%TYPE);'||unistr('\000a')||
'    TYPE eosl_rec IS RECORD ('||unistr('\000a')||
'        uitdovend_datum DATE,'||unistr('\000a')||
'        uitgedoofd_datum DATE);'||unistr('\000a')||
'    TYPE fct_rec IS RECORD ('||unistr('\000a')||
'        uitdovend kostelementen.waarde%TYPE,'||unistr('\000a')||
'        uitgedoofd kostelementen.waarde%TYPE);'||unistr('\000a')||
'    eosl eosl_rec;'||unistr('\000a')||
'    cut_eosl eosl_rec;'||unistr('\000a')||
'    rel rel_rec;'||unistr('\000a')||
'    fct fct_rec;'||unistr('\000a')||
'    v_loopcnt numb';

s:=s||'er;'||unistr('\000a')||
'    v_msg apps_checks.msgstr%TYPE;'||unistr('\000a')||
'    v_sw_cnt apps_checks.sw_cnt%TYPE;'||unistr('\000a')||
'    v_sw_cnt_bou apps_checks.sw_cnt_bou%TYPE;'||unistr('\000a')||
'    v_job_cnt apps_checks.job_cnt%TYPE;'||unistr('\000a')||
'    v_job_cnt_bou apps_checks.job_cnt_bou%TYPE;'||unistr('\000a')||
'    v_assessment apps_checks.assessment%TYPE;'||unistr('\000a')||
'    v_migratie apps_checks.migratie%TYPE;'||unistr('\000a')||
'    v_connections apps_checks.connections%TYPE;'||unistr('\000a')||
'    v_comp apps_checks.comp%TYPE;'||unistr('\000a')||
'    v_no_comp apps_';

s:=s||'checks.no_comp%TYPE;'||unistr('\000a')||
'    v_mgmt_waarde kostelementen.waarde%TYPE := -1;'||unistr('\000a')||
'    v_arch_waarde kostelementen.waarde%TYPE := -1;'||unistr('\000a')||
'    v_def_waarde kostelementen.waarde%TYPE := -1;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION get_smallest(left_date IN DATE, right_date IN DATE)'||unistr('\000a')||
'    RETURN date'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF ((length(left_date) > 2) AND (length(right_date) >';

s:=s||' 2)) THEN'||unistr('\000a')||
'           RETURN least(left_date, right_date);'||unistr('\000a')||
'        ELSIF (length(left_date) IS NULL) THEN'||unistr('\000a')||
'            RETURN right_date;'||unistr('\000a')||
'        ELSE'||unistr('\000a')||
'            RETURN left_date;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    -- Find EOSL information for this CMDB ID. '||unistr('\000a')||
'    -- Verify if uitdovend_date / uitgedoofd_date is OLDER than what is known already'||unistr('\000a')||
'    -- Remember oldest date.'||unistr('\000a')||
'    PROCEDURE handle_eosl(in_cmdb';

s:=s||'_id IN component.cmdb_id%TYPE, in_eosl IN OUT eosl_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        ci_eosl eosl_rec;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        -- There should be only one record in cons_eosl, '||unistr('\000a')||
'        -- but to be on the safe side....'||unistr('\000a')||
'        SELECT min(uitdovend_datum), min(uitgedoofd_datum)'||unistr('\000a')||
'        INTO ci_eosl'||unistr('\000a')||
'        FROM cons_eosl'||unistr('\000a')||
'        WHERE cmdb_id = in_cmdb_id;'||unistr('\000a')||
'        in_eosl.uitdovend_datum  := get_smallest(ci_eosl.uitdo';

s:=s||'vend_datum,  in_eosl.uitdovend_datum);'||unistr('\000a')||
'        in_eosl.uitgedoofd_datum := get_smallest(ci_eosl.uitgedoofd_datum, in_eosl.uitgedoofd_datum);'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'        -- No issue when no data is found'||unistr('\000a')||
'        RETURN;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE go_down(next_rel IN rel_rec, in_eosl IN OUT eosl_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        CURSOR src_rel_cursor IS'||unistr('\000a')||
'        SELECT CMDB_ID_TARGET,'||unistr('\000a')||
'       ';

s:=s||'        NAAM_TARGET,'||unistr('\000a')||
'               CI_TYPE_TARGET,'||unistr('\000a')||
'               CI_CATEGORIE_TARGET'||unistr('\000a')||
'        FROM RELATIONS'||unistr('\000a')||
'        WHERE CMDB_ID_SOURCE = next_rel.cmdb_id'||unistr('\000a')||
'          AND RELATION = ''is afhankelijk van'';'||unistr('\000a')||
'        TYPE src_rel_type IS RECORD ('||unistr('\000a')||
'            cmdb_id relations.cmdb_id_target%TYPE,'||unistr('\000a')||
'            naam relations.naam_target%TYPE,'||unistr('\000a')||
'            ci_type relations.ci_type_target%TYPE,'||unistr('\000a')||
'          ';

s:=s||'  ci_categorie relations.ci_categorie_target%TYPE);'||unistr('\000a')||
'        src_rel src_rel_type;'||unistr('\000a')||
'        this_sw sw_checks%ROWTYPE;'||unistr('\000a')||
'        thislocation number;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_loopcnt := v_loopcnt + 1;'||unistr('\000a')||
'        IF v_loopcnt > 100 THEN'||unistr('\000a')||
'            p_log(proc_name, ''F'', ''Loop Count exceeded'');'||unistr('\000a')||
'            RETURN;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        '||unistr('\000a')||
'        OPEN src_rel_cursor;'||unistr('\000a')||
'        LOOP'||unistr('\000a')||
'            FETCH src_rel_curso';

s:=s||'r INTO src_rel;'||unistr('\000a')||
'            EXIT WHEN src_rel_cursor%NOTFOUND;'||unistr('\000a')||
'            -- Get Derived Location for this component'||unistr('\000a')||
'            SELECT count(*) INTO thislocation'||unistr('\000a')||
'            FROM derived_locations'||unistr('\000a')||
'            WHERE cmdb_id = src_rel.cmdb_id;'||unistr('\000a')||
'            -- Handle EOSL Information for this CI.'||unistr('\000a')||
'            handle_eosl(src_rel.cmdb_id, in_eosl);'||unistr('\000a')||
'            IF ((src_rel.ci_type = ''ANDERE TOEP.COMP.';

s:=s||'INSTALL.'') OR'||unistr('\000a')||
'                (src_rel.ci_type = ''DB TOEP.COMP-INSTALL.'') OR'||unistr('\000a')||
'                (src_rel.ci_type = ''RAPPORTEN'') OR'||unistr('\000a')||
'                (src_rel.ci_type = ''TOEP.COMP. COLLAB. SYST.'') OR'||unistr('\000a')||
'                (src_rel.ci_type = ''WEB TOEP.COMP-INSTALL.'')) THEN'||unistr('\000a')||
'                v_sw_cnt := v_sw_cnt + 1;'||unistr('\000a')||
'                IF (thislocation > 0) THEN'||unistr('\000a')||
'                    v_sw_cnt_bou := v_sw_cnt_bou + 1;'||unistr('\000a')||
'';

s:=s||'                END IF;'||unistr('\000a')||
'                SELECT * INTO this_sw'||unistr('\000a')||
'                FROM sw_checks'||unistr('\000a')||
'                WHERE sw_id = src_rel.cmdb_id;'||unistr('\000a')||
'            ELSIF (src_rel.ci_type like ''JOB%'') THEN'||unistr('\000a')||
'                v_job_cnt := v_job_cnt + 1;'||unistr('\000a')||
'                IF (thislocation > 0) THEN'||unistr('\000a')||
'                    v_job_cnt_bou := v_job_cnt_bou + 1;'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'                SELECT * INTO this_sw'||unistr('\000a')||
'  ';

s:=s||'              FROM job_checks'||unistr('\000a')||
'                WHERE sw_id = src_rel.cmdb_id;'||unistr('\000a')||
'            ELSE'||unistr('\000a')||
'                v_msg := v_msg || ''SW/Job Component verwacht, '' || src_rel.ci_type || '' gevonden. ID: '' || src_rel.cmdb_id;'||unistr('\000a')||
'                GOTO unexpected_record_next;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'            IF (this_sw.connections > 0) THEN'||unistr('\000a')||
'                v_connections := v_connections + this_sw.connections;'||unistr('\000a')||
' ';

s:=s||'           END IF;'||unistr('\000a')||
'            IF (this_sw.assessment > 0) THEN'||unistr('\000a')||
'                v_assessment := v_assessment + this_sw.assessment;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'            IF (thislocation > 0) THEN'||unistr('\000a')||
'                IF (this_sw.migratie > 0) THEN'||unistr('\000a')||
'                    v_migratie := v_migratie + this_sw.migratie;'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'            IF (length(this_sw.comp_naam) > 0) THEN'||unistr('\000a')||
'  ';

s:=s||'              v_comp := v_comp + 1;'||unistr('\000a')||
'            ELSE '||unistr('\000a')||
'                v_no_comp := v_no_comp + 1;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'            -- Remember Applicatie - Component Link'||unistr('\000a')||
'            INSERT INTO apps_cis (cmdb_id_src, naam_src, '||unistr('\000a')||
'                cmdb_id_tgt, naam_tgt, ci_type_tgt, ci_categorie_tgt)'||unistr('\000a')||
'            VALUES (next_rel.cmdb_id, next_rel.naam, '||unistr('\000a')||
'                src_rel.cmdb_id, src_rel.naam, s';

s:=s||'rc_rel.ci_type, src_rel.ci_categorie);'||unistr('\000a')||
'            <<unexpected_record_next>>'||unistr('\000a')||
'            NULL;'||unistr('\000a')||
'        END LOOP;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    FUNCTION get_eosl_factor(eosl IN eosl_rec)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_eosl_factor number := 0;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF (length(eosl.uitgedoofd_datum) > 2) THEN'||unistr('\000a')||
'            IF (eosl.uitgedoofd_datum < cut_eosl.uitgedoofd_datum) THEN'||unistr('\000a')||
'                v_eosl_factor := fct';

s:=s||'.uitgedoofd;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        IF (length(eosl.uitdovend_datum) > 2) THEN'||unistr('\000a')||
'            IF (eosl.uitdovend_datum < cut_eosl.uitdovend_datum) THEN'||unistr('\000a')||
'                IF (fct.uitdovend > v_eosl_factor) THEN'||unistr('\000a')||
'                    v_eosl_factor := fct.uitdovend;'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        RETURN v_eosl_factor;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE save_resu';

s:=s||'lts(apps IN component%ROWTYPE, in_eosl IN eosl_rec) '||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_work_kost number := 0;'||unistr('\000a')||
'        v_project_kost apps_checks.project_kost%TYPE;'||unistr('\000a')||
'        v_eosl_kost apps_checks.eosl_kost%TYPE;'||unistr('\000a')||
'        v_totale_kost apps_checks.totale_kost%TYPE;'||unistr('\000a')||
'        v_eosl_factor number;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF (v_comp = 0)  THEN'||unistr('\000a')||
'            v_msg := v_msg || ''Applicatie kan niet aan computer gelinkt worden. * ''';

s:=s||';'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        IF (v_sw_cnt_bou = 0) THEN'||unistr('\000a')||
'            v_assessment := 0;'||unistr('\000a')||
'            v_migratie := 0;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        -- Default cost if only Job Components on path from computer to application'||unistr('\000a')||
'        IF ((v_job_cnt_bou > 0) AND ((v_assessment + v_migratie ) = 0)) THEN'||unistr('\000a')||
'            v_assessment := v_def_waarde;'||unistr('\000a')||
'            v_migratie := v_def_waarde;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        v_eo';

s:=s||'sl_factor := get_eosl_factor(in_eosl);'||unistr('\000a')||
'        v_eosl_kost := v_assessment * v_eosl_factor;'||unistr('\000a')||
'        v_work_kost := v_assessment + v_migratie + v_eosl_kost;'||unistr('\000a')||
'        v_project_kost := (v_work_kost * v_mgmt_waarde) + (v_work_kost * v_arch_waarde);'||unistr('\000a')||
'        v_totale_kost := v_assessment + v_migratie + v_eosl_kost + v_project_kost;'||unistr('\000a')||
'        INSERT INTO apps_checks (cmdb_id, naam, dienstentype, eigenaar_b';

s:=s||'eleidsdomein, '||unistr('\000a')||
'             eigenaar_entiteit, fin_beleidsdomein, fin_entiteit,'||unistr('\000a')||
'             connections, comp, no_comp, sw_cnt, sw_cnt_bou, job_cnt, '||unistr('\000a')||
'             job_cnt_bou, assessment, migratie, eosl_kost, project_kost, totale_kost, '||unistr('\000a')||
'             so_toepassingsmanager, vo_applicatiebeheerder, msgstr)'||unistr('\000a')||
'        VALUES (apps.cmdb_id, apps.naam, apps.dienstentype, apps.eigenaar_beleidsdomein, '||unistr('\000a')||
'    ';

s:=s||'         apps.eigenaar_entiteit, apps.fin_beleidsdomein, apps.fin_entiteit,'||unistr('\000a')||
'             v_connections, v_comp, v_no_comp, v_sw_cnt, v_sw_cnt_bou, v_job_cnt, '||unistr('\000a')||
'             v_job_cnt_bou, v_assessment, v_migratie, v_eosl_kost, v_project_kost, v_totale_kost, '||unistr('\000a')||
'             apps.so_toepassingsmanager, apps.vo_applicatiebeheerder, v_msg);'||unistr('\000a')||
'    END;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'   ';

s:=s||' '||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table apps_checks'';'||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table apps_cis'';'||unistr('\000a')||
'    -- Get values from kostelementen'||unistr('\000a')||
'    SELECT waarde INTO v_mgmt_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Management'';'||unistr('\000a')||
'    SELECT waarde INTO v_arch_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Architectuur'';'||unistr('\000a')||
'    SELECT';

s:=s||' waarde INTO v_def_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Default'';'||unistr('\000a')||
'    SELECT datum, waarde'||unistr('\000a')||
'    INTO cut_eosl.uitdovend_datum, fct.uitdovend'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''uitdovend'';'||unistr('\000a')||
'    SELECT datum, waarde'||unistr('\000a')||
'    INTO cut_eosl.uitgedoofd_datum, fct.uitgedoofd'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''uitgedoofd'';'||unistr('\000a')||
'    OPEN apps_cursor;'||unistr('\000a')||
'    L';

s:=s||'OOP'||unistr('\000a')||
'        FETCH apps_cursor INTO apps;'||unistr('\000a')||
'        EXIT WHEN apps_cursor%NOTFOUND;'||unistr('\000a')||
'        -- limitcnt := limitcnt + 1;'||unistr('\000a')||
'        -- EXIT WHEN limitcnt > 5;'||unistr('\000a')||
'        -- dbms_output.put_line(''Investigate '' || sw_comp.naam);'||unistr('\000a')||
'        -- Reset variables'||unistr('\000a')||
'        v_loopcnt := 0;'||unistr('\000a')||
'        v_msg := '''';'||unistr('\000a')||
'        v_sw_cnt := 0;'||unistr('\000a')||
'        v_sw_cnt_bou := 0;'||unistr('\000a')||
'        v_job_cnt := 0;'||unistr('\000a')||
'        v_job_cnt_bou := 0;'||unistr('\000a')||
'        ';

s:=s||'v_assessment := 0;'||unistr('\000a')||
'        v_migratie := 0;'||unistr('\000a')||
'        v_connections := 0;'||unistr('\000a')||
'        eosl.uitdovend_datum := '''';'||unistr('\000a')||
'        eosl.uitgedoofd_datum := '''';'||unistr('\000a')||
'        '||unistr('\000a')||
'        rel.cmdb_id := apps.cmdb_id;'||unistr('\000a')||
'        rel.naam := apps.naam;'||unistr('\000a')||
'        go_down(rel, eosl);'||unistr('\000a')||
'        save_results(apps, eosl);'||unistr('\000a')||
'        '||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_m';

s:=s||'sg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_CALCULATE" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    '||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_calculate'';'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'';

s:=s||'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling sw_component_checks'');'||unistr('\000a')||
'    p_sw_component_checks;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling job_checks''); '||unistr('\000a')||
'    p_job_checks;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling system_checks'');'||unistr('\000a')||
'    p_system_checks;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling apps_checks'');'||unistr('\000a')||
'    p_apps_check;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling system_cost'');'||unistr('\000a')||
'  ';

s:=s||'  p_system_cost;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling system_used_by'');'||unistr('\000a')||
'    p_system_used_by;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'    '||unistr('\000a')||
'/'||unistr('\000a')||
'';

s:=s||''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_CHECK_CMWBT0011" '||unistr('\000a')||
'IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_check_cmwbt0011'';'||unistr('\000a')||
'    v_invalid_rec number;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    SELECT count(*) '||unistr('\000a')||
'    INTO v_invalid_rec'||unistr('\000a')||
'    FROM cmwbt0011'||unistr('\000a')||
'    WHERE (not relatie like ''%=%'')'||unistr('\000a')||
'    OR (relatie is null);'||unistr('\000a')||
'    p_log(proc_name, ''I'', v_invalid_rec || '' invalid records found'');'||unistr('\000a')||
'    ';

s:=s||'IF (v_invalid_rec > 0) THEN'||unistr('\000a')||
'        p_log(proc_name, ''T'', ''Trying to delete the records'');'||unistr('\000a')||
'        DELETE '||unistr('\000a')||
'        FROM cmwbt0011'||unistr('\000a')||
'        WHERE (not relatie like ''%=%'')'||unistr('\000a')||
'           OR (relatie is null);'||unistr('\000a')||
'    END IF;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_CONVERT_DATA" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_convert_data'';'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_l';

s:=s||'og(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling p_get_cmwbt0011_data'');'||unistr('\000a')||
'    p_get_cmwbt0011_data;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling p_get_cmwbt0011_rel'');'||unistr('\000a')||
'    p_get_cmwbt0011_rel;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_BT" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    '||unistr('\000a')||
'    proc_name logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_bt'';'||unistr('\000a')||
'    CURSOR bt_';

s:=s||'cursor IS'||unistr('\000a')||
'    select DISTINCT CMDB_REFERENTIE_BEDRIJFSTOEPAS,'||unistr('\000a')||
'                    NAAM_BEDRIJFSTOEPASSING,'||unistr('\000a')||
'                    NUMMER_BEDRIJFSTOEPASSING,'||unistr('\000a')||
'                    SO_TOEPASSINGSMANAGERS,'||unistr('\000a')||
'                    VO_APPLICATIEBEHEERDERS '||unistr('\000a')||
'    from CMWBT0011'||unistr('\000a')||
'    where length(NAAM_BEDRIJFSTOEPASSING) > 0;'||unistr('\000a')||
'    TYPE bt_record IS RECORD ('||unistr('\000a')||
'        CMDB_ID cmwbt0011.CMDB_REFERENTIE_BEDRIJFSTOEPAS%TYP';

s:=s||'E,'||unistr('\000a')||
'        NAAM component.NAAM%TYPE,'||unistr('\000a')||
'        BT_NUMMER component.BT_NUMMER%TYPE,'||unistr('\000a')||
'        SO_TOEPASSINGSMANAGER component.SO_TOEPASSINGSMANAGER%TYPE,'||unistr('\000a')||
'        VO_APPLICATIEBEHEERDER component.VO_APPLICATIEBEHEERDER%TYPE);'||unistr('\000a')||
'    v_cmdb_id component.cmdb_id%TYPE;'||unistr('\000a')||
'    bt bt_record;'||unistr('\000a')||
'    c_ci_class CONSTANT component.CI_CLASS%TYPE := ''bedrijfstoepassing'';'||unistr('\000a')||
'    v_not_num_cnt number := 999000;'||unistr('\000a')||
'    err_num num';

s:=s||'ber;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION convert2number (v_str IN varchar2)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_nr number;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_nr := to_number(v_str);'||unistr('\000a')||
'        RETURN v_nr;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN VALUE_ERROR THEN'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Waarde niet numeriek! *'' || v_str || ''*'');'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN';

s:=s||' v_not_num_cnt;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''convert2number fout nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    OPEN bt_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'  ';

s:=s||'      FETCH bt_cursor INTO bt;'||unistr('\000a')||
'        EXIT WHEN bt_cursor%NOTFOUND;'||unistr('\000a')||
'        v_cmdb_id := convert2number(bt.cmdb_id);'||unistr('\000a')||
'        v_cmdb_id := v_cmdb_id + 1000000;'||unistr('\000a')||
'        INSERT INTO component (ci_class, naam, cmdb_id, bt_nummer, so_toepassingsmanager, vo_applicatiebeheerder)'||unistr('\000a')||
'        VALUES (c_ci_class, bt.naam, v_cmdb_id, bt.bt_nummer, bt.so_toepassingsmanager, bt.vo_applicatiebeheerder);'||unistr('\000a')||
'    END LO';

s:=s||'OP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_COMP" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    '||unistr('\000a')||
'    proc_name logtbl.evt_pro';

s:=s||'c%TYPE := ''p_get_cmwbt0011_comp'';'||unistr('\000a')||
'    CURSOR comp_cursor IS'||unistr('\000a')||
'    select DISTINCT CI_CATEGORIE,'||unistr('\000a')||
'           CI_TYPE,'||unistr('\000a')||
'           CI_CMDB_REFERENTIE,'||unistr('\000a')||
'           CI_SYSTEEMNAAM,'||unistr('\000a')||
'           CI_STATUS,'||unistr('\000a')||
'           CI_EIGENAAR,'||unistr('\000a')||
'           KENMERKEN,'||unistr('\000a')||
'           PRODUCENT,'||unistr('\000a')||
'           PRODUCT,'||unistr('\000a')||
'           SW_VERSIE,'||unistr('\000a')||
'           OS,'||unistr('\000a')||
'           VERSIE_OS,'||unistr('\000a')||
'           HWSW,'||unistr('\000a')||
'           LOCATIE,'||unistr('\000a')||
'           OMGEVING,'||unistr('\000a')||
' ';

s:=s||'          UITDOVEND_DATUM,'||unistr('\000a')||
'           UITGEDOOFD_DATUM'||unistr('\000a')||
'    from CMWBT0011;'||unistr('\000a')||
'    TYPE comp_record IS RECORD ('||unistr('\000a')||
'    ci_categorie component.ci_categorie%TYPE,'||unistr('\000a')||
'    ci_type component.ci_type%TYPE,'||unistr('\000a')||
'    CMDB_ID cmwbt0011.CI_CMDB_REFERENTIE%TYPE,'||unistr('\000a')||
'    NAAM component.NAAM%TYPE,'||unistr('\000a')||
'    status component.status%TYPE,'||unistr('\000a')||
'    eigenaar_entiteit component.eigenaar_entiteit%TYPE,'||unistr('\000a')||
'    kenmerken component.kenmerken%TYPE,'||unistr('\000a')||
'   ';

s:=s||' producent component.producent%TYPE,'||unistr('\000a')||
'    product component.product%TYPE,'||unistr('\000a')||
'    versie component.versie%TYPE,'||unistr('\000a')||
'    os component.os%TYPE,'||unistr('\000a')||
'    os_versie component.os_versie%TYPE,'||unistr('\000a')||
'    hw_sw_flag component.hw_sw_flag%TYPE,'||unistr('\000a')||
'    locatie component.locatie%TYPE,'||unistr('\000a')||
'    omgeving component.omgeving%TYPE,'||unistr('\000a')||
'    uitdovend_datum cmwbt0011.uitdovend_datum%TYPE,'||unistr('\000a')||
'    uitgedoofd_datum cmwbt0011.uitgedoofd_datum%TYPE);'||unistr('\000a')||
'    ';

s:=s||''||unistr('\000a')||
'    comp comp_record;'||unistr('\000a')||
'    v_cmdb_id component.cmdb_id%TYPE;'||unistr('\000a')||
'    v_uitdovend_datum component.uitdovend_datum%TYPE;'||unistr('\000a')||
'    v_uitgedoofd_datum component.uitgedoofd_datum%TYPE;'||unistr('\000a')||
'    v_not_num_cnt number := 999000;'||unistr('\000a')||
'    v_no_date date := ''21/07/1963'';'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION convert2number (v_str IN varchar2)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_nr num';

s:=s||'ber;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_nr := to_number(v_str);'||unistr('\000a')||
'        RETURN v_nr;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN VALUE_ERROR THEN'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Waarde niet numeriek! *'' || v_str || ''*'');'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'            p_log(proc_';

s:=s||'name, ''E'', ''convert2number fout nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'    FUNCTION convert2date (v_str IN varchar2)'||unistr('\000a')||
'    RETURN date'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_nr date;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_nr := to_date(v_str, ''yyyy/mm/dd  HH24:MI:SS'');'||unistr('\000a')||
'        RETURN v_nr;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN VALUE_ERROR THEN'||unistr('\000a')||
'         ';

s:=s||'   p_log(proc_name, ''E'', ''Waarde geen datum! *'' || v_str || ''*'');'||unistr('\000a')||
'            RETURN v_no_date;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''convert2number fout nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'            RETURN v_no_date;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'   ';

s:=s||' OPEN comp_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH comp_cursor INTO comp;'||unistr('\000a')||
'        EXIT WHEN comp_cursor%NOTFOUND;'||unistr('\000a')||
'        v_cmdb_id := convert2number(comp.cmdb_id);'||unistr('\000a')||
'        v_uitdovend_datum := convert2date(comp.uitdovend_datum);'||unistr('\000a')||
'        v_uitgedoofd_datum := convert2date(comp.uitgedoofd_datum);'||unistr('\000a')||
'        INSERT INTO component (ci_categorie, ci_type, cmdb_id, naam, status,'||unistr('\000a')||
'                               eige';

s:=s||'naar_entiteit, producent, product, versie, os, os_versie,'||unistr('\000a')||
'                               hw_sw_flag, locatie, kenmerken, omgeving,'||unistr('\000a')||
'                               uitdovend_datum, uitgedoofd_datum)'||unistr('\000a')||
'        VALUES (comp.ci_categorie, comp.ci_type, v_cmdb_id, comp.naam, comp.status,'||unistr('\000a')||
'                comp.eigenaar_entiteit, comp.producent, comp.product, comp.versie, comp.os, comp.os_versie,'||unistr('\000a')||
'           ';

s:=s||'     comp.hw_sw_flag, comp.locatie, comp.kenmerken, comp.omgeving,'||unistr('\000a')||
'                v_uitdovend_datum, v_uitgedoofd_datum);'||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' ';

s:=s||'|| err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_DATA" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_data'';'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table component'';'||unistr('\000a')||
'    p_get_cmwbt0011_tpo;'||unistr('\000a')||
'    p_get_cmwbt0011_bt;'||unistr('\000a')||
'    p_get_cmwbt0011_comp;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'';

s:=s||'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_rel'';'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table relations'';'||unistr('\000a')||
'    p_get_cmwbt0011_rel_tpo_bt;'||unistr('\000a')||
'    p_get_cmwbt0011_rel_comp;'||unistr('\000a')||
'    p_get_cmwbt0011_rel_loops;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR RE';

s:=s||'PLACE PROCEDURE  "P_GET_CMWBT0011_REL_COMP" '||unistr('\000a')||
'IS '||unistr('\000a')||
'    proc_name logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_rel_comp'';'||unistr('\000a')||
'    CURSOR rel_cursor IS'||unistr('\000a')||
'    select TOEPASSINGOMGEVING,'||unistr('\000a')||
'           CMDB_REFERENTIE_OMGEVING,'||unistr('\000a')||
'           RELATIE,'||unistr('\000a')||
'           CI_TYPE,'||unistr('\000a')||
'           CI_CATEGORIE,'||unistr('\000a')||
'           CI_CMDB_REFERENTIE,'||unistr('\000a')||
'           CI_SYSTEEMNAAM '||unistr('\000a')||
'    from CMWBT0011'||unistr('\000a')||
'    order by ID ASC;'||unistr('\000a')||
'    TYPE rel_record IS RECORD';

s:=s||' ('||unistr('\000a')||
'        naam_tpo relations.naam_source%TYPE,'||unistr('\000a')||
'        cmdb_id_tpo cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,'||unistr('\000a')||
'        relatie relations.relation%TYPE,'||unistr('\000a')||
'        ci_type relations.ci_type_target%TYPE,'||unistr('\000a')||
'        ci_categorie relations.ci_categorie_target%TYPE,'||unistr('\000a')||
'        cmdb_id cmwbt0011.CI_CMDB_REFERENTIE%TYPE,'||unistr('\000a')||
'        naam relations.naam_target%TYPE);'||unistr('\000a')||
'    rel rel_record;'||unistr('\000a')||
'    relation relations.relation%T';

s:=s||'YPE;'||unistr('\000a')||
'    l_level number;'||unistr('\000a')||
'    l_level_prev number;'||unistr('\000a')||
'    thisrel relations%ROWTYPE;'||unistr('\000a')||
'    v_limitcnt number := 0;'||unistr('\000a')||
'    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);'||unistr('\000a')||
'    allvalues allvalues_type;'||unistr('\000a')||
'    TYPE comp_rec IS RECORD ('||unistr('\000a')||
'        cmdb_id relations.cmdb_id_source%TYPE,'||unistr('\000a')||
'        naam relations.naam_source%TYPE,'||unistr('\000a')||
'        ci_type relations.ci_type_source%TYPE,'||unistr('\000a')||
'        ci_categorie relation';

s:=s||'s.ci_categorie_source%TYPE);'||unistr('\000a')||
'   '||unistr('\000a')||
'    TYPE rel_hash_type IS TABLE OF comp_rec INDEX BY BINARY_INTEGER;'||unistr('\000a')||
'    rel_hash rel_hash_type;'||unistr('\000a')||
'    '||unistr('\000a')||
'    v_not_num_cnt number := 999000;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION convert2number (v_str IN varchar2)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_nr number;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_nr := to_number(v_str);'||unistr('\000a')||
'        RETURN v_nr;'||unistr('\000a')||
'  ';

s:=s||'  EXCEPTION'||unistr('\000a')||
'        WHEN VALUE_ERROR THEN'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Waarde niet numeriek! *'' || v_str || ''*'');'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''convert2number fout nr: '' || err_num || '' msg: '' || err_msg)';

s:=s||';'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'    PROCEDURE handle_relation (currvalues IN OUT allvalues_type, rec2hdl IN relations%ROWTYPE)  '||unistr('\000a')||
'    IS'||unistr('\000a')||
'        valuestr varchar2(255);'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        valuestr := to_char(rec2hdl.cmdb_id_source) || ''.'' || rec2hdl.relation || ''.'' || to_char(rec2hdl.cmdb_id_target);'||unistr('\000a')||
'        IF NOT currvalues.EXISTS(v';

s:=s||'aluestr) THEN'||unistr('\000a')||
'            -- Found Unique String, remember it and add it to the relations table'||unistr('\000a')||
'            currvalues(valuestr) := 1;'||unistr('\000a')||
'            INSERT INTO relations (cmdb_id_source, naam_source, ci_type_source, CI_CATEGORIE_SOURCE,'||unistr('\000a')||
'                                   relation,'||unistr('\000a')||
'                                   cmdb_id_target, naam_target, ci_type_target, CI_CATEGORIE_TARGET)'||unistr('\000a')||
'            VALUES';

s:=s||' (rec2hdl.cmdb_id_source, rec2hdl.naam_source, rec2hdl.ci_type_source, rec2hdl.CI_CATEGORIE_SOURCE,'||unistr('\000a')||
'                    rec2hdl.relation,'||unistr('\000a')||
'                    rec2hdl.cmdb_id_target, rec2hdl.naam_target, rec2hdl.ci_type_target, rec2hdl.CI_CATEGORIE_TARGET);'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE store_level (curr_level IN number, rel IN rel_record, rel_hash IN OUT rel_hash_type)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'  ';

s:=s||'      rel_hash(curr_level).cmdb_id := convert2number(rel.cmdb_id);'||unistr('\000a')||
'        rel_hash(curr_level).naam    := rel.naam;'||unistr('\000a')||
'        rel_hash(curr_level).ci_type := rel.ci_type;'||unistr('\000a')||
'        rel_hash(curr_level).ci_categorie := rel.ci_categorie;'||unistr('\000a')||
'        FOR cnt IN curr_level + 1 .. rel_hash.COUNT LOOP'||unistr('\000a')||
'            rel_hash.DELETE(cnt);'||unistr('\000a')||
'        END LOOP;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure''';

s:=s||');'||unistr('\000a')||
'    '||unistr('\000a')||
'    OPEN rel_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH rel_cursor INTO rel;'||unistr('\000a')||
'        EXIT WHEN rel_cursor%NOTFOUND;'||unistr('\000a')||
'        -- v_limitcnt := v_limitcnt + 1;'||unistr('\000a')||
'        -- EXIT WHEN v_limitcnt > 5;'||unistr('\000a')||
'         '||unistr('\000a')||
'        select regexp_substr( rel.relatie, ''[0-9]+'' ) INTO l_level from dual;  -- Get the level of the relation'||unistr('\000a')||
'        -- Check for Relation details'||unistr('\000a')||
'        IF INSTR(rel.relatie, ''G'') > 0 THEN'||unistr('\000a')||
'      ';

s:=s||'      relation := ''maakt gebruik van'';'||unistr('\000a')||
'        ELSE'||unistr('\000a')||
'            relation := ''is afhankelijk van'';'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        IF l_level = 1 THEN'||unistr('\000a')||
'            thisrel.cmdb_id_target := convert2number(rel.cmdb_id);'||unistr('\000a')||
'            thisrel.naam_target := rel.naam;'||unistr('\000a')||
'            thisrel.ci_type_target := rel.ci_type;'||unistr('\000a')||
'            thisrel.ci_categorie_target := rel.ci_categorie;'||unistr('\000a')||
'            thisrel.relation := re';

s:=s||'lation;'||unistr('\000a')||
'            thisrel.cmdb_id_source := convert2number(rel.cmdb_id_tpo);'||unistr('\000a')||
'            thisrel.naam_source := rel.naam_tpo;'||unistr('\000a')||
'            thisrel.ci_type_source := ''Toepassingomgeving'';'||unistr('\000a')||
'            thisrel.ci_categorie_source := '''';'||unistr('\000a')||
'            -- Only handle relation for cmdb_id_tpo > 0, don''t handle empty relations'||unistr('\000a')||
'            IF (rel.cmdb_id_tpo > 0) THEN'||unistr('\000a')||
'                handle_relation(allva';

s:=s||'lues, thisrel);'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'            store_level(l_level, rel, rel_hash);'||unistr('\000a')||
'       '||unistr('\000a')||
'        ELSE'||unistr('\000a')||
'            '||unistr('\000a')||
'            l_level_prev := l_level - 1;'||unistr('\000a')||
'            IF rel_hash.EXISTS(l_level_prev) THEN'||unistr('\000a')||
'                thisrel.cmdb_id_source := rel_hash(l_level_prev).cmdb_id;'||unistr('\000a')||
'                thisrel.naam_source := rel_hash(l_level_prev).naam;'||unistr('\000a')||
'                thisrel.ci_type_source := rel_ha';

s:=s||'sh(l_level_prev).ci_type;'||unistr('\000a')||
'                thisrel.ci_categorie_source := rel_hash(l_level_prev).ci_categorie;'||unistr('\000a')||
'                thisrel.relation := relation;'||unistr('\000a')||
'                thisrel.cmdb_id_target := convert2number(rel.cmdb_id);'||unistr('\000a')||
'                thisrel.naam_target := rel.naam;'||unistr('\000a')||
'                thisrel.ci_type_target := rel.ci_type;'||unistr('\000a')||
'                thisrel.ci_categorie_target := rel.ci_categorie;'||unistr('\000a')||
'    ';

s:=s||'            handle_relation(allvalues, thisrel);'||unistr('\000a')||
'                store_level(l_level, rel, rel_hash);'||unistr('\000a')||
'            ELSE'||unistr('\000a')||
'                p_log(proc_name, ''F'', ''Could not find previous level'');'||unistr('\000a')||
'                EXIT;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'    '||unistr('\000a')||
'        END IF;     '||unistr('\000a')||
'                '||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLER';

s:=s||'RM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL_LOOPS" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    '||unistr('\000a')||
'    proc_name logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_rel_loops'';'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR looprel_cursor IS'||unistr('\000a')||
'    SELECT a.cmdb_id_source, a.c';

s:=s||'mdb_id_target '||unistr('\000a')||
'    FROM relations a, relations b '||unistr('\000a')||
'    WHERE a.relation = ''is afhankelijk van'' AND'||unistr('\000a')||
'          b.relation = ''is afhankelijk van'' AND '||unistr('\000a')||
'          a.cmdb_id_source = b.cmdb_id_target AND '||unistr('\000a')||
'          a.cmdb_id_target = b.cmdb_id_source AND '||unistr('\000a')||
'          a.cmdb_id_source > a.cmdb_id_target;'||unistr('\000a')||
'    TYPE looprel_type IS RECORD ('||unistr('\000a')||
'        cmdb_id_source relations.cmdb_id_source%TYPE,'||unistr('\000a')||
'        cmdb_id_';

s:=s||'target relations.cmdb_id_target%TYPE);'||unistr('\000a')||
'    looprel looprel_type;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    OPEN looprel_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH looprel_cursor INTO looprel;'||unistr('\000a')||
'        EXIT WHEN looprel_cursor%NOTFOUND;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Duplicate Relation found between '' || looprel.cmdb_id_source || ';

s:=s||''' and '' || looprel.cmdb_id_target);'||unistr('\000a')||
'        DELETE FROM RELATIONS'||unistr('\000a')||
'        WHERE cmdb_id_source = looprel.cmdb_id_source'||unistr('\000a')||
'        AND   cmdb_id_target = looprel.cmdb_id_target;'||unistr('\000a')||
'    END LOOP;'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr:';

s:=s||' '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL_TPO_BT" '||unistr('\000a')||
'   IS '||unistr('\000a')||
'    '||unistr('\000a')||
'    proc_name logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_rel_tpo_bt'';'||unistr('\000a')||
'    CURSOR rel_cursor IS'||unistr('\000a')||
'    select DISTINCT TOEPASSINGOMGEVING,'||unistr('\000a')||
'           CMDB_REFERENTIE_OMGEVING,'||unistr('\000a')||
'           CMDB_REFERENTIE_BEDRIJFSTOEPAS,'||unistr('\000a')||
'           NAAM_BEDRIJFSTOEPASSING '||unistr('\000a')||
'    from CMWBT0011'||unistr('\000a')||
'    where CMDB';

s:=s||'_REFERENTIE_OMGEVING > 0;        '||unistr('\000a')||
'    TYPE rel_record IS RECORD ('||unistr('\000a')||
'        naam_target relations.naam_target%TYPE,'||unistr('\000a')||
'        cmdb_id_target cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,'||unistr('\000a')||
'        cmdb_id_source cmwbt0011.CMDB_REFERENTIE_BEDRIJFSTOEPAS%TYPE,'||unistr('\000a')||
'        naam_source relations.naam_source%TYPE);'||unistr('\000a')||
'    rel rel_record;'||unistr('\000a')||
'    v_cmdb_id_source relations.cmdb_id_source%TYPE;'||unistr('\000a')||
'    v_cmdb_id_target relations.';

s:=s||'cmdb_id_target%TYPE;'||unistr('\000a')||
'    c_ci_type_target   CONSTANT relations.ci_type_target%TYPE := ''Toepassingomgeving'';'||unistr('\000a')||
'    c_ci_type_source   CONSTANT relations.ci_type_source%TYPE := ''Bedrijfstoepassing'';'||unistr('\000a')||
'    c_categorie_source CONSTANT relations.ci_categorie_source%TYPE := '''';'||unistr('\000a')||
'    c_categorie_target CONSTANT relations.ci_categorie_target%TYPE := '''';'||unistr('\000a')||
'    c_relation         CONSTANT relations.relation%TYPE :';

s:=s||'= ''heeft component'';'||unistr('\000a')||
'    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);'||unistr('\000a')||
'    allvalues allvalues_type;'||unistr('\000a')||
'    '||unistr('\000a')||
'    valuestr varchar2(255);'||unistr('\000a')||
'           '||unistr('\000a')||
'    v_not_num_cnt number := 999000;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION convert2number (v_str IN varchar2)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_nr number;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_nr := to_number(v_s';

s:=s||'tr);'||unistr('\000a')||
'        RETURN v_nr;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN VALUE_ERROR THEN'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Waarde niet numeriek! *'' || v_str || ''*'');'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''convert2number fout nr: '' || err';

s:=s||'_num || '' msg: '' || err_msg);'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    OPEN rel_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH rel_cursor INTO rel;'||unistr('\000a')||
'        EXIT WHEN rel_cursor%NOTFOUND;'||unistr('\000a')||
'        v_cmdb_id_source := convert2number(rel.cmdb_id_source);'||unistr('\000a')||
'        v_cmdb_id_target := convert2number(rel.cm';

s:=s||'db_id_target);'||unistr('\000a')||
'        valuestr := to_char(v_cmdb_id_source) || ''.'' || c_relation || ''.'' || to_char(v_cmdb_id_target);'||unistr('\000a')||
'        '||unistr('\000a')||
'        IF NOT allvalues.EXISTS(valuestr) THEN'||unistr('\000a')||
'            -- Found Unique String, remember it and add it to the relations table'||unistr('\000a')||
'            allvalues(valuestr) := 1;'||unistr('\000a')||
'            v_cmdb_id_source := v_cmdb_id_source + 1000000;'||unistr('\000a')||
'            INSERT INTO relations (cmdb_id_so';

wwv_flow_api.append_to_install_script(
  p_id => 71349331904163432 + wwv_flow_api.g_id_offset,
  p_flow_id => wwv_flow.g_flow_id,
  p_script_clob => s);
end;
 
 
end;
/

 
begin
 
declare
    s varchar2(32767) := null;
begin
s:=s||'urce, naam_source, ci_type_source, ci_categorie_source, '||unistr('\000a')||
'                                   relation,'||unistr('\000a')||
'                                   cmdb_id_target, naam_target, ci_type_target, ci_categorie_target)'||unistr('\000a')||
'            VALUES (v_cmdb_id_source, rel.naam_source, c_ci_type_source, c_categorie_source,'||unistr('\000a')||
'                    c_relation,'||unistr('\000a')||
'                    v_cmdb_id_target, rel.naam_target, c_ci_type_target,';

s:=s||' c_categorie_target);'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        '||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_';

s:=s||'GET_CMWBT0011_TPO" '||unistr('\000a')||
'    IS '||unistr('\000a')||
'    proc_name logtbl.evt_proc%TYPE := ''p_get_cmwbt0011_tpo'';'||unistr('\000a')||
'    CURSOR tpo_cursor IS'||unistr('\000a')||
'    select DISTINCT'||unistr('\000a')||
'           TOEPASSINGOMGEVING,'||unistr('\000a')||
'           STATUS_TOEPASSINGOMGEVING,'||unistr('\000a')||
'           CMDB_REFERENTIE_OMGEVING,'||unistr('\000a')||
'           VERSIE,'||unistr('\000a')||
'           TYPE_OMGEVING,'||unistr('\000a')||
'           DATUM_IN_GEBRUIK,'||unistr('\000a')||
'           DATUM_BUITEN_GEBRUIK,'||unistr('\000a')||
'           DIENSTENTYPE,'||unistr('\000a')||
'           FINANCIEEL_BEHEER';

s:=s||'DER_BELEIDSD,'||unistr('\000a')||
'           FINANCIEEL_BEHEERDER_ENTITEIT,'||unistr('\000a')||
'           EIGENAAR_BELEIDSDOMEIN,'||unistr('\000a')||
'           EIGENAAR_ENTITEIT,'||unistr('\000a')||
'           NUMMER_BEDRIJFSTOEPASSING '||unistr('\000a')||
'    from CMWBT0011'||unistr('\000a')||
'    where CMDB_REFERENTIE_OMGEVING >0;'||unistr('\000a')||
'TYPE tpo_record IS RECORD ('||unistr('\000a')||
'    NAAM component.NAAM%TYPE,'||unistr('\000a')||
'    STATUS component.STATUS%TYPE,'||unistr('\000a')||
'    CMDB_ID cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,'||unistr('\000a')||
'    VERSIE component.VERSIE%TYPE,'||unistr('\000a')||
'    ';

s:=s||'OMGEVING component.OMGEVING%TYPE,'||unistr('\000a')||
'    DATUM_IN_GEBRUIK component.DATUM_IN_GEBRUIK%TYPE,'||unistr('\000a')||
'    DATUM_BUITEN_GEBRUIK component.DATUM_BUITEN_GEBRUIK%TYPE,'||unistr('\000a')||
'    DIENSTENTYPE component.DIENSTENTYPE%TYPE,'||unistr('\000a')||
'    FIN_BELEIDSDOMEIN component.FIN_BELEIDSDOMEIN%TYPE,'||unistr('\000a')||
'    FIN_ENTITEIT component.FIN_ENTITEIT%TYPE,'||unistr('\000a')||
'    EIGENAAR_BELEIDSDOMEIN component.EIGENAAR_BELEIDSDOMEIN%TYPE,'||unistr('\000a')||
'    EIGENAAR_ENTITEIT component.EIGE';

s:=s||'NAAR_ENTITEIT%TYPE,'||unistr('\000a')||
'    BT_NUMMER component.BT_NUMMER%TYPE);'||unistr('\000a')||
'    tpo tpo_record;'||unistr('\000a')||
'    c_ci_class CONSTANT component.CI_CLASS%TYPE := ''toepassingcomponentinstallatie'';'||unistr('\000a')||
'    v_cmdb_id component.cmdb_id%TYPE;'||unistr('\000a')||
'    '||unistr('\000a')||
'    v_not_num_cnt number := 998000;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION convert2number (v_str IN varchar2)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_nr n';

s:=s||'umber;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_nr := to_number(v_str);'||unistr('\000a')||
'        RETURN v_nr;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN VALUE_ERROR THEN'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Waarde niet numeriek! *'' || v_str || ''*'');'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'            p_log(pro';

s:=s||'c_name, ''E'', ''convert2number fout nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'            v_not_num_cnt := v_not_num_cnt + 1;'||unistr('\000a')||
'            RETURN v_not_num_cnt;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    OPEN tpo_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH tpo_cursor INTO tpo;'||unistr('\000a')||
'        EXIT WHEN tpo_cursor%NOTFOUND;'||unistr('\000a')||
'        v_cmdb_id := convert2number(tpo.cmdb_id);'||unistr('\000a')||
'        INSERT IN';

s:=s||'TO component (ci_class, naam, status, cmdb_id, versie, omgeving, datum_in_gebruik,'||unistr('\000a')||
'            datum_buiten_gebruik, dienstentype, fin_beleidsdomein, fin_entiteit, '||unistr('\000a')||
'            eigenaar_beleidsdomein, eigenaar_entiteit, bt_nummer)'||unistr('\000a')||
'        VALUES (c_ci_class, tpo.naam, tpo.status, v_cmdb_id, tpo.versie, tpo.omgeving, tpo.datum_in_gebruik,'||unistr('\000a')||
'                tpo.datum_buiten_gebruik, tpo.dienstentype, ';

s:=s||'tpo.fin_beleidsdomein, tpo.fin_entiteit, '||unistr('\000a')||
'                tpo.eigenaar_beleidsdomein, tpo.eigenaar_entiteit, tpo.bt_nummer);'||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: ';

s:=s||''' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_JOB_CHECKS" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_job_checks'';'||unistr('\000a')||
'    limitcnt number := 0;'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR sw_comp_cursor IS'||unistr('\000a')||
'    select CMDB_ID,'||unistr('\000a')||
'           NAAM,'||unistr('\000a')||
'           CI_CATEGORIE,'||unistr('\000a')||
'           CI_TYPE'||unistr('\000a')||
'    from COMPONENT'||unistr('\000a')||
'    where (CI_TYPE like ''JOB%'');'||unistr('\000a')||
'    TYPE sw_comp_rec IS RECORD ('||unistr('\000a')||
'        cmdb_';

s:=s||'id component.cmdb_id%TYPE,'||unistr('\000a')||
'        naam component.naam%TYPE,'||unistr('\000a')||
'        ci_categorie component.ci_categorie%TYPE,'||unistr('\000a')||
'        ci_type component.ci_type%TYPE);'||unistr('\000a')||
'    sw_comp sw_comp_rec;'||unistr('\000a')||
'    next_sw_comp sw_comp_rec;'||unistr('\000a')||
'    v_msg sw_checks.msgstr%TYPE;'||unistr('\000a')||
'    v_computer sw_checks.comp_naam%TYPE;'||unistr('\000a')||
'    v_comp_type sw_checks.comp_type%TYPE;'||unistr('\000a')||
'    v_cluster varchar2(255);'||unistr('\000a')||
'    v_loopcnt number;'||unistr('\000a')||
'    v_connections sw_check';

s:=s||'s.connections%TYPE;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    PROCEDURE go_down (src_comp IN sw_comp_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        CURSOR tgt_comp_cursor IS'||unistr('\000a')||
'        select CMDB_ID_TARGET,'||unistr('\000a')||
'               NAAM_TARGET,'||unistr('\000a')||
'               CI_CATEGORIE_TARGET,'||unistr('\000a')||
'               CI_TYPE_TARGET '||unistr('\000a')||
'        from RELATIONS'||unistr('\000a')||
'        where cmdb_id_source = src_comp.cmdb_id'||unistr('\000a')||
'          and relation = ''';

s:=s||'is afhankelijk van'';'||unistr('\000a')||
'        tgt_comp sw_comp_rec;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_loopcnt := v_loopcnt + 1;'||unistr('\000a')||
'        IF v_loopcnt > 100 THEN'||unistr('\000a')||
'            p_log(proc_name, ''F'', ''Loop Count exceeded'');'||unistr('\000a')||
'            RETURN;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        '||unistr('\000a')||
'        OPEN tgt_comp_cursor;'||unistr('\000a')||
'        LOOP'||unistr('\000a')||
'            FETCH tgt_comp_cursor INTO tgt_comp;'||unistr('\000a')||
'            EXIT WHEN tgt_comp_cursor%NOTFOUND;'||unistr('\000a')||
'            v_connections :=';

s:=s||' v_connections +1;'||unistr('\000a')||
'            -- Did I find a (Fysieke or Virtuele) computer?'||unistr('\000a')||
'            IF ((tgt_comp.ci_type = ''FYSIEKE COMPUTER'') OR (tgt_comp.ci_type = ''VIRTUELE COMPUTER'')) THEN'||unistr('\000a')||
'                IF ((length(v_computer) > 0) AND (length(v_cluster) IS NULL)) THEN'||unistr('\000a')||
'                    v_msg := v_msg || ''More than one computer found, no cluster defined. * '';'||unistr('\000a')||
'                    -- If duplicate ty';

s:=s||'pe, then make sure to remember virtual computer'||unistr('\000a')||
'                    IF (tgt_comp.ci_type = ''VIRTUELE COMPUTER'') THEN'||unistr('\000a')||
'                        v_computer := tgt_comp.naam;'||unistr('\000a')||
'                        v_comp_type := tgt_comp.ci_type;'||unistr('\000a')||
'                    END IF;'||unistr('\000a')||
'                ELSE'||unistr('\000a')||
'                    v_computer := tgt_comp.naam;'||unistr('\000a')||
'                    v_comp_type := tgt_comp.ci_type;                '||unistr('\000a')||
'      ';

s:=s||'          END IF;'||unistr('\000a')||
'            ELSIF INSTR(upper(tgt_comp.ci_type), ''NETWERK'') > 0 THEN'||unistr('\000a')||
'                v_msg := v_msg || ''SW Component to Network, no computer found. * '';'||unistr('\000a')||
'            ELSE'||unistr('\000a')||
'                go_down(tgt_comp);'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END LOOP;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE save_results(sv_sw_comp IN sw_comp_rec) '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF (length(v_computer) IS NULL) THEN'||unistr('\000a')||
'            v';

s:=s||'_msg := v_msg || ''Component niet met computer verbonden. * '';'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        INSERT INTO job_checks'||unistr('\000a')||
'            (sw_id, sw_naam, sw_type, sw_categorie, comp_naam,  '||unistr('\000a')||
'                connections, msgstr, assessment, migratie)'||unistr('\000a')||
'        VALUES'||unistr('\000a')||
'            (sv_sw_comp.cmdb_id, sv_sw_comp.naam, sv_sw_comp.ci_type,'||unistr('\000a')||
'                sv_sw_comp.ci_categorie, v_computer, v_connections, v_msg, 0, 0);'||unistr('\000a')||
'';

s:=s||'    END;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table job_checks'';'||unistr('\000a')||
'    '||unistr('\000a')||
'    OPEN sw_comp_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH sw_comp_cursor INTO sw_comp;'||unistr('\000a')||
'        EXIT WHEN sw_comp_cursor%NOTFOUND;'||unistr('\000a')||
'        -- limitcnt := limitcnt + 1;'||unistr('\000a')||
'        -- EXIT WHEN limitcnt > 5;'||unistr('\000a')||
'        -- dbms_output.put_line(''Investigate '' || sw_comp.naam);'||unistr('\000a')||
'        -- Reset vari';

s:=s||'ables'||unistr('\000a')||
'        v_msg := '''';'||unistr('\000a')||
'        v_computer := '''';'||unistr('\000a')||
'        v_cluster := '''';'||unistr('\000a')||
'        v_loopcnt := 0;'||unistr('\000a')||
'        v_connections := 0;'||unistr('\000a')||
'        next_sw_comp.cmdb_id := sw_comp.cmdb_id;'||unistr('\000a')||
'        next_sw_comp.naam := sw_comp.naam;'||unistr('\000a')||
'        next_sw_comp.ci_categorie := sw_comp.ci_categorie;'||unistr('\000a')||
'        next_sw_comp.ci_type := sw_comp.ci_type;'||unistr('\000a')||
'        go_down(next_sw_comp);'||unistr('\000a')||
'        save_results(next_sw_comp);'||unistr('\000a')||
'   ';

s:=s||' END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'         '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_LOAD_EXTCMWBT0011" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name';

s:=s||' varchar2(255) := ''p_load_extcmwbt0011'';'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling LOADEXTCMWBT0011'');'||unistr('\000a')||
'    LOADEXTCMDB;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling p_check_cmwbt0011'');'||unistr('\000a')||
'    p_check_cmwbt0011;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_LOG" (proc_name IN logtbl.evt_proc%TYPE,'||unistr('\000a')||
'                           ';

s:=s||'                sev IN logtbl.evt_sev%TYPE,'||unistr('\000a')||
'                                           msg IN logtbl.evt_msg%TYPE)'||unistr('\000a')||
'    AS'||unistr('\000a')||
'    PRAGMA AUTONOMOUS_TRANSACTION;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    INSERT INTO logtbl ('||unistr('\000a')||
'        evt_time,'||unistr('\000a')||
'        evt_proc,'||unistr('\000a')||
'        evt_sev,'||unistr('\000a')||
'        evt_msg)'||unistr('\000a')||
'    VALUES ('||unistr('\000a')||
'        sysdate,'||unistr('\000a')||
'        proc_name,'||unistr('\000a')||
'        sev,'||unistr('\000a')||
'        msg);'||unistr('\000a')||
'    COMMIT;'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_LOG_MAINT" '||unistr('\000a')||
'  ';

s:=s||'  IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_log_maint'';'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    EXECUTE IMMEDIATE ''delete from logtbl where (evt_time < (sysdate -7)) and (not(evt_msg like ''''User%''''))'';'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBST';

s:=s||'R(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'   '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_RUN_ALL" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_run_all'';'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Application'');'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Lo';

s:=s||'gfile maintenance'');'||unistr('\000a')||
'    p_log_maint;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling p_load_extcmwbt0011'');'||unistr('\000a')||
'    p_load_extcmwbt0011;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling p_convert_data'');'||unistr('\000a')||
'    p_convert_data;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Calling p_calculate'');'||unistr('\000a')||
'    p_calculate;'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Application'');'||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_SW_COMPONENT_CHECKS" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT l';

s:=s||'ogtbl.evt_proc%TYPE := ''p_sw_component_checks'';'||unistr('\000a')||
'    limitcnt number := 0;'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR sw_comp_cursor IS'||unistr('\000a')||
'    select CMDB_ID,'||unistr('\000a')||
'           NAAM,'||unistr('\000a')||
'           CI_CATEGORIE,'||unistr('\000a')||
'           CI_TYPE'||unistr('\000a')||
'    from COMPONENT'||unistr('\000a')||
'    where (CI_TYPE = ''ANDERE TOEP.COMP.INSTALL.'''||unistr('\000a')||
'       or CI_TYPE = ''DB TOEP.COMP-INSTALL.'''||unistr('\000a')||
'       or CI_TYPE = ''RAPPORTEN'''||unistr('\000a')||
'       or CI_TYPE = ''TOEP.COMP. COLLAB. SYST.'''||unistr('\000a')||
'        or CI_TYPE =';

s:=s||' ''WEB TOEP.COMP-INSTALL.'');'||unistr('\000a')||
'    TYPE sw_comp_rec IS RECORD ('||unistr('\000a')||
'        cmdb_id component.cmdb_id%TYPE,'||unistr('\000a')||
'        naam component.naam%TYPE,'||unistr('\000a')||
'        ci_categorie component.ci_categorie%TYPE,'||unistr('\000a')||
'        ci_type component.ci_type%TYPE);'||unistr('\000a')||
'    sw_comp sw_comp_rec;'||unistr('\000a')||
'    next_sw_comp sw_comp_rec;'||unistr('\000a')||
'    v_msg sw_checks.msgstr%TYPE;'||unistr('\000a')||
'    v_computer sw_checks.comp_naam%TYPE;'||unistr('\000a')||
'    v_comp_type sw_checks.comp_type%TYPE;'||unistr('\000a')||
'   ';

s:=s||' v_cluster varchar2(255);'||unistr('\000a')||
'    v_loopcnt number;'||unistr('\000a')||
'    v_connections sw_checks.connections%TYPE;'||unistr('\000a')||
'    TYPE cost_cat_rec is RECORD ('||unistr('\000a')||
'        ci_type kostelementen.ci_type%TYPE,'||unistr('\000a')||
'        ci_categorie kostelementen.ci_categorie%TYPE,'||unistr('\000a')||
'        computertype kostelementen.computertype%TYPE);'||unistr('\000a')||
'    TYPE cost_res_rec IS RECORD ('||unistr('\000a')||
'        migratie kostelementen.waarde%TYPE,'||unistr('\000a')||
'        assessment kostelementen.waarde%T';

s:=s||'YPE);'||unistr('\000a')||
'    sw_cost_cat cost_cat_rec;'||unistr('\000a')||
'    sw_cost_res cost_res_rec;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'        '||unistr('\000a')||
'    PROCEDURE get_cost(cost_cat IN cost_cat_rec, cost_res OUT cost_res_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        SELECT waarde INTO cost_res.migratie'||unistr('\000a')||
'        FROM kostelementen'||unistr('\000a')||
'        WHERE element = ''Migratie'''||unistr('\000a')||
'          AND ci_type = cost_cat.ci_type'||unistr('\000a')||
'          AND ci';

s:=s||'_categorie = cost_cat.ci_categorie'||unistr('\000a')||
'          AND computertype = cost_cat.computertype;'||unistr('\000a')||
'        SELECT waarde INTO cost_res.assessment'||unistr('\000a')||
'        FROM kostelementen'||unistr('\000a')||
'        WHERE element = ''Assessment'''||unistr('\000a')||
'          AND ci_type = cost_cat.ci_type'||unistr('\000a')||
'          AND ci_categorie = cost_cat.ci_categorie'||unistr('\000a')||
'          AND computertype = cost_cat.computertype;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'            ';

s:=s||'p_log(proc_name, ''E'', ''Geen Assessment of Migratie kostelement gevonden voor '' || cost_cat.ci_type || '' - '' || cost_cat.ci_categorie || '' - '' || cost_cat.computertype);'||unistr('\000a')||
'        WHEN TOO_MANY_ROWS THEN'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Meer dan één kost element gevonden voor '' || cost_cat.ci_type || '' - '' || cost_cat.ci_categorie || '' - '' || cost_cat.computertype);'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE go_down (';

s:=s||'src_comp IN sw_comp_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        CURSOR tgt_comp_cursor IS'||unistr('\000a')||
'        select CMDB_ID_TARGET,'||unistr('\000a')||
'               NAAM_TARGET,'||unistr('\000a')||
'               CI_CATEGORIE_TARGET,'||unistr('\000a')||
'               CI_TYPE_TARGET '||unistr('\000a')||
'        from RELATIONS'||unistr('\000a')||
'        where cmdb_id_source = src_comp.cmdb_id'||unistr('\000a')||
'          and relation = ''is afhankelijk van'';'||unistr('\000a')||
'        tgt_comp sw_comp_rec;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_loopcnt := v_loopcnt + 1;'||unistr('\000a')||
'        IF v_l';

s:=s||'oopcnt > 100 THEN'||unistr('\000a')||
'            p_log(proc_name, ''F'', ''Loop Count exceeded'');'||unistr('\000a')||
'            RETURN;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        '||unistr('\000a')||
'        OPEN tgt_comp_cursor;'||unistr('\000a')||
'        LOOP'||unistr('\000a')||
'            FETCH tgt_comp_cursor INTO tgt_comp;'||unistr('\000a')||
'            EXIT WHEN tgt_comp_cursor%NOTFOUND;'||unistr('\000a')||
'            v_connections := v_connections +1;'||unistr('\000a')||
'            -- Did I find a (Fysieke or Virtuele) computer?'||unistr('\000a')||
'            IF ((tgt_comp.ci_typ';

s:=s||'e = ''FYSIEKE COMPUTER'') OR (tgt_comp.ci_type = ''VIRTUELE COMPUTER'')) THEN'||unistr('\000a')||
'                IF ((length(v_computer) > 0) AND (length(v_cluster) IS NULL)) THEN'||unistr('\000a')||
'                    v_msg := v_msg || ''More than one computer found, no cluster defined. * '';'||unistr('\000a')||
'                    -- If duplicate type, then make sure to remember virtual computer'||unistr('\000a')||
'                    IF (tgt_comp.ci_type = ''VIRTUELE COMPUTER'')';

s:=s||' THEN'||unistr('\000a')||
'                        v_computer := tgt_comp.naam;'||unistr('\000a')||
'                        v_comp_type := tgt_comp.ci_type;'||unistr('\000a')||
'                    END IF;'||unistr('\000a')||
'                ELSE'||unistr('\000a')||
'                    v_computer := tgt_comp.naam;'||unistr('\000a')||
'                    v_comp_type := tgt_comp.ci_type;'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'            ELSIF INSTR(upper(tgt_comp.ci_type), ''NETWERK'') > 0 THEN'||unistr('\000a')||
'                v_msg := v_msg || ''SW Co';

s:=s||'mponent to Network, no computer found. * '';'||unistr('\000a')||
'            ELSE'||unistr('\000a')||
'                go_down(tgt_comp);'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END LOOP;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE save_results(sv_sw_comp IN sw_comp_rec) '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF (length(v_computer) IS NULL) THEN'||unistr('\000a')||
'            v_msg := v_msg || ''Component niet met computer verbonden. * '';'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        sw_cost_cat.ci_type := sv_sw_comp.ci_type';

s:=s||';'||unistr('\000a')||
'        sw_cost_cat.ci_categorie := sv_sw_comp.ci_categorie;'||unistr('\000a')||
'        -- Make sure Computertype is defined'||unistr('\000a')||
'        IF (length(v_comp_type) > 5) THEN'||unistr('\000a')||
'            sw_cost_cat.computertype := v_comp_type;'||unistr('\000a')||
'        ELSE'||unistr('\000a')||
'            sw_cost_cat.computertype := ''FYSIEKE COMPUTER'';'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        get_cost(sw_cost_cat, sw_cost_res);'||unistr('\000a')||
'        INSERT INTO sw_checks'||unistr('\000a')||
'            (sw_id, sw_naam, sw_ty';

s:=s||'pe, sw_categorie, comp_naam,  '||unistr('\000a')||
'                connections, msgstr, assessment, migratie)'||unistr('\000a')||
'        VALUES'||unistr('\000a')||
'            (sv_sw_comp.cmdb_id, sv_sw_comp.naam, sv_sw_comp.ci_type,'||unistr('\000a')||
'                sv_sw_comp.ci_categorie, v_computer, v_connections, v_msg,'||unistr('\000a')||
'                sw_cost_res.assessment, sw_cost_res.migratie);'||unistr('\000a')||
'    END;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    EXECUTE IMMEDIATE';

s:=s||' ''truncate table sw_checks'';'||unistr('\000a')||
'    '||unistr('\000a')||
'    OPEN sw_comp_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH sw_comp_cursor INTO sw_comp;'||unistr('\000a')||
'        EXIT WHEN sw_comp_cursor%NOTFOUND;'||unistr('\000a')||
'        -- limitcnt := limitcnt + 1;'||unistr('\000a')||
'        -- EXIT WHEN limitcnt > 5;'||unistr('\000a')||
'        -- dbms_output.put_line(''Investigate '' || sw_comp.naam);'||unistr('\000a')||
'        -- Reset variables'||unistr('\000a')||
'        v_msg := '''';'||unistr('\000a')||
'        v_computer := '''';'||unistr('\000a')||
'        v_cluster := '''';'||unistr('\000a')||
'        v_';

s:=s||'loopcnt := 0;'||unistr('\000a')||
'        v_connections := 0;'||unistr('\000a')||
'        v_comp_type := ''sml'';'||unistr('\000a')||
'        next_sw_comp.cmdb_id := sw_comp.cmdb_id;'||unistr('\000a')||
'        next_sw_comp.naam := sw_comp.naam;'||unistr('\000a')||
'        next_sw_comp.ci_categorie := sw_comp.ci_categorie;'||unistr('\000a')||
'        next_sw_comp.ci_type := sw_comp.ci_type;'||unistr('\000a')||
'        go_down(next_sw_comp);'||unistr('\000a')||
'        save_results(next_sw_comp);'||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');   ';

s:=s||' '||unistr('\000a')||
'         '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'   '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_SYSTEM_CHECKS" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_system_checks'';'||unistr('\000a')||
'    l';

s:=s||'imitcnt number := 0;'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR comp_cursor IS'||unistr('\000a')||
'    select CMDB_ID,'||unistr('\000a')||
'           NAAM,'||unistr('\000a')||
'           CI_CATEGORIE,'||unistr('\000a')||
'           CI_TYPE,'||unistr('\000a')||
'           STATUS,'||unistr('\000a')||
'           LOCATIE,'||unistr('\000a')||
'           PRODUCT,'||unistr('\000a')||
'           PRODUCENT,'||unistr('\000a')||
'           UITDOVEND_DATUM,'||unistr('\000a')||
'           UITGEDOOFD_DATUM'||unistr('\000a')||
'    from COMPONENT'||unistr('\000a')||
'    where CI_TYPE = ''FYSIEKE COMPUTER'';'||unistr('\000a')||
'      '||unistr('\000a')||
'    TYPE comp_rec IS RECORD ('||unistr('\000a')||
'        cmdb_id component.cmdb_id';

s:=s||'%TYPE,'||unistr('\000a')||
'        naam component.naam%TYPE,'||unistr('\000a')||
'        ci_categorie component.ci_categorie%TYPE,'||unistr('\000a')||
'        ci_type component.ci_type%TYPE,'||unistr('\000a')||
'        status component.status%TYPE,'||unistr('\000a')||
'        locatie component.locatie%TYPE,'||unistr('\000a')||
'        product component.product%TYPE,'||unistr('\000a')||
'        producent component.producent%TYPE,'||unistr('\000a')||
'        uitdovend_datum component.uitdovend_datum%TYPE,'||unistr('\000a')||
'        uitgedoofd_datum component.uitgedoofd_datum';

s:=s||'%TYPE);'||unistr('\000a')||
'    TYPE eosl_rec IS RECORD ('||unistr('\000a')||
'        uitdovend_datum DATE,'||unistr('\000a')||
'        uitgedoofd_datum DATE);'||unistr('\000a')||
'    eosl eosl_rec;'||unistr('\000a')||
'    '||unistr('\000a')||
'    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);'||unistr('\000a')||
'    allvalues allvalues_type;  -- remember all server to ci relations for cons_cis table'||unistr('\000a')||
'    locations allvalues_type;  -- remember all locations for derived locations table   '||unistr('\000a')||
'    comp comp_rec;'||unistr('\000a')||
'    next_ci c';

s:=s||'omp_rec;'||unistr('\000a')||
'    v_msg system_checks.msgstr%TYPE;'||unistr('\000a')||
'    v_connections system_checks.connections%TYPE;'||unistr('\000a')||
'    v_sw_cnt system_checks.connections%TYPE;'||unistr('\000a')||
'    v_job_cnt system_checks.connections%TYPE;'||unistr('\000a')||
'    v_top_cmdb_id cons_cis.cmdb_id_src%TYPE;'||unistr('\000a')||
'    v_top_naam cons_cis.naam_src%TYPE;'||unistr('\000a')||
'    v_loopcnt number;'||unistr('\000a')||
'    v_locatie component.locatie%TYPE;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
' ';

s:=s||'   FUNCTION get_smallest(left_date IN DATE, right_date IN DATE)'||unistr('\000a')||
'    RETURN date'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF ((length(left_date) > 2) AND (length(right_date) > 2)) THEN'||unistr('\000a')||
'           RETURN least(left_date, right_date);'||unistr('\000a')||
'        ELSIF (length(left_date) IS NULL) THEN'||unistr('\000a')||
'            RETURN right_date;'||unistr('\000a')||
'        ELSE'||unistr('\000a')||
'            RETURN left_date;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE get_os_eosl(cmdb_id_in I';

s:=s||'N component.cmdb_id%TYPE, thiseosl IN OUT eosl_rec) '||unistr('\000a')||
'    IS'||unistr('\000a')||
'        this_uitdovend_datum DATE;'||unistr('\000a')||
'        this_uitgedoofd_datum DATE;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        -- In exceptional situations the Server has more than one'||unistr('\000a')||
'        -- Operating System, e.g. ID: 60106'||unistr('\000a')||
'        SELECT min(uitdovend_datum), min(uitgedoofd_datum)'||unistr('\000a')||
'        INTO this_uitdovend_datum, this_uitgedoofd_datum'||unistr('\000a')||
'        FROM component, relations';

s:=s||''||unistr('\000a')||
'        WHERE cmdb_id_target = cmdb_id_in'||unistr('\000a')||
'        AND relation = ''is afhankelijk van'''||unistr('\000a')||
'        AND ci_categorie_source = ''OPERATING SYSTEEM'''||unistr('\000a')||
'        AND cmdb_id = cmdb_id_source;'||unistr('\000a')||
'        thiseosl.uitdovend_datum := get_smallest(this_uitdovend_datum, thiseosl.uitdovend_datum);'||unistr('\000a')||
'        thiseosl.uitgedoofd_datum := get_smallest(this_uitgedoofd_datum, thiseosl.uitgedoofd_datum);'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        ';

s:=s||'WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'            RETURN;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE safe_cons_eosl(cmdb_id_in IN component.cmdb_id%TYPE, eosl IN eosl_rec) '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF (not((eosl.uitdovend_datum IS NULL) AND (eosl.uitgedoofd_datum IS NULL))) THEN'||unistr('\000a')||
'            INSERT INTO cons_eosl(cmdb_id, uitdovend_datum, uitgedoofd_datum)'||unistr('\000a')||
'                VALUES (cmdb_id_in, eosl.uitdovend_datum, eosl.uitgedoofd_da';

s:=s||'tum);'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE go_up (cmdb_id2chk IN relations.cmdb_id_target%TYPE, ck_eosl IN OUT eosl_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        CURSOR tgt_rel_cursor IS'||unistr('\000a')||
'        SELECT CMDB_ID_SOURCE,'||unistr('\000a')||
'               NAAM_SOURCE,'||unistr('\000a')||
'               CI_TYPE_SOURCE,'||unistr('\000a')||
'               CI_CATEGORIE_SOURCE,'||unistr('\000a')||
'               UITDOVEND_DATUM,'||unistr('\000a')||
'               UITGEDOOFD_DATUM'||unistr('\000a')||
'        FROM RELATIONS, COMPONENT'||unistr('\000a')||
'        WHERE';

s:=s||' CMDB_ID_TARGET = cmdb_id2chk'||unistr('\000a')||
'          AND NOT (CI_CATEGORIE_SOURCE = ''OPERATING SYSTEEM'')'||unistr('\000a')||
'          AND RELATION = ''is afhankelijk van'''||unistr('\000a')||
'          AND CMDB_ID = CMDB_ID_SOURCE;'||unistr('\000a')||
'        TYPE rel_rec IS RECORD ('||unistr('\000a')||
'            cmdb_id relations.cmdb_id_source%TYPE,'||unistr('\000a')||
'            naam relations.naam_source%TYPE,'||unistr('\000a')||
'            ci_type relations.ci_type_source%TYPE,'||unistr('\000a')||
'            ci_categorie relations.ci_cate';

s:=s||'gorie_source%TYPE,'||unistr('\000a')||
'            uitdovend_datum component.uitdovend_datum%TYPE,'||unistr('\000a')||
'            uitgedoofd_datum component.uitgedoofd_datum%TYPE);'||unistr('\000a')||
'        tgt_rel rel_rec;'||unistr('\000a')||
'        v_allvals_key varchar2(255);'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        v_loopcnt := v_loopcnt + 1;'||unistr('\000a')||
'        IF v_loopcnt > 1000 THEN'||unistr('\000a')||
'            p_log(proc_name, ''F'', ''Loop Count exceeded'');'||unistr('\000a')||
'            RETURN;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        '||unistr('\000a')||
'        OPEN t';

s:=s||'gt_rel_cursor;'||unistr('\000a')||
'        LOOP'||unistr('\000a')||
'            FETCH tgt_rel_cursor INTO tgt_rel;'||unistr('\000a')||
'            EXIT WHEN tgt_rel_cursor%NOTFOUND;'||unistr('\000a')||
'            -- Verify if this component has been seen from the physical server already.'||unistr('\000a')||
'            -- If so, stop searching.'||unistr('\000a')||
'            v_allvals_key := v_top_cmdb_id || ''.'' || tgt_rel.cmdb_id;'||unistr('\000a')||
'            IF allvalues.EXISTS(v_allvals_key) THEN'||unistr('\000a')||
'                NULL;'||unistr('\000a')||
'        ';

s:=s||'        -- p_log(proc_name, ''E'', ''CI is reeds gezien, server: '' || v_top_cmdb_id || '', CI: '' || tgt_rel.cmdb_id);'||unistr('\000a')||
'            ELSE'||unistr('\000a')||
'                -- Remember that I have been here before'||unistr('\000a')||
'                allvalues(v_allvals_key) := 1;'||unistr('\000a')||
'                v_connections := v_connections + 1;'||unistr('\000a')||
'                -- If this component runs on computer in Boudewijn'||unistr('\000a')||
'                -- and this was not known befo';

s:=s||'re, then store it in derived_locations'||unistr('\000a')||
'                IF ((length(v_locatie) > 5) AND (NOT locations.EXISTS(tgt_rel.cmdb_id))) THEN'||unistr('\000a')||
'                    locations(tgt_rel.cmdb_id) := 1;'||unistr('\000a')||
'                    INSERT INTO derived_locations (cmdb_id, locatie)'||unistr('\000a')||
'                        VALUES (tgt_rel.cmdb_id, v_locatie);'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'                -- Get oldest EOSL dates'||unistr('\000a')||
'                -- ';

s:=s||'If it is Computer System, then also look at its Operating System'||unistr('\000a')||
'                IF ((tgt_rel.ci_type = ''FYSIEKE COMPUTER'') OR (tgt_rel.ci_type = ''VIRTUELE COMPUTER'')) THEN'||unistr('\000a')||
'                    get_os_eosl(tgt_rel.cmdb_id, ck_eosl);'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'                ck_eosl.uitdovend_datum  := get_smallest(tgt_rel.uitdovend_datum,  ck_eosl.uitdovend_datum);'||unistr('\000a')||
'                ck_eosl.uitgedoofd_';

s:=s||'datum := get_smallest(tgt_rel.uitgedoofd_datum, ck_eosl.uitgedoofd_datum);'||unistr('\000a')||
'                -- Remember this in cons_eosl table'||unistr('\000a')||
'                safe_cons_eosl(tgt_rel.cmdb_id, ck_eosl);'||unistr('\000a')||
'                -- Remember this combination in the cons_cis table'||unistr('\000a')||
'                INSERT INTO cons_cis (cmdb_id_src, naam_src, '||unistr('\000a')||
'                    cmdb_id_tgt, naam_tgt, ci_type_tgt, ci_categorie_tgt)'||unistr('\000a')||
'            ';

s:=s||'    VALUES (v_top_cmdb_id, v_top_naam, tgt_rel.cmdb_id, tgt_rel.naam,'||unistr('\000a')||
'                    tgt_rel.ci_type, tgt_rel.ci_categorie);'||unistr('\000a')||
'                -- Is this a SW_Comp Type?'||unistr('\000a')||
'                IF ((tgt_rel.ci_type = ''ANDERE TOEP.COMP.INSTALL.'') OR'||unistr('\000a')||
'                    (tgt_rel.ci_type = ''DB TOEP.COMP-INSTALL.'') OR'||unistr('\000a')||
'                    (tgt_rel.ci_type = ''RAPPORTEN'') OR'||unistr('\000a')||
'                    (tgt_rel.ci_ty';

s:=s||'pe = ''TOEP.COMP. COLLAB. SYST.'') OR'||unistr('\000a')||
'                    (tgt_rel.ci_type = ''WEB TOEP.COMP-INSTALL.'')) THEN'||unistr('\000a')||
'                    v_sw_cnt := v_sw_cnt + 1;'||unistr('\000a')||
'                ELSIF (tgt_rel.ci_type like ''JOB%'') THEN'||unistr('\000a')||
'                    v_job_cnt := v_job_cnt +1;'||unistr('\000a')||
'                ELSIF (length(tgt_rel.ci_type) IS NULL) THEN'||unistr('\000a')||
'                    v_msg := v_msg || ''Pad van Computer naar Applicatie zonder SW/';

s:=s||'Job component. * '';'||unistr('\000a')||
'                ELSE'||unistr('\000a')||
'                    go_up(tgt_rel.cmdb_id, ck_eosl);'||unistr('\000a')||
'                END IF;         '||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END LOOP;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'            v_msg := v_msg || ''Unexpected End of Path * '';'||unistr('\000a')||
'--        WHEN OTHERS THEN'||unistr('\000a')||
'--            v_msg := v_msg || ''Unknown exception encountered * '';'||unistr('\000a')||
'--            p_log(proc_name, ''E'',';

s:=s||' ''Unknown exception encountered'');'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    PROCEDURE save_results(comp IN comp_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        INSERT INTO system_checks'||unistr('\000a')||
'            (cmdb_id, naam, ci_type, ci_categorie, producent, product,'||unistr('\000a')||
'                 locatie, sw_cnt, job_cnt, connections, msgstr, status)'||unistr('\000a')||
'        VALUES'||unistr('\000a')||
'            (comp.cmdb_id, comp.naam, comp.ci_type,comp.ci_categorie, '||unistr('\000a')||
'                comp.producent,';

s:=s||' comp.product, comp.locatie,'||unistr('\000a')||
'                v_sw_cnt, v_job_cnt, v_connections, v_msg, comp.status);'||unistr('\000a')||
'    END;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table system_checks'';'||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table cons_cis'';'||unistr('\000a')||
'    EXECUTE IMMEDIATE ''truncate table derived_locations'';'||unistr('\000a')||
'    OPEN comp_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH comp_cursor INTO comp;'||unistr('\000a')||
'   ';

s:=s||'     EXIT WHEN comp_cursor%NOTFOUND;'||unistr('\000a')||
'        -- limitcnt := limitcnt + 1;'||unistr('\000a')||
'        -- EXIT WHEN limitcnt > 5;'||unistr('\000a')||
'        -- dbms_output.put_line(''Investigate '' || sw_comp.naam);'||unistr('\000a')||
'        -- Reset variables'||unistr('\000a')||
'        v_msg := ''Init * '';'||unistr('\000a')||
'        v_loopcnt := 0;'||unistr('\000a')||
'        v_sw_cnt := 0;'||unistr('\000a')||
'        v_job_cnt := 0;'||unistr('\000a')||
'        v_connections := 0;'||unistr('\000a')||
'        -- Remember Location only if it is for Boudewijn Computerzaal'||unistr('\000a')||
'  ';

s:=s||'      IF (comp.locatie = ''Boudewijn - Brussel/-1C Computerzaal'') THEN'||unistr('\000a')||
'            v_locatie := ''Boudewijn - Brussel/-1C Computerzaal'';'||unistr('\000a')||
'            locations(comp.cmdb_id) := 1;'||unistr('\000a')||
'            INSERT INTO derived_locations (cmdb_id, locatie)'||unistr('\000a')||
'                VALUES (comp.cmdb_id, v_locatie);'||unistr('\000a')||
'        ELSE'||unistr('\000a')||
'            v_locatie := '''';'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        eosl.uitdovend_datum := comp.uitdovend_datum;'||unistr('\000a')||
'';

s:=s||'        eosl.uitgedoofd_datum := comp.uitgedoofd_datum;'||unistr('\000a')||
'        v_top_cmdb_id := comp.cmdb_id;'||unistr('\000a')||
'        v_top_naam := comp.naam;'||unistr('\000a')||
'        get_os_eosl(comp.cmdb_id, eosl);'||unistr('\000a')||
'        safe_cons_eosl(comp.cmdb_id, eosl);'||unistr('\000a')||
'        go_up(comp.cmdb_id, eosl);'||unistr('\000a')||
'        save_results(comp);'||unistr('\000a')||
'        '||unistr('\000a')||
'END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');    '||unistr('\000a')||
'         '||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg';

s:=s||':= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'  '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_SYSTEM_COST" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_system_cost'';'||unistr('\000a')||
'    limitcnt number := 0;'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR sys_cursor IS'||unistr('\000a')||
'    select s';

s:=s||'.cmdb_id, s.naam, c.kenmerken, c.omgeving'||unistr('\000a')||
'    from SYSTEM_CHECKS s, COMPONENT c'||unistr('\000a')||
'    where c.locatie = ''Boudewijn - Brussel/-1C Computerzaal'''||unistr('\000a')||
'    and s.sw_cnt = 0'||unistr('\000a')||
'        and s.job_cnt = 0'||unistr('\000a')||
'    and s.cmdb_id not in (select distinct cmdb_id from netwerk where cmdb_id is not null)'||unistr('\000a')||
'    and s.cmdb_id = c.cmdb_id;'||unistr('\000a')||
'    TYPE sys_record IS RECORD ('||unistr('\000a')||
'        cmdb_id component.cmdb_id%TYPE,'||unistr('\000a')||
'        naam compon';

s:=s||'ent.naam%TYPE,'||unistr('\000a')||
'        kenmerken component.kenmerken%TYPE,'||unistr('\000a')||
'        omgeving component.omgeving%TYPE);'||unistr('\000a')||
'    TYPE eosl_rec IS RECORD ('||unistr('\000a')||
'        uitdovend_datum DATE,'||unistr('\000a')||
'        uitgedoofd_datum DATE);'||unistr('\000a')||
'    TYPE fct_rec IS RECORD ('||unistr('\000a')||
'        uitdovend kostelementen.waarde%TYPE,'||unistr('\000a')||
'        uitgedoofd kostelementen.waarde%TYPE);'||unistr('\000a')||
'    TYPE kenmerk_err_rec IS TABLE OF number INDEX BY varchar2(255);'||unistr('\000a')||
'    cut_eosl eosl';

s:=s||'_rec;'||unistr('\000a')||
'    fct fct_rec;'||unistr('\000a')||
'    '||unistr('\000a')||
'    sys sys_record;'||unistr('\000a')||
'    kenmerk_err kenmerk_err_rec;'||unistr('\000a')||
'    v_loopcnt number;'||unistr('\000a')||
'    v_msg apps_checks.msgstr%TYPE;'||unistr('\000a')||
'    v_mgmt_waarde kostelementen.waarde%TYPE;'||unistr('\000a')||
'    v_arch_waarde kostelementen.waarde%TYPE;'||unistr('\000a')||
'    v_migratie system_cost.migratie%TYPE;'||unistr('\000a')||
'    v_eosl_kost system_cost.eosl_kost%TYPE;'||unistr('\000a')||
'    v_project_kost system_cost.project_kost%TYPE;'||unistr('\000a')||
'    v_totale_kost system_cost.totale';

s:=s||'_kost%TYPE;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    FUNCTION get_cost_kenm(kenmerk IN kostelementen.functie%TYPE)'||unistr('\000a')||
'    RETURN kostelementen.waarde%TYPE'||unistr('\000a')||
'    AS'||unistr('\000a')||
'        v_waarde kostelementen.waarde%TYPE;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        SELECT waarde INTO v_waarde'||unistr('\000a')||
'        FROM kostelementen'||unistr('\000a')||
'        WHERE functie = kenmerk'||unistr('\000a')||
'        AND element = ''Server'';'||unistr('\000a')||
'        RETURN v_waarde;'||unistr('\000a')||
'    ';

s:=s||'EXCEPTION'||unistr('\000a')||
'        WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'            IF (NOT kenmerk_err.EXISTS(kenmerk)) THEN'||unistr('\000a')||
'                p_log(proc_name, ''E'', ''Kenmerk '' || kenmerk || '' niet gevonden in Tabel Kostelementen'');'||unistr('\000a')||
'                kenmerk_err(kenmerk) := 1;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'            RETURN 0;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'            err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'            err_num:= SQLCODE;'||unistr('\000a')||
'           ';

s:=s||' err_line := $$PLSQL_LINE;'||unistr('\000a')||
'            p_log(proc_name, ''E'', ''Procedure get_cost_kenm, onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg); '||unistr('\000a')||
'            RETURN 0;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    FUNCTION get_cost(kenmerken IN component.kenmerken%TYPE) '||unistr('\000a')||
'        RETURN system_cost.migratie%TYPE'||unistr('\000a')||
'    AS'||unistr('\000a')||
'        k_array string_fnc.t_array;'||unistr('\000a')||
'        v_cost system_cost.migratie%TYPE := 0;'||unistr('\000a')||
'    ';

s:=s||'BEGIN'||unistr('\000a')||
'        k_array := string_fnc.split(kenmerken, '';'');'||unistr('\000a')||
'        FOR cnt IN 1..k_array.COUNT LOOP'||unistr('\000a')||
'            v_cost := v_cost + get_cost_kenm(k_array(cnt));'||unistr('\000a')||
'        END LOOP;'||unistr('\000a')||
'        IF (v_cost = 0) THEN '||unistr('\000a')||
'            v_cost := get_cost_kenm(''Default'');'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        RETURN v_cost;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    FUNCTION get_eosl_factor(cmdb_id_in IN cons_eosl.cmdb_id%TYPE)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    ';

s:=s||'    v_eosl_factor number := 0;'||unistr('\000a')||
'        eosl eosl_rec;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        -- Find EOSL date in cons_eosl'||unistr('\000a')||
'        SELECT min(uitdovend_datum), min(uitgedoofd_datum)'||unistr('\000a')||
'        INTO eosl'||unistr('\000a')||
'        FROM cons_eosl'||unistr('\000a')||
'        WHERE cmdb_id = cmdb_id_in;'||unistr('\000a')||
'        IF (length(eosl.uitgedoofd_datum) > 2) THEN'||unistr('\000a')||
'            IF (eosl.uitgedoofd_datum < cut_eosl.uitgedoofd_datum) THEN'||unistr('\000a')||
'                v_eosl_factor := fct.';

wwv_flow_api.append_to_install_script(
  p_id => 71349331904163432 + wwv_flow_api.g_id_offset,
  p_flow_id => wwv_flow.g_flow_id,
  p_script_clob => s);
end;
 
 
end;
/

 
begin
 
declare
    s varchar2(32767) := null;
begin
s:=s||'uitgedoofd;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        IF (length(eosl.uitdovend_datum) > 2) THEN'||unistr('\000a')||
'            IF (eosl.uitdovend_datum < cut_eosl.uitdovend_datum) THEN'||unistr('\000a')||
'                IF (fct.uitdovend > v_eosl_factor) THEN'||unistr('\000a')||
'                    v_eosl_factor := fct.uitdovend;'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        RETURN v_eosl_factor;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN NO_DAT';

s:=s||'A_FOUND THEN'||unistr('\000a')||
'        RETURN v_eosl_factor;'||unistr('\000a')||
'        WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Procedure get_eosl_factor, onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg); '||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    EXECUTE IM';

s:=s||'MEDIATE ''truncate table system_cost'';'||unistr('\000a')||
'    -- Get values from kostelementen'||unistr('\000a')||
'    SELECT waarde INTO v_mgmt_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Management'';'||unistr('\000a')||
'    SELECT waarde INTO v_arch_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Architectuur'';'||unistr('\000a')||
'    SELECT datum, waarde'||unistr('\000a')||
'    INTO cut_eosl.uitdovend_datum, fct.uitdovend'||unistr('\000a')||
' ';

s:=s||'   FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''uitdovend'';'||unistr('\000a')||
'    SELECT datum, waarde'||unistr('\000a')||
'    INTO cut_eosl.uitgedoofd_datum, fct.uitgedoofd'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''uitgedoofd'';'||unistr('\000a')||
'    OPEN sys_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH sys_cursor INTO sys;'||unistr('\000a')||
'        EXIT WHEN sys_cursor%NOTFOUND;'||unistr('\000a')||
'        -- limitcnt := limitcnt + 1;'||unistr('\000a')||
'        -- EXIT WHEN limitcnt > 5;'||unistr('\000a')||
'        -- dbms_output.put_line(''Inv';

s:=s||'estigate '' || sw_comp.naam);'||unistr('\000a')||
'        -- Reset variables'||unistr('\000a')||
'        v_loopcnt := 0;'||unistr('\000a')||
'        v_msg := '''';'||unistr('\000a')||
'        v_migratie := get_cost(sys.kenmerken);'||unistr('\000a')||
'        IF ((sys.omgeving like ''T%'') OR (sys.omgeving like ''O%'')) THEN'||unistr('\000a')||
'            v_migratie := v_migratie / 3;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        v_eosl_kost := v_migratie * get_eosl_factor(sys.cmdb_id);'||unistr('\000a')||
'        v_project_kost := ((v_migratie + v_eosl_kost) * v';

s:=s||'_mgmt_waarde) + ((v_migratie + v_eosl_kost) * v_arch_waarde);'||unistr('\000a')||
'        v_totale_kost := v_migratie + v_eosl_kost + v_project_kost;'||unistr('\000a')||
'        -- Save the resuls'||unistr('\000a')||
'        INSERT INTO system_cost (cmdb_id, naam, migratie, project_kost, eosl_kost, totale_kost)'||unistr('\000a')||
'        VALUES (sys.cmdb_id, sys.naam, v_migratie, v_project_kost, v_eosl_kost, v_totale_kost);'||unistr('\000a')||
'        '||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''';

s:=s||'End Procedure'');'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err_num || '' msg: '' || err_msg);'||unistr('\000a')||
'   '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
'CREATE OR REPLACE PROCEDURE  "P_SYSTEM_USED_BY" '||unistr('\000a')||
'    IS'||unistr('\000a')||
'    proc_name CONSTANT logtbl.evt_proc%TYPE := ''p_system_used_by''';

s:=s||';'||unistr('\000a')||
'    limitcnt number := 0;'||unistr('\000a')||
'    '||unistr('\000a')||
'    CURSOR sys_cursor IS'||unistr('\000a')||
'    select r.cmdb_id_source, r.naam_source, r.cmdb_id_target, r.naam_target, c.omgeving '||unistr('\000a')||
'    from relations r, system_cost s, component c '||unistr('\000a')||
'    where r.cmdb_id_target = s.cmdb_id '||unistr('\000a')||
'      and r.ci_type_source = ''Toepassingomgeving'''||unistr('\000a')||
'      and (not(r.cmdb_id_source in (select cmdb_id_comp from srv2apps)))'||unistr('\000a')||
'      and s.cmdb_id = c.cmdb_id;'||unistr('\000a')||
'    TYP';

s:=s||'E sys_record IS RECORD ('||unistr('\000a')||
'        cmdb_id_appl component.cmdb_id%TYPE,'||unistr('\000a')||
'        naam_appl component.naam%TYPE,'||unistr('\000a')||
'        cmdb_id_comp component.cmdb_id%TYPE,'||unistr('\000a')||
'        naam_comp component.naam%TYPE,'||unistr('\000a')||
'        omgeving component.omgeving%TYPE);'||unistr('\000a')||
'    TYPE eosl_rec IS RECORD ('||unistr('\000a')||
'        uitdovend_datum DATE,'||unistr('\000a')||
'        uitgedoofd_datum DATE);'||unistr('\000a')||
'    TYPE fct_rec IS RECORD ('||unistr('\000a')||
'        uitdovend kostelementen.waarde%TYPE';

s:=s||','||unistr('\000a')||
'        uitgedoofd kostelementen.waarde%TYPE);'||unistr('\000a')||
'    '||unistr('\000a')||
'    eosl eosl_rec;'||unistr('\000a')||
'    cut_eosl eosl_rec;'||unistr('\000a')||
'    fct fct_rec;'||unistr('\000a')||
'    sys sys_record;'||unistr('\000a')||
'    v_msg apps_checks.msgstr%TYPE;'||unistr('\000a')||
'    v_mgmt_waarde kostelementen.waarde%TYPE;'||unistr('\000a')||
'    v_arch_waarde kostelementen.waarde%TYPE;'||unistr('\000a')||
'    v_def_waarde kostelementen.waarde%TYPE;'||unistr('\000a')||
'    v_migratie system_cost.migratie%TYPE;'||unistr('\000a')||
'    v_assessment system_cost.migratie%TYPE;'||unistr('\000a')||
'    v_eosl_k';

s:=s||'ost system_cost.eosl_kost%TYPE;'||unistr('\000a')||
'    v_project_kost system_cost.project_kost%TYPE;'||unistr('\000a')||
'    v_totale_kost system_cost.totale_kost%TYPE;'||unistr('\000a')||
'    v_eosl_factor number;'||unistr('\000a')||
'    err_num number;'||unistr('\000a')||
'    err_line number;'||unistr('\000a')||
'    err_msg varchar2(255);'||unistr('\000a')||
'    -- Find EOSL information for this CMDB ID. '||unistr('\000a')||
'    -- Verify if uitdovend_date / uitgedoofd_date is OLDER than what is known already'||unistr('\000a')||
'    -- Remember oldest date.'||unistr('\000a')||
'    PROCEDURE';

s:=s||' handle_eosl(in_cmdb_id IN component.cmdb_id%TYPE, ci_eosl OUT eosl_rec)'||unistr('\000a')||
'    IS'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        -- There should be only one record in cons_eosl, '||unistr('\000a')||
'        -- but to be on the safe side....'||unistr('\000a')||
'        SELECT min(uitdovend_datum), min(uitgedoofd_datum)'||unistr('\000a')||
'        INTO ci_eosl'||unistr('\000a')||
'        FROM cons_eosl'||unistr('\000a')||
'        WHERE cmdb_id = in_cmdb_id;'||unistr('\000a')||
'    EXCEPTION'||unistr('\000a')||
'        WHEN NO_DATA_FOUND THEN'||unistr('\000a')||
'        -- No issue when ';

s:=s||'no data is found'||unistr('\000a')||
'        RETURN;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'    '||unistr('\000a')||
'    FUNCTION get_eosl_factor(eosl IN eosl_rec)'||unistr('\000a')||
'    RETURN number'||unistr('\000a')||
'    IS'||unistr('\000a')||
'        v_eosl_factor number := 0;'||unistr('\000a')||
'    BEGIN'||unistr('\000a')||
'        IF (length(eosl.uitgedoofd_datum) > 2) THEN'||unistr('\000a')||
'            IF (eosl.uitgedoofd_datum < cut_eosl.uitgedoofd_datum) THEN'||unistr('\000a')||
'                v_eosl_factor := fct.uitgedoofd;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        IF (length(eosl.uit';

s:=s||'dovend_datum) > 2) THEN'||unistr('\000a')||
'            IF (eosl.uitdovend_datum < cut_eosl.uitdovend_datum) THEN'||unistr('\000a')||
'                IF (fct.uitdovend > v_eosl_factor) THEN'||unistr('\000a')||
'                    v_eosl_factor := fct.uitdovend;'||unistr('\000a')||
'                END IF;'||unistr('\000a')||
'            END IF;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        RETURN v_eosl_factor;'||unistr('\000a')||
'    END;'||unistr('\000a')||
'BEGIN'||unistr('\000a')||
'    p_log(proc_name, ''I'', ''Start Procedure'');'||unistr('\000a')||
'    '||unistr('\000a')||
'    -- Get values from kostelementen'||unistr('\000a')||
'    S';

s:=s||'ELECT waarde INTO v_mgmt_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Management'';'||unistr('\000a')||
'    SELECT waarde INTO v_arch_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Architectuur'';'||unistr('\000a')||
'    SELECT waarde INTO v_def_waarde'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''Project'''||unistr('\000a')||
'      AND functie = ''Default'';'||unistr('\000a')||
'    '||unistr('\000a')||
'    SELECT datum, waarde'||unistr('\000a')||
'    I';

s:=s||'NTO cut_eosl.uitdovend_datum, fct.uitdovend'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''uitdovend'';'||unistr('\000a')||
'    SELECT datum, waarde'||unistr('\000a')||
'    INTO cut_eosl.uitgedoofd_datum, fct.uitgedoofd'||unistr('\000a')||
'    FROM kostelementen'||unistr('\000a')||
'    WHERE element = ''uitgedoofd'';'||unistr('\000a')||
'    OPEN sys_cursor;'||unistr('\000a')||
'    LOOP'||unistr('\000a')||
'        FETCH sys_cursor INTO sys;'||unistr('\000a')||
'        EXIT WHEN sys_cursor%NOTFOUND;'||unistr('\000a')||
'        -- Found Application that is using isolated server'||unistr('\000a')||
'    ';

s:=s||'    -- Get Server EOSL Information'||unistr('\000a')||
'        handle_eosl(sys.cmdb_id_comp, eosl);'||unistr('\000a')||
'        v_eosl_factor := get_eosl_factor(eosl);'||unistr('\000a')||
'        '||unistr('\000a')||
'        v_migratie := v_def_waarde;'||unistr('\000a')||
'        IF ((sys.omgeving like ''T%'') OR (sys.omgeving like ''O%'')) THEN'||unistr('\000a')||
'            v_migratie := v_migratie / 3;'||unistr('\000a')||
'        END IF;'||unistr('\000a')||
'        v_assessment := v_migratie / 4;'||unistr('\000a')||
'        v_eosl_kost := v_migratie * v_eosl_factor;'||unistr('\000a')||
'       ';

s:=s||' v_project_kost := ((v_migratie + v_eosl_kost) * v_mgmt_waarde) + ((v_migratie + v_eosl_kost) * v_arch_waarde);'||unistr('\000a')||
'        v_totale_kost := v_migratie + v_eosl_kost + v_project_kost;'||unistr('\000a')||
'        -- Save the resuls'||unistr('\000a')||
'        UPDATE apps_checks set migratie = migratie + v_migratie,'||unistr('\000a')||
'                               assessment = assessment + v_assessment,'||unistr('\000a')||
'                               eosl_kost = eosl_kost + v_';

s:=s||'eosl_kost,'||unistr('\000a')||
'                               project_kost = project_kost + v_project_kost,'||unistr('\000a')||
'                               totale_kost = totale_kost + v_totale_kost'||unistr('\000a')||
'        WHERE cmdb_id = sys.cmdb_id_appl;'||unistr('\000a')||
'        '||unistr('\000a')||
'        -- Add to srv2apps'||unistr('\000a')||
'        INSERT INTO srv2apps (cmdb_id_comp, naam_comp, cmdb_id_appl, naam_appl) '||unistr('\000a')||
'        VALUES (sys.cmdb_id_comp, sys.naam_comp, sys.cmdb_id_appl, sys.naam_appl';

s:=s||');'||unistr('\000a')||
'        -- Remove from system_cost'||unistr('\000a')||
'        DELETE FROM system_cost'||unistr('\000a')||
'        WHERE cmdb_id = sys.cmdb_id_comp;'||unistr('\000a')||
'        '||unistr('\000a')||
'    END LOOP; '||unistr('\000a')||
'    p_log(proc_name, ''I'', ''End Procedure'');'||unistr('\000a')||
'EXCEPTION'||unistr('\000a')||
'    WHEN OTHERS THEN'||unistr('\000a')||
'        err_msg:= SUBSTR(SQLERRM, 1, 100);'||unistr('\000a')||
'        err_num:= SQLCODE;'||unistr('\000a')||
'        err_line := $$PLSQL_LINE;'||unistr('\000a')||
'        p_log(proc_name, ''E'', ''Onverwachte fout lijn: '' || err_line || '' nr: '' || err';

s:=s||'_num || '' msg: '' || err_msg);'||unistr('\000a')||
'   '||unistr('\000a')||
'END;'||unistr('\000a')||
'/'||unistr('\000a')||
''||unistr('\000a')||
' CREATE SEQUENCE   "CMWBT0011_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 8894366 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "LOGTBL_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 645871 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "COMPONENT_SEQ"  MINVALUE 1 MAXVALUE 999999999999';

s:=s||'9999999999999999 INCREMENT BY 1 START WITH 652606 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "RELATIONS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 885640 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "JOB_CHECKS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 18354 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "SW_CHECKS_';

s:=s||'SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 86848 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "KOSTELEMENTEN_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 53 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "SYSTEM_CHECKS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 39612 NOCACHE  NOORDER  ';

s:=s||'NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "CONS_CIS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 654532 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "DERIVED_LOCATIONS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 47009 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "CONS_EOSL_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREME';

s:=s||'NT BY 1 START WITH 652920 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "APPS_CHECKS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 25362 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "APPS_CIS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 94215 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "NETWERK_SEQ"  MINVALUE 1 MAXVALUE 9';

s:=s||'999999999999999999999999999 INCREMENT BY 1 START WITH 748 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "SYSTEM_COST_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 3571 NOCACHE  NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUENCE   "SYSTEM_VERIFICATION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1501 CACHE 20 NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
' CREATE SEQUEN';

s:=s||'CE   "SRV2APPS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 29481 CACHE 20 NOORDER  NOCYCLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "BI_CONS_EOSL" '||unistr('\000a')||
'  before insert on "CONS_EOSL"               '||unistr('\000a')||
'  for each row  '||unistr('\000a')||
'begin   '||unistr('\000a')||
'  if :NEW."ID" is null then '||unistr('\000a')||
'    select "CONS_EOSL_SEQ".nextval into :NEW."ID" from dual; '||unistr('\000a')||
'  end if; '||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "BI_CONS_EOSL" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE ';

s:=s||'OR REPLACE TRIGGER  "LOGTBL_T1" '||unistr('\000a')||
'BEFORE'||unistr('\000a')||
'insert on "LOGTBL"'||unistr('\000a')||
'for each row'||unistr('\000a')||
'begin'||unistr('\000a')||
'if :NEW."EVT_IDX" is null then '||unistr('\000a')||
'    select "LOGTBL_SEQ".nextval into :NEW."EVT_IDX" from sys.dual; '||unistr('\000a')||
'end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "LOGTBL_T1" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_APPS_CHECKS" '||unistr('\000a')||
'  before insert on "APPS_CHECKS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "APPS_CHECKS_SEQ';

s:=s||'".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_APPS_CHECKS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_APPS_CIS" '||unistr('\000a')||
'  before insert on "APPS_CIS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "APPS_CIS_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_APPS_CIS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_CMWBT0011" '||unistr('\000a')||
'  ';

s:=s||'before insert on "CMWBT0011"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "CMWBT0011_SEQ".nextval into :new."ID" from dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_CMWBT0011" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_COMPONENT" '||unistr('\000a')||
'  before insert on "COMPONENT"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "COMPONENT_SEQ".nextval into :new."ID';

s:=s||'" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_COMPONENT" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_CONS_CIS" '||unistr('\000a')||
'  before insert on "CONS_CIS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "CONS_CIS_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_CONS_CIS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_DERIVED_LOCATIONS" '||unistr('\000a')||
'  before insert on ';

s:=s||'"DERIVED_LOCATIONS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "DERIVED_LOCATIONS_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_DERIVED_LOCATIONS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_JOB_CHECKS" '||unistr('\000a')||
'  before insert on "JOB_CHECKS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "JOB_CHECKS_SEQ".nextval';

s:=s||' into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_JOB_CHECKS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_KOSTELEMENTEN" '||unistr('\000a')||
'  before insert on "KOSTELEMENTEN"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "KOSTELEMENTEN_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_KOSTELEMENTEN" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_NETW';

s:=s||'ERK" '||unistr('\000a')||
'  before insert on "NETWERK"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "NETWERK_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_NETWERK" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_RELATIONS" '||unistr('\000a')||
'  before insert on "RELATIONS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "RELATIONS_SEQ".nextval into :n';

s:=s||'ew."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_RELATIONS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_SRV2APPS" '||unistr('\000a')||
'  before insert on "SRV2APPS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "SRV2APPS_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
''||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_SRV2APPS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_SW_CHECKS" '||unistr('\000a')||
'  before insert on "';

s:=s||'SW_CHECKS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "SW_CHECKS_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_SW_CHECKS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_SYSTEM_CHECKS" '||unistr('\000a')||
'  before insert on "SYSTEM_CHECKS"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "SYSTEM_CHECKS_SEQ".nextval into :new."ID" ';

s:=s||'from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_SYSTEM_CHECKS" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_SYSTEM_COST" '||unistr('\000a')||
'  before insert on "SYSTEM_COST"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "SYSTEM_COST_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_SYSTEM_COST" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'CREATE OR REPLACE TRIGGER  "bi_SYSTEM_VERIFICATION" '||unistr('\000a')||
'  b';

s:=s||'efore insert on "SYSTEM_VERIFICATION"              '||unistr('\000a')||
'  for each row '||unistr('\000a')||
'begin  '||unistr('\000a')||
'  if :new."ID" is null then'||unistr('\000a')||
'    select "SYSTEM_VERIFICATION_SEQ".nextval into :new."ID" from sys.dual;'||unistr('\000a')||
'  end if;'||unistr('\000a')||
'end;'||unistr('\000a')||
''||unistr('\000a')||
'/'||unistr('\000a')||
'ALTER TRIGGER  "bi_SYSTEM_VERIFICATION" ENABLE'||unistr('\000a')||
'/'||unistr('\000a')||
'';

wwv_flow_api.append_to_install_script(
  p_id => 71349331904163432 + wwv_flow_api.g_id_offset,
  p_flow_id => wwv_flow.g_flow_id,
  p_script_clob => s);
end;
 
 
end;
/

--application/deployment/checks
prompt  ...application deployment checks
--
 
begin
 
null;
 
end;
/

--application/deployment/buildoptions
prompt  ...application deployment build options
--
 
begin
 
null;
 
end;
/

prompt  ...post import process
 
begin
 
wwv_flow_api.post_import_process(p_flow_id => wwv_flow.g_flow_id);
null;
 
end;
/

--application/end_environment
commit;
commit;
begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
set define on
prompt  ...done
