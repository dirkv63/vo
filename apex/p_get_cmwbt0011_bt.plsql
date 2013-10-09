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
    CMDB_ID component.CMDB_ID%TYPE,
    NAAM component.NAAM%TYPE,
    BT_NUMMER component.BT_NUMMER%TYPE,
    SO_TOEPASSINGSMANAGER component.SO_TOEPASSINGSMANAGER%TYPE,
    VO_APPLICATIEBEHEERDER component.VO_APPLICATIEBEHEERDER%TYPE);

    bt bt_record;

    c_ci_class CONSTANT component.CI_CLASS%TYPE := 'bedrijfstoepassing';
    
BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN bt_cursor;
    LOOP
        FETCH bt_cursor INTO bt;
        EXIT WHEN bt_cursor%NOTFOUND;
        bt.cmdb_id := bt.cmdb_id + 1000000;
        -- dbms_output.put_line(RPAD('CMDB_ID: ' || bt.cmdb_id,30,'.') || ' naam: ' || bt.naam);
        INSERT INTO component (ci_class, naam, cmdb_id, bt_nummer, so_toepassingsmanager, vo_applicatiebeheerder)
        VALUES (c_ci_class, bt.naam, bt.cmdb_id, bt.bt_nummer, bt.so_toepassingsmanager, bt.vo_applicatiebeheerder);
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

END;​

