CREATE OR REPLACE PROCEDURE p_log(proc_name IN logtbl.evt_proc%TYPE,
                                           sev IN logtbl.evt_sev%TYPE,
                                           msg IN logtbl.evt_msg%TYPE)
    AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO logtbl (
        evt_time,
        evt_proc,
        evt_sev,
        evt_msg)
    VALUES (
        sysdate,
        proc_name,
        sev,
        msg);
    COMMIT;
END;

