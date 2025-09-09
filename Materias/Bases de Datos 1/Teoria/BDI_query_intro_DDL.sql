
/*
	modelo de datos

	Registrar los alumnos por asignatura, una asignatura puede corresponder a varias carreras.
	Un alumno está inscripto en varias asignaturas.
	
*/


SELECT @@VERSION; -- muestra la versión de la instancia del motor de base de datos en la que estamos conectados
-- sp_help
-- CREAR la base de datos
CREATE DATABASE cursoBD2022;
-- DROP DATABASE cursoBD;
-- situarce en la base de datos de trabajo:
GO
USE cursoBD2022;
GO
-- CREAR un esquema dentro de la base de datos
CREATE SCHEMA personal;

-- CREAR la tabla dentro de un esquema específico
CREATE TABLE personal.alumno(
	idAlumno INT IDENTITY PRIMARY KEY,
	dni INT NOT NULL,
	apellido varchar(254),
	nombre varchar(254),
	segundoNombre varchar(254),
	genero varchar(10)
);
-- BORRAR una tabla
  --DROP TABLE alumno;

-- MODIFICAR una tabla
-- AGREGAR una nueva columna
ALTER TABLE personal.alumno
	ADD fecha_nac DATETIME;

-- MODIFICAR una tabla
-- MODIFICAR una columna
ALTER TABLE personal.alumno
	ALTER COLUMN genero CHAR(1) NOT NULL;


-- MODIFICAR una tabla
-- AGREGAR una restricción de unicidad (no controlar la restricción) WITH NOCHECK
ALTER TABLE personal.alumno
	  ADD CONSTRAINT UQ_alumno_dni UNIQUE(dni);

-- MODIFICAR una tabla
-- AGREGAR una restricción de control CHECK
ALTER TABLE personal.alumno
	ADD CONSTRAINT CK_alumno_genero CHECK(genero IN('M','F','O'));

/*
SELECT GETDATE();
SELECT FORMAT(GETDATE(),'yyyyMMdd'); -- muestra la fecha actual del sistema en un formato de fecha corta

-- ISO: yyyymmdd
SELECT CONVERT(VARCHAR(10), getdate(), 112); -- convierte una fecha en un formato dado

SELECT getdate(), DATEADD(day, 1,getdate()); -- modifica una fecha

SELECT CONVERT(date, '12-25-2019'); -- convierte un string en fecha
*/

-- MODIFICAR una tabla
-- AGREGAR una nueva restricción CHECK para controlar la fecha
/*
-- a partir de 2014
ALTER TABLE personal.alumno
	ADD CONSTRAINT CK_alumno_fecha_nac CHECK (FORMAT(fecha_nac,'yyyyMMdd') <= FORMAT(GETDATE(),'yyyyMMdd'));
*/
-- SELECT CONVERT(VARCHAR(10), fecha_nac, 112), CONVERT(VARCHAR(10), getdate(), 112);

-- Utilizo la función CONVERT, cod: 112 = yyyymmdd Fecha en formato ISO
ALTER TABLE personal.alumno
	WITH NOCHECK ADD CONSTRAINT CK_alumno_fecha_nac 
	CHECK (CONVERT(VARCHAR(10), fecha_nac, 112) <= CONVERT(VARCHAR(10), getdate(), 112));

	SELECT getdate();
/*
-- BORRAR una restricción
ALTER TABLE personal.alumno
	DROP CK_alumno_fecha_nac;
*/

-- CREAR un tabla
-- si no se especifica el esquema se crea en el esquema por defectos 'dbo'

CREATE TABLE asignatura(
	idAsignatura INT IDENTITY,
	nombre varchar(254)
);

-- MODIFICAR una tabla
-- AGREGAR una clave primaria
ALTER TABLE asignatura
	ADD CONSTRAINT PK_asignatura PRIMARY KEY (idAsignatura);

	
-- CREAR una tabla
-- usar una restricción en la definición de la tabla
CREATE TABLE carrera(
	idCarrera INT IDENTITY,
	nombre varchar(254),
	CONSTRAINT PK_carrera PRIMARY KEY (idCarrera)
);

-- CREAR una tabla 
-- con clave primaria compuesta
CREATE TABLE carrera_asignatura(
	idCarrera INT,
	idAsignatura INT,
	CONSTRAINT PK_carrera_asignatura PRIMARY KEY (idCarrera,idAsignatura)
);

-- MODIFICAR una tabla
-- AGREGAR una clave foranea
ALTER TABLE carrera_asignatura
	ADD CONSTRAINT FK_carr_asig_carrera FOREIGN KEY (idCarrera) REFERENCES carrera(idCarrera);

-- MODIFICAR una tabla
-- AGREGAR una clave foranea
ALTER TABLE carrera_asignatura
	ADD CONSTRAINT FK_carr_asig_asignatura FOREIGN KEY (idAsignatura) References asignatura(IdAsignatura);

-- CREAR una tabla

CREATE TABLE alumno_asignatura(
	idAlumno INT NOT NULL,
	idCarrera INT NOT NULL,
	idAsignatura INT NOT NULL,
	fechaAlta DATE,
	fecUltAct DATETIME,
	CONSTRAINT PK_alumno_asignatura PRIMARY KEY (idAlumno,idCarrera,idAsignatura),
	CONSTRAINT FK_alumno_asignatura_carrera FOREIGN KEY (idCarrera,idAsignatura) REFERENCES carrera_asignatura(idCarrera,idAsignatura),
	CONSTRAINT FK_alumno_asignatura_alumno FOREIGN KEY (idAlumno) REFERENCES personal.alumno(idAlumno)
);

-- MODIFICAR una tabla
-- AGREGAR un nuevo atributo
ALTER TABLE personal.alumno
	ADD fecUltAct DATETIME NULL;

-- MODIFICAR una tabla
-- AGREGAR una resrticción con un valor por defecto DEFAULT
ALTER TABLE personal.alumno
	ADD CONSTRAINT DF_alumno_fecUltAct DEFAULT CURRENT_TIMESTAMP FOR fecUltAct;

-- DROP TABLE alumno; -- borra la tabla alumno

/*
Genero la entidad asistencia, 
solo como ejemplo, para demostrar una FK a una restricción UNIQUE
*/
CREATE TABLE asistencia(
	idAsistencia INT IDENTITY,
	dia DATETIME,
	idAlumno INT
);

-- referencia a un atributo UNIQUE
ALTER TABLE asistencia
	ADD CONSTRAINT FK_asistencia_alumno FOREIGN KEY (idAlumno) REFERENCES personal.alumno(dni);


---------------------------
-- TRUNCATE ---------------
---------------------------

-- Borrar por completo los datos e información de una tabla

-- TRUNCATE TABLE personal.alumno;

-- En SQL Server es necesario borrar las restricciones FK para poder ejecutar el TRUNCATE
ALTER TABLE alumno_asignatura
	DROP FK_alumno_asignatura_alumno;


	
-- Después de ejecutar el TRUNCATE es necesario volver a establecer las restricciones
ALTER TABLE alumno_asignatura
	ADD CONSTRAINT FK_alumno_asignatura_alumno FOREIGN KEY (idAlumno) REFERENCES personal.alumno(idAlumno);


/*
TRUNCATE TABLE carrera;

ALTER TABLE carrera_asignatura
	DROP FK_carr_asig_carrera;

TRUNCATE TABLE asignatura;
ALTER TABLE carrera_asignatura
	DROP FK_carr_asig_asignatura;

TRUNCATE TABLE carrera_asignatura;
ALTER TABLE carrera_asignatura
	DROP [FK_alumno_asignatura_carrera]


*/