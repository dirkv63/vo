DECLARE

    proc_name CONSTANT logtbl.evt_proc%TYPE := 'sw_component_checks';

    limitcnt number := 0;
    
    CURSOR sw_comp_cursor IS
    select CMDB_ID,
           NAAM,
           CI_CATEGORIE,
           CI_TYPE
    from COMPONENT
    where (CI_TYPE = 'ANDERE TOEP.COMP.INSTALL.'
       or CI_TYPE = 'DB TOEP.COMP-INSTALL.'
       or CI_TYPE = 'RAPPORTEN'
       or CI_TYPE = 'TOEP.COMP. COLLAB. SYST.'
        or CI_TYPE = 'WEB TOEP.COMP-INSTALL.');

    TYPE sw_comp_rec IS RECORD (
        cmdb_id component.cmdb_id%TYPE,
        naam component.naam%TYPE,
        ci_categorie component.ci_categorie%TYPE,
        ci_type component.ci_type%TYPE);

    sw_comp sw_comp_rec;
    next_sw_comp sw_comp_rec;

    v_msg sw_checks.msgstr%TYPE;
    v_computer sw_checks.comp_naam%TYPE;
    v_comp_type sw_checks.comp_type%TYPE;
    v_cluster varchar2(255);
    v_loopcnt number;
    v_connections sw_checks.connections%TYPE;

    TYPE cost_cat_rec is RECORD (
        ci_type kostelementen.ci_type%TYPE,
        ci_categorie kostelementen.ci_categorie%TYPE,
        computertype kostelementen.computertype%TYPE);

    TYPE cost_res_rec IS RECORD (
        migratie kostelementen.waarde%TYPE,
        assessment kostelementen.waarde%TYPE);

    sw_cost_cat cost_cat_rec;
    sw_cost_res cost_res_rec;
        
    PROCEDURE get_cost(cost_cat IN cost_cat_rec, cost_res OUT cost_res_rec)
    IS
    BEGIN
        SELECT waarde INTO cost_res.migratie
        FROM kostelementen
        WHERE element = 'Migratie'
          AND ci_type = cost_cat.ci_type
          AND ci_categorie = cost_cat.ci_categorie
          AND computertype = cost_cat.computertype;
        SELECT waarde INTO cost_res.assessment
        FROM kostelementen
        WHERE element = 'Assessment'
          AND ci_type = cost_cat.ci_type
          AND ci_categorie = cost_cat.ci_categorie
          AND computertype = cost_cat.computertype;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_log(proc_name, 'E', 'Geen Assessment of Migratie kostelement gevonden voor ' || cost_cat.ci_type || ' - ' || cost_cat.ci_categorie || ' - ' || cost_cat.computertype);
        WHEN TOO_MANY_ROWS THEN
            p_log(proc_name, 'E', 'Meer dan één kost element gevonden voor ' || cost_cat.ci_type || ' - ' || cost_cat.ci_categorie || ' - ' || cost_cat.computertype);
    END;

    PROCEDURE go_down (src_comp IN sw_comp_rec)
    IS
        CURSOR tgt_comp_cursor IS
        select CMDB_ID_TARGET,
               NAAM_TARGET,
               CI_CATEGORIE_TARGET,
               CI_TYPE_TARGET 
        from RELATIONS
        where cmdb_id_source = src_comp.cmdb_id
          and relation = 'is afhankelijk van';

        tgt_comp sw_comp_rec;

    BEGIN
        v_loopcnt := v_loopcnt + 1;
        IF v_loopcnt > 100 THEN
            p_log(proc_name, 'F', 'Loop Count exceeded');
            RETURN;
        END IF;
        
        OPEN tgt_comp_cursor;
        LOOP
            FETCH tgt_comp_cursor INTO tgt_comp;
            EXIT WHEN tgt_comp_cursor%NOTFOUND;
            v_connections := v_connections +1;
            p_log(proc_name, 'T', 'In go_down for cmdb_id ' || tgt_comp.cmdb_id || ' naam: ' || tgt_comp.naam || ' type: ' || tgt_comp.ci_type);
            -- Did I find a (Fysieke or Virtuele) computer?
            IF ((tgt_comp.ci_type = 'FYSIEKE COMPUTER') OR (tgt_comp.ci_type = 'VIRTUELE COMPUTER')) THEN
                IF ((length(v_computer) > 0) AND (length(v_cluster) IS NULL)) THEN
                    v_msg := v_msg || 'More than one computer found, no cluster defined. * ';
                    -- If duplicate type, then make sure to remember virtual computer
                    IF (tgt_comp.ci_type = 'VIRTUELE COMPUTER') THEN
                        v_computer := tgt_comp.naam;
                        v_comp_type := tgt_comp.ci_type;
                    END IF;
                ELSE
                    v_computer := tgt_comp.naam;
                    v_comp_type := tgt_comp.ci_type;
                END IF;
            ELSIF INSTR(upper(tgt_comp.ci_type), 'NETWERK') > 0 THEN
                v_msg := v_msg || 'SW Component to Network, no computer found. * ';
            ELSE
                go_down(tgt_comp);
            END IF;
        END LOOP;
    END;

    PROCEDURE save_results(sv_sw_comp IN sw_comp_rec) 
    IS
    BEGIN
        IF (length(v_computer) IS NULL) THEN
            v_msg := v_msg || 'Component niet met computer verbonden. * ';
        END IF;
        sw_cost_cat.ci_type := sv_sw_comp.ci_type;
        sw_cost_cat.ci_categorie := sv_sw_comp.ci_categorie;
        sw_cost_cat.computertype := v_comp_type;
        get_cost(sw_cost_cat, sw_cost_res);
        INSERT INTO sw_checks
            (sw_id, sw_naam, sw_type, sw_categorie, comp_naam,  
                connections, msgstr, assessment, migratie)
        VALUES
            (sv_sw_comp.cmdb_id, sv_sw_comp.naam, sv_sw_comp.ci_type,
                sv_sw_comp.ci_categorie, v_computer, v_connections, v_msg,
                sw_cost_res.assessment, sw_cost_res.migratie);
    END;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table sw_checks';
    
    OPEN sw_comp_cursor;
    LOOP
        FETCH sw_comp_cursor INTO sw_comp;
        EXIT WHEN sw_comp_cursor%NOTFOUND;
        -- limitcnt := limitcnt + 1;
        -- EXIT WHEN limitcnt > 5;
        -- dbms_output.put_line('Investigate ' || sw_comp.naam);
        -- Reset variables
        v_msg := '';
        v_computer := '';
        v_cluster := '';
        v_loopcnt := 0;
        v_connections := 0;
        next_sw_comp.cmdb_id := sw_comp.cmdb_id;
        next_sw_comp.naam := sw_comp.naam;
        next_sw_comp.ci_categorie := sw_comp.ci_categorie;
        next_sw_comp.ci_type := sw_comp.ci_type;
        go_down(next_sw_comp);
        save_results(next_sw_comp);

    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    
         
    
END;

