CREATE TABLE  "CONS_CIS" 
   (	"ID" NUMBER, 
	"CMDB_ID_SRC" NUMBER, 
	"NAAM_SRC" VARCHAR2(255), 
	"CMDB_ID_TGT" NUMBER, 
	"NAAM_TGT" VARCHAR2(255), 
	"CI_TYPE_TGT" VARCHAR2(255), 
	"CI_CATEGORIE_TGT" VARCHAR2(255), 
	 CONSTRAINT "CONS_CIS_PK" PRIMARY KEY ("ID") ENABLE
   ) ;

CREATE OR REPLACE TRIGGER  "bi_CONS_CIS" 
  before insert on "CONS_CIS"              
  for each row 
begin  
  if :new."ID" is null then
    select "CONS_CIS_SEQ".nextval into :new."ID" from sys.dual;
  end if;
end;
/
ALTER TRIGGER  "bi_CONS_CIS" ENABLE;

