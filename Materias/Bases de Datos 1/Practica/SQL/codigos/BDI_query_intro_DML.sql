
USE cursoBD2022;
/*---------------------------------------------------*/
-- Breve introducción a sentencias DML ---------------------
/*---------------------------------------------------*/


SELECT dni, apellido FROM personal.alumno; -- Consulta de proyeccción

SELECT * FROM personal.alumno WHERE dni = '22222222'; -- Consulta de selección

SELECT dni, apellido, nombre FROM personal.alumno AS al WHERE idAlumno = 1; 

-- Consulta de combinación (JOIN)
-------------------------------------------------------
SELECT *
FROM carrera_asignatura ca
INNER JOIN asignatura a ON ca.idAsignatura = ca.idAsignatura
INNER JOIN carrera c ON ca.idCarrera = c.idCarrera
WHERE a.nombre LIKE 'Base de Datos I';
------------------------------------------------------------



/*
	Estructura de una sentencia SELECT (ver presentación)
*/


-- Consultas a las vistas (VIEW) de la base de datos creada
-- Diccionario de datos
 
SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM [INFORMATION_SCHEMA].[COLUMNS]
WHERE TABLE_NAME = 'alumno';

SELECT isc.TABLE_SCHEMA, isc.TABLE_NAME FROM [INFORMATION_SCHEMA].[COLUMNS] AS isc
WHERE TABLE_NAME = 'alumno';


---------------------------------------
-- INSERT -----------------------------
---------------------------------------

-- INSERTAR datos en la tabla

INSERT INTO personal.alumno(dni, apellido, nombre, segundoNombre, genero, fecha_nac, fecUltAct) 
VALUES (11111111,'Apellido Alumno 1', 'Nombre Alumno 1', 'Segundo Nombre Alumno 1','F','1994-14-09', '20200930');

SELECT * FROM personal.alumno;

-- Verifico que permita NULL el campo 'segundoNombre' y 'fecUltAct'
-- no incluyo los campos en el listado
INSERT INTO personal.alumno(dni, apellido, nombre, genero,fecha_nac) 
VALUES (22222222,'Apellido Alumno 2', 'Nombre Alumno 2','M','19900918');

-- incluyo los campos en el listado pero especifico NULL en la posición correspondiente
INSERT INTO personal.alumno(dni, apellido, nombre, segundoNombre, genero, fecha_nac, fecUltAct) 
VALUES (22222225,'Apellido Alumno 25', 'Nombre Alumno 25', NULL,'M','1994-14-09', NULL);


-- INSERT sin incluir la lista de campos
-- es necesario especificar todos los valores en la posición que ocupan en la tabla
INSERT INTO personal.alumno 
VALUES (33333333,'Apellido Alumno 3', 'Nombre Alumno 3',NULL,'M','19940816',NULL);
SELECT * FROM personal.alumno;

-- Verifico el UNIQUE en el campo 'dni'
-- agrego el DNI 22222222
-- luego cambio por 22222223
INSERT INTO personal.alumno(dni, apellido, nombre, genero, fecha_nac) 
VALUES (22222223,'Apellido Alumno 4', 'Nombre Alumno 4','F','19910728');

SELECT * FROM personal.alumno;

-- Verifico el CHECK en el campo 'fecha_nac'
INSERT INTO personal.alumno(dni, apellido, nombre, genero,fecha_nac) 
VALUES (33333335,'Apellido Alumno 5', 'Nombre Alumno 5','M','2020-30-09');


SELECT ISDATE ('2020-09-30');
-- devuelve:
-- 1 si es el formato correcto
-- 0 si es el incorrecto

 -- SET DATEFORMAT ymd
 
----------------------------
-- UPDATE ------------------
----------------------------

SELECT * FROM personal.alumno WHERE idAlumno = 6;

UPDATE personal.alumno
SET nombre = 'Nombre 4444-4444'
WHERE idAlumno = 6;

----------------------------
-- DELETE ------------------
----------------------------

DELETE 
FROM personal.alumno 
WHERE idAlumno = 1;


-- sp_help;

-- Tabla asignatura
INSERT INTO asignatura (nombre) VALUES ('Bases de Datos I');
INSERT INTO asignatura (nombre) VALUES ('Taller de Programación II');
INSERT INTO asignatura (nombre) VALUES ('Matemática I');
INSERT INTO asignatura (nombre) VALUES ('Álgebra Lineal');

SELECT * FROM asignatura;

-- Tabla carrera
INSERT INTO carrera (nombre) VALUES ('Lic. en Sistemas de Información');
INSERT INTO carrera (nombre) VALUES ('Lic. en Cs Matemáticas');

SELECT * FROM carrera;

-- Tabla carrera_asignatura
INSERT INTO carrera_asignatura (idCarrera, idAsignatura) VALUES (1,1);
INSERT INTO carrera_asignatura (idCarrera, idAsignatura) VALUES (1,2);
INSERT INTO carrera_asignatura (idCarrera, idAsignatura) VALUES (1,3);
INSERT INTO carrera_asignatura (idCarrera, idAsignatura) VALUES (2,3);
INSERT INTO carrera_asignatura (idCarrera, idAsignatura) VALUES (2,4);

SELECT * FROM carrera_asignatura;


-- Insertar datos desde otra tabla
-- Crear primero la tabla 'pruebatabla'
INSERT INTO pruebatabla SELECT * FROM personal.alumno;

-- Crea una tabla desde otra ya existente
-- Este método no copia índices, keys, etc...
SELECT * INTO pruebatabla2 FROM personal.alumno;