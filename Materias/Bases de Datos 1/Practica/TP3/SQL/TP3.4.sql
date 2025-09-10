-- Crear la base de datos
CREATE DATABASE ejer4_tp3;
GO

-- Usar la base de datos
USE ejer4_tp3;
GO

-- Crear tabla plato
CREATE TABLE plato (
  id_plato INT NOT NULL,
  nombre_plato VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_plato)
);

-- Crear tabla categoria
CREATE TABLE categoria (
  id_categoria INT NOT NULL,
  nombre_categoria VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_categoria)
);

-- Crear tabla agregado
CREATE TABLE agregado (
  id_agregado INT NOT NULL,
  nombre_agregado VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_agregado)
);

-- Crear tabla cliente
CREATE TABLE cliente (
  id_cliente INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_cliente),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- Crear tabla pedido
CREATE TABLE pedido (
  id_pedido INT NOT NULL,
  fecha DATE NOT NULL,
  id_cliente INT NOT NULL,
  PRIMARY KEY (id_pedido),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Crear tabla detalle_pedido
CREATE TABLE detalle_pedido (
  id_detalle_pedido INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario FLOAT NOT NULL,
  id_pedido INT NOT NULL,
  id_plato INT NOT NULL,
  PRIMARY KEY (id_detalle_pedido),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_plato) REFERENCES plato(id_plato)
);

-- Crear tabla detalle_agregado
CREATE TABLE detalle_agregado (
  cantidad INT NOT NULL,
  id_agregado INT NOT NULL,
  id_detalle_pedido INT NOT NULL,
  PRIMARY KEY (id_agregado, id_detalle_pedido),
  FOREIGN KEY (id_agregado) REFERENCES agregado(id_agregado),
  FOREIGN KEY (id_detalle_pedido) REFERENCES detalle_pedido(id_detalle_pedido)
);
