CREATE TABLE "component" (
			  "id" NUMBER,
			  "cmdb_id" NUMBER,
			  "bt_nummer" NUMBER,
			  "ci_categorie" VARCHAR2(255),
			  "ci_class" VARCHAR2(255),
			  "ci_type" VARCHAR2(255),
			  "datum_buiten_gebruik" date,
			  "datum_in_gebruik" date,
			  "dienstentype" VARCHAR2(255),
			  "eigenaar_beleidsdomein" VARCHAR2(255),
			  "eigenaar_entiteit" VARCHAR2(255),
			  "fin_beleidsdomein" VARCHAR2(255),
			  "fin_entiteit" VARCHAR2(255),
			  "hw_sw_flag" VARCHAR2(255),
			  "locatie" VARCHAR2(255),
			  "naam" VARCHAR2(255),
			  "omgeving" VARCHAR2(255),
			  "os" VARCHAR2(255),
			  "os_versie" VARCHAR2(255),
			  "producent" VARCHAR2(255),
			  "product" VARCHAR2(255),
			  "so_toepassingsmanager" VARCHAR2(255),
			  "status" VARCHAR2(255),
			  "versie" VARCHAR2(255),
			  "vo_applicatiebeheerder" VARCHAR2(255),
			CONSTRAINT "component_PK" PRIMARY KEY ("id") ENABLE
   ) ;

CREATE OR REPLACE TRIGGER  "bi_component" 
  before insert on "component"              
  for each row 
begin  
  if :new."ID" is null then
    select "component_SEQ".nextval into :new."ID" from dual;
  end if;
end;

/
ALTER TRIGGER  "bi_component" ENABLE;
