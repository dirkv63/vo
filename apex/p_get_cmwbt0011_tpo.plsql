CREATE OR REPLACE PROCEDURE p_get_cmwbt0011_tpo
    IS 

    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_tpo';

    CURSOR tpo_cursor IS
    select DISTINCT
           TOEPASSINGOMGEVING,
           STATUS_TOEPASSINGOMGEVING,
           CMDB_REFERENTIE_OMGEVING,
           VERSIE,
           TYPE_OMGEVING,
           DATUM_IN_GEBRUIK,
           DATUM_BUITEN_GEBRUIK,
           DIENSTENTYPE,
           FINANCIEEL_BEHEERDER_BELEIDSD,
           FINANCIEEL_BEHEERDER_ENTITEIT,
           EIGENAAR_BELEIDSDOMEIN,
           EIGENAAR_ENTITEIT,
           NUMMER_BEDRIJFSTOEPASSING 
    from CMWBT0011
    where CMDB_REFERENTIE_OMGEVING >0;

TYPE tpo_record IS RECORD (
    NAAM component.NAAM%TYPE,
    STATUS component.STATUS%TYPE,
    CMDB_ID cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,
    VERSIE component.VERSIE%TYPE,
    OMGEVING component.OMGEVING%TYPE,
    DATUM_IN_GEBRUIK component.DATUM_IN_GEBRUIK%TYPE,
    DATUM_BUITEN_GEBRUIK component.DATUM_BUITEN_GEBRUIK%TYPE,
    DIENSTENTYPE component.DIENSTENTYPE%TYPE,
    FIN_BELEIDSDOMEIN component.FIN_BELEIDSDOMEIN%TYPE,
    FIN_ENTITEIT component.FIN_ENTITEIT%TYPE,
    EIGENAAR_BELEIDSDOMEIN component.EIGENAAR_BELEIDSDOMEIN%TYPE,
    EIGENAAR_ENTITEIT component.EIGENAAR_ENTITEIT%TYPE,
    BT_NUMMER component.BT_NUMMER%TYPE);

    tpo tpo_record;

    c_ci_class CONSTANT component.CI_CLASS%TYPE := 'toepassingcomponentinstallatie';
    v_cmdb_id component.cmdb_id%TYPE;
    
    v_not_num_cnt number := 998000;
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
    
BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN tpo_cursor;
    LOOP
        FETCH tpo_cursor INTO tpo;
        EXIT WHEN tpo_cursor%NOTFOUND;
        v_cmdb_id := convert2number(tpo.cmdb_id);
        INSERT INTO component (ci_class, naam, status, cmdb_id, versie, omgeving, datum_in_gebruik,
            datum_buiten_gebruik, dienstentype, fin_beleidsdomein, fin_entiteit, 
            eigenaar_beleidsdomein, eigenaar_entiteit, bt_nummer)
        VALUES (c_ci_class, tpo.naam, tpo.status, v_cmdb_id, tpo.versie, tpo.omgeving, tpo.datum_in_gebruik,
                tpo.datum_buiten_gebruik, tpo.dienstentype, tpo.fin_beleidsdomein, tpo.fin_entiteit, 
                tpo.eigenaar_beleidsdomein, tpo.eigenaar_entiteit, tpo.bt_nummer);
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);

END;

