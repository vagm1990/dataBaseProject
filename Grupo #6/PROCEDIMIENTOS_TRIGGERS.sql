CREATE TABLE HOSPITAL.lab_bitacora
(idbita number(20),
 tabla varchar2(30),
 idcampo  number(30),
 campo  varchar2(30),
 valorant  varchar2(100),
 valornue  varchar2(100),
 fechabita date,
 userbita  varchar2(30),
 accion varchar2(30)
);

--alter table LAB_BITACORA add ACCION varchar2(30);

CREATE SEQUENCE HOSPITAL.SEQ_BITA
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 99999999999999999999;

create or replace PROCEDURE HOSPITAL.PRC_BITACORA(NTABLA VARCHAR2, NIDCAMPO NUMBER, NCAMPO VARCHAR2,NVALORANT VARCHAR2, NVALORNUE VARCHAR2, NACCION VARCHAR2)
AS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO HOSPITAL.LAB_BITACORA(idbita, tabla, idcampo, campo, valorant, valornue, fechabita, userbita, accion)
    VALUES (HOSPITAL.SEQ_BITA.NEXTVAL, NTABLA, NIDCAMPO, NCAMPO, NVALORANT, NVALORNUE, SYSDATE, USERENV('CLIENT_INFO'),NACCION);
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001,'ERROR INSERTANDO BITACORA'||sqlerrm);
END;

/*Bitacora Laboratorios Cabecera*/
create or replace TRIGGER HOSPITAL.TRG_BIR_LABO_CABE
BEFORE INSERT OR UPDATE ON HOSPITAL.LABORATORIOS_CABE
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
INFO_EXCEPCION EXCEPTION;
BEGIN
  /*CAMBIOS EN DESCRIPCION*/
  IF INSERTING AND :OLD.DSLABOCABE IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_CABE', :NEW.IDLABOCABE, 'DSLABOCABE', :OLD.DSLABOCABE, :NEW.DSLABOCABE,'INGRESA');
  ELSIF UPDATING AND :NEW.DSLABOCABE != :OLD.DSLABOCABE THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_CABE', :NEW.IDLABOCABE, 'DSLABOCABE', :OLD.DSLABOCABE, :NEW.DSLABOCABE, 'MODIFICA');
  ELSIF DELETING AND :NEW.DSLABOCABE IS NULL THEN
    HOSPITAL.PRC_BITACORA( 'LABORATORIOS_CABE', :NEW.IDLABOCABE, 'DSLABOCABE', :OLD.DSLABOCABE, :NEW.DSLABOCABE, 'ELIMINA');
  END IF;
  /*CAMBIOS EN ACTIVO*/
  IF INSERTING AND :OLD.ACTIVO IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_CABE', :NEW.IDLABOCABE, 'ACTIVO', :OLD.ACTIVO, :NEW.ACTIVO,'INGRESA');
  ELSIF UPDATING AND :NEW.ACTIVO != :OLD.ACTIVO THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_CABE', :NEW.IDLABOCABE, 'ACTIVO', :OLD.ACTIVO, :NEW.ACTIVO,'MODIFICA');
  ELSIF DELETING AND :NEW.ACTIVO IS NULL THEN
    HOSPITAL.PRC_BITACORA( 'LABORATORIOS_CABE', :NEW.IDLABOCABE, 'ACTIVO', :OLD.ACTIVO, :NEW.ACTIVO,'ELIMINA');
  END IF;
EXCEPTION
WHEN INFO_EXCEPCION THEN
       HOSPITAL.PRC_BITACORA('LABORATORIOS_CABE',:NEW.IDLABOCABE, 'ERROR INSERTANDO BITACORA', NULL, NULL,'ERROR');
       RAISE_APPLICATION_ERROR (-20001, 'Error '||SQLERRM);
END;

/*Bitacora Laboratorios Detalle*/
create or replace TRIGGER HOSPITAL.TRG_BIR_LABO_DETA
BEFORE INSERT OR UPDATE OR DELETE ON HOSPITAL.LABORATORIOS_DETA
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
INFO_EXCEPCION EXCEPTION;
BEGIN	
  /*CAMBIOS EN CABECERA DE LABORATORIOS*/
  IF INSERTING  AND :OLD.IDLABOCABE IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_DETA', :NEW.IDLABODETA, 'IDLABOCABE', :OLD.IDLABOCABE, :NEW.IDLABOCABE, 'INGRESA');
  ELSIF UPDATING AND :NEW.IDLABOCABE != :OLD.IDLABOCABE THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_DETA', :NEW.IDLABODETA, 'IDLABOCABE', :OLD.IDLABOCABE, :NEW.IDLABOCABE, 'MODIFICA');
  ELSIF DELETING AND :NEW.IDLABOCABE IS NULL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_DETA', :NEW.IDLABODETA, 'IDLABOCABE', :OLD.IDLABOCABE, :NEW.IDLABOCABE, 'ELIMINA');
  END IF;
  /*CAMBIOS EN ID DE LABORATORIO REQUISITO*/
  IF INSERTING  AND :OLD.IDLABOREQUI IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_DETA', :NEW.IDLABODETA, 'IDLABOREQUI', :OLD.IDLABOREQUI, :NEW.IDLABOREQUI, 'INGRESA');
  ELSIF UPDATING AND :NEW.IDLABOREQUI != :OLD.IDLABOREQUI THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_DETA', :NEW.IDLABODETA, 'IDLABOREQUI', :OLD.IDLABOREQUI, :NEW.IDLABOREQUI, 'MODIFICA');
  ELSIF DELETING AND :NEW.IDLABOREQUI IS NULL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_DETA', :NEW.IDLABODETA, 'IDLABOREQUI', :OLD.IDLABOREQUI, :NEW.IDLABOREQUI, 'ELIMINA');
  END IF;  
EXCEPTION
WHEN INFO_EXCEPCION THEN
       HOSPITAL.PRC_BITACORA('LABORATORIOS_DETA',:NEW.IDLABODETA, 'ERROR INSERTANDO BITACORA', NULL, NULL,'ERROR');
       RAISE_APPLICATION_ERROR (-20001, 'Error '||SQLERRM);
END;

/*Bitacora Laboratorios Requisitos*/
create or replace TRIGGER HOSPITAL.TRG_BIR_LABO_REQU
BEFORE INSERT OR UPDATE OR DELETE ON HOSPITAL.LABORATORIOS_REQUISITO
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
INFO_EXCEPCION EXCEPTION;
BEGIN	
  /*CAMBIOS EN ID DE REQUISITOS DE LABORATORIO*/
  IF INSERTING  THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_REQUISITO', :NEW.IDLABOREQUI, 'DSLABOREQUI', :OLD.DSLABOREQUI, :NEW.DSLABOREQUI, 'INGRESA');
  ELSIF UPDATING AND :NEW.DSLABOREQUI != :OLD.DSLABOREQUI THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_REQUISITO', :NEW.IDLABOREQUI, 'DSLABOREQUI', :OLD.DSLABOREQUI, :NEW.DSLABOREQUI, 'MODIFICA');
  ELSIF DELETING THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_REQUISITO', :NEW.IDLABOREQUI, 'DSLABOREQUI', :OLD.DSLABOREQUI, :NEW.DSLABOREQUI, 'ELIMINA');
  END IF;
EXCEPTION
WHEN INFO_EXCEPCION THEN
       HOSPITAL.PRC_BITACORA('LABORATORIOS_REQUISITO',:NEW.IDLABOREQUI, 'ERROR INSERTANDO BITACORA', NULL, NULL,'ERROR');
       RAISE_APPLICATION_ERROR (-20001, 'Error '||SQLERRM);
END;

/*Bitacora Laboratorios Reesultados */
create or replace TRIGGER HOSPITAL.TRG_BIR_LABO_RESUL
BEFORE INSERT OR UPDATE OR DELETE ON HOSPITAL.LABORATORIOS_RESULTADO
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
INFO_EXCEPCION EXCEPTION;
BEGIN	
  /*CAMBIOS EN ID DE REQUISITOS DE LABORATORIO*/
  IF INSERTING  THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO', :NEW.IDLABORESUL, 'DSLABORESUL', :OLD.DSLABORESUL, :NEW.DSLABORESUL, 'INGRESA');
  ELSIF UPDATING AND :NEW.DSLABORESUL != :OLD.DSLABORESUL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO', :NEW.IDLABORESUL, 'DSLABORESUL', :OLD.DSLABORESUL, :NEW.DSLABORESUL, 'MODIFICA');
  ELSIF DELETING THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO', :NEW.IDLABORESUL, 'DSLABORESUL', :OLD.DSLABORESUL, :NEW.DSLABORESUL, 'ELIMINA');
  END IF;
EXCEPTION
WHEN INFO_EXCEPCION THEN
       HOSPITAL.PRC_BITACORA('LABORATORIOS_RESULTADO',:NEW.IDLABORESUL, 'ERROR INSERTANDO BITACORA', NULL, NULL,'ERROR');
       RAISE_APPLICATION_ERROR (-20001, 'Error '||SQLERRM);
END;

/*Bitacora Laboratorios Resultados Cabecera */
create or replace TRIGGER HOSPITAL.TRG_BIR_LABO_RESU_CABE
BEFORE INSERT OR UPDATE OR DELETE ON HOSPITAL.LABORATORIOS_RESULTADO_CABE
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
INFO_EXCEPCION EXCEPTION;
BEGIN	
  /*CAMBIOS EN ID ITEM DETALLE RESULTADOS LABORATORIOS*/
  IF INSERTING  AND :OLD.IDLABORESULDETA IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_CABE', :NEW.IDLABORESULCABE, 'IDLABORESULDETA', :OLD.IDLABORESULDETA, :NEW.IDLABORESULDETA, 'INGRESA');
  ELSIF UPDATING AND :NEW.IDLABORESULDETA != :OLD.IDLABORESULDETA THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_CABE', :NEW.IDLABORESULCABE, 'IDLABORESULDETA', :OLD.IDLABORESULDETA, :NEW.IDLABORESULDETA, 'MODIFICA');
  ELSIF DELETING AND :NEW.IDLABORESULDETA IS NULL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_CABE', :NEW.IDLABORESULCABE, 'IDLABORESULDETA', :OLD.IDLABORESULDETA, :NEW.IDLABORESULDETA, 'ELIMINA');
  END IF;
  /*CAMBIOS EN ID DE ORDEN RESULTADOS LABORATORIOS*/
  IF INSERTING  AND :OLD.IDLABOORDEN IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_CABE', :NEW.IDLABORESULCABE, 'IDLABOORDEN', :OLD.IDLABOORDEN, :NEW.IDLABOORDEN, 'INGRESA');
  ELSIF UPDATING AND :NEW.IDLABOORDEN != :OLD.IDLABOORDEN THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_CABE', :NEW.IDLABORESULCABE, 'IDLABOORDEN', :OLD.IDLABOORDEN, :NEW.IDLABOORDEN, 'MODIFICA');
  ELSIF DELETING AND :NEW.IDLABOORDEN IS NULL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_CABE', :NEW.IDLABORESULCABE, 'IDLABOORDEN', :OLD.IDLABOORDEN, :NEW.IDLABOORDEN, 'ELIMINA');
  END IF;  
EXCEPTION
WHEN INFO_EXCEPCION THEN
       HOSPITAL.PRC_BITACORA('LABORATORIOS_RESULTADO_CABE',:NEW.IDLABORESULCABE, 'ERROR INSERTANDO BITACORA', NULL, NULL,'ERROR');
       RAISE_APPLICATION_ERROR (-20001, 'Error '||SQLERRM);
END;

/*Bitacora Laboratorios Resultados Orden */
create or replace TRIGGER HOSPITAL.TRG_BIR_LABO_RESU_ORDE
BEFORE INSERT OR UPDATE OR DELETE ON HOSPITAL.LABORATORIOS_RESULTADO_ORDEN
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
INFO_EXCEPCION EXCEPTION;
BEGIN	
  /*CAMBIOS EN ID DE LABORATORIO CABECERA*/
  IF INSERTING  AND :OLD.IDLABORESULCABE IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_ORDEN', :NEW.IDLABORESULORDEN, 'IDLABORESULCABE', :OLD.IDLABORESULCABE, :NEW.IDLABORESULCABE, 'INGRESA');
  ELSIF UPDATING AND :NEW.IDLABORESULCABE != :OLD.IDLABORESULCABE THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_ORDEN', :NEW.IDLABORESULORDEN, 'IDLABORESULCABE', :OLD.IDLABORESULCABE, :NEW.IDLABORESULCABE, 'MODIFICA');
  ELSIF DELETING AND :NEW.IDLABORESULCABE IS NULL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_ORDEN', :NEW.IDLABORESULORDEN, 'IDLABORESULCABE', :OLD.IDLABORESULCABE, :NEW.IDLABORESULCABE, 'ELIMINA');
  END IF;
  /*CAMBIOS EN ID ITEM RESULTADOS LABORATORIOS*/
  IF INSERTING  AND :OLD.VALOR IS NULL THEN
     HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_ORDEN', :NEW.IDLABORESULORDEN, 'VALOR', :OLD.VALOR, :NEW.VALOR, 'INGRESA');
  ELSIF UPDATING AND :NEW.VALOR != :OLD.VALOR THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_ORDEN', :NEW.IDLABORESULORDEN, 'VALOR', :OLD.VALOR, :NEW.VALOR, 'MODIFICA');
  ELSIF DELETING AND :NEW.VALOR IS NULL THEN
      HOSPITAL.PRC_BITACORA( 'LABORATORIOS_RESULTADO_ORDEN', :NEW.IDLABORESULORDEN, 'VALOR', :OLD.VALOR, :NEW.VALOR, 'ELIMINA');
  END IF;  
EXCEPTION
WHEN INFO_EXCEPCION THEN
       HOSPITAL.PRC_BITACORA('LABORATORIOS_RESULTADO_ORDEN',:NEW.IDLABORESULORDEN, 'ERROR INSERTANDO BITACORA', NULL, NULL,'ERROR');
       RAISE_APPLICATION_ERROR (-20001, 'Error '||SQLERRM);
END;