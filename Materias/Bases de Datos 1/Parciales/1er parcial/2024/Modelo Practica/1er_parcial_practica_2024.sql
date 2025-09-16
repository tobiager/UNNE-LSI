CREATE DATABASE parcial_practica_2024;
GO
USE parcial_practica_2024;
GO


/* =====================
   DUENOS
   ===================== */
CREATE TABLE duenos (
  id_dueno   INT NOT NULL,
  dni        VARCHAR(8) NOT NULL,
  nombre     VARCHAR(30) NOT NULL,
  direccion  VARCHAR(70) NOT NULL,
  telefono   CHAR(15) NOT NULL,
  correo     VARCHAR(70) NOT NULL,

  CONSTRAINT PK_dueno PRIMARY KEY (id_dueno),
  CONSTRAINT UQ_dueno_correo UNIQUE (correo),
  CONSTRAINT CK_dueno_dni CHECK (LEN(dni) <= 8)
);
GO

/* =====================
   PACIENTES
   ===================== */
CREATE TABLE pacientes (
  id_mascota       INT NOT NULL,
  especie          VARCHAR(30) NOT NULL,
  raza             VARCHAR(30) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  peso             DECIMAL(5,2) NOT NULL,
  id_dueno         INT NOT NULL,

  CONSTRAINT PK_mascota PRIMARY KEY (id_mascota),
  CONSTRAINT FK_paciente_dueno FOREIGN KEY (id_dueno) REFERENCES duenos(id_dueno),
  CONSTRAINT CK_paciente_fecha_pasada CHECK (fecha_nacimiento <= CAST(GETDATE() AS DATE)),
  CONSTRAINT CK_paciente_peso_pos CHECK (peso > 0),
  CONSTRAINT CK_paciente_edad CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) < 30)
);
GO

/* =====================
   VETERINARIOS
   ===================== */
CREATE TABLE veterinarios (
  nro_licencia      INT NOT NULL,
  nombre            VARCHAR(30) NOT NULL,
  especialidad      VARCHAR(20),
  horario_atencion  VARCHAR(30) NOT NULL,

  CONSTRAINT PK_veterinario PRIMARY KEY (nro_licencia)
);
GO

/* =====================
   CITAS MEDICAS
   ===================== */
CREATE TABLE citas_medicas (
  id_cita          INT NOT NULL,
  id_mascota       INT NOT NULL,
  nro_licencia     INT NOT NULL,
  fecha_cita       DATETIME NOT NULL CONSTRAINT DF_cita_fecha DEFAULT (GETDATE()),
  motivo           VARCHAR(30) NOT NULL,
  observacion      VARCHAR(40) NULL,
  fecha_creacion   DATETIME NOT NULL CONSTRAINT DF_cita_fecha_creacion DEFAULT (GETDATE()),
  usuario_creacion VARCHAR(50) NOT NULL CONSTRAINT DF_cita_usuario_creacion DEFAULT (SYSTEM_USER),

  CONSTRAINT PK_cita PRIMARY KEY (id_cita),
  CONSTRAINT FK_cita_paciente FOREIGN KEY (id_mascota) REFERENCES pacientes(id_mascota),
  CONSTRAINT FK_cita_veterinario FOREIGN KEY (nro_licencia) REFERENCES veterinarios(nro_licencia),
  CONSTRAINT UQ_cita_paciente_vet_fecha UNIQUE (id_mascota, nro_licencia, fecha_cita)
);
GO

/* =====================
   TRATAMIENTOS
   ===================== */
CREATE TABLE tratamientos (
  id_tratamiento INT NOT NULL,
  id_cita        INT NOT NULL,
  nombre         VARCHAR(50) NOT NULL,
  duracion       VARCHAR(20) NOT NULL,  
  indicacion     VARCHAR(200) NOT NULL,

  CONSTRAINT PK_tratamiento PRIMARY KEY (id_tratamiento),
  CONSTRAINT FK_tratamiento_cita FOREIGN KEY (id_cita) REFERENCES citas_medicas(id_cita)
);
GO

/* =====================
   MEDICAMENTOS
   ===================== */
CREATE TABLE medicamentos (
  id_medicamento   INT NOT NULL,
  nombre_comercial VARCHAR(30) NOT NULL,
  monodroga        VARCHAR(50) NOT NULL,
  presentacion     VARCHAR(40) NOT NULL,
  laboratorio      VARCHAR(40) NOT NULL,

  CONSTRAINT PK_medicamento PRIMARY KEY (id_medicamento)
);
GO

/* =====================
   ASIGNAR MEDICAMENTO
   ===================== */
CREATE TABLE asignar_medicamento (
  id_tratamiento INT NOT NULL,
  id_medicamento INT NOT NULL,

  CONSTRAINT PK_tratamiento_medicamento PRIMARY KEY (id_tratamiento, id_medicamento),
  CONSTRAINT FK_tto_med_tratamiento FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento),
  CONSTRAINT FK_tto_med_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);
GO

/* =====================
   CONDICIONES
   ===================== */
CREATE TABLE condiciones (
  id_condicion     INT NOT NULL,
  id_mascota       INT NOT NULL,
  condicion_medica VARCHAR(100) NULL,

  CONSTRAINT PK_condicion PRIMARY KEY (id_condicion),
  CONSTRAINT FK_condicion_paciente FOREIGN KEY (id_mascota) REFERENCES pacientes(id_mascota)
);
GO
