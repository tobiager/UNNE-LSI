CREATE DATABASE ejer7tp2;
USE ejer7tp2;

CREATE TABLE Ciudad
(
  id_ciudad INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_ciudad PRIMARY KEY (id_ciudad)
);

CREATE TABLE Vendedor
(
  id_vendedor INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_vendedor PRIMARY KEY (id_vendedor)
);

CREATE TABLE Rubro
(
  id_rubro INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  CONSTRAINT PK_rubro PRIMARY KEY (id_rubro)
);

CREATE TABLE Proveedor
(
  id_proveedor INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_proveedor PRIMARY KEY (id_proveedor)
);

CREATE TABLE Medios_Pagos
(
  id_medio_pago INT NOT NULL,
  tipo VARCHAR(100) NOT NULL,
  CONSTRAINT PK_medios_pagos PRIMARY KEY (id_medio_pago)
);

CREATE TABLE Sucursal
(
  id_sucursal INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  id_ciudad INT NOT NULL,
  CONSTRAINT PK_sucursal PRIMARY KEY (id_sucursal),
  CONSTRAINT FK_sucrusal_id_ciudad FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Articulo
(
  id_articulo INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  stock INT NOT NULL,
  id_proveedor INT NOT NULL,
  id_rubro INT NOT NULL,
  CONSTRAINT PK_articulo PRIMARY KEY (id_articulo),
  CONSTRAINT FK_articulo_id_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
  CONSTRAINT FK_articulo_id_rubro FOREIGN KEY (id_rubro) REFERENCES Rubro(id_rubro)
);

CREATE TABLE Ticket
(
  id_ticket INT NOT NULL,
  fecha DATE NOT NULL,
  id_medio_pago INT NOT NULL,
  id_vendedor INT NOT NULL,
  id_sucursal INT NOT NULL,
  CONSTRAINT PK_ticket_id_ticket PRIMARY KEY (id_ticket),
  CONSTRAINT FK_ticket_id_medio_pago FOREIGN KEY (id_medio_pago) REFERENCES Medios_Pagos(id_medio_pago),
  CONSTRAINT FK_ticket_id_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
  CONSTRAINT FK_ticket_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal)
);

CREATE TABLE Ticket_Linea
(
  cantidad_vendidad INT NOT NULL,
  subtotal INT NOT NULL,
  precio_unitario INT NOT NULL,
  id_ticket_linea INT NOT NULL,
  id_articulo INT NOT NULL,
  id_ticket INT NOT NULL,
  CONSTRAINT PK_ticket_linea_id_ticket_linea PRIMARY KEY (id_ticket_linea),
  CONSTRAINT FK_ticket_linea_id_ticket FOREIGN KEY (id_ticket) REFERENCES Ticket(id_ticket),
  CONSTRAINT FK_ticket_linea_id_articulo FOREIGN KEY (id_articulo) REFERENCES Articulo(id_articulo)
);

ALTER TABLE Rubro ADD CONSTRAINT CK_rubro_descripcion CHECK (descripcion IN ('Perfumeria', 'Lacteos', 'Cotillon', 'Jugueteria', 'Lacteos', 'Remedios', 'Gaseosa'))
ALTER TABLE Ticket ADD CONSTRAINT DF_ticket_fecha DEFAULT GETDATE() FOR fecha;
ALTER TABLE Sucursal ADD CONSTRAINT UQ_sucursal_nombre UNIQUE (nombre);



--Lote de datos

-- Insertar datos en la tabla Ciudad
INSERT INTO Ciudad (id_ciudad, nombre) VALUES 
(1, 'Buenos Aires'),
(2, 'Córdoba'),
(3, 'Rosario');

-- Insertar datos en la tabla Vendedor
INSERT INTO Vendedor (id_vendedor, nombre) VALUES 
(1, 'Juan Pérez'),
(2, 'María López'),
(3, 'Carlos García');

-- Insertar datos en la tabla Rubro
INSERT INTO Rubro (id_rubro, descripcion) VALUES 
(1, 'Perfumeria'),
(2, 'Lacteos'),
(3, 'Cotillon');

-- Insertar datos en la tabla Proveedor
INSERT INTO Proveedor (id_proveedor, nombre) VALUES 
(1, 'Proveedor A'),
(2, 'Proveedor B'),
(3, 'Proveedor C');

-- Insertar datos en la tabla Medios_Pagos
INSERT INTO Medios_Pagos (id_medio_pago, tipo) VALUES 
(1, 'Efectivo'),
(2, 'Tarjeta de Crédito'),
(3, 'Tarjeta de Débito');

-- Insertar datos en la tabla Sucursal
INSERT INTO Sucursal (id_sucursal, nombre, id_ciudad) VALUES 
(1, 'Sucursal Centro', 1),
(2, 'Sucursal Norte', 2),
(3, 'Sucursal Sur', 3);

-- Insertar datos en la tabla Articulo
INSERT INTO Articulo (id_articulo, nombre, stock, id_proveedor, id_rubro) VALUES 
(1, 'Perfume X', 100, 1, 1),
(2, 'Leche Y', 200, 2, 2),
(3, 'Globo Z', 300, 3, 3);

-- Insertar datos en la tabla Ticket
INSERT INTO Ticket (id_ticket, fecha, id_medio_pago, id_vendedor, id_sucursal) VALUES 
(1, GETDATE(), 1, 1, 1),
(2, GETDATE(), 2, 2, 2),
(3, GETDATE(), 3, 3, 3);

-- Insertar datos en la tabla Ticket_Linea
INSERT INTO Ticket_Linea (id_ticket_linea, cantidad_vendidad, subtotal, precio_unitario, id_articulo, id_ticket) VALUES 
(1, 2, 200, 100, 1, 1),
(2, 3, 300, 100, 2, 2),
(3, 4, 400, 100, 3, 3);

-- Consultar datos de la tabla Ciudad
SELECT * FROM Ciudad;

-- Consultar datos de la tabla Vendedor
SELECT * FROM Vendedor;

-- Consultar datos de la tabla Rubro
SELECT * FROM Rubro;

-- Consultar datos de la tabla Proveedor
SELECT * FROM Proveedor;

-- Consultar datos de la tabla Medios_Pagos
SELECT * FROM Medios_Pagos;

-- Consultar datos de la tabla Sucursal
SELECT * FROM Sucursal;

-- Consultar datos de la tabla Articulo
SELECT * FROM Articulo;

-- Consultar datos de la tabla Ticket
SELECT * FROM Ticket;

-- Consultar datos de la tabla Ticket_Linea
SELECT * FROM Ticket_Linea;


--Prueba error ciudad
-- Insertar datos en la tabla Sucursal
INSERT INTO Sucursal (id_sucursal, nombre, id_ciudad) VALUES 
(1, 'Sucursal Centro', 5),
(2, 'Sucursal Norte', 6),
(3, 'Sucursal Sur', 7);

-- Insertar datos en la tabla Rubro
INSERT INTO Rubro (id_rubro, descripcion) VALUES 
(4, 'Perfumeria'); 