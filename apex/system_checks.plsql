DECLARE

    proc_name CONSTANT logtbl.evt_proc%TYPE := 'system_checks';

    limitcnt number := 0;
    
    CURSOR comp_cursor IS
    select CMDB_ID,
           NAAM,
           CI_CATEGORIE,
           CI_TYPE,
           STATUS,
           LOCATIE,
           PRODUCT,
           PRODUCENT,
           UITDOVEND_DATUM,
           UITGEDOOFD_DATUM
    from COMPONENT
    where CI_TYPE = 'FYSIEKE COMPUTER';
      
    TYPE comp_rec IS RECORD (
        cmdb_id component.cmdb_id%TYPE,
        naam component.naam%TYPE,
        ci_categorie component.ci_categorie%TYPE,
        ci_type component.ci_type%TYPE,
        status component.status%TYPE,
        locatie component.locatie%TYPE,
        product component.product%TYPE,
        producent component.producent%TYPE,
        uitdovend_datum component.uitdovend_datum%TYPE,
        uitgedoofd_datum component.uitgedoofd_datum%TYPE);

    TYPE eosl_rec IS RECORD (
        uitdovend_datum DATE,
        uitgedoofd_datum DATE);

    eosl eosl_rec;
    
    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);
    allvalues allvalues_type;  -- remember all server to ci relations for cons_cis table
    locations allvalues_type;  -- remember all locations for derived locations table   

    comp comp_rec;
    next_ci comp_rec;

    v_msg system_checks.msgstr%TYPE;
    v_connections system_checks.connections%TYPE;
    v_sw_cnt system_checks.connections%TYPE;
    v_job_cnt system_checks.connections%TYPE;
    v_top_cmdb_id cons_cis.cmdb_id_src%TYPE;
    v_top_naam cons_cis.naam_src%TYPE;
    v_loopcnt number;
    v_locatie component.locatie%TYPE;

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

    PROCEDURE get_os_eosl(cmdb_id_in IN component.cmdb_id%TYPE, thiseosl IN OUT eosl_rec) 
    IS
        this_uitdovend_datum DATE;
        this_uitgedoofd_datum DATE;
    BEGIN
        -- In exceptional situations the Server has more than one
        -- Operating System, e.g. ID: 60106
        SELECT min(uitdovend_datum), min(uitgedoofd_datum)
        INTO this_uitdovend_datum, this_uitgedoofd_datum
        FROM component, relations
        WHERE cmdb_id_target = cmdb_id_in
        AND relation = 'is afhankelijk van'
        AND ci_categorie_source = 'OPERATING SYSTEEM'
        AND cmdb_id = cmdb_id_source;
        thiseosl.uitdovend_datum := get_smallest(this_uitdovend_datum, thiseosl.uitdovend_datum);
        thiseosl.uitgedoofd_datum := get_smallest(this_uitgedoofd_datum, thiseosl.uitgedoofd_datum);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN;
    END;

    PROCEDURE safe_cons_eosl(cmdb_id_in IN component.cmdb_id%TYPE, eosl IN eosl_rec) 
    IS
    BEGIN
        IF (not((eosl.uitdovend_datum IS NULL) AND (eosl.uitgedoofd_datum IS NULL))) THEN
            INSERT INTO cons_eosl(cmdb_id, uitdovend_datum, uitgedoofd_datum)
                VALUES (cmdb_id_in, eosl.uitdovend_datum, eosl.uitgedoofd_datum);
        END IF;
    END;

    PROCEDURE go_up (cmdb_id2chk IN relations.cmdb_id_target%TYPE, ck_eosl IN OUT eosl_rec)
    IS
        CURSOR tgt_rel_cursor IS
        SELECT CMDB_ID_SOURCE,
               NAAM_SOURCE,
               CI_TYPE_SOURCE,
               CI_CATEGORIE_SOURCE,
               UITDOVEND_DATUM,
               UITGEDOOFD_DATUM
        FROM RELATIONS, COMPONENT
        WHERE CMDB_ID_TARGET = cmdb_id2chk
          AND NOT (CI_CATEGORIE_SOURCE = 'OPERATING SYSTEEM')
          AND RELATION = 'is afhankelijk van'
          AND CMDB_ID = CMDB_ID_SOURCE;

        TYPE rel_rec IS RECORD (
            cmdb_id relations.cmdb_id_source%TYPE,
            naam relations.naam_source%TYPE,
            ci_type relations.ci_type_source%TYPE,
            ci_categorie relations.ci_categorie_source%TYPE,
            uitdovend_datum component.uitdovend_datum%TYPE,
            uitgedoofd_datum component.uitgedoofd_datum%TYPE);

        tgt_rel rel_rec;
        v_allvals_key varchar2(255);

    BEGIN

        v_loopcnt := v_loopcnt + 1;
        IF v_loopcnt > 1000 THEN
            p_log(proc_name, 'F', 'Loop Count exceeded');
            RETURN;
        END IF;
        
        OPEN tgt_rel_cursor;
        LOOP
            FETCH tgt_rel_cursor INTO tgt_rel;
            EXIT WHEN tgt_rel_cursor%NOTFOUND;
            -- Verify if this component has been seen from the physical server already.
            -- If so, stop searching.
            v_allvals_key := v_top_cmdb_id || '.' || tgt_rel.cmdb_id;
            IF allvalues.EXISTS(v_allvals_key) THEN
                p_log(proc_name, 'E', 'CI is reeds gezien, server: ' || v_top_cmdb_id || ', CI: ' || tgt_rel.cmdb_id);
            ELSE
                -- Remember that I have been here before
                allvalues(v_allvals_key) := 1;
                v_connections := v_connections + 1;
                -- If this component runs on computer in Boudewijn
                -- and this was not known before, then store it in derived_locations
                IF ((length(v_locatie) > 5) AND (NOT locations.EXISTS(tgt_rel.cmdb_id))) THEN
                    locations(tgt_rel.cmdb_id) := 1;
                    INSERT INTO derived_locations (cmdb_id, locatie)
                        VALUES (tgt_rel.cmdb_id, v_locatie);
                END IF;
                -- Get oldest EOSL dates
                -- If it is Computer System, then also look at its Operating System
                IF ((tgt_rel.ci_type = 'FYSIEKE COMPUTER') OR (tgt_rel.ci_type = 'VIRTUELE COMPUTER')) THEN
                    get_os_eosl(tgt_rel.cmdb_id, ck_eosl);
                END IF;
                ck_eosl.uitdovend_datum  := get_smallest(tgt_rel.uitdovend_datum,  ck_eosl.uitdovend_datum);
                ck_eosl.uitgedoofd_datum := get_smallest(tgt_rel.uitgedoofd_datum, ck_eosl.uitgedoofd_datum);
                -- Remember this in cons_eosl table
                safe_cons_eosl(tgt_rel.cmdb_id, ck_eosl);
                -- Remember this combination in the cons_cis table
                INSERT INTO cons_cis (cmdb_id_src, naam_src, 
                    cmdb_id_tgt, naam_tgt, ci_type_tgt, ci_categorie_tgt)
                VALUES (v_top_cmdb_id, v_top_naam, tgt_rel.cmdb_id, tgt_rel.naam,
                    tgt_rel.ci_type, tgt_rel.ci_categorie);
                -- Is this a SW_Comp Type?
                IF ((tgt_rel.ci_type = 'ANDERE TOEP.COMP.INSTALL.') OR
                    (tgt_rel.ci_type = 'DB TOEP.COMP-INSTALL.') OR
                    (tgt_rel.ci_type = 'RAPPORTEN') OR
                    (tgt_rel.ci_type = 'TOEP.COMP. COLLAB. SYST.') OR
                    (tgt_rel.ci_type = 'WEB TOEP.COMP-INSTALL.')) THEN
                    v_sw_cnt := v_sw_cnt + 1;
                ELSIF ((tgt_rel.ci_type = 'JOB INSTALL. (ANDERE)') OR
                       (tgt_rel.ci_type = 'JOB INSTALL. (CRON)') OR
                       (tgt_rel.ci_type = 'JOB INSTALL. (CTRL-M)') OR
                       (tgt_rel.ci_type = 'JOB INSTALL. (WIN)') OR
                       (tgt_rel.ci_type = 'JOBCLUSTER INSTALL.')) THEN
                    v_job_cnt := v_job_cnt +1;
                ELSIF (length(tgt_rel.ci_type) IS NULL) THEN
                    v_msg := v_msg || 'Pad van Computer naar Applicatie zonder SW/Job component. * ';
                ELSE
                    go_up(tgt_rel.cmdb_id, ck_eosl);
                END IF;         
            END IF;
        END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_msg := v_msg || 'Unexpected End of Path * ';
--        WHEN OTHERS THEN
--            v_msg := v_msg || 'Unknown exception encountered * ';
--            p_log(proc_name, 'E', 'Unknown exception encountered');
    END;

    PROCEDURE save_results(comp IN comp_rec)
    IS
    BEGIN
        INSERT INTO system_checks
            (cmdb_id, naam, ci_type, ci_categorie, producent, product,
                 locatie, sw_cnt, job_cnt, connections, msgstr, status)
        VALUES
            (comp.cmdb_id, comp.naam, comp.ci_type,comp.ci_categorie, 
                comp.producent, comp.product, comp.locatie,
                v_sw_cnt, v_job_cnt, v_connections, v_msg, comp.status);

    END;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table system_checks';
    EXECUTE IMMEDIATE 'truncate table cons_cis';
    EXECUTE IMMEDIATE 'truncate table derived_locations';

    OPEN comp_cursor;
    LOOP
        FETCH comp_cursor INTO comp;
        EXIT WHEN comp_cursor%NOTFOUND;
        -- limitcnt := limitcnt + 1;
        -- EXIT WHEN limitcnt > 5;
        -- dbms_output.put_line('Investigate ' || sw_comp.naam);
        -- Reset variables
        v_msg := 'Init * ';
        v_loopcnt := 0;
        v_sw_cnt := 0;
        v_job_cnt := 0;
        v_connections := 0;
        -- Remember Location only if it is for Boudewijn Computerzaal
        IF (comp.locatie = 'Boudewijn - Brussel/-1C Computerzaal') THEN
            v_locatie := 'Boudewijn - Brussel/-1C Computerzaal';
            locations(comp.cmdb_id) := 1;
            INSERT INTO derived_locations (cmdb_id, locatie)
                VALUES (comp.cmdb_id, v_locatie);
        ELSE
            v_locatie := '';
        END IF;
        eosl.uitdovend_datum := comp.uitdovend_datum;
        eosl.uitgedoofd_datum := comp.uitgedoofd_datum;
        v_top_cmdb_id := comp.cmdb_id;
        v_top_naam := comp.naam;
        get_os_eosl(comp.cmdb_id, eosl);
        safe_cons_eosl(comp.cmdb_id, eosl);
        go_up(comp.cmdb_id, eosl);
        save_results(comp);
        
END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    
         
    
END;

