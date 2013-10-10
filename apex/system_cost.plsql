DECLARE

    proc_name CONSTANT logtbl.evt_proc%TYPE := 'system_cost';

    limitcnt number := 0;
    
    CURSOR sys_cursor IS
    select s.cmdb_id, s.naam, c.kenmerken, c.omgeving
    from SYSTEM_CHECKS s, COMPONENT c
    where c.locatie = 'Boudewijn - Brussel/-1C Computerzaal'
    and s.sw_cnt = 0
        and s.job_cnt = 0
    and s.cmdb_id not in (select distinct cmdb_id from netwerk where cmdb_id is not null)
    and s.cmdb_id = c.cmdb_id;

    TYPE sys_record IS RECORD (
        cmdb_id component.cmdb_id%TYPE,
        naam component.naam%TYPE,
        kenmerken component.kenmerken%TYPE,
        omgeving component.omgeving%TYPE);
    
    sys sys_record;

    v_loopcnt number;
    v_msg apps_checks.msgstr%TYPE;
    v_mgmt_waarde kostelementen.waarde%TYPE;
    v_arch_waarde kostelementen.waarde%TYPE;
    v_migratie system_cost.migratie%TYPE;
    v_project_kost system_cost.project_kost%TYPE;
    v_totale_kost system_cost.totale_kost%TYPE;

    FUNCTION get_cost_kenm(kenmerk IN kostelementen.functie%TYPE)
    RETURN kostelementen.waarde%TYPE
    AS
        v_waarde kostelementen.waarde%TYPE;
    BEGIN
        SELECT waarde INTO v_waarde
        FROM kostelementen
        WHERE functie = kenmerk
        AND element = 'Server';
        RETURN v_waarde;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_log(proc_name, 'E', 'Kenmerk ' || kenmerk || ' niet gevonden in Tabel Kostelementen');
            RETURN 0;
--        WHEN OTHERS THEN
--            p_log(proc_name, 'E', 'Onverwachte fout bij berekening kosten per functie.');
--            RETURN 0;
    END;

    FUNCTION get_cost(kenmerken IN component.kenmerken%TYPE) 
        RETURN system_cost.migratie%TYPE
    AS
        k_array string_fnc.t_array;
        v_cost system_cost.migratie%TYPE := 0;
    BEGIN
        k_array := string_fnc.split(kenmerken, ';');
        FOR cnt IN 1..k_array.COUNT LOOP
            v_cost := v_cost + get_cost_kenm(k_array(cnt));
        END LOOP;
        IF (v_cost = 0) THEN 
            v_cost := get_cost_kenm('Default');
        END IF;
        RETURN v_cost;
    END;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table system_cost';

    -- Get values from kostelementen
    SELECT waarde INTO v_mgmt_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Management';

    SELECT waarde INTO v_arch_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Architectuur';

    OPEN sys_cursor;
    LOOP
        FETCH sys_cursor INTO sys;
        EXIT WHEN sys_cursor%NOTFOUND;
        -- limitcnt := limitcnt + 1;
        -- EXIT WHEN limitcnt > 5;
        -- dbms_output.put_line('Investigate ' || sw_comp.naam);
        -- Reset variables
        v_loopcnt := 0;
        v_msg := '';
        v_migratie := get_cost(sys.kenmerken);
        v_project_kost := (v_migratie * v_mgmt_waarde) + (v_migratie * v_arch_waarde);
        v_totale_kost := v_migratie + v_project_kost;
        IF ((sys.omgeving = 'T') OR (sys.omgeving = 'O')) THEN
            v_migratie := v_migratie / 3;
        END IF;

        -- Save the resuls
        INSERT INTO system_cost (cmdb_id, naam, migratie, project_kost, totale_kost)
        VALUES (sys.cmdb_id, sys.naam, v_migratie, v_project_kost, v_totale_kost);
        
    END LOOP; 
   
END;
