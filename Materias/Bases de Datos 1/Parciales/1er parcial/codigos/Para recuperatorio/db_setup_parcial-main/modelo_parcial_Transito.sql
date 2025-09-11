CREATE DATABASE modelo_parcial_Trancito;
GO
USE modelo_parcial_Trancito;
GO

CREATE TABLE Inspector
(
  id_inspector INT NOT NULL,
  nombre_inspector VARCHAR(50) NOT NULL,
  apellido_inspector VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Inspector_id PRIMARY KEY (id_inspector)
);

CREATE TABLE Pais
(
  id_pais INT NOT NULL,
  nombre_pais VARCHAR(30) NOT NULL,
  CONSTRAINT PK_Pais_id PRIMARY KEY (id_pais)
);

CREATE TABLE Provincia
(
  id_provincia INT NOT NULL,
  nombre_provincia VARCHAR(50) NOT NULL,
  id_pais INT NOT NULL,
  CONSTRAINT PK_Provincia_id PRIMARY KEY (id_provincia),
  CONSTRAINT FK_Provincia_id_pais FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)
);

CREATE TABLE Localidad
(
  id_localidad INT NOT NULL,
  nombre_localidad VARCHAR(50) NOT NULL,
  id_provincia INT NOT NULL,
  CONSTRAINT PK_Localidad_id PRIMARY KEY (id_localidad),
  CONSTRAINT FK_Localidad_id_provincia FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

CREATE TABLE Conductor
(
  id_conductor INT NOT NULL,
  nombre_conductor VARCHAR(50) NOT NULL,
  apellido_conductor VARCHAR(50) NOT NULL,
  dni_conductor CHAR(8) NOT NULL,
  domicilio_conductor VARCHAR(50) NOT NULL,
  CONSTRAINT PK_Conductor_id PRIMARY KEY (id_conductor),
  CONSTRAINT UQ_Conductor_dni UNIQUE (dni_conductor)
);

CREATE TABLE Vehiculo
(
  id_vehiculo INT NOT NULL,
  patente_vehiculo VARCHAR(11) NOT NULL,
  marca_vehiculo VARCHAR(15) NOT NULL,
  modelo_vehiculo DATE NOT NULL,
  añoFabricacion_vehiculo DATE NOT NULL,
  nroChasis_vehiculo VARCHAR(15) NOT NULL,
  id_conductor INT NOT NULL,
  CONSTRAINT PK_Vehiculo_id PRIMARY KEY (id_vehiculo),
  CONSTRAINT FK_Vehiculo_id_conductor FOREIGN KEY (id_conductor) REFERENCES Conductor(id_conductor),
  CONSTRAINT UQ_Vehiculo_patente UNIQUE (patente_vehiculo)
);

CREATE TABLE Carnet_Conductor
(
  id_carnetConduc INT NOT NULL,
  nro_carnet INT NOT NULL,
  id_localidad INT NOT NULL,
  id_conductor INT NOT NULL,
  CONSTRAINT PK_Cartent_Conductor_id PRIMARY KEY (id_carnetConduc),
  CONSTRAINT FK_Cartent_Conductor_localidad FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad),
  CONSTRAINT FK_Cartent_Conductor_id_conductor FOREIGN KEY (id_conductor) REFERENCES Conductor(id_conductor)
);

CREATE TABLE Tarjeta_Seguro
(
  id_tarjetaSeguro INT NOT NULL,
  nro_poliza_seguro INT NOT NULL,
  vencimiento_seguro DATE NOT NULL,
  monto_seguro FLOAT NOT NULL,
  empresa_seguro VARCHAR(50) NOT NULL,
  id_vehiculo INT NOT NULL,
  CONSTRAINT PK_Tarjeta_Seguro_id PRIMARY KEY (id_tarjetaSeguro),
  CONSTRAINT FK_Tarjeta_Seguro_id_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo)
);

CREATE TABLE Acta
(
  id_acta INT NOT NULL,
  id_carnetConduc INT NOT NULL,
  id_tarjetaVerde INT NOT NULL,
  id_tarjetaSeguro INT NOT NULL,
  id_inspector INT NOT NULL,
  CONSTRAINT PK_Acta_id PRIMARY KEY (id_acta),
  CONSTRAINT FK_Acta_id_carnetConductor FOREIGN KEY (id_carnetConduc) REFERENCES Carnet_Conductor(id_carnetConduc),
  CONSTRAINT FK_Acta_id_tarjetaVerde FOREIGN KEY (id_tarjetaVerde) REFERENCES Vehiculo(id_vehiculo),
  CONSTRAINT FK_Acta_id_tarjetaSeguro FOREIGN KEY (id_tarjetaSeguro) REFERENCES Tarjeta_Seguro(id_tarjetaSeguro),
  CONSTRAINT FK_Acta_id_inspector FOREIGN KEY (id_inspector) REFERENCES Inspector(id_inspector)
);

CREATE TABLE Infraccion
(
  id_infraccion INT NOT NULL,
  fecha_infraccion DATE NOT NULL,
  lugar_infraccion VARCHAR(50) NOT NULL,
  descripcion_infraccion VARCHAR(70) NOT NULL,
  id_acta INT NOT NULL,
  CONSTRAINT PK_Infraccion_id PRIMARY KEY (id_infraccion),
  CONSTRAINT FK_Infraccion_id_acta FOREIGN KEY (id_acta) REFERENCES Acta(id_acta)
);

CREATE TABLE Descripcion_Infraccion
(
  id_descripInfraccion INT NOT NULL,
  importeaPagar_descripInfraccion FLOAT NOT NULL,
  fechaVencimiento_descripInfraccion DATE NOT NULL,
  id_infraccion INT NOT NULL,
  CONSTRAINT PK_Descripcion_Infraccion_id PRIMARY KEY (id_descripInfraccion),
  CONSTRAINT FK_Descripcion_Infraccion_id_infraccion FOREIGN KEY (id_infraccion) REFERENCES Infraccion(id_infraccion)
);

-----------------------
-- VARIANTES ----------
-----------------------

CREATE TABLE Pago_Acta (
id_pagoActa INT NOT NULL,
fecha_pagoActa DATE NOT NULL,
montoAbonado_pagoActa INT NOT NULL,
id_infraccion INT NOT NULL,
id_conductor INT NOT NULL,
CONSTRAINT PK_Pago_Acto_id PRIMARY KEY (id_pagoActa),
CONSTRAINT FK_Pago_Acto_id_infraccion FOREIGN KEY (id_infraccion) REFERENCES Infraccion(id_infraccion),
CONSTRAINT FK_Pago_Acto_id_conductor FOREIGN KEY (id_conductor) REFERENCES Conductor(id_conductor)
);


-- ----------------------
-- Restricciones --------
-- ----------------------

ALTER TABLE Conductor
ADD CONSTRAINT CK_NroDoc_Long 
CHECK (LEN(dni_conductor) = 8 AND ISNUMERIC(dni_conductor) = 1);


-- ---------------------
-- LOTES DE DATOS ------
------------------------

SELECT * FROM Inspector;
INSERT INTO Inspector (id_inspector, nombre_inspector, apellido_inspector)
VALUES (1, 'Juan', 'Pérez'), (2, 'María', 'Gómez'), (3, 'Carlos', 'López');

SELECT * FROM Pais;
INSERT INTO Pais (id_pais, nombre_pais)
VALUES (1, 'Argentina'), (2, 'Brasil'), (3, 'Chile');

SELECT * FROM Provincia;
INSERT INTO Provincia (id_provincia, nombre_provincia, id_pais)
VALUES (1, 'Santa Fe', 1), (2, 'Buenos Aires', 1), (3, 'São Paulo', 2);

SELECT * FROM Localidad;
INSERT INTO Localidad (id_localidad, nombre_localidad, id_provincia)
VALUES (1, 'Rosario', 1), (2, 'Cañada de Gómez', 1), (3, 'Campinas', 3);

SELECT * FROM Conductor;
INSERT INTO Conductor (id_conductor, nombre_conductor, apellido_conductor, dni_conductor, domicilio_conductor)
VALUES (1, 'Ana', 'Martínez', '12345678', 'Calle Falsa 123'),
(2, 'Luis', 'Rodríguez', '87654321', 'Avenida Siempre Viva 742'),
(3, 'Sofía', 'Fernández', '11223344', 'Boulevard de los Sueños 456');

SELECT * FROM Vehiculo;
INSERT INTO Vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, añoFabricacion_vehiculo, nroChasis_vehiculo, id_conductor)
VALUES 
(1, 'ABC123', 'Toyota', '2020-01-01', '2019-01-01', '123456', 1),
(2, 'DEF456', 'Ford', '2021-01-01', '2020-01-01', '654321', 2),
(3, 'GHI789', 'Chevrolet', '2019-01-01', '2018-01-01', '789012', 3);

SELECT * FROM Carnet_Conductor;
INSERT INTO Carnet_Conductor (id_carnetConduc, nro_carnet, id_localidad, id_conductor)
VALUES (1, 1001, 1, 1), (2, 1002, 2, 2), (3, 1003, 3, 3);

SELECT * FROM Tarjeta_Seguro;
INSERT INTO Tarjeta_Seguro (id_tarjetaSeguro, nro_poliza_seguro, vencimiento_seguro, monto_seguro, empresa_seguro, id_vehiculo)
VALUES 
(1, 2001, '2025-01-01', 15000.50, 'Seguro S.A.', 1),
(2, 2002, '2024-12-31', 12000.75, 'Protección Total', 2),
(3, 2003, '2025-06-30', 18000.00, 'Aseguradora Global', 3);

SELECT * FROM Acta;
INSERT INTO Acta (id_acta, id_carnetConduc, id_tarjetaVerde, id_tarjetaSeguro, id_inspector)
VALUES 
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 1, 2, 3, 1),
(5, 2, 3, 1, 2),
(6, 3, 1, 2, 3);

SELECT * FROM Infraccion;
INSERT INTO Infraccion (id_infraccion, fecha_infraccion, lugar_infraccion, descripcion_infraccion, id_acta)
VALUES 
(1, '2024-09-01', 'Calle Principal', 'Exceso de velocidad', 1),
(2, '2024-09-05', 'Avenida Central', 'Estacionamiento indebido', 2),
(3, '2024-09-10', 'Boulevard Norte', 'Conducción temeraria', 3);

SELECT * FROM Descripcion_Infraccion;
INSERT INTO Descripcion_Infraccion (id_descripInfraccion, importeaPagar_descripInfraccion, fechaVencimiento_descripInfraccion, id_infraccion)
VALUES 
(1, 5000.00, '2024-10-01', 1),
(2, 3000.00, '2024-10-05', 2),
(3, 7000.00, '2024-10-10', 3);


---- Validacion de restricciones

---- Salta la restrinccion de UQ_DNI
INSERT INTO Conductor (id_conductor, nombre_conductor, apellido_conductor, dni_conductor, domicilio_conductor)
VALUES (4, 'Juana', 'Tartínez', '12345678', 'Calle Falsa 321');

--- Salta la restrinccion de CK_LEN_DNI
INSERT INTO Conductor (id_conductor, nombre_conductor, apellido_conductor, dni_conductor, domicilio_conductor)
VALUES (5, 'Juana', 'Tartínez', '12345678910', 'Calle Falsa 321');

---- Salta la restriccion de UQ_patente
INSERT INTO Vehiculo (id_vehiculo, patente_vehiculo, marca_vehiculo, modelo_vehiculo, añoFabricacion_vehiculo, nroChasis_vehiculo, id_conductor)
VALUES (4, 'ABC123', 'Fiat', '2020-01-01', '2019-01-01', '123456', 1);


