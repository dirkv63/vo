CREATE OR REPLACE PROCEDURE p_get_cmwbt0011_comp
    IS
    
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_comp';

    CURSOR comp_cursor IS
    select DISTINCT CI_CATEGORIE,
           CI_TYPE,
           CI_CMDB_REFERENTIE,
           CI_SYSTEEMNAAM,
           CI_STATUS,
           CI_EIGENAAR,
           KENMERKEN,
           PRODUCENT,
           PRODUCT,
           SW_VERSIE,
           OS,
           VERSIE_OS,
           HWSW,
           LOCATIE,
           OMGEVING,
           UITDOVEND_DATUM,
           UITGEDOOFD_DATUM
    from CMWBT0011;

    TYPE comp_record IS RECORD (
    ci_categorie component.ci_categorie%TYPE,
    ci_type component.ci_type%TYPE,
    CMDB_ID cmwbt0011.CI_CMDB_REFERENTIE%TYPE,
    NAAM component.NAAM%TYPE,
    status component.status%TYPE,
    eigenaar_entiteit component.eigenaar_entiteit%TYPE,
    kenmerken component.kenmerken%TYPE,
    producent component.producent%TYPE,
    product component.product%TYPE,
    versie component.versie%TYPE,
    os component.os%TYPE,
    os_versie component.os_versie%TYPE,
    hw_sw_flag component.hw_sw_flag%TYPE,
    locatie component.locatie%TYPE,
    omgeving component.omgeving%TYPE,
    uitdovend_datum cmwbt0011.uitdovend_datum%TYPE,
    uitgedoofd_datum cmwbt0011.uitgedoofd_datum%TYPE);
    
    comp comp_record;

    v_cmdb_id component.cmdb_id%TYPE;
    v_uitdovend_datum component.uitdovend_datum%TYPE;
    v_uitgedoofd_datum component.uitgedoofd_datum%TYPE;

    v_not_num_cnt number := 999000;
    v_no_date date := '21/07/1963';
    err_num number;
    err_line number;
    err_msg varchar2(255);

    FUNCTION convert2number (v_str IN varchar2)
    RETURN number
    IS
        v_nr number;
    BEGIN
        v_nr := to_number(v_str);
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde niet numeriek! *' || v_str || '*');
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
    END;
    
    FUNCTION convert2date (v_str IN varchar2)
    RETURN date
    IS
        v_nr date;
    BEGIN
        v_nr := to_date(v_str, 'yyyy/mm/dd  HH24:MI:SS');
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde geen datum! *' || v_str || '*');
            RETURN v_no_date;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            RETURN v_no_date;
    END;
    
BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN comp_cursor;
    LOOP
        FETCH comp_cursor INTO comp;
        EXIT WHEN comp_cursor%NOTFOUND;
        v_cmdb_id := convert2number(comp.cmdb_id);
        v_uitdovend_datum := convert2date(comp.uitdovend_datum);
        v_uitgedoofd_datum := convert2date(comp.uitgedoofd_datum);
        INSERT INTO component (ci_categorie, ci_type, cmdb_id, naam, status,
                               eigenaar_entiteit, producent, product, versie, os, os_versie,
                               hw_sw_flag, locatie, kenmerken, omgeving,
                               uitdovend_datum, uitgedoofd_datum)
        VALUES (comp.ci_categorie, comp.ci_type, v_cmdb_id, comp.naam, comp.status,
                comp.eigenaar_entiteit, comp.producent, comp.product, comp.versie, comp.os, comp.os_versie,
                comp.hw_sw_flag, comp.locatie, comp.kenmerken, comp.omgeving,
                v_uitdovend_datum, v_uitgedoofd_datum);
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);

END;

