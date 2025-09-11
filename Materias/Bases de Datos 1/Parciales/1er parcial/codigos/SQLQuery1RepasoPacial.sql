create database modelo_parcial;

use modelo_parcial;

CREATE TABLE Persona
(
  DNI INT NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  CONSTRAINT PK_persona_dni PRIMARY KEY (DNI)
);

CREATE TABLE Niño
(
  fecha_nacimiento DATE NOT NULL,
  fecha_ingreso DATE NOT NULL,
  fecha_baja DATE,
  dni_niño INT NOT NULL,
  CONSTRAINT PK_niño_dni PRIMARY KEY (dni_niño),
  CONSTRAINT FK_niño_dni FOREIGN KEY (dni_niño) REFERENCES Persona(DNI)
);

CREATE TABLE Tutor
(
  telefono BIGINT NOT NULL,
  email VARCHAR(50) NOT NULL,
  dni_tutor INT NOT NULL,
  CONSTRAINT PK_tutor_dni PRIMARY KEY (dni_tutor),
  CONSTRAINT FK_tutor_dni FOREIGN KEY (dni_tutor) REFERENCES Persona(DNI),
  CONSTRAINT UQ_tutor_email UNIQUE (email)
);

CREATE TABLE Planilla
(
  hora_retiro TIME NOT NULL,
  fecha_planilla DATE NOT NULL,
  id_planilla INT NOT NULL,
  CONSTRAINT PK_planilla_id PRIMARY KEY (id_planilla)

);

CREATE TABLE Niño_Tutor
(
  relacion VARCHAR(50) NOT NULL,
  id_planilla INT NOT NULL,
  dni_tutor INT NOT NULL,
  dni_niño INT NOT NULL,
  CONSTRAINT PK_niño_tutor PRIMARY KEY (dni_tutor, dni_niño),
  CONSTRAINT FK_niño_tutor_plantilla FOREIGN KEY (id_planilla) REFERENCES Planilla(id_planilla),
  CONSTRAINT FK_niño_tutor_dni_tutor FOREIGN KEY (dni_tutor) REFERENCES Tutor(dni_tutor),
  CONSTRAINT FK_niño_tutor_dni_niño FOREIGN KEY (dni_niño) REFERENCES Niño(dni_niño)
);

CREATE TABLE Tipo_Categoria
(
  id_categoria INT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  CONSTRAINT PK_tipo_categoria_id PRIMARY KEY (id_categoria)
);

CREATE TABLE Horario_laboral
(
  id_horario INT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  CONSTRAINT PK_horario_laboral_id PRIMARY KEY (id_horario)
);

CREATE TABLE Responsable_Institucion
(
  id_responsable INT NOT NULL,
  id_planilla INT NOT NULL,
  CONSTRAINT PK_responsable_institucion_id PRIMARY KEY (id_responsable),
  CONSTRAINT FK_responsable_institucion_dni FOREIGN KEY (id_responsable) REFERENCES Persona(DNI),
  CONSTRAINT FK_responsable_institucion_planilla FOREIGN KEY (id_planilla) REFERENCES Planilla(id_planilla)
);

CREATE TABLE Cuidador
(
  dni_cuidador INT NOT NULL,
  id_categoria INT NOT NULL,
  id_horario INT NOT NULL,
  dni_niño INT NOT NULL,
  CONSTRAINT PK_cuidador_dni PRIMARY KEY (dni_cuidador),
  CONSTRAINT FK_cuidador_persona_dni FOREIGN KEY (dni_cuidador) REFERENCES Persona(DNI),
  CONSTRAINT FK_cuidador_categoria FOREIGN KEY (id_categoria) REFERENCES Tipo_Categoria(id_categoria),
  CONSTRAINT FK_cuidador_horario FOREIGN KEY (id_horario) REFERENCES Horario_laboral(id_horario),
  CONSTRAINT FK_cuidador_dni_niño FOREIGN KEY (dni_niño) REFERENCES Niño(dni_niño)
);

-- RESTRICIONES --

ALTER TABLE Planilla
ADD CONSTRAINT DF_planilla_fecha DEFAULT CONVERT(DATE, GETDATE()) FOR fecha_planilla;

ALTER TABLE Planilla
ADD CONSTRAINT DF_planilla_hora_retiro DEFAULT CONVERT(TIME, GETDATE()) FOR hora_retiro;

-- Como eliminar una restriccion --
ALTER TABLE Planilla
DROP CONSTRAINT DF_planilla_hora_retiro;

-- TIME(0) elimina los milisegundos -- 
ALTER TABLE Planilla
ADD CONSTRAINT DF_planilla_hora_retiro DEFAULT CONVERT(TIME(0), GETDATE()) FOR hora_retiro;

-- INSETS --

select * from persona
insert INTO persona (dni, apellido, nombre) values (23456532, 'Perez', 'Juan'), (73529711, 'Diaz', 'Pablo'), (64937293, 'Perez', 'Juancito'), (45837239, 'Torres', 'Marta');

select * from niño
insert INTO niño (fecha_nacimiento, fecha_ingreso, dni_niño) values ('2018-04-12', '2024-03-01', 64937293);

select * from Tutor
insert INTO tutor (telefono, email, dni_tutor) values (3794274912, 'juanperez@gmail.com', 23456532);


select * from Tipo_Categoria
insert INTO Tipo_Categoria (id_categoria, descripcion) values (1, 'docente'), (2, 'administrativa');

select * from Horario_laboral
insert INTO Horario_laboral (id_horario, descripcion) values (1, 'mañana'), (2, 'tarde');

select * from cuidador
insert INTO cuidador (dni_cuidador, id_categoria, id_horario, dni_niño) values (73529711, 1, 1, 64937293);


select * from planilla
insert INTO planilla (id_planilla) values (1);
insert INTO planilla (id_planilla) values (2);

select * from Niño_Tutor
insert INTO Niño_Tutor (relacion, id_planilla, dni_tutor, dni_niño) values ('padre_hijo', 1, 23456532, 64937293);


select * from Responsable_Institucion
insert INTO Responsable_Institucion (id_responsable, id_planilla) values (45837239, 1);

