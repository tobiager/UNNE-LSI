-- EJ 10
CREATE TABLE Paciente (
  id_paciente   INT IDENTITY PRIMARY KEY,
  documento     VARCHAR(20) NOT NULL UNIQUE,
  apellido      VARCHAR(80) NOT NULL,
  nombre        VARCHAR(80) NOT NULL,
  fecha_nac     DATE NULL,
  sexo          CHAR(1) NULL,
  domicilio     VARCHAR(200) NULL,
  telefono      VARCHAR(30) NULL
);

CREATE TABLE Especialidad (
  id_especialidad INT IDENTITY PRIMARY KEY,
  nombre          VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Medico (
  id_medico      INT IDENTITY PRIMARY KEY,
  matricula      VARCHAR(30) NOT NULL UNIQUE,
  apellido       VARCHAR(80) NOT NULL,
  nombre         VARCHAR(80) NOT NULL,
  id_especialidad INT NULL REFERENCES Especialidad(id_especialidad)
);

CREATE TABLE Atencion (
  id_atencion    INT IDENTITY PRIMARY KEY,
  id_paciente    INT NOT NULL REFERENCES Paciente(id_paciente),
  id_medico      INT NOT NULL REFERENCES Medico(id_medico),
  fecha          DATETIME2 NOT NULL,
  motivo         VARCHAR(250) NULL,
  diagnostico    VARCHAR(400) NULL
);

CREATE TABLE Tratamiento (
  id_tratamiento INT IDENTITY PRIMARY KEY,
  nombre         VARCHAR(120) NOT NULL UNIQUE,
  descripcion    VARCHAR(400) NULL
);

CREATE TABLE AtencionTratamiento (
  id_atencion     INT NOT NULL REFERENCES Atencion(id_atencion) ON DELETE CASCADE,
  id_tratamiento  INT NOT NULL REFERENCES Tratamiento(id_tratamiento),
  dosis           VARCHAR(80) NULL,
  frecuencia      VARCHAR(80) NULL,
  duracion_dias   INT NULL,
  observaciones   VARCHAR(250) NULL,
  CONSTRAINT PK_AtencionTratamiento PRIMARY KEY (id_atencion, id_tratamiento)
);
