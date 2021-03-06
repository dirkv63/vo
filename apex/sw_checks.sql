CREATE TABLE  "SW_CHECKS" 
   (	"ID" NUMBER, 
	"SW_ID" NUMBER, 
	"SW_NAAM" VARCHAR2(255), 
	"SW_TYPE" VARCHAR2(255), 
	"SW_CATEGORIE" VARCHAR2(255), 
	"COMP_ID" VARCHAR2(255), 
	"COMP_NAAM" VARCHAR2(255), 
	"COMP_TYPE" VARCHAR2(255), 
	"COMP_CATEGORIE" VARCHAR2(255), 
	"CONNECTIONS" NUMBER, 
	"ASSESSMENT" NUMBER, 
	"MIGRATIE" NUMBER, 
	"MSGSTR" VARCHAR2(1000), 
	 CONSTRAINT "SW_CHECKS_PK" PRIMARY KEY ("ID") ENABLE
   ) ;

CREATE OR REPLACE TRIGGER  "bi_SW_CHECKS" 
  before insert on "SW_CHECKS"              
  for each row 
begin  
  if :new."ID" is null then
    select "SW_CHECKS_SEQ".nextval into :new."ID" from sys.dual;
  end if;
end;
/
ALTER TRIGGER  "bi_SW_CHECKS" ENABLE;

