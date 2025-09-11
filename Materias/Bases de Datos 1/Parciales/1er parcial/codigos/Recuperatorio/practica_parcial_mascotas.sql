CREATE DATABASE veterinaria;

USE veterinaria;



CREATE TABLE dueno
(
  id_dueno INT NOT NULL,
  dni INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  CONSTRAINT PK_dueno PRIMARY KEY (id_dueno),
  CONSTRAINT UQ_dueno_email UNIQUE (email)
);

CREATE TABLE especie
(
  id_especie INT NOT NULL,
  especie VARCHAR(100) NOT NULL,
  CONSTRAINT PK_especie PRIMARY KEY (id_especie)
);

CREATE TABLE raza
(
  raza VARCHAR(100) NOT NULL,
  id_especie INT NOT NULL,
  CONSTRAINT PK_raza PRIMARY KEY (raza, id_especie),
  CONSTRAINT FK_especie_id_especie FOREIGN KEY (id_especie) REFERENCES especie(id_especie)
);

CREATE TABLE laboratorio
(
  id_laboratorio INT NOT NULL,
  nombre_lab VARCHAR(100) NOT NULL,
  CONSTRAINT PK_laboratorio PRIMARY KEY (id_laboratorio)
);

CREATE TABLE telefono
(
  nro_telefono VARCHAR(50) NOT NULL,
  id_dueno INT NOT NULL,
  CONSTRAINT PK_telefono PRIMARY KEY (nro_telefono, id_dueno),
  CONSTRAINT FK_dueno_id_dueno FOREIGN KEY (id_dueno) REFERENCES dueno(id_dueno)
);

CREATE TABLE especialidad
(
  id_especialidad INT NOT NULL,
  especialidad VARCHAR(100) NOT NULL,
  CONSTRAINT PK_especialidad PRIMARY KEY (id_especialidad)
);

CREATE TABLE horario_atencion
(
  id_horario INT NOT NULL,
  horario INT NOT NULL,
  CONSTRAINT PK_horario_atencion PRIMARY KEY (id_horario)
);

CREATE TABLE mascota
(
  id_mascota INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  peso INT NOT NULL,
  condicion_medica_especial VARCHAR(100) NOT NULL,
  id_dueno INT NOT NULL,
  id_especie INT NOT NULL,
  CONSTRAINT PK_mascota PRIMARY KEY (id_mascota),
  CONSTRAINT FK_dueno_id_dueno FOREIGN KEY (id_dueno) REFERENCES dueno(id_dueno),
  CONSTRAINT FK_especie_id_especie FOREIGN KEY (id_especie) REFERENCES especie(id_especie)
);

CREATE TABLE veterinario
(
  nro_licencia_profesional INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  id_especialidad INT NOT NULL,
  id_horario INT NOT NULL,
  CONSTRAINT PK_veterinario PRIMARY KEY (nro_licencia_profesional),
  CONSTRAINT FK_especialidad_id_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad),
  CONSTRAINT FK_horario_atencion_id_horario FOREIGN KEY (id_horario) REFERENCES horario_atencion(id_horario)
);

CREATE TABLE cita_medica
(
  id_cita INT NOT NULL,
  motivo VARCHAR(100) NOT NULL,
  id_mascota INT NOT NULL,
  nro_licencia_profesional INT NOT NULL,
  CONSTRAINT PK_cita_medica PRIMARY KEY (id_cita),
  CONSTRAINT FK_mascota_id_mascotaFOREIGN KEY (id_mascota) REFERENCES mascota(id_mascota),
  CONSTRAINT FK_veterinario_nro_licencia_profesional FOREIGN KEY (nro_licencia_profesional) REFERENCES veterinario(nro_licencia_profesional)
);

CREATE TABLE tratamiento
(
  id_tratamiento INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  duracion INT NOT NULL,
  otra_indicacion VARCHAR(100) NOT NULL,
  id_cita INT NOT NULL,
  PRIMARY KEY (id_tratamiento),
CREATE TABLE medicamento
(
  id_medicamento INT NOT NULL,
  nombre_medicamento VARCHAR(100) NOT NULL,
  monodrogra VARCHAR(100) NOT NULL,
  presentacion VARCHAR(100) NOT NULL,
  id_tratamiento INT NOT NULL,
  id_laboratorio INT NOT NULL,
  CONSTRAINT PK_medicamento PRIMARY KEY (id_medicamento),
  CONSTRAINT FK_tratamiento_id_tratamiento FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento),
  CONSTRAINT FK_laboratorio_id_laboratorio FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio)
);

--restricciones

--edad
  CONSTRAINT CK_vendedor_edad CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 18)



--datos prueba


--selects


--datos prueba restricciones