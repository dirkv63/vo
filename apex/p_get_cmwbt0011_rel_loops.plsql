CREATE OR REPLACE PROCEDURE p_get_cmwbt0011_rel_loops
    IS
    
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_rel_loops';
    
    CURSOR looprel_cursor IS
    SELECT a.cmdb_id_source, a.cmdb_id_target 
    FROM relations a, relations b 
    WHERE a.relation = 'is afhankelijk van' AND
          b.relation = 'is afhankelijk van' AND 
          a.cmdb_id_source = b.cmdb_id_target AND 
          a.cmdb_id_target = b.cmdb_id_source AND 
          a.cmdb_id_source > a.cmdb_id_target;

    TYPE looprel_type IS RECORD (
        cmdb_id_source relations.cmdb_id_source%TYPE,
        cmdb_id_target relations.cmdb_id_target%TYPE);

    looprel looprel_type;

BEGIN
    p_log(proc_name, 'I', 'Start Procedure');

    OPEN looprel_cursor;
    LOOP
        FETCH looprel_cursor INTO looprel;
        EXIT WHEN looprel_cursor%NOTFOUND;

        p_log(proc_name, 'E', 'Duplicate Relation found between ' || looprel.cmdb_id_source || ' and ' || looprel.cmdb_id_target);
        DELETE FROM RELATIONS
        WHERE cmdb_id_source = looprel.cmdb_id_source
        AND   cmdb_id_target = looprel.cmdb_id_target;

    END LOOP;

END;

