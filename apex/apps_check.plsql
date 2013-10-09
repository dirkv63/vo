DECLARE

    proc_name CONSTANT logtbl.evt_proc%TYPE := 'apps_check';

    limitcnt number := 0;
    
    CURSOR apps_cursor IS
    select *
    from COMPONENT
    where CI_class = 'toepassingcomponentinstallatie';

    apps component%ROWTYPE;

    TYPE rel_rec IS RECORD (
        cmdb_id component.cmdb_id%TYPE,
        naam component.naam%TYPE);

    rel rel_rec;

    v_loopcnt number;
    v_msg apps_checks.msgstr%TYPE;
    v_sw_cnt apps_checks.sw_cnt%TYPE;
    v_sw_cnt_bou apps_checks.sw_cnt_bou%TYPE;
    v_job_cnt apps_checks.job_cnt%TYPE;
    v_job_cnt_bou apps_checks.job_cnt_bou%TYPE;
    v_assessment apps_checks.assessment%TYPE;
    v_migratie apps_checks.migratie%TYPE;
    v_connections apps_checks.connections%TYPE;
    v_comp apps_checks.comp%TYPE;
    v_no_comp apps_checks.no_comp%TYPE;
    v_mgmt_waarde kostelementen.waarde%TYPE := -1;
    v_arch_waarde kostelementen.waarde%TYPE := -1;
    v_def_waarde kostelementen.waarde%TYPE := -1;

    PROCEDURE go_down(next_rel IN rel_rec)
    IS

        CURSOR src_rel_cursor IS
        SELECT CMDB_ID_TARGET,
               NAAM_TARGET,
               CI_TYPE_TARGET,
               CI_CATEGORIE_TARGET
        FROM RELATIONS
        WHERE CMDB_ID_SOURCE = next_rel.cmdb_id
          AND RELATION = 'is afhankelijk van';

        TYPE src_rel_type IS RECORD (
            cmdb_id relations.cmdb_id_target%TYPE,
            naam relations.naam_target%TYPE,
            ci_type relations.ci_type_target%TYPE,
            ci_categorie relations.ci_categorie_target%TYPE);

        src_rel src_rel_type;
        this_sw sw_checks%ROWTYPE;
        thislocation number;

    BEGIN
        p_log(proc_name, 'T', 'In go down searching for ' || next_rel.cmdb_id);
        v_loopcnt := v_loopcnt + 1;
        IF v_loopcnt > 100 THEN
            p_log(proc_name, 'F', 'Loop Count exceeded');
            RETURN;
        END IF;
        
        OPEN src_rel_cursor;
        LOOP
            p_log(proc_name, 'T', 'Before Fetch relation table');
            FETCH src_rel_cursor INTO src_rel;
            EXIT WHEN src_rel_cursor%NOTFOUND;

            -- Get Derived Location for this component
            SELECT count(*) INTO thislocation
            FROM derived_locations
            WHERE cmdb_id = src_rel.cmdb_id;

p_log(proc_name, 'T', 'Found ID ' || src_rel.cmdb_id || ' Type: ' || src_rel.ci_type);
            IF ((src_rel.ci_type = 'ANDERE TOEP.COMP.INSTALL.') OR
                (src_rel.ci_type = 'DB TOEP.COMP-INSTALL.') OR
                (src_rel.ci_type = 'RAPPORTEN') OR
                (src_rel.ci_type = 'TOEP.COMP. COLLAB. SYST.') OR
                (src_rel.ci_type = 'WEB TOEP.COMP-INSTALL.')) THEN
                v_sw_cnt := v_sw_cnt + 1;
                IF (thislocation > 0) THEN
                    v_sw_cnt_bou := v_sw_cnt_bou + 1;
                END IF;
p_log(proc_name, 'T', 'Found sw component');
                SELECT * INTO this_sw
                FROM sw_checks
                WHERE sw_id = src_rel.cmdb_id;
            ELSIF ((src_rel.ci_type = 'JOB INSTALL. (ANDERE)') OR
                  (src_rel.ci_type = 'JOB INSTALL. (CRON)') OR
                  (src_rel.ci_type = 'JOB INSTALL. (CTRL-M)') OR
                  (src_rel.ci_type = 'JOB INSTALL. (WIN)') OR
                  (src_rel.ci_type = 'JOBCLUSTER INSTALL.')) THEN
                v_job_cnt := v_job_cnt + 1;
                IF (thislocation > 0) THEN
                    v_job_cnt_bou := v_job_cnt_bou + 1;
                END IF;
p_log(proc_name, 'T', 'Found job component');
                SELECT * INTO this_sw
                FROM job_checks
                WHERE sw_id = src_rel.cmdb_id;
            ELSE
                v_msg := v_msg || 'SW/Job Component verwacht, ' || src_rel.ci_type || ' gevonden. ID: ' || src_rel.cmdb_id;
                RETURN;
            END IF;
p_log(proc_name, 'T', 'Handling whatever component I found');
            v_connections := v_connections + this_sw.connections;
            v_assessment := v_assessment + this_sw.assessment;
            IF (thislocation > 0) THEN
                v_migratie := v_migratie + this_sw.migratie;
            END IF;
            IF (length(this_sw.comp_naam) > 0) THEN
                v_comp := v_comp + 1;
            ELSE 
                v_no_comp := v_no_comp + 1;
            END IF;

p_log(proc_name, 'T', 'Ready to insert into apps_cis');
            -- Remember Applicatie - Component Link
            INSERT INTO apps_cis (cmdb_id_src, naam_src, 
                cmdb_id_tgt, naam_tgt, ci_type_tgt, ci_categorie_tgt)
            VALUES (next_rel.cmdb_id, next_rel.naam, 
                src_rel.cmdb_id, src_rel.naam, src_rel.ci_type, src_rel.ci_categorie);

        END LOOP;

    END;

    PROCEDURE save_results(apps IN component%ROWTYPE) 
    IS
        v_work_kost number := 0;
        v_project_kost apps_checks.project_kost%TYPE;
        v_totale_kost apps_checks.totale_kost%TYPE;
    BEGIN
        IF (v_comp = 0)  THEN
            v_msg := v_msg || 'Applicatie kan niet aan computer gelinkt worden. * ';
        END IF;
        IF (v_sw_cnt_bou = 0) THEN
            v_assessment := 0;
            v_migratie := 0;
        END IF;
        -- Default cost if only Job Components on path from computer to application
        IF ((v_job_cnt_bou > 0) AND ((v_assessment + v_migratie ) = 0)) THEN
            v_assessment := v_def_waarde;
            v_migratie := v_def_waarde;
        END IF;
        v_work_kost := v_assessment + v_migratie;
        v_project_kost := (v_work_kost * v_mgmt_waarde) + (v_work_kost * v_arch_waarde);
        v_totale_kost := v_assessment + v_migratie + v_project_kost;
        INSERT INTO apps_checks (cmdb_id, naam, dienstentype, eigenaar_beleidsdomein, 
             eigenaar_entiteit, fin_beleidsdomein, fin_entiteit,
             connections, comp, no_comp, sw_cnt, sw_cnt_bou, job_cnt, 
             job_cnt_bou, assessment, migratie, project_kost, totale_kost, 
             so_toepassingsmanager, vo_applicatiebeheerder, msgstr)
        VALUES (apps.cmdb_id, apps.naam, apps.dienstentype, apps.eigenaar_beleidsdomein, 
             apps.eigenaar_entiteit, apps.fin_beleidsdomein, apps.fin_entiteit,
             v_connections, v_comp, v_no_comp, v_sw_cnt, v_sw_cnt_bou, v_job_cnt, 
             v_job_cnt_bou, v_assessment, v_migratie, v_project_kost, v_totale_kost, 
             apps.so_toepassingsmanager, apps.vo_applicatiebeheerder, v_msg);
    END;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table apps_checks';
    EXECUTE IMMEDIATE 'truncate table apps_cis';

    -- Get values from kostelementen
p_log(proc_name, 'T', 'Get kostelementen');
    SELECT waarde INTO v_mgmt_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Management';

    SELECT waarde INTO v_arch_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Architectuur';

    SELECT waarde INTO v_def_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Default';

        p_log(proc_name, 'T', 'Open Cursor');
    OPEN apps_cursor;
    LOOP
        FETCH apps_cursor INTO apps;
        EXIT WHEN apps_cursor%NOTFOUND;
        -- limitcnt := limitcnt + 1;
        -- EXIT WHEN limitcnt > 5;
        -- dbms_output.put_line('Investigate ' || sw_comp.naam);
        -- Reset variables
        v_loopcnt := 0;
        v_msg := '';
        v_sw_cnt := 0;
        v_sw_cnt_bou := 0;
        v_job_cnt := 0;
        v_job_cnt_bou := 0;
        v_assessment := 0;
        v_migratie := 0;
        v_connections := 0;
        
        rel.cmdb_id := apps.cmdb_id;
        rel.naam := apps.naam;
        p_log(proc_name, 'T', 'Going Down');
        go_down(rel);
        save_results(apps);
        
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

-- EXCEPTION
--    WHEN OTHERS THEN
--         dbms_output.put_line( dbms_utility.format_error_backtrace );
        
END;

