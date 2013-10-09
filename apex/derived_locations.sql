CREATE TABLE  "DERIVED_LOCATIONS" 
   (	"ID" NUMBER, 
	"CMDB_ID" NUMBER, 
	"LOCATIE" VARCHAR2(255), 
	 CONSTRAINT "DERIVED_LOCATIONS_PK" PRIMARY KEY ("ID") ENABLE
   ) ;

CREATE OR REPLACE TRIGGER  "bi_DERIVED_LOCATIONS" 
  before insert on "DERIVED_LOCATIONS"              
  for each row 
begin  
  if :new."ID" is null then
    select "DERIVED_LOCATIONS_SEQ".nextval into :new."ID" from sys.dual;
  end if;
end;
/
ALTER TRIGGER  "bi_DERIVED_LOCATIONS" ENABLE;

