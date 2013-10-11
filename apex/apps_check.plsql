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

    TYPE eosl_rec IS RECORD (
        uitdovend_datum DATE,
        uitgedoofd_datum DATE);

    TYPE fct_rec IS RECORD (
        uitdovend kostelementen.waarde%TYPE,
        uitgedoofd kostelementen.waarde%TYPE);

    eosl eosl_rec;
    cut_eosl eosl_rec;
    rel rel_rec;
    fct fct_rec;

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

    FUNCTION get_smallest(left_date IN DATE, right_date IN DATE)
    RETURN date
    IS
    BEGIN
        IF ((length(left_date) > 2) AND (length(right_date) > 2)) THEN
           RETURN least(left_date, right_date);
        ELSIF (length(left_date) IS NULL) THEN
            RETURN right_date;
        ELSE
            RETURN left_date;
        END IF;
    END;

    -- Find EOSL information for this CMDB ID. 
    -- Verify if uitdovend_date / uitgedoofd_date is OLDER than what is known already
    -- Remember oldest date.
    PROCEDURE handle_eosl(in_cmdb_id IN component.cmdb_id%TYPE, in_eosl IN OUT eosl_rec)
    IS
        ci_eosl eosl_rec;
    BEGIN
        -- There should be only one record in cons_eosl, 
        -- but to be on the safe side....
        SELECT min(uitdovend_datum), min(uitgedoofd_datum)
        INTO ci_eosl
        FROM cons_eosl
        WHERE cmdb_id = in_cmdb_id;
        in_eosl.uitdovend_datum  := get_smallest(ci_eosl.uitdovend_datum,  in_eosl.uitdovend_datum);
        in_eosl.uitgedoofd_datum := get_smallest(ci_eosl.uitgedoofd_datum, in_eosl.uitgedoofd_datum);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        -- No issue when no data is found
        RETURN;
    END;

    PROCEDURE go_down(next_rel IN rel_rec, in_eosl IN OUT eosl_rec)
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
        v_loopcnt := v_loopcnt + 1;
        IF v_loopcnt > 100 THEN
            p_log(proc_name, 'F', 'Loop Count exceeded');
            RETURN;
        END IF;
        
        OPEN src_rel_cursor;
        LOOP
            FETCH src_rel_cursor INTO src_rel;
            EXIT WHEN src_rel_cursor%NOTFOUND;

            -- Get Derived Location for this component
            SELECT count(*) INTO thislocation
            FROM derived_locations
            WHERE cmdb_id = src_rel.cmdb_id;

            -- Handle EOSL Information for this CI.
            handle_eosl(src_rel.cmdb_id, in_eosl);

            IF ((src_rel.ci_type = 'ANDERE TOEP.COMP.INSTALL.') OR
                (src_rel.ci_type = 'DB TOEP.COMP-INSTALL.') OR
                (src_rel.ci_type = 'RAPPORTEN') OR
                (src_rel.ci_type = 'TOEP.COMP. COLLAB. SYST.') OR
                (src_rel.ci_type = 'WEB TOEP.COMP-INSTALL.')) THEN
                v_sw_cnt := v_sw_cnt + 1;
                IF (thislocation > 0) THEN
                    v_sw_cnt_bou := v_sw_cnt_bou + 1;
                END IF;
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
                SELECT * INTO this_sw
                FROM job_checks
                WHERE sw_id = src_rel.cmdb_id;
            ELSE
                v_msg := v_msg || 'SW/Job Component verwacht, ' || src_rel.ci_type || ' gevonden. ID: ' || src_rel.cmdb_id;
                GOTO unexpected_record_next;
            END IF;
            IF (this_sw.connections > 0) THEN
                v_connections := v_connections + this_sw.connections;
            END IF;
            IF (this_sw.assessment > 0) THEN
                v_assessment := v_assessment + this_sw.assessment;
            END IF;
            IF (thislocation > 0) THEN
                IF (this_sw.migratie > 0) THEN
                    v_migratie := v_migratie + this_sw.migratie;
                END IF;
            END IF;
            IF (length(this_sw.comp_naam) > 0) THEN
                v_comp := v_comp + 1;
            ELSE 
                v_no_comp := v_no_comp + 1;
            END IF;

            -- Remember Applicatie - Component Link
            INSERT INTO apps_cis (cmdb_id_src, naam_src, 
                cmdb_id_tgt, naam_tgt, ci_type_tgt, ci_categorie_tgt)
            VALUES (next_rel.cmdb_id, next_rel.naam, 
                src_rel.cmdb_id, src_rel.naam, src_rel.ci_type, src_rel.ci_categorie);

            <<unexpected_record_next>>
            NULL;

        END LOOP;

    END;

    FUNCTION get_eosl_factor(eosl IN eosl_rec)
    RETURN number
    IS
        v_eosl_factor number := 0;
    BEGIN
        IF (length(eosl.uitgedoofd_datum) > 2) THEN
            IF (eosl.uitgedoofd_datum < cut_eosl.uitgedoofd_datum) THEN
                v_eosl_factor := fct.uitgedoofd;
            END IF;
        END IF;
        IF (length(eosl.uitdovend_datum) > 2) THEN
            IF (eosl.uitdovend_datum < cut_eosl.uitdovend_datum) THEN
                IF (fct.uitdovend > v_eosl_factor) THEN
                    v_eosl_factor := fct.uitdovend;
                END IF;
            END IF;
        END IF;
        RETURN v_eosl_factor;
    END;

    PROCEDURE save_results(apps IN component%ROWTYPE, in_eosl IN eosl_rec) 
    IS
        v_work_kost number := 0;
        v_project_kost apps_checks.project_kost%TYPE;
        v_eosl_kost apps_checks.eosl_kost%TYPE;
        v_totale_kost apps_checks.totale_kost%TYPE;
        v_eosl_factor number;
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
        v_eosl_factor := get_eosl_factor(in_eosl);
        v_eosl_kost := v_assessment * v_eosl_factor;
        v_project_kost := (v_work_kost * v_mgmt_waarde) + (v_work_kost * v_arch_waarde);
        v_totale_kost := v_assessment + v_migratie + v_eosl_kost + v_project_kost;
        INSERT INTO apps_checks (cmdb_id, naam, dienstentype, eigenaar_beleidsdomein, 
             eigenaar_entiteit, fin_beleidsdomein, fin_entiteit,
             connections, comp, no_comp, sw_cnt, sw_cnt_bou, job_cnt, 
             job_cnt_bou, assessment, migratie, eosl_kost, project_kost, totale_kost, 
             so_toepassingsmanager, vo_applicatiebeheerder, msgstr)
        VALUES (apps.cmdb_id, apps.naam, apps.dienstentype, apps.eigenaar_beleidsdomein, 
             apps.eigenaar_entiteit, apps.fin_beleidsdomein, apps.fin_entiteit,
             v_connections, v_comp, v_no_comp, v_sw_cnt, v_sw_cnt_bou, v_job_cnt, 
             v_job_cnt_bou, v_assessment, v_migratie, v_eosl_kost, v_project_kost, v_totale_kost, 
             apps.so_toepassingsmanager, apps.vo_applicatiebeheerder, v_msg);
    END;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table apps_checks';
    EXECUTE IMMEDIATE 'truncate table apps_cis';

    -- Get values from kostelementen
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

    SELECT datum, waarde
    INTO cut_eosl.uitdovend_datum, fct.uitdovend
    FROM kostelementen
    WHERE element = 'uitdovend';

    SELECT datum, waarde
    INTO cut_eosl.uitgedoofd_datum, fct.uitgedoofd
    FROM kostelementen
    WHERE element = 'uitgedoofd';

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
        eosl.uitdovend_datum := '';
        eosl.uitgedoofd_datum := '';
        
        rel.cmdb_id := apps.cmdb_id;
        rel.naam := apps.naam;
        go_down(rel, eosl);
        save_results(apps, eosl);
        
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

-- EXCEPTION
--    WHEN OTHERS THEN
--         dbms_output.put_line( dbms_utility.format_error_backtrace );
        
END;
