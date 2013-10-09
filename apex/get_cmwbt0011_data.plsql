DECLARE
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'get_cmwbt0011_data';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    EXECUTE IMMEDIATE 'truncate table component';
    p_get_cmwbt0011_tpo;
    p_get_cmwbt0011_bt;
    p_get_cmwbt0011_comp;
    p_log(proc_name, 'I', 'End Application');
END;

