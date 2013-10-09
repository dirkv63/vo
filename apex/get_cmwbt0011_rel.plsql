DECLARE
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'get_cmwbt0011_rel';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    EXECUTE IMMEDIATE 'truncate table relations';
    p_get_cmwbt0011_rel_tpo_bt;
    p_get_cmwbt0011_rel_comp;
    p_get_cmwbt0011_rel_loops;
    p_log(proc_name, 'I', 'End Application');
END;​

