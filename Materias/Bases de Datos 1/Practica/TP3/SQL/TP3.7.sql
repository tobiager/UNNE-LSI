-- Crear la base de datos
CREATE DATABASE ejer7_tp3;
GO

-- Usar la base de datos
USE ejer7_tp3;
GO

-- Tabla sucursal
CREATE TABLE sucursal (
  id_sucursal INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  ciudad VARCHAR(120) NOT NULL,
  PRIMARY KEY (id_sucursal)
);

-- Tabla vendedor
CREATE TABLE vendedor (
  id_vendedor INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  id_sucursal INT NOT NULL,
  PRIMARY KEY (id_vendedor),
  FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

-- Tabla metodo_pago
CREATE TABLE metodo_pago (
  id_metodo INT NOT NULL,
  descripcion VARCHAR(80) NOT NULL,
  PRIMARY KEY (id_metodo)
);

-- Tabla ticket
CREATE TABLE ticket (
  id_ticket INT NOT NULL,
  fecha DATE NOT NULL,
  id_vendedor INT NOT NULL,
  id_metodo INT NOT NULL,
  id_sucursal INT NOT NULL,
  PRIMARY KEY (id_ticket),
  FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor),
  FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo),
  FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

-- Tabla rubro
CREATE TABLE rubro (
  id_rubro INT NOT NULL,
  descripcion VARCHAR(80) NOT NULL,
  PRIMARY KEY (id_rubro)
);

-- Tabla proveedor
CREATE TABLE proveedor (
  id_proveedor INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  telefono VARCHAR(30),
  direccion VARCHAR(180),
  PRIMARY KEY (id_proveedor)
);

-- Tabla articulo
CREATE TABLE articulo (
  codigo_articulo INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  stock INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  id_rubro INT NOT NULL,
  id_proveedor INT NOT NULL,
  PRIMARY KEY (codigo_articulo),
  FOREIGN KEY (id_rubro) REFERENCES rubro(id_rubro),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- Tabla linea_ticket (corregida)
CREATE TABLE linea_ticket (
  id_ticket INT NOT NULL,
  codigo_articulo INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  precio_total DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_ticket, codigo_articulo),
  FOREIGN KEY (id_ticket) REFERENCES ticket(id_ticket),
  FOREIGN KEY (codigo_articulo) REFERENCES articulo(codigo_articulo)
);
