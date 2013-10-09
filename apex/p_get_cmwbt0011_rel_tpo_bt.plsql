CREATE OR REPLACE PROCEDURE p_get_cmwbt0011_rel_tpo_bt
    IS 
    
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_rel_tpo_bt';

    CURSOR rel_cursor IS
    select DISTINCT TOEPASSINGOMGEVING,
           CMDB_REFERENTIE_OMGEVING,
           CMDB_REFERENTIE_BEDRIJFSTOEPAS,
           NAAM_BEDRIJFSTOEPASSING 
    from CMWBT0011
    where CMDB_REFERENTIE_OMGEVING > 0;        

    TYPE rel_record IS RECORD (
        naam_target relations.naam_target%TYPE,
        cmdb_id_target relations.cmdb_id_target%TYPE,
        cmdb_id_source relations.cmdb_id_source%TYPE,
        naam_source relations.naam_source%TYPE);

    rel rel_record;

    c_ci_type_target   CONSTANT relations.ci_type_target%TYPE := 'Toepassingomgeving';
    c_ci_type_source   CONSTANT relations.ci_type_source%TYPE := 'Bedrijfstoepassing';
    c_categorie_source CONSTANT relations.ci_categorie_source%TYPE := '';
    c_categorie_target CONSTANT relations.ci_categorie_target%TYPE := '';
    c_relation         CONSTANT relations.relation%TYPE := 'heeft component';

    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);
    allvalues allvalues_type;
    
    valuestr varchar2(255);
           
BEGIN

    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN rel_cursor;
    LOOP
        FETCH rel_cursor INTO rel;
        EXIT WHEN rel_cursor%NOTFOUND;
        valuestr := to_char(rel.cmdb_id_source) || '.' || c_relation || '.' || to_char(rel.cmdb_id_target);
        -- dbms_output.put_line('String to evaluate: ' || valuestr);
        
        IF NOT allvalues.EXISTS(valuestr) THEN
            -- Found Unique String, remember it and add it to the relations table
            allvalues(valuestr) := 1;
            rel.cmdb_id_source := rel.cmdb_id_source + 1000000;
            INSERT INTO relations (cmdb_id_source, naam_source, ci_type_source, ci_categorie_source, 
                                   relation,
                                   cmdb_id_target, naam_target, ci_type_target, ci_categorie_target)
            VALUES (rel.cmdb_id_source, rel.naam_source, c_ci_type_source, c_categorie_source,
                    c_relation,
                    rel.cmdb_id_target, rel.naam_target, c_ci_type_target, c_categorie_target);
        END IF;
        
    END LOOP; 

    p_log(proc_name, 'I', 'End Procedure');    

END;​

