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
           LOCATIE 
    from CMWBT0011;

    TYPE comp_record IS RECORD (
    ci_categorie component.ci_categorie%TYPE,
    ci_type component.ci_type%TYPE,
    CMDB_ID component.CMDB_ID%TYPE,
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
    locatie component.locatie%TYPE);
    
    comp comp_record;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN comp_cursor;
    LOOP
        FETCH comp_cursor INTO comp;
        EXIT WHEN comp_cursor%NOTFOUND;
        -- dbms_output.put_line(RPAD('CMDB_ID: ' || comp.cmdb_id,30,'.') || ' naam: ' || comp.naam);
        INSERT INTO component (ci_categorie, ci_type, cmdb_id, naam, status,
                               eigenaar_entiteit, producent, product, versie, os, os_versie,
                               hw_sw_flag, locatie, kenmerken)
        VALUES (comp.ci_categorie, comp.ci_type, comp.cmdb_id, comp.naam, comp.status,
                comp.eigenaar_entiteit, comp.producent, comp.product, comp.versie, comp.os, comp.os_versie,
                comp.hw_sw_flag, comp.locatie, comp.kenmerken);
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

END;​

