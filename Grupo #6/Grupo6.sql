/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     9/04/2016 12:57:54 a. m.                     */
/*==============================================================*/

/*==============================================================*/
/* TABLE: LABORATORIOS_TIPO                                     */
/*==============================================================*/

CREATE TABLE HOSPITAL.LABORATORIOS_TIPO 
(
   IDLABOTIPO INT PRIMARY KEY,
   DSLABOTIPO VARCHAR2(100) NOT NULL   
);
/*Valor Unico en descripcion*/
ALTER TABLE HOSPITAL.LABORATORIOS_TIPO 
ADD CONSTRAINT UQ_LAB_TIP_DSLABOTIPO
UNIQUE (DSLABOTIPO);

/*==============================================================*/
/* SECUENCIA: LABORATORIOS_TIPO                                 */
/*==============================================================*/
CREATE SEQUENCE HOSPITAL.LABOTIPO
START WITH 1 
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_RESULTADO                                */
/*==============================================================*/

CREATE TABLE HOSPITAL.LABORATORIOS_RESULTADO
(
  IDLABORESUL INT PRIMARY KEY,
  DSLABORESUL VARCHAR2(100) NOT NULL
);
/*Valor Unico en descripcion*/
ALTER TABLE HOSPITAL.LABORATORIOS_RESULTADO 
ADD CONSTRAINT UQ_LAB_RES_DSLABORESUL
UNIQUE (DSLABORESUL);
/*==============================================================*/
/* SECUENCIA: LABORATORIOS_RESULTADO                            */
/*==============================================================*/

CREATE SEQUENCE HOSPITAL.LABORESUL
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_REQUISITO                                */
/*==============================================================*/

CREATE TABLE HOSPITAL.LABORATORIOS_REQUISITO
(
   IDLABOREQUI INT PRIMARY KEY,
   DSLABOREQUI VARCHAR2(100) NOT NULL
);
/*Valor Unico en descripcion*/
ALTER TABLE HOSPITAL.LABORATORIOS_REQUISITO 
ADD CONSTRAINT UQ_LAB_REQ_DSLABOREQUI
UNIQUE (DSLABOREQUI);
/*==============================================================*/
/* SECUENCIA: LABORATORIOS_REQUISITOS                           */
/*==============================================================*/
--DROP SEQUENCE HOSPITAL.LABOREQUISITO;
CREATE SEQUENCE HOSPITAL.LABOREQUISITO
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_CABE                                     */
/*==============================================================*/
CREATE TABLE HOSPITAL.LABORATORIOS_CABE
(
   IDLABOCABE INT PRIMARY KEY,
   IDLABOTIPO INT NOT NULL,
   DSLABOCABE VARCHAR2(40) NOT NULL,
   FECHALABOCABE DATE NOT NULL,
   ACTIVO NUMBER (1) NOT NULL,
   CHECK(ACTIVO BETWEEN 0 AND 1),
   CONSTRAINT FK_LABORATO_REF_LAB_C_LABORATO FOREIGN KEY (IDLABOTIPO)
   REFERENCES HOSPITAL.LABORATORIOS_TIPO (IDLABOTIPO)
);
/*Valor Unico en descripcion*/
ALTER TABLE HOSPITAL.LABORATORIOS_CABE 
ADD CONSTRAINT UQ_LAB_REQ_DSLABOCABE
UNIQUE (DSLABOCABE);
/*==============================================================*/
/* SECUENCIA: LABORATORIOS_CABE                                 */
/*==============================================================*/
CREATE SEQUENCE HOSPITAL.LABOCABE
START WITH 1
INCREMENT BY 1 ; 

/*==============================================================*/
/* TABLE: LABORATORIOS_PRECIO                                   */
/*==============================================================*/
--DROP TABLE HOSPITAL.LABORATORIOS_PRECIO;
CREATE TABLE HOSPITAL.LABORATORIOS_PRECIO 
(
   IDLABOPRECIO INT PRIMARY KEY,
   IDLABOCABE INT NOT NULL,
   FECHAPRECIOLABO DATE NOT NULL,
   VALOR FLOAT(10) NOT NULL,
   ACTIVO NUMBER(1) NOT NULL,
   CHECK (ACTIVO BETWEEN 0 AND 1),
   CONSTRAINT FK_LABORATO_REF_CABE_LABORATO FOREIGN KEY(IDLABOCABE)
   REFERENCES HOSPITAL.LABORATORIOS_CABE(IDLABOCABE)
);

/*==============================================================*/
/* SECUENCIA: LABORATORIOS_PRECIO                               */
/*==============================================================*/
--DROP SEQUENCE HOSPITAL.PRECIOLABO;
CREATE SEQUENCE HOSPITAL.PRECIOLABO
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_DETA                                     */
/*==============================================================*/
CREATE TABLE HOSPITAL.LABORATORIOS_DETA
(
   IDLABODETA INT PRIMARY KEY,
   IDLABOCABE INT NOT NULL,
   IDLABOREQUI INT NOT NULL,
  CONSTRAINT FK_LABORATO_REF_LAB_D_LABORATO FOREIGN KEY(IDLABOCABE)
  REFERENCES HOSPITAL.LABORATORIOS_CABE(IDLABOCABE),
  CONSTRAINT FK_LABORATO_REF_LABDE_LABORATO FOREIGN KEY(IDLABOREQUI)
  REFERENCES HOSPITAL.LABORATORIOS_REQUISITO(IDLABOREQUI)
);
/*Valor Unico en descripcion*/
ALTER TABLE HOSPITAL.LABORATORIOS_DETA 
ADD CONSTRAINT UQ_LAB_REQ_IDLABO_CAB_REQ
UNIQUE (IDLABOCABE,IDLABOREQUI);
/*==============================================================*/
/* SECUENCIA: LABORATORIOS_DETA                                 */
/*==============================================================*/
CREATE SEQUENCE HOSPITAL.LABODETA
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_ORDEN                                     */
/*==============================================================*/
CREATE TABLE HOSPITAL.LABORATORIOS_ORDEN
(
  IDLABOORDEN INT PRIMARY KEY,  
  IDPACIENTE INT NOT NULL,
  FECHAORDEN DATE NOT NULL,
  ESTADO NUMBER(1) NOT NULL,
  CHECK (ESTADO BETWEEN 0 AND 1),
  CONSTRAINT FK_LAB_ORD_REF_LAB_ORD_PAC FOREIGN KEY(IDPACIENTE)
  REFERENCES HOSPITAL.HPTL_PACIENTES(ID),
  CONSTRAINT UQ_LAB_ORD_ID_ORD_PAC UNIQUE (IDLABOORDEN,IDPACIENTE)
);

/*==============================================================*/
/* SECUENCIA: LABORATORIOS_ORDEN                                */
/*==============================================================*/
CREATE SEQUENCE HOSPITAL.ORDENLABO
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_RESUL_DETA                               */
/*==============================================================*/
CREATE TABLE HOSPITAL.LABORATORIOS_RESULTADO_DETA
(
  IDLABORESULDETA INT PRIMARY KEY,
  IDLABOCABE INT NOT NULL,
  IDLABORESUL INT NOT NULL,
  CONSTRAINT FK_LABORATO_REF_LABRE_LABORATO FOREIGN KEY(IDLABOCABE) 
  REFERENCES HOSPITAL.LABORATORIOS_CABE(IDLABOCABE),
  CONSTRAINT FK_LABORATO_REF_LAB2_LABORATO FOREIGN KEY(IDLABORESUL)
  REFERENCES HOSPITAL.LABORATORIOS_RESULTADO(IDLABORESUL)
);
/*Valor Unico en descripcion*/
ALTER TABLE HOSPITAL.LABORATORIOS_RESULTADO_DETA 
ADD CONSTRAINT UQ_LAB_REQ_IDLABO_CAB_RES
UNIQUE (IDLABOCABE,IDLABORESUL);
/*==============================================================*/
/* SECUENCIA: LABORATORIOS_RESUL_DETA                           */
/*==============================================================*/
CREATE SEQUENCE HOSPITAL.LABORESULDETA
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIO_RESULTADO_CABE                            */
/*==============================================================*/
CREATE TABLE HOSPITAL.LABORATORIOS_RESULTADO_CABE 
(
   IDLABORESULCABE INT PRIMARY KEY,
   IDLABORESULDETA INT NOT NULL,
   IDLABOORDEN INT NOT NULL,
   FECHALABORESULCABE DATE NOT NULL,
   CONSTRAINT FK_LABORATO_REF_LAB_R_LABORATO FOREIGN KEY(IDLABORESULDETA)
   REFERENCES HOSPITAL.LABORATORIOS_RESULTADO_DETA(IDLABORESULDETA),
  CONSTRAINT FK_LABORATO_REF_LAB_R_ORDEN_LA FOREIGN KEY(IDLABOORDEN)
  REFERENCES HOSPITAL.LABORATORIOS_ORDEN(IDLABOORDEN)
);

/*==============================================================*/
/* SECUENCIA: LABORATORIOS_RESULTADO_CABE                       */
/*==============================================================*/

CREATE SEQUENCE HOSPITAL.LABORESULTADOCABE
START WITH 1
INCREMENT BY 1;

/*==============================================================*/
/* TABLE: LABORATORIOS_RESULTADO_ORDEN                          */
/*==============================================================*/
--DROP TABLE HOSPITAL.LABORATORIOS_RESULTADO_ORDEN ;
CREATE TABLE HOSPITAL.LABORATORIOS_RESULTADO_ORDEN 
(
   IDLABORESULORDEN INT PRIMARY KEY,
   IDLABORESULCABE INT NOT NULL,
   VALOR VARCHAR2(100) NOT NULL,
   CONSTRAINT FK_LABORATO_REF_LAB1_LABORATO FOREIGN KEY(IDLABORESULCABE)
   REFERENCES HOSPITAL.LABORATORIOS_RESULTADO_CABE(IDLABORESULCABE)
);
 
/*==============================================================*/
/* SECUENCIA: LABORATORIOS_RESULTADO_ORDEN                      */
/*==============================================================*/
--DROP SEQUENCE  HOSPITAL.LABORESULORDEN;
CREATE SEQUENCE HOSPITAL.LABORESULORDEN
START WITH 1
INCREMENT BY 1;


/*==============================================================*/
/* TABLE: LABORATORIOS_ORDEN_DETALLE                                     */
/*==============================================================*/
CREATE TABLE HOSPITAL.LABORATORIOS_ORDEN_DETA
(
  IDLABOORDENDETA INT PRIMARY KEY,  
  IDLABOORDEN INT NOT NULL,  
  IDLABOCABE INT NOT NULL,
  CONSTRAINT FK_LAB_ORD_DET_REF_LAB_ORD FOREIGN KEY(IDLABOORDEN)
  REFERENCES HOSPITAL.LABORATORIOS_ORDEN (IDLABOORDEN),
  CONSTRAINT FK_LAB_ORD_DET_REF_LAB_CAB FOREIGN KEY(IDLABOCABE)
  REFERENCES HOSPITAL.LABORATORIOS_CABE (IDLABOCABE),
  CONSTRAINT UQ_LAB_ORD_DETA_IDLAB_ORD_CAB UNIQUE (IDLABOORDEN,IDLABOCABE)
);

/*==============================================================*/
/* SECUENCIA: LABORATORIOS_ORDEN_DETA                           */
/*==============================================================*/
CREATE SEQUENCE HOSPITAL.ORDENLABODETA
START WITH 1
INCREMENT BY 1;