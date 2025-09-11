/*
SCRIPT para mostrar el manejo de las restricciones
*/

CREATE DATABASE ejercicio_test;

USE ejercicio_test;

/*
-- ------------------------
-- Script según ERDplus
-- ------------------------

CREATE TABLE persona
(
  dni INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  email VARCHAR(200) NOT NULL,
  fecha_nacimiento DATE,
  date_create DATE,
  user_create INT NOT NULL,
  domicilio VARCHAR(200),
  PRIMARY KEY (dni),
  UNIQUE (email)
);
*/
-- DROP TABLE persona;
-- DROP TABLE ciudad;

-- ------------------------
-- Script según ERDplus
-- Cración de la tabla sin realizar modificaciones
-- Observar los nombres de las claves (Key) y restricciones (Constraint)
-- ------------------------
CREATE TABLE persona_erdplus
(
  dni INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  email VARCHAR(200) NOT NULL,
  fecha_nacimiento DATE,
  date_create DATE,
  user_create INT NOT NULL,
  domicilio VARCHAR(200),
  PRIMARY KEY (dni),
  UNIQUE (email)
);

-- Uso de la cláusulo CONSTRAINT para manejar los nombres de las restricciones
CREATE TABLE persona(
	dni INT NOT NULL,
	nombre varchar(200), 
	email varchar(200),
	fecha_nacimiento DATE NULL,
	domicilio VARCHAR(200) NULL,
	date_create DATE,
	user_create INT NOT NULL,
	CONSTRAINT PK_persona PRIMARY KEY (dni)
);

-- ALTER TABLE persona
-- ADD CONSTRAINT PK_persona PRIMARY KEY (dni);

ALTER TABLE persona
	ADD CONSTRAINT UQ_persona_email UNIQUE(email);

ALTER TABLE persona
	ADD CONSTRAINT CK_persona_fecha CHECK (DATEDIFF(YY,fecha_nacimiento,getdate())<100);

ALTER TABLE persona
	ADD CONSTRAINT DF_persona_fecha_nac DEFAULT getdate() FOR fecha_nacimiento;

-- La función getdate() muestra la fecha actual
SELECT getdate(); 

-- DATEDIFF muestra la diferencia entre dos fechas según el intervalo establecido (años, meses, días ...)
-- Este ejemplo muestra el funcionamiento de DATEDIFF, para calcular la edad con una fecha específica
-- '1981-03-20'
SELECT DATEDIFF(YY,'1981-03-20',getdate()) as 'EDAD';


CREATE TABLE ciudad(
	id INT IDENTITY, -- incremental IDENTITY(1000,2)
	nombre varchar(200),
	CONSTRAINT PK_ciudad PRIMARY KEY (id)
);


ALTER TABLE persona
	ADD ciudad_id INT NULL;

ALTER TABLE persona
	ADD CONSTRAINT FK_persona_ciudad FOREIGN KEY (ciudad_id) REFERENCES ciudad(id);


-- Muestra el funcionamiento de DATEDIFF, para calcular la edad con una fecha específica
-- '1981-03-20'
SELECT DATEDIFF(YY,'1981-03-20',getdate()) as 'EDAD';


SELECT * FROM dbo.persona;
SELECT * FROM dbo.ciudad;


-- 3. Insertar algunos datos en la tabla ciudad
INSERT INTO ciudad (nombre) VALUES ('Buenos Aires');
INSERT INTO ciudad (nombre) VALUES ('Córdoba');
INSERT INTO ciudad (nombre) VALUES ('Rosario');

-- Para demostrar el funcionamiento del IDENTITY creo una restricción
ALTER TABLE ciudad
	ADD CONSTRAINT UQ_ciudad_nombre UNIQUE(nombre);

INSERT INTO ciudad (nombre) VALUES ('Córdoba'); -- fallido
INSERT INTO ciudad (nombre) VALUES ('Rosario'); -- fallido

INSERT INTO ciudad (nombre) VALUES ('Corrientes'); -- observar que pasa con el incremental
INSERT INTO ciudad (nombre) VALUES ('Resistencia');

SELECT * FROM dbo.ciudad order by id;
SELECT * FROM dbo.persona;

-- Insertar datos en la tabla persona
-- Inserción exitosa con datos completos y ciudad referenciada
INSERT INTO persona (dni, nombre, email, fecha_nacimiento, domicilio, date_create, user_create, ciudad_id)
VALUES (12345678, 'Juan Perez', 'juan.perez@example.com', '1985-05-15', 'Calle Falsa 123', GETDATE(), 1, 1);

-- Inserción con valores nulos permitidos
INSERT INTO persona (dni, nombre, email, fecha_nacimiento, domicilio, date_create, user_create, ciudad_id)
VALUES (87654321, 'Ana Gomez', NULL, NULL, NULL, GETDATE(), 2, 2);

-- Inserción con fecha de nacimiento automáticamente asignada por la restricción DEFAULT
INSERT INTO persona (dni, nombre, email, domicilio, date_create, user_create, ciudad_id)
VALUES (56789012, 'Carlos López', 'carlos.lopez@example.com', 'Calle Verdadera 456', GETDATE(), 3, 3);

-- Inserción fallida por violación de la restricción de email único
INSERT INTO persona (dni, nombre, email, fecha_nacimiento, domicilio, date_create, user_create, ciudad_id)
 VALUES (34567890, 'Laura Fernández', 'juan.perez@example.com', '1990-02-20', 'Otra Calle 789', GETDATE(), 4, 1);

-- Inserción fallida por violación de la restricción de fecha de nacimiento (mayor de 100 años)
INSERT INTO persona (dni, nombre, email, fecha_nacimiento, domicilio, date_create, user_create, ciudad_id)
 VALUES (23456789, 'Marta Suarez', 'marta.suarez@example.com', '1900-01-01', 'Calle Vieja 321', GETDATE(), 5, 2);

 -- Inserción fallida por violación de la restricción de clave foránea (FOREIGN KEY) 
 INSERT INTO persona (dni, nombre, email, fecha_nacimiento, domicilio, date_create, user_create, ciudad_id)
VALUES (12345679, 'Juan Perez', 'juan.pere9z@example.com', '1985-05-15', 'Calle Falsa 123', GETDATE(), 1, 10);



-- ---------------------------
-- Tratamiento de valores NULL
-- ---------------------------

-- Esta consulta muestra todos los registros,
-- observar la presencia de valores 'null' en algunas columnas
SELECT dni, nombre, email, fecha_nacimiento, domicilio  FROM dbo.persona;

-- La función ISNULL(), permite tratar los valores 'null' de una columna
-- al realizarse una consulta identifica un valor 'null' y le asigna al resultado otro valor dado
-- esto no modifica los valores almacenados
SELECT dni, nombre, ISNULL(email,'-- Sin EMAIL --') AS 'Correo electrónico', fecha_nacimiento, ISNULL(domicilio,'-- Sin domicilio --') as 'domicilio' 
FROM dbo.persona;

-- No se puede comparar directamente valores 'null' con los operadores de comparación =, <> ...
-- esta consulta devuelve vacío, ningún valor es igual a 'null'
-- 'null' representa la ausencia de valor, no un valor específico
SELECT dni, nombre, email, fecha_nacimiento, domicilio  
FROM dbo.persona 
WHERE email = null;

-- Para buscar/seleccionar filas con columnas que tengan valores 'null'
-- es necesario utilizar el operador IS o su negación IS NOT
SELECT dni, nombre, email, fecha_nacimiento, domicilio  
FROM dbo.persona 
WHERE email IS null; -- WHERE email IS NOT null;