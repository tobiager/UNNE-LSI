CREATE DATABASE ejer1_tp3;
GO

CREATE TABLE cliente (
  codigo_cliente INT NOT NULL,
  nombre_cliente VARCHAR(100) NOT NULL,
  PRIMARY KEY (codigo_cliente)
);

CREATE TABLE articulo (
  codigo_articulo INT NOT NULL,
  nombre_articulo VARCHAR(100) NOT NULL,
  PRIMARY KEY (codigo_articulo)
);

CREATE TABLE provincia (
  codigo_provincia INT NOT NULL,
  nombre_provincia VARCHAR(100) NOT NULL,
  PRIMARY KEY (codigo_provincia)
);

CREATE TABLE localidad (
  codigo_localidad VARCHAR(20) NOT NULL,
  nombre_localidad VARCHAR(100) NOT NULL,
  codigo_provincia INT NOT NULL,
  PRIMARY KEY (codigo_localidad),
  FOREIGN KEY (codigo_provincia) REFERENCES provincia(codigo_provincia)
);

CREATE TABLE domicilio (
  codigo_domicilio INT NOT NULL,
  calle VARCHAR(100) NOT NULL,
  numero VARCHAR(10),
  codigo_cliente INT NOT NULL,
  codigo_localidad VARCHAR(20) NOT NULL,
  PRIMARY KEY (codigo_domicilio),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente),
  FOREIGN KEY (codigo_localidad) REFERENCES localidad(codigo_localidad)
);

CREATE TABLE orden (
  codigo_orden INT NOT NULL,
  fecha_salida DATE NOT NULL,
  codigo_cliente INT NOT NULL,
  codigo_domicilio INT NOT NULL,
  PRIMARY KEY (codigo_orden),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente),
  FOREIGN KEY (codigo_domicilio) REFERENCES domicilio(codigo_domicilio)
);

CREATE TABLE detalle_orden (
  codigo_orden INT NOT NULL,
  codigo_articulo INT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY (codigo_orden, codigo_articulo),
  FOREIGN KEY (codigo_orden) REFERENCES orden(codigo_orden),
  FOREIGN KEY (codigo_articulo) REFERENCES articulo(codigo_articulo)
);
