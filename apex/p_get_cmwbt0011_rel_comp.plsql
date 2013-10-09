CREATE OR REPLACE PROCEDURE p_get_cmwbt0011_rel_comp
IS 

    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_rel_comp';

    CURSOR rel_cursor IS
    select TOEPASSINGOMGEVING,
           CMDB_REFERENTIE_OMGEVING,
           RELATIE,
           CI_TYPE,
           CI_CATEGORIE,
           CI_CMDB_REFERENTIE,
           CI_SYSTEEMNAAM 
    from CMWBT0011
    order by ID ASC;

    TYPE rel_record IS RECORD (
        naam_tpo relations.naam_source%TYPE,
        cmdb_id_tpo relations.cmdb_id_source%TYPE,
        relatie relations.relation%TYPE,
        ci_type relations.ci_type_target%TYPE,
        ci_categorie relations.ci_categorie_target%TYPE,
        cmdb_id relations.cmdb_id_target%TYPE,
        naam relations.naam_target%TYPE);

    rel rel_record;
    relation relations.relation%TYPE;
    l_level number;
    l_level_prev number;
    thisrel relations%ROWTYPE;
    v_limitcnt number := 0;

    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);
    allvalues allvalues_type;

    TYPE comp_rec IS RECORD (
        cmdb_id relations.cmdb_id_source%TYPE,
        naam relations.naam_source%TYPE,
        ci_type relations.ci_type_source%TYPE,
        ci_categorie relations.ci_categorie_source%TYPE);
   
    TYPE rel_hash_type IS TABLE OF comp_rec INDEX BY BINARY_INTEGER;
    rel_hash rel_hash_type;
    
    PROCEDURE handle_relation (currvalues IN OUT allvalues_type, rec2hdl IN relations%ROWTYPE)  
    IS
        valuestr varchar2(255);
    BEGIN
        valuestr := to_char(rec2hdl.cmdb_id_source) || '.' || rec2hdl.relation || '.' || to_char(rec2hdl.cmdb_id_target);
        IF NOT currvalues.EXISTS(valuestr) THEN
            -- Found Unique String, remember it and add it to the relations table
            currvalues(valuestr) := 1;
            INSERT INTO relations (cmdb_id_source, naam_source, ci_type_source, CI_CATEGORIE_SOURCE,
                                   relation,
                                   cmdb_id_target, naam_target, ci_type_target, CI_CATEGORIE_TARGET)
            VALUES (rec2hdl.cmdb_id_source, rec2hdl.naam_source, rec2hdl.ci_type_source, rec2hdl.CI_CATEGORIE_SOURCE,
                    rec2hdl.relation,
                    rec2hdl.cmdb_id_target, rec2hdl.naam_target, rec2hdl.ci_type_target, rec2hdl.CI_CATEGORIE_TARGET);
        END IF;
    END;

    PROCEDURE store_level (curr_level IN number, rel IN rel_record, rel_hash IN OUT rel_hash_type)
    IS
    BEGIN
        rel_hash(curr_level).cmdb_id := rel.cmdb_id;
        rel_hash(curr_level). naam := rel.naam;
        rel_hash(curr_level).ci_type := rel.ci_type;
        rel_hash(curr_level).ci_categorie := rel.ci_categorie;
        FOR cnt IN curr_level + 1 .. rel_hash.COUNT LOOP
            rel_hash.DELETE(cnt);
        END LOOP;
    END;

BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN rel_cursor;
    LOOP
        FETCH rel_cursor INTO rel;
        EXIT WHEN rel_cursor%NOTFOUND;
        -- v_limitcnt := v_limitcnt + 1;
        -- EXIT WHEN v_limitcnt > 5;
         
        select regexp_substr( rel.relatie, '[0-9]+' ) INTO l_level from dual;  -- Get the level of the relation
        -- Check for Relation details
        IF INSTR(rel.relatie, 'G') > 0 THEN
            relation := 'maakt gebruik van';
        ELSE
            relation := 'is afhankelijk van';
        END IF;
        IF l_level = 1 THEN
            thisrel.cmdb_id_target := rel.cmdb_id;
            thisrel.naam_target := rel.naam;
            thisrel.ci_type_target := rel.ci_type;
            thisrel.ci_categorie_target := rel.ci_categorie;
            thisrel.relation := relation;
            thisrel.cmdb_id_source := rel.cmdb_id_tpo;
            thisrel.naam_source := rel.naam_tpo;
            thisrel.ci_type_source := 'Toepassingomgeving';
            thisrel.ci_categorie_source := '';
            -- Only handle relation for cmdb_id_tpo > 0, don't handle empty relations
            IF (rel.cmdb_id_tpo > 0) THEN
                handle_relation(allvalues, thisrel);
            END IF;
            store_level(l_level, rel, rel_hash);
       
        ELSE
            
            l_level_prev := l_level - 1;
            IF rel_hash.EXISTS(l_level_prev) THEN
                thisrel.cmdb_id_source := rel_hash(l_level_prev).cmdb_id;
                thisrel.naam_source := rel_hash(l_level_prev).naam;
                thisrel.ci_type_source := rel_hash(l_level_prev).ci_type;
                thisrel.ci_categorie_source := rel_hash(l_level_prev).ci_categorie;
                thisrel.relation := relation;
                thisrel.cmdb_id_target := rel.cmdb_id;
                thisrel.naam_target := rel.naam;
                thisrel.ci_type_target := rel.ci_type;
                thisrel.ci_categorie_target := rel.ci_categorie;
                handle_relation(allvalues, thisrel);
                store_level(l_level, rel, rel_hash);
            ELSE
                p_log(proc_name, 'F', 'Could not find previous level');
                EXIT;
            END IF;
    
        END IF;     
                
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

END;​

