-- Catálogos de ubicación
CREATE TABLE localidad (
  id_localidad       INT          NOT NULL PRIMARY KEY,
  nombre_localidad   VARCHAR(80)  NOT NULL
);

CREATE TABLE provincia (
  id_provincia       INT          NOT NULL PRIMARY KEY,
  nombre_provincia   VARCHAR(80)  NOT NULL,
  id_localidad       INT          NOT NULL,
  CONSTRAINT FK_provincia_localidad
    FOREIGN KEY (id_localidad) REFERENCES localidad(id_localidad)
);

CREATE TABLE direccion (
  id_direccion  INT          NOT NULL PRIMARY KEY,
  altura        VARCHAR(10)  NULL,
  calle         VARCHAR(120) NULL
);

-- Colegio y domicilio
CREATE TABLE colegio (
  id_colegio         INT          NOT NULL PRIMARY KEY,
  nombre             VARCHAR(120) NOT NULL,
  poliza_nro         VARCHAR(30)  NULL,
  telefono           VARCHAR(30)  NULL,
  director_nombre    VARCHAR(80)  NULL,
  director_DNI       VARCHAR(20)  NULL UNIQUE,
  director_apellido  VARCHAR(80)  NULL,
  id_provincia       INT          NOT NULL,
  id_direccion       INT          NOT NULL,
  CONSTRAINT FK_colegio_provincia
    FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia),
  CONSTRAINT FK_colegio_direccion
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE domicilio (
  id_domicilio  INT          NOT NULL PRIMARY KEY,
  calle         VARCHAR(120) NOT NULL,
  altura        VARCHAR(10)  NOT NULL,
  piso          VARCHAR(10)  NULL,
  num_dpto      VARCHAR(10)  NULL
);

-- Alumnos
CREATE TABLE alumno (
  id_alumno         INT          NOT NULL PRIMARY KEY,
  nombre            VARCHAR(80)  NOT NULL,
  apellido          VARCHAR(80)  NOT NULL,
  DNI               VARCHAR(20)  NOT NULL UNIQUE,
  fecha_nacimiento  DATE         NULL,
  sexo              VARCHAR(1)   NULL,
  turno             VARCHAR(20)  NULL,
  grado             VARCHAR(10)  NULL,
  division          VARCHAR(10)  NULL,
  id_colegio        INT          NOT NULL,
  id_domicilio      INT          NOT NULL,
  CONSTRAINT FK_alumno_colegio
    FOREIGN KEY (id_colegio)   REFERENCES colegio(id_colegio),
  CONSTRAINT FK_alumno_domicilio
    FOREIGN KEY (id_domicilio) REFERENCES domicilio(id_domicilio)
);

-- Catálogos de accidente
CREATE TABLE forma_accidente (
  id_forma     INT          NOT NULL PRIMARY KEY,
  descripcion  VARCHAR(120) NOT NULL
);

CREATE TABLE lugar (
  id_lugar     INT          NOT NULL PRIMARY KEY,
  descripcion  VARCHAR(120) NOT NULL
);

-- Hecho: accidente
CREATE TABLE accidente (
  nro_siniestro     INT          NOT NULL PRIMARY KEY,
  fecha_accidente   DATE         NOT NULL,
  hora_accidente    VARCHAR(8)   NULL,
  observaciones     VARCHAR(250) NULL,
  id_forma          INT          NOT NULL,
  id_lugar          INT          NOT NULL,
  CONSTRAINT FK_accidente_forma
    FOREIGN KEY (id_forma) REFERENCES forma_accidente(id_forma),
  CONSTRAINT FK_accidente_lugar
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);

-- N:M alumno <-> accidente
CREATE TABLE accidente_alumno (
  id_alumno      INT NOT NULL,
  nro_siniestro  INT NOT NULL,
  CONSTRAINT PK_accidente_alumno PRIMARY KEY (id_alumno, nro_siniestro),
  CONSTRAINT FK_accidente_alumno_alumno
    FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno),
  CONSTRAINT FK_accidente_alumno_accidente
    FOREIGN KEY (nro_siniestro) REFERENCES accidente(nro_siniestro)
);

-- Lesiones y N:M accidente <-> lesión
CREATE TABLE lesion (
  id_lesion      INT           NOT NULL PRIMARY KEY,
  descripciones  VARCHAR(150)  NOT NULL
);

CREATE TABLE accidente_lesion (
  id_lesion      INT NOT NULL,
  nro_siniestro  INT NOT NULL,
  CONSTRAINT PK_accidente_lesion PRIMARY KEY (id_lesion, nro_siniestro),
  CONSTRAINT FK_accidente_lesion_lesion
    FOREIGN KEY (id_lesion)     REFERENCES lesion(id_lesion),
  CONSTRAINT FK_accidente_lesion_accidente
    FOREIGN KEY (nro_siniestro) REFERENCES accidente(nro_siniestro)
);
