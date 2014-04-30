CREATE OR REPLACE FUNCTION  "UF_KENMERK" (kenmerk IN component.kenmerken%TYPE)
    RETURN component.kenmerken%TYPE
IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'uf_kenmerk';
    TYPE kenm_array IS VARRAY(6) OF varchar2(255);
    kenm kenm_array := kenm_array
        ('CENTRALE BACKUP FACILITEIT BRUSSEL;',
         'CENTRALE BACKUP FACILITEIT BRUSSEL',
         'BUR-ANDERE;','BUR-ANDERE',
         'MONITORING MOM;','MONITORING MOM');
    v_kenm component.kenmerken%TYPE;
    err_num number;
    err_line number;
    err_msg varchar2(255);
BEGIN
    v_kenm := kenmerk;
    IF (length(v_kenm) is null) THEN
        RETURN v_kenm;
    END IF;
    FOR cnt IN 1..kenm.COUNT LOOP
        v_kenm := REPLACE(v_kenm, kenm(cnt));
    END LOOP;
    RETURN v_kenm;
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
        RETURN v_kenm;
END;
    
/

CREATE OR REPLACE FUNCTION  "LDAP_AUTHENTICATE" 
(p_username in VARCHAR2, p_password in VARCHAR2) 
return boolean
is
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'LDAP_AUTHENTICATE';
    err_msg varchar2(255);
    invalid_credentials EXCEPTION;
    PRAGMA EXCEPTION_INIT(invalid_credentials, -31202);
    l_ldap_host VARCHAR2(256) := 'ldapp.vlaanderen.be';
    l_ldap_port VARCHAR2(256) := '389';
    l_session DBMS_LDAP.session;
    l_session2 DBMS_LDAP.session;
    l_retval PLS_INTEGER; 
    l_ldap_user VARCHAR2(256) := 'uid=et_ivo21_app,ou=admins,o=vlaanderen,c=be';
    l_ldap_base VARCHAR2(256) := 'o=vlaanderen,c=be';
    l_dn VARCHAR2(256);
    l_attrs DBMS_LDAP.string_collection;
    l_message DBMS_LDAP.message;
    l_deleted_in_db VARCHAR2(1); 
    l_present_in_db VARCHAR2(1); 
    cte number;
    v_aantal number;
BEGIN
    p_log(proc_name, 'I', 'Trying to authenticate User: ' || p_username);
    if (p_password is null) then 
        p_log(proc_name, 'I', 'User : ' || p_username || ' failed to authenticate (pwd null)');
        return false;
    end if;
    DBMS_LDAP.USE_EXCEPTION := TRUE; 
    --We halen via een admin de dn van de te valideren gebruiker op.
    l_session := DBMS_LDAP.init(hostname => l_ldap_host,
                                portnum => l_ldap_port);
    l_retval := DBMS_LDAP.simple_bind_s(ld => l_session,
                                        dn => l_ldap_user,
                                        passwd => NULL);
    l_attrs(1) := 'inr';
    l_retval := DBMS_LDAP.search_s(ld => l_session, 
                                   base => l_ldap_base, 
                                   scope => DBMS_LDAP.SCOPE_SUBTREE,
                                   filter => 'uid=' || p_username,
                                   attrs => l_attrs,
                                   attronly => 1,
                                   res => l_message);
    IF DBMS_LDAP.count_entries(ld => l_session, msg => l_message) > 0 THEN 
        l_dn := DBMS_LDAP.get_dn(ld => l_session, ldapEntry => DBMS_LDAP.first_entry(ld => l_session, msg => l_message));
    ELSE
        p_log(proc_name, 'I', 'User : ' || p_username || ' failed to authenticate.');
        return false;
    END IF;
    l_retval := DBMS_LDAP.unbind_s(ld => l_session);
    --We checken of de combinatie gebruikernaam/paswoord juist is 
    l_session := DBMS_LDAP.init(hostname => l_ldap_host,
                                portnum => l_ldap_port);
    l_retval := DBMS_LDAP.simple_bind_s(ld => l_session,
                                        dn => l_dn,
                                        passwd => p_password); 
    l_retval := DBMS_LDAP.unbind_s(ld => l_session);
-- Test of de aangelogde gebruiker gekend is in de 
-- gebruikerstabel van de toepassing 
-- deze gebruikerstabel moet kolommen LDAP en ACTIEF hebben!!
--Select count(*) 
--into v_Aantal 
--from LDAP_GEBRUIKERS
--where upper(LDAP) = upper(p_username) 
--and actief = 'J';
--If v_aantal != 1 then
--return false;
--end if;
--
    p_log(proc_name, 'I', 'User : ' || p_username || ' successful authentication.');
    return true;
EXCEPTION
    WHEN invalid_credentials THEN
        p_log(proc_name, 'I', 'User : ' || p_username || ' invalid credentials');
        return false;

    WHEN OTHERS THEN
        l_retval := DBMS_LDAP.unbind_s(ld => l_session);
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
        RETURN false;
END;
/

CREATE OR REPLACE FUNCTION  "ID_IN_COMPONENT" (netw_id IN netwerk.cmdb_id%TYPE, f_status IN component.status%TYPE)
    RETURN varchar2
IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'id_in_component';
    err_msg varchar2(255);
BEGIN
    IF (length(netw_id) is null) THEN
        RETURN '';
    ELSIF (length(f_status) is null) THEN
        RETURN 'Buiten gebruik';
    ELSE
        RETURN f_status;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
        RETURN '';
END;
    
/

CREATE OR REPLACE FUNCTION  "F_OMGEVING" (f_omg_abb IN component.omgeving%TYPE)
    RETURN varchar2
    IS
    proc_name logtbl.evt_proc%TYPE := 'p_beleidsdocument2xml';
    err_msg varchar2(255);
    v_omgeving varchar2(255) := '';
    
BEGIN
        
    IF (length(f_omg_abb) = 0) THEN
        RETURN v_omgeving;
    ELSIF (upper(substr(f_omg_abb,1,1))) = 'P' THEN
        RETURN 'Productie';
    ELSIF (upper(substr(f_omg_abb,1,1))) = 'O' THEN
        RETURN 'Ontwikkeling';
    ELSIF (upper(substr(f_omg_abb,1,1))) = 'T' THEN
        RETURN 'Test';
    ELSE
        RETURN f_omg_abb;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
        RETURN '';
END;
/

CREATE OR REPLACE FUNCTION  "F_GET_EOSL_STATUS" (comp_id IN component.cmdb_id%TYPE)
    RETURN varchar2
IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'f_get_eosl_status';
    TYPE status_tx_type IS TABLE OF varchar2(255) INDEX BY varchar2(255);
    status_tx status_tx_type;
    eosl_status_val varchar2(255) := 'InitValue';
    aangepast_op_val apex_user_004.eosl_toepassingen.aangepast_op%TYPE;
    err_msg varchar2(255);
BEGIN
    
    status_tx('KEGU') := 'Klant Exceptie - Geen Plan Upgrade';
    status_tx('KEPU') := 'Klant Exceptie - Plan Upgrade';
    status_tx('KEPU04') := 'Klant Exceptie - Plan Upgrade zonder datum';
    status_tx('Open') := 'Open';
    status_tx('OPGL') := 'Opgelost';
    status_tx('STZP') := 'Stopzetting';
    status_tx('NOVL') := 'Geen actie nodig';
    status_tx('IODZ') := 'Actie nodig';
    status_tx('UPGP') := 'Oplossing in uitvoering';
    status_tx('OPLB') := 'Oplossing bepaald';
    -- First get most recent EOSL STATUS
    select ALG_STATUS
    into eosl_status_val
    from apex_user_004.eosl_toepassingen
        where (omg_cmdb_ref = to_char(comp_id))
        and (aangepast_op = (
            select max(aangepast_op)
            from apex_user_004.eosl_toepassingen
            where (omg_cmdb_ref = to_char(comp_id))))
      and (rownum <= 1);
    IF status_tx.EXISTS(eosl_status_val) THEN
        eosl_status_val := status_tx(eosl_status_val);
    ELSE
        -- eosl_status_val := eosl_status_val || ' (vertaling!)';
        p_log(proc_name, 'E', 'eosl_toepassingen vertaling van status: ' || eosl_status_val);
        eosl_status_val := '';
    END IF;
        
    RETURN eosl_status_val;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '';
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
        RETURN 'Error - See Log';
END;
    
/

CREATE OR REPLACE PROCEDURE  "P_SYSTEM_VERIFICATION" 
    IS
    
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'system_verification';
    CURSOR comp_cursor IS
    SELECT cmdb_id, naam
    FROM  component 
    WHERE ci_type =  'FYSIEKE COMPUTER'
    AND locatie =  'Boudewijn - Brussel/-1C Computerzaal';
    TYPE comp_rec IS RECORD (
        cmdb_id component.cmdb_id%TYPE,
        naam component.naam%TYPE);
    comp comp_rec;
    v_src system_verification.source%TYPE;
    v_msg system_verification.msg%TYPE;
    v_res varchar2(255) := '';
    err_msg varchar2(255);
    FUNCTION get_isolated (cmdb_id_in IN component.cmdb_id%TYPE)
    RETURN number
    IS
        v_res number := 0;
    BEGIN
        SELECT cmdb_id
        INTO v_res
        FROM system_cost
        WHERE cmdb_id = cmdb_id_in;
        RETURN v_res;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN v_res;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
END;
    FUNCTION get_netwerk (cmdb_id_in IN component.cmdb_id%TYPE)
    RETURN number
    IS
        v_res number := 0;
    BEGIN
        SELECT cmdb_id
        INTO v_res
        FROM netwerk
        WHERE cmdb_id = cmdb_id_in;
        RETURN v_res;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN v_res;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
    END;
    FUNCTION get_appl (cmdb_id_in IN component.cmdb_id%TYPE)
    RETURN number
    IS
        v_res number := 0;
    BEGIN
        SELECT distinct cmdb_id_comp
        INTO v_res
        FROM srv2apps
        WHERE cmdb_id_comp = cmdb_id_in;
        RETURN v_res;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN v_res;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
        END;
BEGIN
    
    p_log(proc_name, 'I', 'Start Procedure');
    EXECUTE IMMEDIATE 'truncate table system_verification';
    EXECUTE IMMEDIATE 'truncate table srv2apps';
    INSERT INTO srv2apps  (cmdb_id_comp, naam_comp, cmdb_id_appl, naam_appl) 
        SELECT DISTINCT c.cmdb_id_src as cmdb_id_comp, 
                   c.naam_src as naam_comp,
                   a.cmdb_id_src as cmdb_id_appl,
                   a.naam_src as naam_appl
        FROM cons_cis c, apps_cis a
        WHERE c.cmdb_id_tgt = a.cmdb_id_tgt;
    OPEN comp_cursor;
    LOOP
        FETCH comp_cursor INTO comp;
        EXIT WHEN comp_cursor%NOTFOUND;
        v_msg := '';
        v_src := '';
        v_res := get_isolated(comp.cmdb_id);
        IF (length(v_res) > 2) THEN
            v_src := 'Geïsoleerde Servers Rapport';
        END IF;
        v_res := get_netwerk(comp.cmdb_id);
        IF (length(v_res) > 2) THEN
            IF (length(v_src) > 2) THEN
                v_msg := v_msg || ' ook in rapport ' || v_src;
            END IF;
            v_src := 'Netwerk Rapport';
        END IF;
        v_res := get_appl(comp.cmdb_id);
        IF (length(v_res) > 2) THEN
            IF (length(v_src) > 2) THEN
                v_msg := v_msg || ' ook in rapport ' || v_src;
            END IF;
            v_src := 'Applicatie Migratie Rapport';
        END IF;
        IF (length(v_src) IS NULL) THEN
            v_msg := 'Niet gevonden in een rapport';
        END IF;
        INSERT INTO system_verification (cmdb_id, naam, source, msg)
            VALUES (comp.cmdb_id, comp.naam, v_src, v_msg);
    END LOOP;
    p_log(proc_name, 'I', 'End Procedure');
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);   
END;
/

CREATE OR REPLACE PROCEDURE  "P_SYSTEM_USED_BY" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_system_used_by';
    limitcnt number := 0;
    
    CURSOR sys_cursor IS
    select r.cmdb_id_source, r.naam_source, r.cmdb_id_target, r.naam_target, c.omgeving 
    from relations r, system_cost s, component c 
    where r.cmdb_id_target = s.cmdb_id 
      and r.ci_type_source = 'Toepassingomgeving'
      and (not(r.cmdb_id_source in (select cmdb_id_comp from srv2apps)))
      and s.cmdb_id = c.cmdb_id;
    TYPE sys_record IS RECORD (
        cmdb_id_appl component.cmdb_id%TYPE,
        naam_appl component.naam%TYPE,
        cmdb_id_comp component.cmdb_id%TYPE,
        naam_comp component.naam%TYPE,
        omgeving component.omgeving%TYPE);
    TYPE eosl_rec IS RECORD (
        uitdovend_datum DATE,
        uitgedoofd_datum DATE);
    TYPE fct_rec IS RECORD (
        uitdovend kostelementen.waarde%TYPE,
        uitgedoofd kostelementen.waarde%TYPE);
    
    eosl eosl_rec;
    cut_eosl eosl_rec;
    fct fct_rec;
    sys sys_record;
    v_msg apps_checks.msgstr%TYPE;
    v_mgmt_waarde kostelementen.waarde%TYPE;
    v_arch_waarde kostelementen.waarde%TYPE;
    v_def_waarde kostelementen.waarde%TYPE;
    v_migratie system_cost.migratie%TYPE;
    v_assessment system_cost.migratie%TYPE;
    v_eosl_kost system_cost.eosl_kost%TYPE;
    v_project_kost system_cost.project_kost%TYPE;
    v_totale_kost system_cost.totale_kost%TYPE;
    v_eosl_factor number;
    err_num number;
    err_line number;
    err_msg varchar2(255);
    -- Find EOSL information for this CMDB ID. 
    -- Verify if uitdovend_date / uitgedoofd_date is OLDER than what is known already
    -- Remember oldest date.
    PROCEDURE handle_eosl(in_cmdb_id IN component.cmdb_id%TYPE, ci_eosl OUT eosl_rec)
    IS
    BEGIN
        -- There should be only one record in cons_eosl, 
        -- but to be on the safe side....
        SELECT min(uitdovend_datum), min(uitgedoofd_datum)
        INTO ci_eosl
        FROM cons_eosl
        WHERE cmdb_id = in_cmdb_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        -- No issue when no data is found
        RETURN;
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
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
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
    OPEN sys_cursor;
    LOOP
        FETCH sys_cursor INTO sys;
        EXIT WHEN sys_cursor%NOTFOUND;
        -- Found Application that is using isolated server
        -- Get Server EOSL Information
        handle_eosl(sys.cmdb_id_comp, eosl);
        v_eosl_factor := get_eosl_factor(eosl);
        
        v_migratie := v_def_waarde;
        IF ((sys.omgeving like 'T%') OR (sys.omgeving like 'O%')) THEN
            v_migratie := v_migratie / 3;
        END IF;
        v_assessment := v_migratie / 4;
        v_eosl_kost := v_migratie * v_eosl_factor;
        v_project_kost := ((v_migratie + v_eosl_kost) * v_mgmt_waarde) + ((v_migratie + v_eosl_kost) * v_arch_waarde);
        v_totale_kost := v_migratie + v_eosl_kost + v_project_kost;
        -- Save the resuls
        UPDATE apps_checks set migratie = migratie + v_migratie,
                               assessment = assessment + v_assessment,
                               eosl_kost = eosl_kost + v_eosl_kost,
                               project_kost = project_kost + v_project_kost,
                               totale_kost = totale_kost + v_totale_kost
        WHERE cmdb_id = sys.cmdb_id_appl;
        
        -- Add to srv2apps
        INSERT INTO srv2apps (cmdb_id_comp, naam_comp, cmdb_id_appl, naam_appl) 
        VALUES (sys.cmdb_id_comp, sys.naam_comp, sys.cmdb_id_appl, sys.naam_appl);
        -- Remove from system_cost
        DELETE FROM system_cost
        WHERE cmdb_id = sys.cmdb_id_comp;
        
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
   
END;
/

CREATE OR REPLACE PROCEDURE  "P_SYSTEM_COST" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_system_cost';
    limitcnt number := 0;
    
    CURSOR sys_cursor IS
    select s.cmdb_id, s.naam, c.kenmerken, c.omgeving
    from SYSTEM_CHECKS s, COMPONENT c
    where c.locatie = 'Boudewijn - Brussel/-1C Computerzaal'
    and s.sw_cnt = 0
        and s.job_cnt = 0
    and s.cmdb_id not in (select distinct cmdb_id from netwerk where cmdb_id is not null)
    and s.cmdb_id = c.cmdb_id;
    TYPE sys_record IS RECORD (
        cmdb_id component.cmdb_id%TYPE,
        naam component.naam%TYPE,
        kenmerken component.kenmerken%TYPE,
        omgeving component.omgeving%TYPE);
    TYPE eosl_rec IS RECORD (
        uitdovend_datum DATE,
        uitgedoofd_datum DATE);
    TYPE fct_rec IS RECORD (
        uitdovend kostelementen.waarde%TYPE,
        uitgedoofd kostelementen.waarde%TYPE);
    TYPE kenmerk_err_rec IS TABLE OF number INDEX BY varchar2(255);
    cut_eosl eosl_rec;
    fct fct_rec;
    
    sys sys_record;
    kenmerk_err kenmerk_err_rec;
    v_loopcnt number;
    v_msg apps_checks.msgstr%TYPE;
    v_mgmt_waarde kostelementen.waarde%TYPE;
    v_arch_waarde kostelementen.waarde%TYPE;
    v_migratie system_cost.migratie%TYPE;
    v_eosl_kost system_cost.eosl_kost%TYPE;
    v_project_kost system_cost.project_kost%TYPE;
    v_totale_kost system_cost.totale_kost%TYPE;
    err_num number;
    err_line number;
    err_msg varchar2(255);
    FUNCTION get_cost_kenm(kenmerk IN kostelementen.functie%TYPE)
    RETURN kostelementen.waarde%TYPE
    AS
        v_waarde kostelementen.waarde%TYPE;
    BEGIN
        SELECT waarde INTO v_waarde
        FROM kostelementen
        WHERE functie = kenmerk
        AND element = 'Server';
        RETURN v_waarde;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            IF (NOT kenmerk_err.EXISTS(kenmerk)) THEN
                p_log(proc_name, 'E', 'Kenmerk ' || kenmerk || ' niet gevonden in Tabel Kostelementen');
                kenmerk_err(kenmerk) := 1;
            END IF;
            RETURN 0;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            err_line := $$PLSQL_LINE;
            p_log(proc_name, 'E', 'Procedure get_cost_kenm, onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg); 
            RETURN 0;
    END;
    FUNCTION get_cost(kenmerken IN component.kenmerken%TYPE) 
        RETURN system_cost.migratie%TYPE
    AS
        k_array string_fnc.t_array;
        v_cost system_cost.migratie%TYPE := 0;
    BEGIN
        k_array := string_fnc.split(kenmerken, ';');
        FOR cnt IN 1..k_array.COUNT LOOP
            v_cost := v_cost + get_cost_kenm(k_array(cnt));
        END LOOP;
        IF (v_cost = 0) THEN 
            v_cost := get_cost_kenm('Default');
        END IF;
        RETURN v_cost;
    END;
    FUNCTION get_eosl_factor(cmdb_id_in IN cons_eosl.cmdb_id%TYPE)
    RETURN number
    IS
        v_eosl_factor number := 0;
        eosl eosl_rec;
    BEGIN
        -- Find EOSL date in cons_eosl
        SELECT min(uitdovend_datum), min(uitgedoofd_datum)
        INTO eosl
        FROM cons_eosl
        WHERE cmdb_id = cmdb_id_in;
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
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN v_eosl_factor;
        WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Procedure get_eosl_factor, onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg); 
    END;
    
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table system_cost';
    -- Get values from kostelementen
    SELECT waarde INTO v_mgmt_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Management';
    SELECT waarde INTO v_arch_waarde
    FROM kostelementen
    WHERE element = 'Project'
      AND functie = 'Architectuur';
    SELECT datum, waarde
    INTO cut_eosl.uitdovend_datum, fct.uitdovend
    FROM kostelementen
    WHERE element = 'uitdovend';
    SELECT datum, waarde
    INTO cut_eosl.uitgedoofd_datum, fct.uitgedoofd
    FROM kostelementen
    WHERE element = 'uitgedoofd';
    OPEN sys_cursor;
    LOOP
        FETCH sys_cursor INTO sys;
        EXIT WHEN sys_cursor%NOTFOUND;
        -- limitcnt := limitcnt + 1;
        -- EXIT WHEN limitcnt > 5;
        -- dbms_output.put_line('Investigate ' || sw_comp.naam);
        -- Reset variables
        v_loopcnt := 0;
        v_msg := '';
        v_migratie := get_cost(sys.kenmerken);
        IF ((sys.omgeving like 'T%') OR (sys.omgeving like 'O%')) THEN
            v_migratie := v_migratie / 3;
        END IF;
        v_eosl_kost := v_migratie * get_eosl_factor(sys.cmdb_id);
        v_project_kost := ((v_migratie + v_eosl_kost) * v_mgmt_waarde) + ((v_migratie + v_eosl_kost) * v_arch_waarde);
        v_totale_kost := v_migratie + v_eosl_kost + v_project_kost;
        -- Save the resuls
        INSERT INTO system_cost (cmdb_id, naam, migratie, project_kost, eosl_kost, totale_kost)
        VALUES (sys.cmdb_id, sys.naam, v_migratie, v_project_kost, v_eosl_kost, v_totale_kost);
        
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
   
END;
/

CREATE OR REPLACE PROCEDURE  "P_SYSTEM_CHECKS" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_system_checks';
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
    err_num number;
    err_line number;
    err_msg varchar2(255);
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
                NULL;
                -- p_log(proc_name, 'E', 'CI is reeds gezien, server: ' || v_top_cmdb_id || ', CI: ' || tgt_rel.cmdb_id);
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
                ELSIF (tgt_rel.ci_type like 'JOB%') THEN
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
         
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
  
END;
/

CREATE OR REPLACE PROCEDURE  "P_SW_COMPONENT_CHECKS" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_sw_component_checks';
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
    err_num number;
    err_line number;
    err_msg varchar2(255);
        
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
        -- Make sure Computertype is defined
        IF (length(v_comp_type) > 5) THEN
            sw_cost_cat.computertype := v_comp_type;
        ELSE
            sw_cost_cat.computertype := 'FYSIEKE COMPUTER';
        END IF;
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
        v_comp_type := 'sml';
        next_sw_comp.cmdb_id := sw_comp.cmdb_id;
        next_sw_comp.naam := sw_comp.naam;
        next_sw_comp.ci_categorie := sw_comp.ci_categorie;
        next_sw_comp.ci_type := sw_comp.ci_type;
        go_down(next_sw_comp);
        save_results(next_sw_comp);
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');    
         
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
   
END;
/

CREATE OR REPLACE PROCEDURE  "P_SEND_SUMM" 
    IS
    
    proc_name logtbl.evt_proc%TYPE := 'p_send_summ';
    err_msg varchar2(255);
    v_p_body_html VARCHAR2(4000); 
    v_resultaat number;
    v_msg_token varchar2(50) := 'Mail Log Information Checkpoint';
    v_title varchar2(50) := 'Boudewijn Datacenter Move';
    cursor log_cursor IS
        SELECT * FROM logtbl
        WHERE evt_time > (select max(evt_time) from logtbl where evt_msg = v_msg_token)
        AND ((evt_sev = 'E') OR (evt_proc = 'LDAP_AUTHENTICATE'))
        ORDER BY evt_idx ASC;
    log_rec logtbl%ROWTYPE;
    PROCEDURE ip_send_mail
        IS
    BEGIN
        wwv_flow_api.set_security_group_id(51155200479522588); -- Workspace: MOW_DATAROOM_PROD
        v_p_body_html := '<html><body><h3>' || v_title || '</h3><br>' ||
                         '<table><tr><th>Index<th>Time<th>Procedure<th>Sev<th>Message</tr>' ||
                         v_p_body_html || '</table></body></html>';
        v_resultaat := APEX_MAIL.SEND(
            p_to        => 'dirk.vermeylen@hp.com',
            p_from      => 'dirk.vermeylen@hp.com',
            p_subj      => v_title,
            p_body      => 'Tekst body',
            p_body_html => v_p_body_html
            );
        APEX_MAIL.PUSH_QUEUE;
        p_log(proc_name, 'T', 'Summary message sent');
    EXCEPTION
        WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        p_log(proc_name || ' in ip_send_mail', 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
    END;
BEGIN
    
    OPEN log_cursor;
    LOOP
        FETCH log_cursor INTO log_rec;
        EXIT WHEN log_cursor%NOTFOUND;
        v_p_body_html := v_p_body_html ||
                         '<tr><td>'  || log_rec.evt_idx  || 
                         '</td><td>' || to_char(log_rec.evt_time, 'DD/MM/YYYY HH24:MI:SS') ||
                         '</td><td>' || log_rec.evt_proc ||
                         '</td><td>' || log_rec.evt_sev  ||
                         '</td><td>' || log_rec.evt_msg  ||
                         '</td></tr>';
        IF (length(v_p_body_html) > 3200) THEN 
            -- Exit loop when message is too long,
            -- the user has been warned....
            v_p_body_html := v_p_body_html || '<tr><td><td><td><td><td><b><font color=red>More messages in logtbl...</font></b></tr>';
            EXIT;
        END IF;
    END LOOP;
            
            p_log(proc_name, 'I', v_msg_token);
    IF length(v_p_body_html) > 0 THEN
        ip_send_mail;
    END IF;
        
EXCEPTION
    WHEN OTHERS THEN
    err_msg:= SUBSTR(SQLERRM, 1, 100);
    p_log(proc_name, 'E', 'Onverwachte fout: ' || err_msg || ' backtrack: ' || DBMS_UTILITY.format_error_backtrace);
END;
/

CREATE OR REPLACE PROCEDURE  "P_SEND_MAIL" (p_evt_time IN logtbl.evt_time%TYPE, 
                                          p_evt_proc IN logtbl.evt_proc%TYPE, 
                                          p_evt_msg  IN logtbl.evt_msg%TYPE)
    IS
    
    v_p_body_html VARCHAR2(4000); 
    v_resultaat number;
    v_evt_time varchar2(20);
BEGIN
        
    wwv_flow_api.set_security_group_id(51155200479522588); -- Workspace: HB_CMDB_PROD
    v_evt_time := to_char(p_evt_time, 'DD/MM/YYYY HH24:MI:SS');
    v_p_body_html := '<html><body><h3>Migratie Boudewijn</h3>';
    v_p_body_html := v_p_body_html || 'Procedure: ' || p_evt_proc || '<br>';
    v_p_body_html := v_p_body_html || 'Tijd: ' || v_evt_time || '<br>';
    v_p_body_html := v_p_body_html || 'Bericht: ' || p_evt_msg || '</body></html>';
    v_resultaat := APEX_MAIL.SEND(p_to => 'dirk.vermeylen@hp.com',
        p_from => 'dirk.vermeylen@hp.com',
        p_subj => 'Migratie Boudewijn',
        p_body => 'Tekst body',
        p_body_html => v_p_body_html
        );
    APEX_MAIL.PUSH_QUEUE;
END;
/

CREATE OR REPLACE PROCEDURE  "P_RUN_ALL" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_run_all';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    p_log(proc_name, 'I', 'Logfile maintenance');
    p_log_maint;
    p_log(proc_name, 'I', 'Calling p_load_extcmwbt0011');
    p_load_extcmwbt0011;
    p_log(proc_name, 'I', 'Calling p_convert_data');
    p_convert_data;
    p_log(proc_name, 'I', 'Calling p_calculate');
    p_calculate;
    p_log(proc_name, 'I', 'Calling p_system_verification');
    p_system_verification;
    p_log(proc_name, 'I', 'End Application');
    p_apex_mail_send;
    p_log(proc_name, 'I', 'Email notificatie');
END;
/

CREATE OR REPLACE PROCEDURE  "P_LOG_MAINT" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_log_maint';
    err_num number;
    err_line number;
    err_msg varchar2(255);
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'delete from logtbl where (evt_time < (sysdate -7)) and (not(evt_msg like ''User%''))';
    p_log(proc_name, 'I', 'End Procedure');
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
   
END;
/

CREATE OR REPLACE PROCEDURE  "P_LOG" (proc_name IN logtbl.evt_proc%TYPE,
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
    --IF ((proc_name = 'LDAP_AUTHENTICATE') OR (sev = 'E')) THEN
    --    p_send_mail(sysdate, proc_name, msg);
    --END IF;
END;
/

CREATE OR REPLACE PROCEDURE  "P_LOAD_EXTCMWBT0011" 
    IS
    proc_name varchar2(255) := 'p_load_extcmwbt0011';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    p_log(proc_name, 'I', 'Calling LOADEXTCMWBT0011');
    LOADEXTCMDB;
    p_log(proc_name, 'I', 'Calling p_check_cmwbt0011');
    p_check_cmwbt0011;
    p_log(proc_name, 'I', 'End Application');
END;
/

CREATE OR REPLACE PROCEDURE  "P_JOB_CHECKS" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_job_checks';
    limitcnt number := 0;
    
    CURSOR sw_comp_cursor IS
    select CMDB_ID,
           NAAM,
           CI_CATEGORIE,
           CI_TYPE
    from COMPONENT
    where (CI_TYPE like 'JOB%');
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
    err_num number;
    err_line number;
    err_msg varchar2(255);
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
        INSERT INTO job_checks
            (sw_id, sw_naam, sw_type, sw_categorie, comp_naam,  
                connections, msgstr, assessment, migratie)
        VALUES
            (sv_sw_comp.cmdb_id, sv_sw_comp.naam, sv_sw_comp.ci_type,
                sv_sw_comp.ci_categorie, v_computer, v_connections, v_msg, 0, 0);
    END;
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    EXECUTE IMMEDIATE 'truncate table job_checks';
    
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
         
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_TPO" 
    IS 
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_tpo';
    CURSOR tpo_cursor IS
    select DISTINCT
           TOEPASSINGOMGEVING,
           STATUS_TOEPASSINGOMGEVING,
           CMDB_REFERENTIE_OMGEVING,
           VERSIE,
           TYPE_OMGEVING,
           DATUM_IN_GEBRUIK,
           DATUM_BUITEN_GEBRUIK,
           DIENSTENTYPE,
           FINANCIEEL_BEHEERDER_BELEIDSD,
           FINANCIEEL_BEHEERDER_ENTITEIT,
           EIGENAAR_BELEIDSDOMEIN,
           EIGENAAR_ENTITEIT,
           NUMMER_BEDRIJFSTOEPASSING 
    from CMWBT0011
    where CMDB_REFERENTIE_OMGEVING >0;
TYPE tpo_record IS RECORD (
    NAAM component.NAAM%TYPE,
    STATUS component.STATUS%TYPE,
    CMDB_ID cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,
    VERSIE component.VERSIE%TYPE,
    OMGEVING component.OMGEVING%TYPE,
    DATUM_IN_GEBRUIK component.DATUM_IN_GEBRUIK%TYPE,
    DATUM_BUITEN_GEBRUIK component.DATUM_BUITEN_GEBRUIK%TYPE,
    DIENSTENTYPE component.DIENSTENTYPE%TYPE,
    FIN_BELEIDSDOMEIN component.FIN_BELEIDSDOMEIN%TYPE,
    FIN_ENTITEIT component.FIN_ENTITEIT%TYPE,
    EIGENAAR_BELEIDSDOMEIN component.EIGENAAR_BELEIDSDOMEIN%TYPE,
    EIGENAAR_ENTITEIT component.EIGENAAR_ENTITEIT%TYPE,
    BT_NUMMER component.BT_NUMMER%TYPE);
    tpo tpo_record;
    c_ci_class CONSTANT component.CI_CLASS%TYPE := 'toepassingcomponentinstallatie';
    v_cmdb_id component.cmdb_id%TYPE;
    
    v_not_num_cnt number := 998000;
    err_num number;
    err_line number;
    err_msg varchar2(255);
    FUNCTION convert2number (v_str IN varchar2)
    RETURN number
    IS
        v_nr number;
    BEGIN
        v_nr := to_number(v_str);
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde niet numeriek! *' || v_str || '*');
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
    END;
    
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN tpo_cursor;
    LOOP
        FETCH tpo_cursor INTO tpo;
        EXIT WHEN tpo_cursor%NOTFOUND;
        v_cmdb_id := convert2number(tpo.cmdb_id);
        INSERT INTO component (ci_class, naam, status, cmdb_id, versie, omgeving, datum_in_gebruik,
            datum_buiten_gebruik, dienstentype, fin_beleidsdomein, fin_entiteit, 
            eigenaar_beleidsdomein, eigenaar_entiteit, bt_nummer)
        VALUES (c_ci_class, tpo.naam, tpo.status, v_cmdb_id, tpo.versie, tpo.omgeving, tpo.datum_in_gebruik,
                tpo.datum_buiten_gebruik, tpo.dienstentype, tpo.fin_beleidsdomein, tpo.fin_entiteit, 
                tpo.eigenaar_beleidsdomein, tpo.eigenaar_entiteit, tpo.bt_nummer);
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');    
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL_TPO_BT" 
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
        cmdb_id_target cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,
        cmdb_id_source cmwbt0011.CMDB_REFERENTIE_BEDRIJFSTOEPAS%TYPE,
        naam_source relations.naam_source%TYPE);
    rel rel_record;
    v_cmdb_id_source relations.cmdb_id_source%TYPE;
    v_cmdb_id_target relations.cmdb_id_target%TYPE;
    c_ci_type_target   CONSTANT relations.ci_type_target%TYPE := 'Toepassingomgeving';
    c_ci_type_source   CONSTANT relations.ci_type_source%TYPE := 'Bedrijfstoepassing';
    c_categorie_source CONSTANT relations.ci_categorie_source%TYPE := '';
    c_categorie_target CONSTANT relations.ci_categorie_target%TYPE := '';
    c_relation         CONSTANT relations.relation%TYPE := 'heeft component';
    TYPE allvalues_type IS TABLE OF number INDEX BY varchar2(255);
    allvalues allvalues_type;
    
    valuestr varchar2(255);
           
    v_not_num_cnt number := 999000;
    err_num number;
    err_line number;
    err_msg varchar2(255);
    FUNCTION convert2number (v_str IN varchar2)
    RETURN number
    IS
        v_nr number;
    BEGIN
        v_nr := to_number(v_str);
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde niet numeriek! *' || v_str || '*');
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
    END;
    
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN rel_cursor;
    LOOP
        FETCH rel_cursor INTO rel;
        EXIT WHEN rel_cursor%NOTFOUND;
        v_cmdb_id_source := convert2number(rel.cmdb_id_source);
        v_cmdb_id_target := convert2number(rel.cmdb_id_target);
        valuestr := to_char(v_cmdb_id_source) || '.' || c_relation || '.' || to_char(v_cmdb_id_target);
        
        IF NOT allvalues.EXISTS(valuestr) THEN
            -- Found Unique String, remember it and add it to the relations table
            allvalues(valuestr) := 1;
            v_cmdb_id_source := v_cmdb_id_source + 1000000;
            INSERT INTO relations (cmdb_id_source, naam_source, ci_type_source, ci_categorie_source, 
                                   relation,
                                   cmdb_id_target, naam_target, ci_type_target, ci_categorie_target)
            VALUES (v_cmdb_id_source, rel.naam_source, c_ci_type_source, c_categorie_source,
                    c_relation,
                    v_cmdb_id_target, rel.naam_target, c_ci_type_target, c_categorie_target);
        END IF;
        
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');    
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL_LOOPS" 
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
    err_num number;
    err_line number;
    err_msg varchar2(255);
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
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL_COMP" 
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
        cmdb_id_tpo cmwbt0011.CMDB_REFERENTIE_OMGEVING%TYPE,
        relatie relations.relation%TYPE,
        ci_type relations.ci_type_target%TYPE,
        ci_categorie relations.ci_categorie_target%TYPE,
        cmdb_id cmwbt0011.CI_CMDB_REFERENTIE%TYPE,
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
    
    v_not_num_cnt number := 999000;
    err_num number;
    err_line number;
    err_msg varchar2(255);
    FUNCTION convert2number (v_str IN varchar2)
    RETURN number
    IS
        v_nr number;
    BEGIN
        v_nr := to_number(v_str);
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde niet numeriek! *' || v_str || '*');
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
    END;
    
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
        rel_hash(curr_level).cmdb_id := convert2number(rel.cmdb_id);
        rel_hash(curr_level).naam    := rel.naam;
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
            thisrel.cmdb_id_target := convert2number(rel.cmdb_id);
            thisrel.naam_target := rel.naam;
            thisrel.ci_type_target := rel.ci_type;
            thisrel.ci_categorie_target := rel.ci_categorie;
            thisrel.relation := relation;
            thisrel.cmdb_id_source := convert2number(rel.cmdb_id_tpo);
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
                thisrel.cmdb_id_target := convert2number(rel.cmdb_id);
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
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_REL" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_rel';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    EXECUTE IMMEDIATE 'truncate table relations';
    p_get_cmwbt0011_rel_tpo_bt;
    p_get_cmwbt0011_rel_comp;
    p_get_cmwbt0011_rel_loops;
    p_log(proc_name, 'I', 'End Application');
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_DATA" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_data';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    EXECUTE IMMEDIATE 'truncate table component';
    p_get_cmwbt0011_tpo;
    p_get_cmwbt0011_bt;
    p_get_cmwbt0011_comp;
    p_log(proc_name, 'I', 'End Application');
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_COMP" 
    IS
    
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_comp';
    CURSOR comp_cursor IS
    select DISTINCT CI_CATEGORIE,
           CI_TYPE,
           CI_CMDB_REFERENTIE,
           CI_SYSTEEMNAAM,
           CI_STATUS,
           CI_EIGENAAR,
           KENMERKEN,
           PRODUCENT,
           PRODUCT,
           SW_VERSIE,
           OS,
           VERSIE_OS,
           HWSW,
           LOCATIE,
           OMGEVING,
           UITDOVEND_DATUM,
           UITGEDOOFD_DATUM
    from CMWBT0011;
    TYPE comp_record IS RECORD (
    ci_categorie component.ci_categorie%TYPE,
    ci_type component.ci_type%TYPE,
    CMDB_ID cmwbt0011.CI_CMDB_REFERENTIE%TYPE,
    NAAM component.NAAM%TYPE,
    status component.status%TYPE,
    eigenaar_entiteit component.eigenaar_entiteit%TYPE,
    kenmerken component.kenmerken%TYPE,
    producent component.producent%TYPE,
    product component.product%TYPE,
    versie component.versie%TYPE,
    os component.os%TYPE,
    os_versie component.os_versie%TYPE,
    hw_sw_flag component.hw_sw_flag%TYPE,
    locatie component.locatie%TYPE,
    omgeving component.omgeving%TYPE,
    uitdovend_datum cmwbt0011.uitdovend_datum%TYPE,
    uitgedoofd_datum cmwbt0011.uitgedoofd_datum%TYPE);
    
    comp comp_record;
    v_cmdb_id component.cmdb_id%TYPE;
    v_uitdovend_datum component.uitdovend_datum%TYPE;
    v_uitgedoofd_datum component.uitgedoofd_datum%TYPE;
    v_not_num_cnt number := 999000;
    v_no_date date := '21/07/1963';
    err_num number;
    err_line number;
    err_msg varchar2(255);
    FUNCTION convert2number (v_str IN varchar2)
    RETURN number
    IS
        v_nr number;
    BEGIN
        v_nr := to_number(v_str);
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde niet numeriek! *' || v_str || '*');
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
    END;
    
    FUNCTION convert2date (v_str IN varchar2)
    RETURN date
    IS
        v_nr date;
    BEGIN
        v_nr := to_date(v_str, 'yyyy/mm/dd  HH24:MI:SS');
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde geen datum! *' || v_str || '*');
            RETURN v_no_date;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            RETURN v_no_date;
    END;
    
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN comp_cursor;
    LOOP
        FETCH comp_cursor INTO comp;
        EXIT WHEN comp_cursor%NOTFOUND;
        v_cmdb_id := convert2number(comp.cmdb_id);
        v_uitdovend_datum := convert2date(comp.uitdovend_datum);
        v_uitgedoofd_datum := convert2date(comp.uitgedoofd_datum);
        INSERT INTO component (ci_categorie, ci_type, cmdb_id, naam, status,
                               eigenaar_entiteit, producent, product, versie, os, os_versie,
                               hw_sw_flag, locatie, kenmerken, omgeving,
                               uitdovend_datum, uitgedoofd_datum)
        VALUES (comp.ci_categorie, comp.ci_type, v_cmdb_id, comp.naam, comp.status,
                comp.eigenaar_entiteit, comp.producent, comp.product, comp.versie, comp.os, comp.os_versie,
                comp.hw_sw_flag, comp.locatie, comp.kenmerken, comp.omgeving,
                v_uitdovend_datum, v_uitgedoofd_datum);
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');    
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_GET_CMWBT0011_BT" 
    IS
    
    proc_name logtbl.evt_proc%TYPE := 'p_get_cmwbt0011_bt';
    CURSOR bt_cursor IS
    select DISTINCT CMDB_REFERENTIE_BEDRIJFSTOEPAS,
                    NAAM_BEDRIJFSTOEPASSING,
                    NUMMER_BEDRIJFSTOEPASSING,
                    SO_TOEPASSINGSMANAGERS,
                    VO_APPLICATIEBEHEERDERS 
    from CMWBT0011
    where length(NAAM_BEDRIJFSTOEPASSING) > 0;
    TYPE bt_record IS RECORD (
        CMDB_ID cmwbt0011.CMDB_REFERENTIE_BEDRIJFSTOEPAS%TYPE,
        NAAM component.NAAM%TYPE,
        BT_NUMMER component.BT_NUMMER%TYPE,
        SO_TOEPASSINGSMANAGER component.SO_TOEPASSINGSMANAGER%TYPE,
        VO_APPLICATIEBEHEERDER component.VO_APPLICATIEBEHEERDER%TYPE);
    v_cmdb_id component.cmdb_id%TYPE;
    bt bt_record;
    c_ci_class CONSTANT component.CI_CLASS%TYPE := 'bedrijfstoepassing';
    v_not_num_cnt number := 999000;
    err_num number;
    err_line number;
    err_msg varchar2(255);
    FUNCTION convert2number (v_str IN varchar2)
    RETURN number
    IS
        v_nr number;
    BEGIN
        v_nr := to_number(v_str);
        RETURN v_nr;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            p_log(proc_name, 'E', 'Waarde niet numeriek! *' || v_str || '*');
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
        WHEN OTHERS THEN
            err_msg:= SUBSTR(SQLERRM, 1, 100);
            err_num:= SQLCODE;
            p_log(proc_name, 'E', 'convert2number fout nr: ' || err_num || ' msg: ' || err_msg);
            v_not_num_cnt := v_not_num_cnt + 1;
            RETURN v_not_num_cnt;
    END;
    
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    
    OPEN bt_cursor;
    LOOP
        FETCH bt_cursor INTO bt;
        EXIT WHEN bt_cursor%NOTFOUND;
        v_cmdb_id := convert2number(bt.cmdb_id);
        v_cmdb_id := v_cmdb_id + 1000000;
        INSERT INTO component (ci_class, naam, cmdb_id, bt_nummer, so_toepassingsmanager, vo_applicatiebeheerder)
        VALUES (c_ci_class, bt.naam, v_cmdb_id, bt.bt_nummer, bt.so_toepassingsmanager, bt.vo_applicatiebeheerder);
    END LOOP; 
    p_log(proc_name, 'I', 'End Procedure');
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_CONVERT_DATA" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_convert_data';
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    p_log(proc_name, 'I', 'Calling p_get_cmwbt0011_data');
    p_get_cmwbt0011_data;
    p_log(proc_name, 'I', 'Calling p_get_cmwbt0011_rel');
    p_get_cmwbt0011_rel;
    p_log(proc_name, 'I', 'End Application');
END;
/

CREATE OR REPLACE PROCEDURE  "P_CHECK_CMWBT0011" 
IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_check_cmwbt0011';
    v_invalid_rec number;
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    SELECT count(*) 
    INTO v_invalid_rec
    FROM cmwbt0011
    WHERE (not relatie like '%=%')
    OR (relatie is null);
    p_log(proc_name, 'I', v_invalid_rec || ' invalid records found');
    IF (v_invalid_rec > 0) THEN
        p_log(proc_name, 'T', 'Trying to delete the records');
        DELETE 
        FROM cmwbt0011
        WHERE (not relatie like '%=%')
           OR (relatie is null);
    END IF;
    p_log(proc_name, 'I', 'End Application');
END;
/

CREATE OR REPLACE PROCEDURE  "P_CALCULATE" 
    IS
    
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_calculate';
    err_num number;
    err_line number;
    err_msg varchar2(255);
BEGIN
    p_log(proc_name, 'I', 'Start Application');
    p_log(proc_name, 'I', 'Calling sw_component_checks');
    p_sw_component_checks;
    p_log(proc_name, 'I', 'Calling job_checks'); 
    p_job_checks;
    p_log(proc_name, 'I', 'Calling system_checks');
    p_system_checks;
    p_log(proc_name, 'I', 'Calling apps_checks');
    p_apps_check;
    p_log(proc_name, 'I', 'Calling system_cost');
    p_system_cost;
    p_log(proc_name, 'I', 'Calling system_used_by');
    p_system_used_by;
    p_log(proc_name, 'I', 'End Application');
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
    
/

CREATE OR REPLACE PROCEDURE  "P_APPS_CHECK" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_apps_check';
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
    err_num number;
    err_line number;
    err_msg varchar2(255);
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
            ELSIF (src_rel.ci_type like 'JOB%') THEN
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
        v_eosl_factor := get_eosl_factor(in_eosl);
        v_eosl_kost := v_assessment * v_eosl_factor;
        v_work_kost := v_assessment + v_migratie + v_eosl_kost;
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
EXCEPTION
    WHEN OTHERS THEN
        err_msg:= SUBSTR(SQLERRM, 1, 100);
        err_num:= SQLCODE;
        err_line := $$PLSQL_LINE;
        p_log(proc_name, 'E', 'Onverwachte fout lijn: ' || err_line || ' nr: ' || err_num || ' msg: ' || err_msg);
END;
/

CREATE OR REPLACE PROCEDURE  "P_APEX_MAIL_SEND" 
    IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'p_apex_mail_send';
-- Auteur: Brackenier Bart
-- Doel: Opsturen statistitieken, per dag, na batch "KOSTENRAMING_CALC"
    
v_host VARCHAR2(255);
v_service VARCHAR2(255);
v_user VARCHAR2(255);
v_ip VARCHAR2(255);
v_session VARCHAR2(255);
v_schema VARCHAR2(255);
v_schemauniq VARCHAR2(255);
v_schemanaam VARCHAR2(255);
v_schemaid VARCHAR2(255);
v_domein VARCHAR2(255);
v_uid VARCHAR2(255);
v_module VARCHAR2(255);
v_records VARCHAR2(255);
v_workspace VARCHAR2(255);
v_fs number := 2;  -- Font size
html_body VARCHAR2(5200);
v_p_body_html VARCHAR2(5700); -- CLOB := EMPTY_CLOB;
Resultaat NUMBER;
CURSOR C1 IS SELECT TABLE_NAME FROM USER_TABLES order by 1;
l_query varchar2(300);
l_num pls_integer;
l_num_1 pls_integer;
l_num_1_c varchar2(10);
l_num_c varchar2(10);
delta_c varchar2(10);
delta pls_integer;
procent pls_integer;    -- delta
drempel pls_integer := 10;   -- Procent
v_kleur varchar2(6);
BEGIN
    wwv_flow_api.set_security_group_id(51155200479522588); -- Workspace: HB_CMDB_PROD
    
    SELECT count(table_name) - 1   -- min delta tabel (niet zichtbaar)
    into v_records
    FROM user_tables;
    select workspace into v_workspace from apex_workspaces;
    -- hoofding
    html_body := '<tr><th><font face="Arial" size="2">Tabellen</font></th>' || 
    '<th><font face="Arial" size="2">D-1<br>Aantal</font></th>' ||
    '<th><font face="Arial" size="2">D<br>Aantal</font></th>' ||
    '<th><font face="Arial" size="2"> 
    Delta</font></th><th>&#916; %</th></tr>';
    FOR REC IN C1 LOOP
        
        l_query := 'SELECT COUNT(*) FROM ' || REC.TABLE_NAME;
        EXECUTE IMMEDIATE l_query INTO l_num;
        if rec.TABLE_NAME <> 'DELTA' then -- interne keuken
            
            BEGIN
            select aantal
            into l_num_1
            from (select aantal
            from delta
            where trunc(datum) = trunc(sysdate-1) and tabel_naam = rec.TABLE_NAME
            order by datum desc ) where rownum=1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                  DBMS_OUTPUT.PUT_LINE ('Geen gegevens gevonden over tabel ' || rec.TABLE_NAME);
                  l_num_1 := 0; 
              WHEN TOO_MANY_ROWS THEN
                  DBMS_OUTPUT.PUT_LINE ('Meerdere resultaten voor tabel ' || rec.TABLE_NAME);
                  l_num_1 := 0;
            END;
            delta := l_num - l_num_1;
            l_num_1_c := TO_CHAR(l_num_1,'999G999G999','NLS_NUMERIC_CHARACTERS=".,"');
            l_num_c := TO_CHAR(l_num,'999G999G999','NLS_NUMERIC_CHARACTERS=".,"');
            delta_c := TO_CHAR(delta,'999G999G999','NLS_NUMERIC_CHARACTERS=".,"');
            if l_num = 0 or l_num_1 = 0 then -- aantal records => leeg => Rood
                v_kleur := 'ee0000'; -- devision by zero
                if rec.TABLE_NAME = 'EXT_CMWBT0011' then
                    -- Vet rood                     
                    html_body := html_body || utl_tcp.crlf || '<tr><td><font face="Arial" size=2><b>' || rec.TABLE_NAME || '</b></font></td>' ||     
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2><b>' || l_num_1_c || '</b></font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2><b>' || l_num_c || '</b></font></td>' ||
                    '<td align=right><b>' || delta_c || '</b></td>' ||
                    '<td align=right><b>-</b></td></tr>';
                else -- Rood
                    html_body := html_body || utl_tcp.crlf || '<tr><td><font face="Arial" size=2>' || rec.TABLE_NAME || '</font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2>' || l_num_1_c || '</font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2>' || l_num_c || '</font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2>' || delta_c || '</font></td>' ||
                    '<td align=right>-</td></tr>';
                end if;
            else -- Groen
                procent := (100 * l_num / l_num_1) - 100;
                if abs(procent) > drempel then
                    v_kleur := 'ee0000'; -- rood
                else
                    v_kleur := '00ee00'; -- groen
                end if;
                if rec.TABLE_NAME = 'EXT_CMWBT0011' then
                    -- Vet
                    html_body := html_body || utl_tcp.crlf || '<tr><td><font face="Arial" size=2><b>' || rec.TABLE_NAME || '</b></font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2><b>' || l_num_1_c || '</b></font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2><b>' || l_num_c || '</b></font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2><b>' || delta || '</b></font></td>' ||
                    '<td align=right><font face="Arial" color=#' || v_kleur || ' size=2><b>' || procent || '</b></font></td></tr>';
                else -- groen
                    html_body := html_body || utl_tcp.crlf || '<tr><td><font face="Arial" size=2>' || rec.TABLE_NAME || '</font></td>' ||
                    -- '<td align=right><font face="Arial" color=#00ee00 size=2>' || l_num_1 || '</font></td>' ||
                    '<td align=right>' || l_num_1_c || '</td>' || 
                    -- <font face="Arial" color=#00ee00 size=2>  </font>
                    '<td align=right>' || l_num_c || '</td>' ||
                    '<td align=right>' || delta_c || '</td>' || 
                    '<td align=right>' || procent || '</td></tr>';
                end if;
            end if;
            INSERT INTO DELTA (TABEL_NAAM,AANTAL,DATUM) VALUES (rec.TABLE_NAME,l_num,SYSDATE);
        end if;
    END loop;
    -- opkuis na zeven dagen
    delete from DELTA where trunc(DATUM) < trunc(sysdate-7);
    SELECT SYS_CONTEXT('USERENV','IP_ADDRESS')
    INTO v_ip
    FROM dual;
 
    SELECT SYS_CONTEXT('USERENV','HOST') 
    INTO v_host    
    FROM dual;
    SELECT SYS_CONTEXT('USERENV','SERVICE_NAME')
    INTO v_service
    FROm dual;
    -- dbms_output.put_line(v_service);
    SELECT SYS_CONTEXT('USERENV','SESSION_USER') 
    INTO v_user
    FROM DUAL;
    SELECT SYS_CONTEXT('USERENV','CURRENT_SCHEMA')
    INTO v_schema
    FROM dual;
    SELECT SYS_CONTEXT('USERENV','MODULE')
    INTO v_module
    FROM dual;
    SELECT SYS_CONTEXT('USERENV','AUTHENTICATION_METHOD')
    INTO v_schemanaam
    FROM dual;
    SELECT SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER')
    INTO v_schemauniq
    FROM dual;
    
    SELECT SYS_CONTEXT('USERENV','OS_USER')
    INTO v_uid
    FROM dual;
dbms_output.put_line('Html body lengte: '|| LENGTH(html_body));
-- TO_CLOB();
v_p_body_html := '<html><body bgcolor="#EEEEEE" alink="#333333" vlink="#444444" link="#555555">' ||
        '<basefont face="Arial" size="2">' ||
        '<table width=100% border=1 bgcolor="#dddddd"><tr><td width=33%>IP-adres: ' || v_ip || 
        '</td><td width=33%>Host naam: ' || v_host || 
        '</td><td width=33%>Service: ' || v_service || 
        '</td></tr></table><hr>' || 
        '<table width=100% border=1 bgcolor="#dddddd"><tr><td>Sessie gebruiker: ' || v_user ||
        '</td><td width=33%>OS Gebruiker id: ' || v_uid ||
        '</td><td width=33%>Schema/user: ' || v_schema ||
        '</td></tr><tr><td width=33%>Bron e-mail Module: ' || v_module ||
        '</td><td width=33%>Methode: ' || v_schemanaam ||
        '</td><td width=33%>Client: ' || v_schemauniq ||
        '</td></tr></table><hr>Aantal tabellen: ' || v_records || 
        '<center><table border=1 bgcolor="#dddddd">' || utl_tcp.crlf || html_body || utl_tcp.crlf || 
        '</table>' || '<br><a href="https://apexprod.vonet.be/pls/apex/">Naar Apex prod</a></center>' ||
    '</body></html>';
dbms_output.put_line('Html body lengte: '|| LENGTH(v_p_body_html));
    
    -- Dirk.Vermeylen@hp.com
    
    Resultaat := APEX_MAIL.SEND(p_to => 'bart.brackenier@hp.com',
        p_from => 'bart.brackenier@hb.vlaanderen.be',
        p_subj => 'Statistieken ' || v_host || '/' || v_workspace,
        p_body => 'Tekst body',
        p_body_html => v_p_body_html
        ,p_cc => 'Dirk.Vermeylen@hp.com'
        -- ,p_bcc => ''
        -- ,p_replyto => ''
        );
dbms_output.put_line('Resultaat: '|| Resultaat);
        
APEX_MAIL.PUSH_QUEUE;
END;
/

CREATE OR REPLACE PROCEDURE  "LOADEXTCMDB" 
IS
    proc_name CONSTANT logtbl.evt_proc%TYPE := 'LOADEXTCMDB';
--    v_naam varchar2(255);
--    v_loopcnt number := 0;
BEGIN
    p_log(proc_name, 'I', 'Start Procedure');
    EXECUTE IMMEDIATE 'truncate table cmwbt0011';
    FOR c1 IN (SELECT 
    "TOEPASSINGOMGEVING", 
    "STATUS_TOEPASSINGOMGEVING", 
    "CMDB_REFERENTIE_OMGEVING", 
    "VERSIE", 
    "TYPE_OMGEVING", 
    "DATUM_IN_GEBRUIK", 
    "DATUM_BUITEN_GEBRUIK", 
    "CMDB_REFERENTIE_BEDRIJFSTOEPAS", 
    "NAAM_BEDRIJFSTOEPASSING", 
    "NUMMER_BEDRIJFSTOEPASSING", 
    "DIENSTENTYPE", 
    "FINANCIEEL_BEHEERDER_BELEIDSD", 
    "FINANCIEEL_BEHEERDER_ENTITEIT", 
    "EIGENAAR_BELEIDSDOMEIN", 
    "EIGENAAR_ENTITEIT", 
    "STATUS_BEDRIJFSTOEPASSING", 
    "SO_TOEPASSINGSMANAGERS", 
    "VO_APPLICATIEBEHEERDERS", 
    "RELATIE", 
    "CI_CATEGORIE", 
    "CI_TYPE", 
    "CI_CMDB_REFERENTIE", 
    "CI_SYSTEEMNAAM", 
    "CI_STATUS", 
    "CI_EIGENAAR", 
    "PRODUCENT", 
    "PRODUCT", 
    "SW_VERSIE", 
    "OS", 
    "VERSIE_OS", 
    "HWSW", 
    "LOCATIE", 
    "KENMERKEN", 
    "DIENST_SLA", 
    "TP_FINANCIEEL_BEHEERDER", 
    "UITDOVEND_DATUM", 
    "UITGEDOOFD_DATUM", 
    "OMGEVING"
    FROM EXT_CMWBT0011)
    LOOP
--        v_naam := REPLACE (c1.CI_SYSTEEMNAAM, CHR(0), '');
--        p_log(proc_name, 'T', 'Converting: ' || v_naam);
        INSERT INTO CMWBT0011 (
    TOEPASSINGOMGEVING, 
    STATUS_TOEPASSINGOMGEVING, 
    CMDB_REFERENTIE_OMGEVING, 
    VERSIE, 
    TYPE_OMGEVING, 
    DATUM_IN_GEBRUIK, 
    DATUM_BUITEN_GEBRUIK, 
    CMDB_REFERENTIE_BEDRIJFSTOEPAS, 
    NAAM_BEDRIJFSTOEPASSING, 
    NUMMER_BEDRIJFSTOEPASSING, 
    DIENSTENTYPE, 
    FINANCIEEL_BEHEERDER_BELEIDSD, 
    FINANCIEEL_BEHEERDER_ENTITEIT, 
    EIGENAAR_BELEIDSDOMEIN, 
    EIGENAAR_ENTITEIT, 
    STATUS_BEDRIJFSTOEPASSING, 
    SO_TOEPASSINGSMANAGERS, 
    VO_APPLICATIEBEHEERDERS, 
    RELATIE, 
    CI_CATEGORIE, 
    CI_TYPE, 
    CI_CMDB_REFERENTIE, 
    CI_SYSTEEMNAAM, 
    CI_STATUS, 
    CI_EIGENAAR, 
    PRODUCENT, 
    PRODUCT, 
    SW_VERSIE, 
    OS, 
    VERSIE_OS, 
    HWSW, 
    LOCATIE, 
    KENMERKEN, 
    DIENST_SLA, 
    TP_FINANCIEEL_BEHEERDER, 
    UITDOVEND_DATUM, 
    UITGEDOOFD_DATUM, 
    OMGEVING)
        VALUES(
    REPLACE (c1.TOEPASSINGOMGEVING, CHR(0), ''), 
    REPLACE (c1.STATUS_TOEPASSINGOMGEVING, CHR(0), ''), 
    REPLACE (c1.CMDB_REFERENTIE_OMGEVING, CHR(0), ''), 
    REPLACE (c1.VERSIE, CHR(0), ''), 
    REPLACE (c1.TYPE_OMGEVING, CHR(0), ''), 
    REPLACE (c1.DATUM_IN_GEBRUIK, CHR(0), ''), 
    REPLACE (c1.DATUM_BUITEN_GEBRUIK, CHR(0), ''), 
    REPLACE (c1.CMDB_REFERENTIE_BEDRIJFSTOEPAS, CHR(0), ''), 
    REPLACE (c1.NAAM_BEDRIJFSTOEPASSING, CHR(0), ''), 
    REPLACE (c1.NUMMER_BEDRIJFSTOEPASSING, CHR(0), ''), 
    REPLACE (c1.DIENSTENTYPE, CHR(0), ''), 
    REPLACE (c1.FINANCIEEL_BEHEERDER_BELEIDSD, CHR(0), ''), 
    REPLACE (c1.FINANCIEEL_BEHEERDER_ENTITEIT, CHR(0), ''), 
    REPLACE (c1.EIGENAAR_BELEIDSDOMEIN, CHR(0), ''), 
    REPLACE (c1.EIGENAAR_ENTITEIT, CHR(0), ''), 
    REPLACE (c1.STATUS_BEDRIJFSTOEPASSING, CHR(0), ''), 
    REPLACE (c1.SO_TOEPASSINGSMANAGERS, CHR(0), ''), 
    REPLACE (c1.VO_APPLICATIEBEHEERDERS, CHR(0), ''), 
    REPLACE (c1.RELATIE, CHR(0), ''), 
    REPLACE (c1.CI_CATEGORIE, CHR(0), ''), 
    REPLACE (c1.CI_TYPE, CHR(0), ''), 
    REPLACE (c1.CI_CMDB_REFERENTIE, CHR(0), ''), 
    REPLACE (c1.CI_SYSTEEMNAAM, CHR(0), ''), 
    REPLACE (c1.CI_STATUS, CHR(0), ''), 
    REPLACE (c1.CI_EIGENAAR, CHR(0), ''), 
    REPLACE (c1.PRODUCENT, CHR(0), ''), 
    REPLACE (c1.PRODUCT, CHR(0), ''), 
    REPLACE (c1.SW_VERSIE, CHR(0), ''), 
    REPLACE (c1.OS, CHR(0), ''), 
    REPLACE (c1.VERSIE_OS, CHR(0), ''), 
    REPLACE (c1.HWSW, CHR(0), ''), 
    REPLACE (c1.LOCATIE, CHR(0), ''), 
    REPLACE (c1.KENMERKEN, CHR(0), ''), 
    REPLACE (c1.DIENST_SLA, CHR(0), ''), 
    REPLACE (c1.TP_FINANCIEEL_BEHEERDER, CHR(0), ''), 
    REPLACE (c1.UITDOVEND_DATUM, CHR(0), ''), 
    REPLACE (c1.UITGEDOOFD_DATUM, CHR(0), ''), 
    REPLACE (c1.OMGEVING, CHR(0), '')
  );
    END LOOP;
    p_log(proc_name, 'I', 'End Procedure');
END;
/

