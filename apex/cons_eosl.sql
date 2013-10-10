CREATE TABLE  "CONS_EOSL" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"CMDB_ID" NUMBER NOT NULL ENABLE, 
	"UITDOVEND_DATUM" DATE, 
	"UITGEDOOFD_DATUM" DATE, 
	 CONSTRAINT "CONS_EOSL_PK" PRIMARY KEY ("ID") ENABLE
   ) ;

CREATE OR REPLACE TRIGGER  "BI_CONS_EOSL" 
  before insert on "CONS_EOSL"               
  for each row  
begin   
  if :NEW."ID" is null then 
    select "CONS_EOSL_SEQ".nextval into :NEW."ID" from dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_CONS_EOSL" ENABLE;

