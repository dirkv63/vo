create or replace function "LDAP_AUTHENTICATE" 
(p_username in VARCHAR2, p_password in VARCHAR2) 
return boolean
is
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
DBMS_LDAP.USE_EXCEPTION := TRUE;
--We halen via een admin de dn van de te valideren gebruiker op.
l_session := DBMS_LDAP.init(hostname " dirty="false"=> l_ldap_host,
portnum " dirty="false"=> l_ldap_port);
l_retval := DBMS_LDAP.simple_bind_s(ld " dirty="false"=> l_session,
dn " dirty="false"=> l_ldap_user,
passwd " dirty="false"=> NULL);
l_attrs(1) := 'inr';
l_retval := DBMS_LDAP.search_s(ld " dirty="false"=> l_session, 
base " dirty="false"=> l_ldap_base, 
scope " dirty="false"=> DBMS_LDAP.SCOPE_SUBTREE,
filter " dirty="false"=> 'uid=' || p_username, 
attrs " dirty="false"=> l_attrs,
attronly " dirty="false"=> 1,
res " dirty="false"=> l_message);
IF DBMS_LDAP.count_entries(ld " dirty="false"=> l_session, msg " dirty="false"=> l_message) " dirty="false"> 0 THEN 
l_dn := DBMS_LDAP.get_dn(ld " dirty="false"=> l_session, ldapEntry " dirty="false"=> DBMS_LDAP.first_entry(ld " dirty="false"=> l_session, msg " dirty="false"=> l_message));
ELSE
return false;
END IF;
l_retval := DBMS_LDAP.unbind_s(ld " dirty="false"=> l_session);

--We checken of de combinatie gebruikernaam/paswoord juist is 
l_session := DBMS_LDAP.init(hostname " dirty="false"=> l_ldap_host,
portnum " dirty="false"=> l_ldap_port);
l_retval := DBMS_LDAP.simple_bind_s(ld " dirty="false"=> l_session,
dn " dirty="false"=> l_dn,
passwd " dirty="false"=> p_password); 
l_retval := DBMS_LDAP.unbind_s(ld " dirty="false"=> l_session);


-- Test of de aangelogde gebruiker gekend is in de 
-- gebruikerstabel van de toepassing 
-- deze gebruikerstabel moet kolommen LDAP en ACTIEF hebben!!
Select count(*) 
into v_Aantal 
from LDAP_GEBRUIKERS
where upper(LDAP) = upper(p_username) 
and actief = 'J';
If v_aantal != 1 then
return false;
end if;
--
return true;

EXCEPTION
WHEN OTHERS THEN
l_retval := DBMS_LDAP.unbind_s(ld " dirty="false"=> l_session);
RETURN false;
END;

