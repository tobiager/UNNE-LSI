+
-- Crear la base de datos
CREATE DATABASE serie2_camiones;

-- Ubicarse en la BD a trabajar
USE serie2_camiones;

-- DDL modelo de datos ---------------------------------------------------------------
-- Definci�n de la estructura de la base de datos
-- todas las restricciones se deben definir usando la instrucci�n CONSTRAINT
-- -------------------------------------------------------------------------------------

-- Tabla marca
CREATE TABLE marca
(
  id_marca INT NOT NULL,
  descripcio VARCHAR(200) NOT NULL,
  CONSTRAINT PK_marca PRIMARY KEY (id_marca)
);

-- Tabla modelo
CREATE TABLE modelo
(
  id_modelo INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  id_marca INT NOT NULL,
  CONSTRAINT PK_modelo PRIMARY KEY (id_modelo, id_marca),
  CONSTRAINT FK_modelo_marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

-- Tabla pais
CREATE TABLE pais
(
  id_pais INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_pais PRIMARY KEY (id_pais)
);

-- Tabla categoria_licencia
CREATE TABLE categoria_licencia
(
  id_categoria_lic INT NOT NULL,
  nombre VARCHAR(10) NOT NULL,
  CONSTRAINT PK_categoria_licencia PRIMARY KEY (id_categoria_lic)
);

-- Tabla camion
CREATE TABLE camion
(
  id_camion INT NOT NULL,
  patente VARCHAR(10) NOT NULL,
  capacidad_max INT NOT NULL,
  id_modelo INT NOT NULL,
  id_marca INT NOT NULL,
  CONSTRAINT PK_camion PRIMARY KEY (id_camion),
  CONSTRAINT FK_camion_modelo FOREIGN KEY (id_modelo, id_marca) REFERENCES modelo(id_modelo, id_marca)
);

-- Tabla provincia
CREATE TABLE provincia
(
  id_provincia INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  id_pais INT NOT NULL,
  CONSTRAINT PK_provincia PRIMARY KEY (id_provincia),
  CONSTRAINT FK_provincia_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

-- Tabla camion_producto
CREATE TABLE camion_producto
(
  id_producto INT NOT NULL,
  id_camion INT NOT NULL,
  CONSTRAINT PK_camion_producto PRIMARY KEY (id_producto, id_camion),
  CONSTRAINT FK_camion_producto_camion FOREIGN KEY (id_camion) REFERENCES camion(id_camion)
);

-- Tabla ciudad
CREATE TABLE ciudad
(
  id_ciudad INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  id_provincia INT NOT NULL,
  CONSTRAINT PK_ciudad PRIMARY KEY (id_ciudad),
  CONSTRAINT FK_ciudad_provincia FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia)
);

-- Tabla sucursal
CREATE TABLE sucursal
(
  id_sucursal INT NOT NULL,
  domicilio VARCHAR(200) NOT NULL,
  id_ciudad INT NOT NULL,
  CONSTRAINT PK_sucursal PRIMARY KEY (id_sucursal),
  CONSTRAINT FK_sucursal_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

-- Tabla camion_sucursal
CREATE TABLE camion_sucursal
(
  id_camion INT NOT NULL,
  id_sucursal INT NOT NULL,
  CONSTRAINT PK_camion_sucursal PRIMARY KEY (id_camion, id_sucursal),
  CONSTRAINT FK_camion_sucursal_camion FOREIGN KEY (id_camion) REFERENCES camion(id_camion),
  CONSTRAINT FK_camion_sucursal_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

-- Tabla chofer
CREATE TABLE chofer
(
  id_chofer INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  dni INT NOT NULL,
  id_sucursal INT NOT NULL,
  id_categoria_lic INT NOT NULL,
  CONSTRAINT PK_chofer PRIMARY KEY (id_chofer),
  CONSTRAINT FK_chofer_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
  CONSTRAINT FK_chofer_categoria_licencia FOREIGN KEY (id_categoria_lic) REFERENCES categoria_licencia(id_categoria_lic)
);

-- Tabla camion_chofer
CREATE TABLE camion_chofer
(
  fecha_asignacion DATE NOT NULL,
  id_camion INT NOT NULL,
  id_chofer INT NOT NULL,
  CONSTRAINT PK_camion_chofer PRIMARY KEY (id_camion, id_chofer),
  CONSTRAINT FK_camion_chofer_camion FOREIGN KEY (id_camion) REFERENCES camion(id_camion),
  CONSTRAINT FK_camion_chofer_chofer FOREIGN KEY (id_chofer) REFERENCES chofer(id_chofer)
);

-- Tabla viaje
-- Tabla de viaje modificada para evitar el error de dupliaci�n de nombres de columnas
-- se mantiene el dise�o extraido del ERDPlus
CREATE TABLE viaje
(
  fecha INT NOT NULL,
  id_viaje INT NOT NULL,
  duracion INT NOT NULL,
  distancia INT NOT NULL,
  peso_transportado INT NOT NULL,
  id_producto INT NOT NULL,
  id_camion_a INT NOT NULL,
  id_sucursal_origen INT NOT NULL,
  id_sucursal_destino INT NOT NULL,
  id_camion_b INT NOT NULL,
  id_chofer INT NOT NULL,
  CONSTRAINT PK_viaje PRIMARY KEY (id_viaje),
  CONSTRAINT FK_viaje_camion_producto FOREIGN KEY (id_producto, id_camion_a) REFERENCES camion_producto(id_producto, id_camion),
  CONSTRAINT FK_viaje_sucursal_origen FOREIGN KEY (id_sucursal_origen) REFERENCES sucursal(id_sucursal),
  CONSTRAINT FK_viaje_sucursal_destino FOREIGN KEY (id_sucursal_destino) REFERENCES sucursal(id_sucursal),
  CONSTRAINT FK_viaje_camion_chofer FOREIGN KEY (id_camion_b, id_chofer) REFERENCES camion_chofer(id_camion, id_chofer)
);


-- -----------------------------
-- Restricciones ---------------
-- -----------------------------

ALTER TABLE viaje
	ADD CONSTRAINT CK_viaje_sucursal_origen_destino
	CHECK (id_sucursal_origen <> id_sucursal_destino);

/*
Sintaxis
ALTER TABLE: Modifica la estructura de la tabla viaje.
ADD CONSTRAINT: A�ade una nueva restricci�n con el nombre CK_viaje_sucursal_origen_destino.
CHECK (id_sucursal_origen <> id_sucursal_destino): 
Verifica que el valor de id_sucursal_origen sea diferente al de id_sucursal_destino, 
evitando as� que un viaje tenga la misma sucursal como origen y destino.
*/

ALTER TABLE chofer
	ADD CONSTRAINT UQ_chofer_dni UNIQUE (dni);
-- UNIQUE (dni): Garantiza que los valores en la columna dni sean �nicos, evitando duplicados.

ALTER TABLE camion_chofer
ADD CONSTRAINT DF_camion_chofer_fecha_asignacion
DEFAULT GETDATE() FOR fecha_asignacion;
-- DEFAULT GETDATE() FOR fecha_asignacion: Establece GETDATE() como valor predeterminado para la columna fecha_asignacion, 
-- insertando la fecha y hora actual del sistema cuando no se proporciona un valor.



-- ---------------------
-- LOTES DE DATOS ------
------------------------

-- Insertar datos en la tabla marca
INSERT INTO marca (id_marca, descripcio) VALUES
(1, 'Mercedes-Benz'),
(2, 'Volvo'),
(3, 'Scania');

-- Insertar datos en la tabla modelo
INSERT INTO modelo (id_modelo, descripcion, id_marca) VALUES
(1, 'Actros', 1),
(2, 'FH16', 2),
(3, 'R-Series', 3);

-- Insertar datos en la tabla pais
INSERT INTO pais (id_pais, nombre) VALUES
(1, 'Argentina'),
(2, 'Brasil'),
(3, 'Chile');

-- Insertar datos en la tabla categoria_licencia
INSERT INTO categoria_licencia (id_categoria_lic, nombre) VALUES
(1, 'C'),
(2, 'CE');

-- Insertar datos en la tabla provincia
INSERT INTO provincia (id_provincia, nombre, id_pais) VALUES
(1, 'Corrientes', 1),
(2, 'Santa Fe', 1),
(3, 'Sao Paulo', 2);

-- Insertar datos en la tabla ciudad
INSERT INTO ciudad (id_ciudad, nombre, id_provincia) VALUES
(1, 'Corrientes', 1),
(2, 'Resistencia', 1),
(3, 'Sao Paulo', 3);

-- Insertar datos en la tabla sucursal
INSERT INTO sucursal (id_sucursal, domicilio, id_ciudad) VALUES
(1, 'Av. Libertad 1234', 1),
(2, 'Calle Falsa 456', 2),
(3, 'Rua Verdadeira 789', 3);

-- Insertar datos en la tabla camion
INSERT INTO camion (id_camion, patente, capacidad_max, id_modelo, id_marca) VALUES
(1, 'ABC123', 20, 1, 1),
(2, 'DEF456', 30, 2, 2),
(3, 'GHI789', 25, 3, 3);

-- Insertar datos en la tabla camion_producto (productos transportados por cada cami�n)
INSERT INTO camion_producto (id_producto, id_camion) VALUES
(1, 1), -- Arena
(2, 2), -- Cemento
(3, 3); -- Piedra

-- Insertar datos en la tabla camion_sucursal
INSERT INTO camion_sucursal (id_camion, id_sucursal) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insertar datos en la tabla chofer
INSERT INTO chofer (id_chofer, nombre, apellido, dni, id_sucursal, id_categoria_lic) VALUES
(1, 'Juan', 'Perez', 12345678, 1, 1),
(2, 'Carlos', 'Gomez', 23456789, 2, 2),
(3, 'Pedro', 'Lopez', 34567890, 3, 2);

-- Insertar datos en la tabla camion_chofer
INSERT INTO camion_chofer (fecha_asignacion, id_camion, id_chofer) VALUES
('20230101', 1, 1),
('20230201', 2, 2),
('20230301', 3, 3);


-- Insertar datos en la tabla viaje
-- Caso consistente
INSERT INTO viaje (fecha, id_viaje, duracion, distancia, peso_transportado, id_producto, id_camion_a, id_sucursal_origen, id_sucursal_destino, id_camion_b, id_chofer) VALUES
(20230901, 1, 2, 500, 15, 1, 1, 1, 2, 1, 1);

-- ------------------------------
-- ATENCI�N ---------------------
-- ------------------------------
-- Caso inconsistente donde se registran camiones diferentes (Error en el dise�o)
INSERT INTO viaje (fecha, id_viaje, duracion, distancia, peso_transportado, id_producto, id_camion_a, id_sucursal_origen, id_sucursal_destino, id_camion_b, id_chofer) VALUES
(20230902, 2, 3, 700, 20, 2, 2, 1, 3, 3, 3); 
-- `id_camion_a` es 2 y `id_camion_b` es 3, lo cual es inconsistente

-- Instrucci�n SELECT que visualiza todos los registros de la tabla
-- verificar la inconsistencia en el segundo registro ingresado en la tabla viaje
SELECT * FROM viaje;

SELECT * FROM marca;
SELECT * FROM modelo;
SELECT * FROM pais;
SELECT * FROM categoria_licencia;
SELECT * FROM camion;
SELECT * FROM provincia;
SELECT * FROM camion_producto;
SELECT * FROM ciudad;
SELECT * FROM sucursal;
SELECT * FROM camion_sucursal;
SELECT * FROM chofer;
SELECT * FROM camion_chofer;

-- ------------------------------------------------------------------------------
-- CORRECCI�N DEL SCRIPT PARA AJUSTAR EL MODELO
-- -----------------------------------------------------------------------------

-- Ajuste del modelo para validar la integridad de los datos
-- Se debe asegurar que sea el mismo cami�n para producto como para chofer

-- Tabla de viaje modificada dejando una sola columna 'id_camion'
CREATE TABLE viaje_nueva
(
  fecha INT NOT NULL,
  id_viaje INT NOT NULL,
  duracion INT NOT NULL,
  distancia INT NOT NULL,
  peso_transportado INT NOT NULL,
  id_producto INT NOT NULL,
  id_camion INT NOT NULL,
  id_sucursal_origen INT NOT NULL,
  id_sucursal_destino INT NOT NULL,
  id_chofer INT NOT NULL,
  CONSTRAINT PK_viaje_nueva PRIMARY KEY (id_viaje),
  CONSTRAINT FK_viaje_nueva_camion_producto FOREIGN KEY (id_producto, id_camion) REFERENCES camion_producto(id_producto, id_camion),
  CONSTRAINT FK_viaje_nuevasucursal_origen FOREIGN KEY (id_sucursal_origen) REFERENCES sucursal(id_sucursal),
  CONSTRAINT FK_viaje_nueva_sucursal_destino FOREIGN KEY (id_sucursal_destino) REFERENCES sucursal(id_sucursal),
  CONSTRAINT FK_viaje_nueva_camion_chofer FOREIGN KEY (id_camion, id_chofer) REFERENCES camion_chofer(id_camion, id_chofer)
);

-- Insertar datos en la tabla viaje_nueva
-- Caso consistente
INSERT INTO viaje_nueva (fecha, id_viaje, duracion, distancia, peso_transportado, id_producto, id_camion, id_sucursal_origen, id_sucursal_destino, id_chofer) VALUES
(20230901, 1, 2, 500, 15, 1, 1, 1, 2, 1);

-- Se verifica que se elimin� la situaci�n de inconistencia
INSERT INTO viaje_nueva (fecha, id_viaje, duracion, distancia, peso_transportado, id_producto, id_camion, id_sucursal_origen, id_sucursal_destino, id_chofer) VALUES
(20230902, 2, 3, 700, 20, 2, 2, 1, 3, 2); 
-- el n�mero de cami�n es igual tanto para producto y chofer


-- SELECT para la tabla viaje_nueva
SELECT * FROM viaje_nueva;


-- -------------------------------------------------------
-- VERIFICACI�N DE RESTRICCIONES DEFAULT, UNIQUE, CHECK --
-- -------------------------------------------------------

-- Insert inv�lido en la tabla viaje (Sucursales de origen y destino son iguales, violando la restricci�n CHECK)
-- error debido a la restricci�n CK_viaje_sucursal_origen_destino
INSERT INTO viaje (fecha, id_viaje, duracion, distancia, peso_transportado, id_producto, id_camion_a, id_sucursal_origen, id_sucursal_destino, id_camion_b, id_chofer)
VALUES (20230912, 3, 3, 600, 20, 2, 2, 1, 1, 2, 2);
-- The INSERT statement conflicted with the CHECK constraint "CK_viaje_sucursal_origen_destino"


-- Insert v�lido en la tabla chofer (DNI �nico)
INSERT INTO chofer (id_chofer, nombre, apellido, dni, id_sucursal, id_categoria_lic)
VALUES (4, 'Luis', 'Martinez', 45678901, 2, 1);

-- Insert inv�lido en la tabla chofer (DNI duplicado, violando la restricci�n UNIQUE)
-- error debido a la restricci�n UQ_chofer_dni
INSERT INTO chofer (id_chofer, nombre, apellido, dni, id_sucursal, id_categoria_lic)
VALUES (5, 'Ana', 'Gonzalez', 45678901, 3, 2);
-- Violation of UNIQUE KEY constraint 'UQ_chofer_dni'. Cannot insert duplicate key in object 'dbo.chofer'.


-- Insert v�lido en la tabla camion_chofer (No se especifica fecha_asignacion, debe tomar la fecha actual por defecto)
INSERT INTO camion_chofer (fecha_asignacion, id_camion, id_chofer)
VALUES (DEFAULT, 2, 1); 
-- Se ejecuta la restricci�n DF_camion_chofer_fecha_asignacion

SELECT * FROM camion_chofer; -- verificar el valor de la fecha generada