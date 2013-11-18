CREATE OR REPLACE PROCEDURE p_get_cmwbt0011_bt
    IS
    
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_bt';

    CURSOR bt_cursor IS
    select DISTINCT CMDB_REFERENTIE_BEDRIJFSTOEPAS,
                    NAAM_BEDRIJFSTOEPASSING,
                    NUMMER_BEDRIJFSTOEPASSING,
                    SO_TOEPASSINGSMANAGERS,
                    VO_APPLICATIEBEHEERDERS 
    from CMWBT0011
    where length(NAAM_BEDRIJFSTOEPASSING) > 0;

    TYPE bt_record IS RECORD (
        CMDB_ID cmwbt0011.CMDB_REFERENTIE_BEDRIJFSTOEPAS%TYPE,
        NAAM component.NAAM%TYPE,
        BT_NUMMER component.BT_NUMMER%TYPE,
        SO_TOEPASSINGSMANAGER component.SO_TOEPASSINGSMANAGER%TYPE,
        VO_APPLICATIEBEHEERDER component.VO_APPLICATIEBEHEERDER%TYPE);

    v_cmdb_id component.cmdb_id%TYPE;

    bt bt_record;

    c_ci_class CONSTANT component.CI_CLASS%TYPE := 'bedrijfstoepassing';

    v_not_num_cnt number := 999000;
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
    
    OPEN bt_cursor;
    LOOP
        FETCH bt_cursor INTO bt;
        EXIT WHEN bt_cursor%NOTFOUND;
        v_cmdb_id := convert2number(bt.cmdb_id);
        v_cmdb_id := v_cmdb_id + 1000000;
        INSERT INTO component (ci_class, naam, cmdb_id, bt_nummer, so_toepassingsmanager, vo_applicatiebeheerder)
        VALUES (c_ci_class, bt.naam, v_cmdb_id, bt.bt_nummer, bt.so_toepassingsmanager, bt.vo_applicatiebeheerder);
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');

EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);

END;

