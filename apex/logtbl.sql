CREATE TABLE  "LOGTBL" 
   (	"EVT_IDX" NUMBER NOT NULL ENABLE, 
	"EVT_TIME" TIMESTAMP (6), 
	"EVT_PROC" VARCHAR2(255), 
	"EVT_SEV" VARCHAR2(1), 
	"EVT_MSG" VARCHAR2(255), 
	 CONSTRAINT "LOGTBL_PK" PRIMARY KEY ("EVT_IDX") ENABLE
   ) ;

CREATE OR REPLACE TRIGGER  "LOGTBL_T1" 
BEFORE
insert on "LOGTBL"
for each row
begin
if :NEW."EVT_IDX" is null then 
    select "LOGTBL_SEQ".nextval into :NEW."EVT_IDX" from sys.dual; 
end if;
end;
/
ALTER TRIGGER  "LOGTBL_T1" ENABLE;

