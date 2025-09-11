/* ==========================================================
   MODELO “Accidentes Escolares” (SQL Server)
   BD: TP3_9
   ========================================================== */
SET NOCOUNT ON;
SET XACT_ABORT ON;

/* 0) (Re)crear Base y usarla */
USE master;
IF DB_ID('TP3_9') IS NOT NULL
BEGIN
  ALTER DATABASE TP3_9 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE TP3_9;
END;
GO
CREATE DATABASE TP3_9;
GO
USE TP3_9;
GO

/* 1) Crear schema lógico */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'escuela')
  EXEC('CREATE SCHEMA escuela AUTHORIZATION dbo');
GO

/* 2) Limpieza defensiva (por si re-ejecutás) */
DROP VIEW IF EXISTS escuela.vw_accidentes_por_alumno;
DROP TABLE IF EXISTS escuela.accidente_lesion;
DROP TABLE IF EXISTS escuela.accidente_alumno;
DROP TABLE IF EXISTS escuela.accidente;
DROP TABLE IF EXISTS escuela.alumno;
DROP TABLE IF EXISTS escuela.colegio;
DROP TABLE IF EXISTS escuela.domicilio;
DROP TABLE IF EXISTS escuela.direccion;
DROP TABLE IF EXISTS escuela.localidad;
DROP TABLE IF EXISTS escuela.provincia;
DROP TABLE IF EXISTS escuela.forma_accidente;
DROP TABLE IF EXISTS escuela.lugar;
DROP TABLE IF EXISTS escuela.lesion;
GO

/* ==========================================================
   3) Catálogos y jerarquías
   ========================================================== */
CREATE TABLE escuela.provincia(
  id_provincia  INT         NOT NULL CONSTRAINT pk_provincia PRIMARY KEY,
  nombre        VARCHAR(80) NOT NULL CONSTRAINT uq_provincia_nombre UNIQUE
);

CREATE TABLE escuela.localidad(
  id_localidad  INT         NOT NULL CONSTRAINT pk_localidad PRIMARY KEY,
  nombre        VARCHAR(80) NOT NULL,
  id_provincia  INT         NOT NULL
    CONSTRAINT fk_localidad_provincia
      FOREIGN KEY REFERENCES escuela.provincia(id_provincia)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE escuela.forma_accidente(
  id_forma      INT          NOT NULL CONSTRAINT pk_forma PRIMARY KEY,
  descripcion   VARCHAR(120) NOT NULL CONSTRAINT uq_forma_desc UNIQUE
);

CREATE TABLE escuela.lugar(
  id_lugar      INT          NOT NULL CONSTRAINT pk_lugar PRIMARY KEY,
  descripcion   VARCHAR(120) NOT NULL CONSTRAINT uq_lugar_desc UNIQUE
);

CREATE TABLE escuela.lesion(
  id_lesion     INT          NOT NULL CONSTRAINT pk_lesion PRIMARY KEY,
  descripcion   VARCHAR(150) NOT NULL CONSTRAINT uq_lesion_desc UNIQUE
);

/* Direcciones de colegios */
CREATE TABLE escuela.direccion(
  id_direccion  INT          NOT NULL CONSTRAINT pk_direccion PRIMARY KEY,
  calle         VARCHAR(120) NOT NULL,
  altura        VARCHAR(10)  NOT NULL
);

/* Domicilios de alumnos */
CREATE TABLE escuela.domicilio(
  id_domicilio  INT          NOT NULL CONSTRAINT pk_domicilio PRIMARY KEY,
  calle         VARCHAR(120) NOT NULL,
  altura        VARCHAR(10)  NOT NULL,
  piso          VARCHAR(10)  NULL,
  num_dpto      VARCHAR(10)  NULL
);

/* ==========================================================
   4) Entidades principales
   ========================================================== */
CREATE TABLE escuela.colegio(
  id_colegio        INT           NOT NULL CONSTRAINT pk_colegio PRIMARY KEY,
  nombre            VARCHAR(120)  NOT NULL,
  poliza_nro        VARCHAR(30)   NULL,
  telefono          VARCHAR(30)   NULL,
  director_nombre   VARCHAR(80)   NULL,
  director_apellido VARCHAR(80)   NULL,
  director_DNI      VARCHAR(20)   NULL CONSTRAINT uq_colegio_director_dni UNIQUE,
  id_provincia      INT           NOT NULL
    CONSTRAINT fk_colegio_provincia
      FOREIGN KEY REFERENCES escuela.provincia(id_provincia)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  id_direccion      INT           NOT NULL
    CONSTRAINT fk_colegio_direccion
      FOREIGN KEY REFERENCES escuela.direccion(id_direccion)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE escuela.alumno(
  id_alumno        INT          NOT NULL CONSTRAINT pk_alumno PRIMARY KEY,
  nombre           VARCHAR(80)  NOT NULL,
  apellido         VARCHAR(80)  NOT NULL,
  DNI              VARCHAR(20)  NOT NULL CONSTRAINT uq_alumno_dni UNIQUE,
  fecha_nacimiento DATE         NULL,
  sexo             CHAR(1)      NULL CONSTRAINT ck_alumno_sexo CHECK (sexo IN ('M','F','X')),
  turno            VARCHAR(20)  NULL,
  grado            VARCHAR(10)  NULL,
  division         VARCHAR(10)  NULL,
  id_colegio       INT          NOT NULL
    CONSTRAINT fk_alumno_colegio
      FOREIGN KEY REFERENCES escuela.colegio(id_colegio)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  id_domicilio     INT          NOT NULL
    CONSTRAINT fk_alumno_domicilio
      FOREIGN KEY REFERENCES escuela.domicilio(id_domicilio)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE escuela.accidente(
  nro_siniestro    INT           NOT NULL CONSTRAINT pk_accidente PRIMARY KEY,
  fecha_accidente  DATE          NOT NULL,
  hora_accidente   TIME(0)       NULL,
  observaciones    VARCHAR(250)  NULL,
  id_forma         INT           NOT NULL
    CONSTRAINT fk_accidente_forma
      FOREIGN KEY REFERENCES escuela.forma_accidente(id_forma)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  id_lugar         INT           NOT NULL
    CONSTRAINT fk_accidente_lugar
      FOREIGN KEY REFERENCES escuela.lugar(id_lugar)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* ==========================================================
   5) Relaciones M:N (tablas puente)
   ========================================================== */
CREATE TABLE escuela.accidente_alumno(
  id_alumno     INT NOT NULL,
  nro_siniestro INT NOT NULL,
  CONSTRAINT pk_accidente_alumno PRIMARY KEY (id_alumno, nro_siniestro),
  CONSTRAINT fk_acc_alum_alumno
    FOREIGN KEY (id_alumno) REFERENCES escuela.alumno(id_alumno)
    ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_acc_alum_accidente
    FOREIGN KEY (nro_siniestro) REFERENCES escuela.accidente(nro_siniestro)
    ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE escuela.accidente_lesion(
  id_lesion     INT NOT NULL,
  nro_siniestro INT NOT NULL,
  CONSTRAINT pk_accidente_lesion PRIMARY KEY (id_lesion, nro_siniestro),
  CONSTRAINT fk_acc_les_lesion
    FOREIGN KEY (id_lesion) REFERENCES escuela.lesion(id_lesion)
    ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_acc_les_accidente
    FOREIGN KEY (nro_siniestro) REFERENCES escuela.accidente(nro_siniestro)
    ON UPDATE NO ACTION ON DELETE CASCADE
);

/* 6) Índices de apoyo (rendimiento) */
CREATE INDEX ix_alumno_colegio     ON escuela.alumno(id_colegio);
CREATE INDEX ix_alumno_domicilio   ON escuela.alumno(id_domicilio);
CREATE INDEX ix_localidad_prov     ON escuela.localidad(id_provincia);
CREATE INDEX ix_colegio_prov       ON escuela.colegio(id_provincia);
CREATE INDEX ix_colegio_dir        ON escuela.colegio(id_direccion);
CREATE INDEX ix_acc_alum_alumno    ON escuela.accidente_alumno(id_alumno);
CREATE INDEX ix_acc_alum_acc       ON escuela.accidente_alumno(nro_siniestro);
CREATE INDEX ix_acc_les_lesion     ON escuela.accidente_lesion(id_lesion);
CREATE INDEX ix_acc_les_acc        ON escuela.accidente_lesion(nro_siniestro);

/* ==========================================================
   7) Datos mínimos de prueba
   ========================================================== */
INSERT INTO escuela.provincia (id_provincia, nombre) VALUES
(1,'Chaco'), (2,'Corrientes');

INSERT INTO escuela.localidad (id_localidad, nombre, id_provincia) VALUES
(10,'Resistencia',1), (11,'Corrientes Capital',2);

INSERT INTO escuela.direccion (id_direccion, calle, altura) VALUES
(100,'Av. Siempreviva','742');

INSERT INTO escuela.colegio (id_colegio, nombre, poliza_nro, telefono, director_nombre, director_apellido, director_DNI, id_provincia, id_direccion)
VALUES (1000,'Colegio Nacional','POL-123','379-555555','Ana','Pérez','32123456',1,100);

INSERT INTO escuela.domicilio (id_domicilio, calle, altura, piso, num_dpto) VALUES
(200,'Mitre','123','3','B'),
(201,'Belgrano','987',NULL,NULL);

INSERT INTO escuela.alumno (id_alumno, nombre, apellido, DNI, fecha_nacimiento, sexo, turno, grado, division, id_colegio, id_domicilio)
VALUES
(1,'Juan','Gómez','40111222','2010-05-01','M','Mañana','5','A',1000,200),
(2,'Lucía','Ríos','42123456','2011-09-10','F','Tarde','4','B',1000,201);

INSERT INTO escuela.forma_accidente (id_forma, descripcion) VALUES
(1,'Caída'),(2,'Golpe'),(3,'Corte');

INSERT INTO escuela.lugar (id_lugar, descripcion) VALUES
(1,'Patio'),(2,'Aula'),(3,'Gimnasio');

INSERT INTO escuela.lesion (id_lesion, descripcion) VALUES
(1,'Excoriación'),(2,'Contusión'),(3,'Corte superficial');

INSERT INTO escuela.accidente (nro_siniestro, fecha_accidente, hora_accidente, observaciones, id_forma, id_lugar)
VALUES (5001,'2025-09-01','10:30','Resbaló en el patio',1,1);

INSERT INTO escuela.accidente_alumno (id_alumno, nro_siniestro) VALUES
(1,5001);

INSERT INTO escuela.accidente_lesion (id_lesion, nro_siniestro) VALUES
(2,5001);

/* ==========================================================
   8) Consultas de verificación
   ========================================================== */
-- Alumnos con su colegio
SELECT a.id_alumno, a.apellido, a.nombre, c.nombre AS colegio
FROM escuela.alumno a
JOIN escuela.colegio c ON c.id_colegio = a.id_colegio
ORDER BY a.apellido;

-- Accidentes con forma, lugar y alumnos
SELECT ac.nro_siniestro, ac.fecha_accidente, ac.hora_accidente,
       f.descripcion AS forma, l.descripcion AS lugar,
       a.id_alumno, a.apellido, a.nombre
FROM escuela.accidente ac
JOIN escuela.forma_accidente f ON f.id_forma = ac.id_forma
JOIN escuela.lugar l           ON l.id_lugar  = ac.id_lugar
LEFT JOIN escuela.accidente_alumno aa ON aa.nro_siniestro = ac.nro_siniestro
LEFT JOIN escuela.alumno a            ON a.id_alumno = aa.id_alumno
ORDER BY ac.nro_siniestro;

-- Lesiones por accidente (GROUP BY/HAVING)
SELECT ac.nro_siniestro, COUNT(al.id_lesion) AS lesiones
FROM escuela.accidente ac
LEFT JOIN escuela.accidente_lesion al ON al.nro_siniestro = ac.nro_siniestro
GROUP BY ac.nro_siniestro
HAVING COUNT(al.id_lesion) >= 1;
GO

/* 9) Vista (GO antes para evitar error de batch) */
CREATE VIEW escuela.vw_accidentes_por_alumno AS
SELECT a.id_alumno, a.apellido, a.nombre,
       COUNT(DISTINCT ac.nro_siniestro) AS accidentes
FROM escuela.alumno a
LEFT JOIN escuela.accidente_alumno aa ON aa.id_alumno = a.id_alumno
LEFT JOIN escuela.accidente ac ON ac.nro_siniestro = aa.nro_siniestro
GROUP BY a.id_alumno, a.apellido, a.nombre;
GO

-- Probar la vista
SELECT * FROM escuela.vw_accidentes_por_alumno ORDER BY accidentes DESC;
