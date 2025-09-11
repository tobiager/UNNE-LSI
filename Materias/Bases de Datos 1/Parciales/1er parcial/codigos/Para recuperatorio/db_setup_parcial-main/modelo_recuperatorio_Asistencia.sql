CREATE TABLE Institucion
(
  id_institucion INT NOT NULL,
  nombre_institucion VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Institucion_id PRIMARY KEY (id_institucion)
);

CREATE TABLE NivelEducativo
(
  id_nivel INT NOT NULL,
  razon_social VARCHAR(30) NOT NULL,
  direccion VARCHAR(30) NOT NULL,
  nombre_nivel VARCHAR(30),
  cuit_nivel VARCHAR(12) NOT NULL,
  telefono_nivel NUMERIC(4,20) NOT NULL,
  email_nivel VARCHAR(30) NOT NULL,
  id_institucion INT NOT NULL,
  CONSTRAINT PK_NivelEducativo_id PRIMARY KEY (id_nivel),
  CONSTRAINT FK_NivelEducativo_id_institucion FOREIGN KEY (id_institucion) REFERENCES Institucion(id_institucion)
);

CREATE TABLE Cargo
(
  id_cargo INT NOT NULL,
  nombre_cargo VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Cargo_id PRIMARY KEY (id_cargo)
);

CREATE TABLE Terminal
(
  id_terminal INT NOT NULL,
  nro_serie_terminal INT NOT NULL,
  modelo_terminal VARCHAR(50) NOT NULL,
  fecha_instalacion DATE NOT NULL,
  id_nivel INT NOT NULL,
  CONSTRAINT PK_Terminal_id PRIMARY KEY (id_terminal),
  CONSTRAINT FK_Terminal_id_nivel FOREIGN KEY (id_nivel) REFERENCES NivelEducativo(id_nivel)
);

CREATE TABLE TipoNivelEducativo
(
  id_tipoNivel INT NOT NULL,
  nombre_tipoNivel VARCHAR(30) NOT NULL,
  id_nivel INT NOT NULL,
  CONSTRAINT PK_TipoNivelEducativo_id PRIMARY KEY (id_tipoNivel),
  CONSTRAINT PK_TipoNivelEducativo_id_nivel FOREIGN KEY (id_nivel) REFERENCES NivelEducativo(id_nivel)
);

CREATE TABLE Personal
(
  id_personal INT NOT NULL,
  nombre_personal VARCHAR(30) NOT NULL,
  apellido_personal VARCHAR(30) NOT NULL,
  dni_personal VARCHAR(8) NOT NULL,
  cuil_personal VARCHAR(21) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  nro_legajo INT NOT NULL,
  id_cargo INT NOT NULL,
  CONSTRAINT PK_Personal_id PRIMARY KEY (id_personal),
  CONSTRAINT FK_Personal_id_cargo FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo),
  CONSTRAINT UQ_Personal_nroLegajo UNIQUE (nro_legajo),
  CONSTRAINT UQ_Personal_dni UNIQUE (dni_personal),
  CONSTRAINT UQ_Personal_cuil UNIQUE (cuil_personal)
);

CREATE TABLE Contacto
(
  id_contacto INT NOT NULL,
  email_contacto VARCHAR(50) NOT NULL,
  numero_contacto INT NOT NULL,
  fb_contacto VARCHAR(30),
  direccion_contacto VARCHAR(50) NOT NULL,
  id_personal INT NOT NULL,
  CONSTRAINT PK_Contacto_id PRIMARY KEY (id_contacto),
  CONSTRAINT FK_Personal_id_personal FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

CREATE TABLE Personal_nivel
(
  id_personal INT NOT NULL,
  id_nivel INT NOT NULL,
  CONSTRAINT PK_Personal_Nivel_id PRIMARY KEY (id_personal, id_nivel),
  CONSTRAINT FK_Personal_Nivel_id_personal FOREIGN KEY (id_personal) REFERENCES Personal(id_personal),
  CONSTRAINT FK_Personal_Nivel_id_nivel FOREIGN KEY (id_nivel) REFERENCES NivelEducativo(id_nivel)
);

CREATE TABLE Asistencia
(
  id_assist INT NOT NULL,
  fecha_assist DATE NOT NULL,
  hora_assist TIME NOT NULL,
  tipo_mov_assit VARCHAR(1) NOT NULL,
  id_terminal INT NOT NULL,
  id_personal INT NOT NULL,
  id_nivel INT NOT NULL,
  CONSTRAINT PK_Asistencia_id PRIMARY KEY (id_assist),
  CONSTRAINT FK_Asistencia_id_terminal FOREIGN KEY (id_terminal) REFERENCES Terminal(id_terminal),
  CONSTRAINT FK_Asistencia_id_personal_id_nivel FOREIGN KEY (id_personal, id_nivel) REFERENCES Personal_nivel(id_personal, id_nivel)
);


    --------------------
    ---Restrincciones---
    --------------------

ALTER TABLE Contacto 
ADD CONSTRAINT UQ_Contacto_email
UNIQUE (email_contacto);

ALTER TABLE Asistencia
ADD CONSTRAINT CK_Asistencia_tipo_movimento
CHECK (tipo_mov_assit IN ('I','E'));

ALTER TABLE Asistencia
ADD CONSTRAINT DF_Asistencia_fecha
DEFAULT CONVERT(DATE, GETDATE()) FOR fecha_assist;

ALTER TABLE Asistencia
ADD CONSTRAINT DF_Asistencia_hora
DEFAULT CONVERT(TIME, GETDATE()) FOR hora_assist;

ALTER TABLE Personal
ADD CONSTRAINT CK_Personal_edad
CHECK DATEDIFF(YEAR, fecha_nacimiento, GETDATE() <=65); 



