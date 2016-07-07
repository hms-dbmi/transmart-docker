UPDATE i2b2pm.PM_CELL_DATA SET URL=REPLACE(URL,'localhost:9090','192.168.99.100:8080');


 CREATE TABLE "DEAPP"."PATIENT_TRIAL" 
  (	"PATIENT_NUM" NUMBER, 
"TRIAL" VARCHAR2(30 BYTE), 
"SECURE_OBJ_TOKEN" VARCHAR2(50 BYTE)
  ) SEGMENT CREATION IMMEDIATE
 TABLESPACE "TRANSMART" ;

 CREATE TABLE "DEAPP"."SAMPLE_DIMENSION" 
  (	"SAMPLE_CD" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
 CONSTRAINT "SAMPLE_DIMENSION_PK" PRIMARY KEY ("SAMPLE_CD")
 USING INDEX
 TABLESPACE "TRANSMART"  ENABLE
  ) SEGMENT CREATION IMMEDIATE
 TABLESPACE "TRANSMART" ;



--
-- Type: SEQUENCE; Owner: DEAPP; Name: I2B2_ID_SEQ
--
CREATE SEQUENCE  "DEAPP"."I2B2_ID_SEQ"    MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 496244 CACHE 20 NOORDER  NOCYCLE ;
GRANT SELECT  ON "DEAPP"."I2B2_ID_SEQ" TO TM_CZ;

CREATE SEQUENCE "DEAPP"."seq_patient_num" MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 CACHE 20 NOORDER  NOCYCLE ;
GRANT SELECT ON "DEAPP"."seq_patient_num" TO TM_CZ;

--
-- Type: TRIGGER; Owner: DEAPP; Name: TRG_I2B2_ID
--
  CREATE OR REPLACE TRIGGER "DEAPP"."TRG_I2B2_ID" 
before insert on "I2B2METADATA"."I2B2"    
for each row begin     
  if inserting then       
    if :NEW."I2B2_ID" is null then          
      select I2B2_ID_SEQ.nextval into :NEW."I2B2_ID" from dual;       
    end if;    
  end if; 
end;

/
ALTER TRIGGER "DEAPP"."TRG_I2B2_ID" ENABLE;

--
-- Name: seq_patient_num; Type: SEQUENCE; Schema: DEAPP; Owner: -
--


--
-- Type: SEQUENCE; Owner: I2B2DEMODATA; Name: SQ_UP_ENCDIM_ENCOUNTERNUM
--
CREATE SEQUENCE  "DEAPP"."SQ_UP_ENCDIM_ENCOUNTERNUM"  MINVALUE 1 MAXVALUE 9999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  ORDER  NOCYCLE ;

--
-- Type: SEQUENCE; Owner: I2B2DEMODATA; Name: CONCEPT_ID
--
CREATE SEQUENCE  "DEAPP"."CONCEPT_ID"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1341004 CACHE 20 NOORDER  NOCYCLE ;

--
-- Type: SEQUENCE; Owner: I2B2DEMODATA; Name: PROTOCOL_ID_SEQ
--
CREATE SEQUENCE  "DEAPP"."PROTOCOL_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 215 CACHE 20 NOORDER  NOCYCLE ;

--
-- Type: SEQUENCE; Owner: I2B2DEMODATA; Name: ASYNC_JOB_SEQ
--
CREATE SEQUENCE  "DEAPP"."ASYNC_JOB_SEQ"  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 0 NOCACHE  NOORDER  NOCYCLE ;

--
-- Type: SEQUENCE; Owner: I2B2DEMODATA; Name: SEQ_SUBJECT_REFERENCE
--
CREATE SEQUENCE  "DEAPP"."SEQ_SUBJECT_REFERENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 743 CACHE 20 NOORDER  NOCYCLE ;


GRANT  SELECT  ON "DEAPP"."SQ_UP_ENCDIM_ENCOUNTERNUM" TO TM_CZ;
GRANT  SELECT  ON "DEAPP"."CONCEPT_ID" TO TM_CZ;
GRANT  SELECT  ON "DEAPP"."PROTOCOL_ID_SEQ" TO TM_CZ;
GRANT  SELECT  ON "DEAPP"."ASYNC_JOB_SEQ" TO TM_CZ;
GRANT  SELECT  ON "DEAPP"."SEQ_SUBJECT_REFERENCE" TO TM_CZ;
GRANT  SELECT,INSERT,DELETE  ON "DEAPP"."PATIENT_TRIAL" TO TM_CZ;
GRANT  SELECT,INSERT  ON "DEAPP"."SAMPLE_DIMENSION" TO TM_CZ;
GRANT  SELECT  ON "I2B2METADATA"."I2B2" TO DEAPP;



ALTER TABLE I2B2METADATA.I2B2 ADD I2B2_ID INTEGER;
ALTER TABLE I2B2DEMODATA.CONCEPT_DIMENSION ADD "TABLE_NAME" VARCHAR2(255 BYTE);
ALTER TABLE I2B2DEMODATA.OBSERVATION_FACT ADD "SAMPLE_CD" VARCHAR2(200 BYTE);

ALTER TABLE i2b2metadata.i2b2 MODIFY M_APPLIED_PATH VARCHAR2(700 BYTE) NULL;
ALTER TABLE i2b2demodata.observation_fact MODIFY ENCOUNTER_NUM NUMBER(38,0) NULL;
ALTER TABLE i2b2demodata.observation_fact MODIFY START_DATE NULL;
ALTER TABLE i2b2demodata.observation_fact DISABLE CONSTRAINT OBSERVATION_FACT_PK;
ALTER TABLE i2b2demodata.QT_PATIENT_SET_COLLECTION DISABLE CONSTRAINT SYS_C007051;
ALTER TABLE i2b2demodata.QT_PATIENT_SET_COLLECTION MODIFY PATIENT_SET_COLL_ID NULL;


exit;