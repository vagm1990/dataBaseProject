/* CADA GRUPO DEBE DE SUBIR EL DIAGRAMA DE LA BASE DE DATOS CON SU SCRIPT */

CREATE USER HOSPITAL IDENTIFIED BY HOSPITAL;
GRANT CREATE SESSION TO HOSPITAL;
GRANT CREATE TABLE TO HOSPITAL;
GRANT CREATE VIEW TO HOSPITAL;
GRANT CREATE PROCEDURE TO HOSPITAL;

ALTER USER HOSPITAL quota unlimited on SYSTEM;

/* -------------------------------------
   TABLAS GENERALES
----------------------------------------*/

CREATE TABLE HOSPITAL.HPTL_PERSONAS(
        ID INTEGER NOT NULL,
        PRIMER_NOMBRE VARCHAR2(60) NOT NULL,
        SEGUNDO_NOMBRE VARCHAR2(60),
        TERCER_NOMBRE VARCHAR2(60),
        PRIMER_APELLIDO VARCHAR2(60) NOT NULL,
        SEGUNDO_APELLIDO VARCHAR2(60),
        APELLIDO_CASADA VARCHAR2(60),
        FECHA_NACIMIENTO DATE,
        SEXO CHAR(1),
		VERSION NUMERIC(5,0) NOT NULL,
        CONSTRAINT HPTL_PERSONAS_PK PRIMARY KEY (ID)
);


CREATE TABLE HOSPITAL.HPTL_TELEFONOS(
        ID INTEGER NOT NULL,
        DESCRIPCION VARCHAR2(60),
        TELEFONO VARCHAR(30),
		VERSION NUMERIC(5,0) NOT NULL,
        CONSTRAINT HPTL_TELEFONOS_PK PRIMARY KEY(ID)
);


CREATE TABLE HOSPITAL.HPTL_PERSONAS_TELEFONOS(
        ID INTEGER NOT NULL,
        PERSONAS_ID INTEGER NOT NULL,
        TELEFONOS_ID INTEGER NOT NULL,
        CONSTRAINT HPTL_PERSONAS_TELEFONOS_PK PRIMARY KEY (ID),
        CONSTRAINT HPTL_PER_PK_HPTL_PER_TEL_FK FOREIGN KEY(PERSONAS_ID) REFERENCES HOSPITAL.HPTL_PERSONAS(ID),
        CONSTRAINT HPTL_TEL_PK_HPTL_PER_TEL_FK FOREIGN KEY(TELEFONOS_ID) REFERENCES HOSPITAL.HPTL_TELEFONOS(ID)
);

CREATE TABLE HOSPITAL.HPTL_TIPO_SANGRE (
		ID INTEGER NOT NULL,
		TIPOSANGRE VARCHAR(20),
		VERSION NUMERIC(5,0) NOT NULL,
		CONSTRAINT HPTL_TIPO_SANGRE_PK PRIMARY KEY (ID)
)

CREATE TABLE HOSPITAL.HPTL_PACIENTES(
        ID INTEGER NOT NULL,
        CODIGO_PACIENTE INTEGER NOT NULL,
        FECHA_REGISTO_PACIENTE DATE,
        PERSONAS_ID INTEGER NOT NULL,
		TIPOSANGRE_ID INTEGER,
		VERSION NUMERIC(5,0) NOT NULL,
        CONSTRAINT HPTL_PACIENTES_PK PRIMARY KEY(ID),
        CONSTRAINT HPTL_PERSONA_PK_HPTL_PAC_FK FOREIGN KEY(PERSONAS_ID) REFERENCES HOSPITAL.HPTL_PERSONAS(ID),
		CONSTRAINT HPTL_TIPO_SAN_PK_HPTL_PAC_FK FOREIGN KEY (TIPOSANGRE_ID) REFERENCES HOSPITAL.HPTL_TIPO_SANGRE(ID)
);


CREATE TABLE HOSPITAL.HPTL_EMPLEADOS(
        ID INTEGER NOT NULL,
        CODIGO_EMPLEADO VARCHAR2(20),
        FECHA_INICIO_LABORES DATE,
        PERSONAS_ID INTEGER NOT NULL,
		VERSION NUMERIC(5,0) NOT NULL,
        CONSTRAINT HPTL_EMPLEADOS_PK PRIMARY KEY (ID),
        CONSTRAINT HPTL_PERSONAS_PK_HPTL_EMP_PK FOREIGN KEY(PERSONAS_ID) REFERENCES HOSPITAL.HPTL_PERSONAS(ID)
);



CREATE TABLE HOSPITAL.HPTL_DOCTORES(
        ID INTEGER NOT NULL,
        COLEGIADO VARCHAR2(20) NOT NULL,
        EMPLEADOS_ID INTEGER NOT NULL,
		VERSION NUMERIC(5,0) NOT NULL,
        CONSTRAINT HPTL_DOCTORES_PK PRIMARY KEY (ID),
        CONSTRAINT HPTL_EMPLEADOS_PK_HPTL_DOC_FK FOREIGN KEY(EMPLEADOS_ID) REFERENCES HOSPITAL.HPTL_PERSONAS(ID)
);


CREATE TABLE HOSPITAL.HPTL_ESPECIALIDADES_DOC(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(10),
	DESCRIPCION VARCHAR2(256),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_ESPECIALIDADES_DOC_PK PRIMARY KEY (ID)
);


CREATE TABLE HOSPITAL.HPTL_DOC_ESPECIALIDAD_DOC(
	ID INTEGER NOT NULL,
	DOCTORES_ID INTEGER NOT NULL,
	ESPECIALIDADES_DOCTORES INTEGER NOT NULL,
	CONSTRAINT HPTL_DOCTORES_ESP_DOC_PK PRIMARY KEY(ID),
	CONSTRAINT HPTL_DOC_PK_DOC_ESP_DOC_FK FOREIGN KEY(DOCTORES_ID) REFERENCES HOSPITAL.HPTL_DOCTORES(ID),
	CONSTRAINT HPTL_ESP_DOC_PK_HTPL_DOC_FK FOREIGN KEY(ESPECIALIDADES_DOCTORES) REFERENCES HOSPITAL.HPTL_ESPECIALIDADES_DOC(ID)
);


CREATE TABLE HOSPITAL.HPTL_PUESTOS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(10) NOT NULL,
	DESCRIPCION VARCHAR2(256),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_PUESTOS_PK PRIMARY KEY (ID)
);


CREATE TABLE HOSPITAL.HPTL_EMPLEADOS_PUESTOS(
	ID INTEGER NOT NULL,
	EMPLEADOS_ID INTEGER NOT NULL,
	PUESTOS_ID INTEGER NOT NULL,
	CONSTRAINT HPTL_EMPLEADOS_PUESTOS_PK PRIMARY KEY (ID),
	CONSTRAINT HPTL_PUE_PK_HPTL_EMP_PUE_FK FOREIGN KEY(PUESTOS_ID) REFERENCES HOSPITAL.HPTL_PUESTOS(ID)
);


CREATE TABLE HOSPITAL.HPTL_AREAS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(10),
	DESCRIPCION VARCHAR2(256),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_AREAS_PK PRIMARY KEY(ID)
);

CREATE TABLE HOSPITAL.HPTL_PUESTOS_AREAS(
	ID INTEGER NOT NULL,
	PUESTOS_ID INTEGER NOT NULL,
	AREAS_ID INTEGER NOT NULL,
	CONSTRAINT HPTL_PUESTOS_AREAS_PK PRIMARY KEY (ID),
	CONSTRAINT HPTL_AREAS_PK_HPTL_PUE_ARE_FK FOREIGN KEY(AREAS_ID) REFERENCES HOSPITAL.HPTL_AREAS(ID),
	CONSTRAINT HPTL_PUE_PK_HPTL_PUE_ARE_FK FOREIGN KEY(PUESTOS_ID) REFERENCES HOSPITAL.HPTL_PUESTOS(ID)
);


CREATE TABLE HOSPITAL.HPTL_HORARIOS(
	ID INTEGER NOT NULL,
	HORA_INICIO DATE NOT NULL,
	HORA_FIN DATE NOT NULL,
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_HORARIOS_PK PRIMARY KEY (ID)
);
---MORE

CREATE TABLE HOSPITAL.HPTL_TIPO_ENFERMEDADES(
	ID INTEGER NOT NULL,
	CODIGO INTEGER NOT NULL,
	DESCRIPCION VARCHAR2(50),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HTPTL_TIPO_ENFERMEDADES_PK PRIMARY KEY(ID)

);

CREATE TABLE HOSPITAL.HPTL_ENFERMEDADES(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(20) NOT NULL,
	TIPOS_ENFERMEDADES_ID INTEGER NOT NULL,	
	DESCRIPCION VARCHAR2(50),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_ENFERMEDADES_PK PRIMARY KEY(ID),
	CONSTRAINT HPTL_ENF_PK_HPTL_TIP_ENF_FK FOREIGN KEY(TIPOS_ENFERMEDADES_ID) REFERENCES HOSPITAL.HPTL_TIPO_ENFERMEDADES(ID)	
);


CREATE TABLE HOSPITAL.HPTL_PAISES(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(15) NOT NULL,
	DESCRIPCION VARCHAR2(30),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_PAISES_PK PRIMARY KEY(ID)
);

CREATE TABLE HOSPITAL.HPTL_DEPARTAMENTOS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(15) NOT NULL,
	DESCRIPCION VARCHAR2(50),
	PAIS_ID INTEGER NOT NULL,
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_DEPARTAMENTOS_PK PRIMARY KEY(ID),
	CONSTRAINT HTPTL_PAISES_FK_DEP FOREIGN KEY(PAIS_ID) REFERENCES HOSPITAL.HPTL_PAISES(ID)
);

CREATE TABLE HOSPITAL.HPTL_MUNICIPIOS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(15) NOT NULL,
	DESCRIPCION VARCHAR2(50),
	DEPARTAMENTO_ID INTEGER NOT NULL,
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_MUNICIPIOS_PK PRIMARY KEY(ID),
	CONSTRAINT HPTL_DEPARTAMENTOS_FK_MUN FOREIGN KEY(DEPARTAMENTO_ID) REFERENCES HOSPITAL.HPTL_DEPARTAMENTOS(ID)
);

CREATE TABLE HOSPITAL.HPTL_DIRECCIONES(
	ID INTEGER NOT NULL,
	NUMERO_CASA VARCHAR2(10),
	COLONIA VARCHAR2(50),
	CALLE_AVENIDA VARCHAR2(50),
	MUNICIPIO_ID INTEGER NOT NULL,
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_DIRECCIONES_PK PRIMARY KEY(ID),
	CONSTRAINT HTPL_MUN_FK_DIRECCIONES FOREIGN KEY(MUNICIPIO_ID) REFERENCES HOSPITAL.HPTL_MUNICIPIOS(ID)
); 

CREATE TABLE HOSPITAL.HPTL_CLINICAS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(30) NOT NULL,
	DESCRIPCION VARCHAR2(50),
	DIRECCIONES_ID INTEGER NOT NULL,
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_CLINICAS_PK PRIMARY KEY(ID),
	CONSTRAINT HPTL_DIR_PK_HPTL_CLI_FK FOREIGN KEY(DIRECCIONES_ID) REFERENCES HOSPITAL.HPTL_DIRECCIONES(ID)
);


CREATE TABLE HOSPITAL.HPTL_MEDICAMENTOS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(30) NOT NULL,
	DESCRIPCION VARCHAR2(30),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_MEDICAMENTOS_PK PRIMARY KEY(ID)
);

CREATE TABLE HOSPITAL.HPTL_TIPOS_EXAMENES(
	ID INTEGER NOT NULL,
	DESCRIPCION VARCHAR2(50),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_TIPOS_ENFERMEDADES_PK PRIMARY KEY(ID)
);


CREATE TABLE HOSPITAL.HPTL_EXAMENES(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(30) NOT NULL,
	TIPOS_EXAMENES_ID INTEGER NOT NULL,
	DESCRIPCION VARCHAR2(30),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_EXAMENES_PK PRIMARY KEY(ID),
	CONSTRAINT HPTL_EX_HPTL_TIPOS_ENF_FK FOREIGN KEY(TIPOS_EXAMENES_ID) REFERENCES HOSPITAL.HPTL_TIPOS_EXAMENES(ID)	
);


CREATE TABLE HOSPITAL.HPTL_TIPOS_EQUIPOS(
	ID INTEGER NOT NULL,
	EQUIPOS_ID INTEGER NOT NULL,
	DESCRIPCION VARCHAR2(50),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_TIPOS_EQUIPOS_PK PRIMARY KEY(ID)
);


CREATE TABLE HOSPITAL.HPTL_EQUIPOS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(30) NOT NULL,
	TIPO_EQUIPOS_ID INTEGER NOT NULL,
	DESCRIPCION VARCHAR2(30),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_EQUIPOS_PK PRIMARY KEY(ID),
	CONSTRAINT HPTL_EQ_PK_HPTL_TIP_ENF_FK FOREIGN KEY(TIPO_EQUIPOS_ID) REFERENCES HOSPITAL.HPTL_TIPOS_EQUIPOS(ID)	
);


CREATE TABLE HOSPITAL.HPTL_TIPO_DOCUMENTOS(
	ID INTEGER NOT NULL,
	CODIGO VARCHAR2(15) NOT NULL,
	DESCRIPCION VARCHAR2(30),
	VERSION NUMERIC(5,0) NOT NULL,
	CONSTRAINT HPTL_DOCUMENTO_PK PRIMARY KEY(ID)
);


CREATE TABLE HOSPITAL.HPTL_PERSONA_DOCTO(
        ID INTEGER NOT NULL,
        PERSONAS_ID INTEGER NOT NULL,
        TIPO_DOC_ID INTEGER NOT NULL,
        CONSTRAINT HPTL_PERSONAS_DOCTO_PK PRIMARY KEY (ID),
        CONSTRAINT HPTL_PER_PK_HPTL_PER_DOC_FK FOREIGN KEY(PERSONAS_ID) REFERENCES HOSPITAL.HPTL_PERSONAS(ID),
        CONSTRAINT HPTL_TIP_PK_HPTL_PER_DOC_FK FOREIGN KEY(TIPO_DOC_ID) REFERENCES HOSPITAL.HPTL_TIPO_DOCUMENTOS(ID)
);

-- CONSULTA EXTERNA GRUPO #2

CREATE TABLE HOSPITAL.HPTL_CITAS (
		ID INTEGER NOT NULL,
		PACIENTES_ID INTEGER NOT NULL,
		CLINICAS_ID INTEGER NOT NULL,
		DOCTORES_ID INTEGER NOT NULL,
		ESPECIALIDAD_DOC_ID INTEGER,
		ESTATUS CHAR,
		OBSERVACIONES VARCHAR(60),
		FECHA_CITA DATE,
		HORA_CITA DATE,
		VERSION NUMERIC(5,0) NOT NULL,
		CONSTRAINT HPTL_CITAS_PK PRIMARY KEY (ID),
		CONSTRAINT HPTL_PAC_PK_HPTL_CIT_FK FOREIGN KEY (PACIENTES_ID) REFERENCES HOSPITAL.HPTL_PACIENTES(ID),
		CONSTRAINT HPTL_DOC_PK_HPTL_CIT_FK FOREIGN KEY (DOCTORES_ID) REFERENCES HOSPITAL.HPTL_DOCTORES(ID),
		CONSTRAINT HPTL_CLI_PK_HPTL_CIT_FK FOREIGN KEY (CLINICAS_ID) REFERENCES HOSPITAL.HPTL_CLINICAS(ID),
		CONSTRAINT HPTL_ESP_PK_HPTL_CIT_FK FOREIGN KEY (ESPECIALIDAD_DOC_ID) REFERENCES HOSPITAL.HPTL_DOC_ESPECIALIDAD_DOC(ID)
);


CREATE TABLE HOSPITAL.HPTL_HIS_MEDICA_DETA (
		ID INTEGER NOT NULL,
		OBSERVACIONES VARCHAR(50),
		CITAS_ID INTEGER,
		VERSION NUMERIC(5,0) NOT NULL,
		CONSTRAINT HPTL_HIS_MEDICA_DETA_PK PRIMARY KEY (ID),
		CONSTRAINT HPTL_CIT_PK_HPTL_HIS_FK FOREIGN KEY (CITAS_ID) REFERENCES HOSPITAL.HPTL_CITAS(ID)
);

CREATE TABLE HOSPITAL.HPTL_RECETAS (
		ID INTEGER NOT NULL,
		HIS_DET_ID INTEGER,
		OBSERVACIONES VARCHAR(250),
		VERSION NUMERIC(5,0) NOT NULL,
		CONSTRAINT HPTL_RECETAS_PK PRIMARY KEY (ID),
		CONSTRAINT HPTL_HIS_PK_HPTL_REC_FK FOREIGN KEY (HIS_DET_ID) REFERENCES HOSPITAL.HPTL_HIS_MEDICA_DETA(ID)
);

CREATE TABLE HOSPITAL.HPTL_HIS_EXAMENES (
		EXAMENES_ID INTEGER NOT NULL,
		HIS_DET_ID INTEGER NOT NULL,
		CONSTRAINT HPTL_HIS_EXAMENES_PK PRIMARY KEY (EXAMENES_ID,HIS_DET_ID),
		CONSTRAINT HPTL_EXA_PK_HPTL_HIS_EXA_FK FOREIGN KEY (EXAMENES_ID) REFERENCES HOSPITAL.HPTL_EXAMENES,
		CONSTRAINT HPTL_HIS_PK_HPTL_HIS_EXA_FK FOREIGN KEY (HIS_DET_ID) REFERENCES HOSPITAL.HPTL_HIS_MEDICA_DETA
);

CREATE TABLE HOSPITAL.HPTL_RECETA_MEDICAMENTO (
		ID INTEGER NOT NULL,
		RECETA_ID INTEGER NOT NULL,
		MEDICAMENTO_ID INTEGER NOT NULL,
		CANTIDAD INTEGER,
		CONSTRAINT HPTL_RECMED_PK PRIMARY KEY (ID),
		CONSTRAINT HPTL_REC_PK_HPTL_REC_FK FOREIGN KEY (RECETA_ID) REFERENCES HOSPITAL.HPTL_RECETAS,
		CONSTRAINT HPTL_MED_PK_HPTL_MED_FK FOREIGN KEY (MEDICAMENTO_ID) REFERENCES HOSPITAL.HPTL_MEDICAMENTOS
);

-- SCRIPT GRUPO #9

CREATE TABLE HOSPITAL.HPTL_ALMACENAMIENTO (
		IDALMACENAMIENTO INT NOT NULL,
		IDTIPOALMACENAMIENTO INT NULL,
		CONSTRAINT PK_HPTL_ALMACENAMIENTO PRIMARY KEY (IDALMACENAMIENTO)
);

CREATE TABLE HOSPITAL.HPTL_CONTROLES (
		IDCONTROL INT NOT NULL,
		TIPOCONTROL VARCHAR2(50) NULL,
		CONSTRAINT PK_HPTL_CONTROLES PRIMARY KEY (IDCONTROL)
);

CREATE TABLE HOSPITAL.HPTL_CONTROLESPORRECURSOS (
		IDCONTROLXRECURSO INT NOT NULL,
		IDCONTROL INT NULL,
		IDRECURSO INT NULL,
		IDENTREGA INT NULL,
		CONSTRAINT PK_HPTL_CONTROLESPORRECURSOS PRIMARY KEY (IDCONTROLXRECURSO)
);


CREATE TABLE HOSPITAL.HPTL_ENTREGA (
		IDENTREGA INT NOT NULL,
		IDPAQUETE INT NULL,
		FECHADEESTERILAZION DATE NULL,
		FECHADECADUCIDAD DATE NULL,
		HORADENTREGA DATE NULL,
		CONSTRAINT PK_HPTL_ENTREGA PRIMARY KEY (IDENTREGA)
);

CREATE TABLE HOSPITAL.HPTL_ENVASES (
		IDENVASE INT NOT NULL,
		TIPOEVASE VARCHAR2(50) NULL,
		CONSTRAINT PK_HPTL_ENVASES PRIMARY KEY (IDENVASE)
);

CREATE TABLE HOSPITAL.HPTL_ENVASEXPAQUETE (
		ENVASEXPAQUETE INT NOT NULL,
		IDPAQUETE INT NULL,
		IDENVASE INT NULL,
		CONSTRAINT PK_HPTL_ENVASEXPAQUETE PRIMARY KEY (ENVASEXPAQUETE)
);


CREATE TABLE HOSPITAL.HPTL_LIMPIEZA (
		IDLIMPIEZA INT NOT NULL,
		IDAREA INT NULL,
		IDTIPOLIMPIEZA INT NULL,
		ID INTEGER NULL,
		HPT_ID INTEGER NULL,
		IDEMPLEADO INT NULL,
		CONSTRAINT PK_HPTL_LIMPIEZA PRIMARY KEY (IDLIMPIEZA)
);

CREATE TABLE HOSPITAL.HPTL_MATENIMIENTO (
		IDMANTENIMIENTO INT NOT NULL,
		ID INTEGER NULL,
		IDRECURSO INT NULL,
		IDEMPLEADO INT NULL,
		COMTROLBIOLOGICO VARCHAR2(50) NULL,
		CONTROLQUIMICO VARCHAR2(50) NULL,
		CONSTRAINT PK_HPTL_MATENIMIENTO PRIMARY KEY (IDMANTENIMIENTO)
);

CREATE TABLE HOSPITAL.HPTL_PAQUETES 
(
   IDPAQUETE            INT                            not null,
   IDCONSERVACION       INT                            null,
   IDALMACENAMIENTO     INT                            null,
   IDTRANSPORTE         INT                            null,
   CONSTRAINT PK_HPTL_PAQUETES primary key (IDPAQUETE)
);

CREATE TABLE HPTL_RECURSOXAREA 
(
   IDRECURSO            INT                            null,
   ID                   INTEGER                        null,
   IDAREA               INT                            null
);

CREATE TABLE HPTL_RIESGOS 
(
   IDRIESGOS            INT                            not null,
   IDTIPORIESGOS        INT                            null,
   CONSTRAINT PK_HPTL_RIESGOS PRIMARY KEY (IDRIESGOS)
);

CREATE TABLE HPTL_TIPOALMACENAMIENTO 
(
   IDTIPOALMACENAMIENTO INT                            not null,
   DESCRIPCION          VARCHAR2(50)                   null,
   CONSTRAINT PK_HPTL_TIPOALMACENAMIENTO PRIMARY KEY (IDTIPOALMACENAMIENTO)
);

CREATE TABLE HPTL_TIPOLIMPIEZA 
(
   IDTIPOLIMPIEZA       INT                            not null,
   DESCRIPCION          VARCHAR2(50)                   null,
   CONSTRAINT PK_HPTL_TIPOLIMPIEZA PRIMARY KEY (IDTIPOLIMPIEZA)
);

CREATE TABLE HPTL_TIPORIESGOS 
(
   IDTIPORIESGOS        INT                            not null,
   DESCRIPCION          VARCHAR2(50)                   null,
   CONSTRAINT PK_HPTL_TIPORIESGOS PRIMARY KEY (IDTIPORIESGOS)
);

create table HPTL_TIPOTRANSPORTE 
(
   IDTIPOTRANSPORTE     INT                            not null,
   DESCRIPCION          VARCHAR2(50)                   null,
   constraint PK_HPTL_TIPOTRANSPORTE primary key (IDTIPOTRANSPORTE)
);

create table HPTL_TRANSPORTE 
(
   IDTRANSPORTE         INT                            not null,
   IDTIPOTRANSPORTE     INT                            null,
   constraint PK_HPTL_TRANSPORTE primary key (IDTRANSPORTE)
);

create table HPTL_UTENCILIOS 
(
   IDRECURSO            INT                            not null,
   TIPOMATERIAL         VARCHAR2(50)                   null,
   constraint PK_HPTL_UTENCILIOS primary key (IDRECURSO)
);

create table HPTL_UTENCILIOSXPAQUETE 
(
   IDUTENCILIOSXPAQUETE INT                            not null,
   IDPAQUETE            INT                            null,
   IDRECURSO            INT                            null,
   constraint PK_HPTL_UTENCILIOSXPAQUETE primary key (IDUTENCILIOSXPAQUETE)
);


alter table HPTL_ALMACENAMIENTO
   add constraint FK_HPTL_ALM_REFERENCE_HPTL_TIP foreign key (IDTIPOALMACENAMIENTO)
      references HPTL_TIPOALMACENAMIENTO (IDTIPOALMACENAMIENTO)
      on update restrict
      on delete restrict;

alter table HPTL_CONTROLESPORRECURSOS
   add constraint FK_HPTL_CON_REFERENCE_HPTL_CON foreign key (IDCONTROL)
      references HPTL_CONTROLES (IDCONTROL)
      on update restrict
      on delete restrict;

alter table HPTL_CONTROLESPORRECURSOS
   add constraint FK_HPTL_CON_REFERENCE_HPTL_UTE foreign key (IDRECURSO)
      references HPTL_UTENCILIOS (IDRECURSO)
      on update restrict
      on delete restrict;

alter table HPTL_CONTROLESPORRECURSOS
   add constraint FK_HPTL_CON_REFERENCE_HPTL_ENT foreign key (IDENTREGA)
      references HPTL_ENTREGA (IDENTREGA)
      on update restrict
      on delete restrict;	  
	  
alter table HPTL_ENTREGA
   add constraint FK_HPTL_ENT_REFERENCE_HPTL_PAQ foreign key (IDPAQUETE)
      references HPTL_PAQUETES (IDPAQUETE)
      on update restrict
      on delete restrict;

alter table HPTL_ENVASEXPAQUETE
   add constraint FK_HPTL_ENV_REFERENCE_HPTL_ENV foreign key (IDENVASE)
      references HPTL_ENVASES (IDENVASE)
      on update restrict
      on delete restrict;

alter table HPTL_ENVASEXPAQUETE
   add constraint FK_HPTL_ENV_REFERENCE_HPTL_PAQ foreign key (IDPAQUETE)
      references HPTL_PAQUETES (IDPAQUETE)
      on update restrict
      on delete restrict;
	  
alter table HPTL_LIMPIEZA
   add constraint FK_HPTL_LIM_REFERENCE_HPTL_ARE foreign key (ID)
      references HPTL.HPTL_AREAS (ID)
      on update restrict
      on delete restrict;

alter table HPTL_LIMPIEZA
   add constraint FK_HPTL_LIM_REFERENCE_HPTL_TIP foreign key (IDTIPOLIMPIEZA)
      references HPTL_TIPOLIMPIEZA (IDTIPOLIMPIEZA)
      on update restrict
      on delete restrict;

alter table HPTL_LIMPIEZA
   add constraint FK_HPTL_LIM_REFERENCE_HPTL_PUE foreign key (HPT_ID)
      references HPTL.HPTL_PUESTOS_AREAS (ID)
      on update restrict
      on delete restrict;

alter table HPTL_MATENIMIENTO
   add constraint FK_HPTL_MAT_REFERENCE_HPTL_UTE foreign key (IDRECURSO)
      references HPTL_UTENCILIOS (IDRECURSO)
      on update restrict
      on delete restrict;

alter table HPTL_MATENIMIENTO
   add constraint FK_HPTL_MAT_REFERENCE_HPTL_PUE foreign key (ID)
      references HPTL.HPTL_PUESTOS_AREAS (ID)
      on update restrict
      on delete restrict;

alter table HPTL_PAQUETES
   add constraint FK_HPTL_PAQ_REFERENCE_HPTL_RIE foreign key (IDCONSERVACION)
      references HPTL_RIESGOS (IDRIESGOS)
      on update restrict
      on delete restrict;

alter table HPTL_PAQUETES
   add constraint FK_HPTL_PAQ_REFERENCE_HPTL_ALM foreign key (IDALMACENAMIENTO)
      references HPTL_ALMACENAMIENTO (IDALMACENAMIENTO)
      on update restrict
      on delete restrict;

alter table HPTL_PAQUETES
   add constraint FK_HPTL_PAQ_REFERENCE_HPTL_TRA foreign key (IDTRANSPORTE)
      references HPTL_TRANSPORTE (IDTRANSPORTE)
      on update restrict
      on delete restrict;
	  
alter table HPTL_RECURSOXAREA
   add constraint FK_HPTL_REC_REFERENCE_HPTL_UTE foreign key (IDRECURSO)
      references HPTL_UTENCILIOS (IDRECURSO)
      on update restrict
      on delete restrict;

alter table HPTL_RECURSOXAREA
   add constraint FK_HPTL_REC_REFERENCE_HPTL_ARE foreign key (ID)
      references HPTL.HPTL_AREAS (ID)
      on update restrict
      on delete restrict;

alter table HPTL_RIESGOS
   add constraint FK_HPTL_RIE_REFERENCE_HPTL_TIP foreign key (IDTIPORIESGOS)
      references HPTL_TIPORIESGOS (IDTIPORIESGOS)
      on update restrict
      on delete restrict;

alter table HPTL_TRANSPORTE
   add constraint FK_HPTL_TRA_REFERENCE_HPTL_TIP foreign key (IDTIPOTRANSPORTE)
      references HPTL_TIPOTRANSPORTE (IDTIPOTRANSPORTE)
      on update restrict
      on delete restrict;

alter table HPTL_UTENCILIOSXPAQUETE
   add constraint FK_HPTL_UTE_REFERENCE_HPTL_PAQ foreign key (IDPAQUETE)
      references HPTL_PAQUETES (IDPAQUETE)
      on update restrict
      on delete restrict;

alter table HPTL_UTENCILIOSXPAQUETE
   add constraint FK_HPTL_UTE_REFERENCE_HPTL_UTE foreign key (IDRECURSO)
      references HPTL_UTENCILIOS (IDRECURSO)
      on update restrict
      on delete restrict;
	  
-- SECUENCIAS PARA IDs (TABLAS GENERALES)

CREATE SEQUENCE HOSPITAL.HPTL_PERSONAS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_TELEFONOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_PERSONAS_TELEFONOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_TIPO_SANGRE_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_PACIENTES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_EMPLEADOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_DOCTORES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_ESPECIALIDADES_DOC_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_DOC_ESPECIALIDAD_DOC_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_PUESTOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_EMPLEADOS_PUESTOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_AREAS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_PUESTOS_AREAS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_HORARIOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_TIPO_ENFERMEDADES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_ENFERMEDADES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_PAISES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_DEPARTAMENTOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_MUNICIPIOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_DIRECCIONES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_CLINICAS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_MEDICAMENTOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_TIPOS_EXAMENES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_EXAMENES_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_TIPOS_EQUIPOS_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_EQUIPOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_TIPO_DOCUMENTOS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_PERSONA_DOCTO_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE

-- SECUENCIAS PARA IDs (TABLAS GRUPO #2)

CREATE SEQUENCE HOSPITAL.HPTL_CITAS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_HIS_MEDICA_DETA_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_RECETAS_SEQ 
INCREMENT BY 1
START WITH 1
NOMAXVALUE

CREATE SEQUENCE HOSPITAL.HPTL_RECETA_MEDICAMENTO_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE



