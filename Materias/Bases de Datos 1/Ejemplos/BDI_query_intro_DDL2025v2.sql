/* ============================================
   MODELO DE DATOS: Gestión de alumnos
   Un alumno puede inscribirse en varias asignaturas.
   Una asignatura puede corresponder a varias carreras.
   ============================================ */

-- Versión del motor
SELECT @@VERSION;

------------------------------------------------
-- CREAR BASE DE DATOS Y ESQUEMA
------------------------------------------------
CREATE DATABASE curso_bd;
GO
USE curso_bd;
GO

-- Crear esquema personalizado
CREATE SCHEMA personal;

------------------------------------------------
-- TABLA ALUMNO
------------------------------------------------
CREATE TABLE personal.alumno (
    id_alumno INT IDENTITY PRIMARY KEY,   -- PK autoincremental
    dni INT NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100),
    genero CHAR(1) NOT NULL,
    fecha_nac DATE,
    fec_ult_act DATETIME NULL
);

-- Restricción de unicidad en DNI
ALTER TABLE personal.alumno
    ADD CONSTRAINT uq_alumno_dni UNIQUE(dni);

-- Restricción CHECK en género
ALTER TABLE personal.alumno
    ADD CONSTRAINT ck_alumno_genero CHECK (genero IN ('M','F','O'));

-- Restricción CHECK en fecha de nacimiento (no futura)
ALTER TABLE personal.alumno
    ADD CONSTRAINT ck_alumno_fecha_nac
    CHECK (fecha_nac <= GETDATE());

-- Valor por defecto para fecha de última actualización
ALTER TABLE personal.alumno
    ADD CONSTRAINT df_alumno_fec_ult_act DEFAULT CURRENT_TIMESTAMP FOR fec_ult_act;

------------------------------------------------
-- TABLAS CARRERA Y ASIGNATURA
------------------------------------------------
CREATE TABLE carrera (
    id_carrera INT IDENTITY,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT pk_carrera PRIMARY KEY (id_carrera)
);

CREATE TABLE asignatura (
    id_asignatura INT IDENTITY,
    nombre VARCHAR(150) NOT NULL,
    CONSTRAINT pk_asignatura PRIMARY KEY (id_asignatura)
);
------------------------------------------------
-- Relación N:M entre carrera y asignatura
------------------------------------------------
CREATE TABLE carrera_asignatura (
    id_carrera INT,
    id_asignatura INT,
    CONSTRAINT pk_carrera_asignatura PRIMARY KEY (id_carrera, id_asignatura),
    CONSTRAINT fk_carr_asig_carrera FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera),
    CONSTRAINT fk_carr_asig_asignatura FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura)
);

------------------------------------------------
-- RELACIÓN ALUMNO - CARRERA - ASIGNATURA
------------------------------------------------
CREATE TABLE alumno_asignatura (
    id_alumno INT NOT NULL,
    id_carrera INT NOT NULL,
    id_asignatura INT NOT NULL,
    fecha_alta DATE NOT NULL DEFAULT GETDATE(),
    fec_ult_act DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_alumno_asignatura PRIMARY KEY (id_alumno, id_carrera, id_asignatura),
    CONSTRAINT fk_alumno_asignatura_carrera FOREIGN KEY (id_carrera, id_asignatura) 
        REFERENCES carrera_asignatura(id_carrera, id_asignatura),
    CONSTRAINT fk_alumno_asignatura_alumno FOREIGN KEY (id_alumno) 
        REFERENCES personal.alumno(id_alumno)
);

------------------------------------------------
-- 5. EJEMPLOS DE INSERTS
------------------------------------------------

-- Carrera y asignaturas
INSERT INTO carrera (nombre) VALUES ('Licenciatura en Sistemas');
INSERT INTO asignatura (nombre) VALUES ('Bases de Datos I');
INSERT INTO asignatura (nombre) VALUES ('Algoritmos I');

-- Vincular asignaturas a la carrera
INSERT INTO carrera_asignatura (id_carrera, id_asignatura) VALUES (1,1);
INSERT INTO carrera_asignatura (id_carrera, id_asignatura) VALUES (1,2);

-- Alumnos válidos
INSERT INTO personal.alumno (dni, apellido, nombre, genero, fecha_nac) 
VALUES (12345678, 'perez', 'juan', 'M', '2000-05-20');

INSERT INTO personal.alumno (dni, apellido, nombre, genero, fecha_nac) 
VALUES (87654321, 'gomez', 'maria', 'F', '1999-10-15');

-- Error: dni duplicado (viola UNIQUE)
INSERT INTO personal.alumno (dni, apellido, nombre, genero, fecha_nac) 
VALUES (12345678, 'lopez', 'ana', 'F', '2001-07-01');

-- Error: género inválido (viola CHECK)
INSERT INTO personal.alumno (dni, apellido, nombre, genero, fecha_nac) 
VALUES (11111111, 'torres', 'luis', 'X', '1995-01-01');

-- Error: fecha futura (viola CHECK)
INSERT INTO personal.alumno (dni, apellido, nombre, genero, fecha_nac) 
VALUES (22222222, 'fernandez', 'carla', 'F', '2100-01-01');

-- Inscripción correcta de un alumno en asignaturas
INSERT INTO alumno_asignatura (id_alumno, id_carrera, id_asignatura) VALUES (1,1,1);
INSERT INTO alumno_asignatura (id_alumno, id_carrera, id_asignatura) VALUES (1,1,2);

-- Error: referencia inválida (id_asignatura no existe en carrera_asignatura)
INSERT INTO alumno_asignatura (id_alumno, id_carrera, id_asignatura) VALUES (2,1,99);
