-- Crear la base de datos
CREATE DATABASE ejer5_tp3;
GO

-- Usar la base de datos
USE ejer5_tp3;
GO

-- Crear tabla huesped
CREATE TABLE huesped (
  id_huesped INT NOT NULL,
  nombre_huesped VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_huesped)
);

-- Crear tabla marca
CREATE TABLE marca (
  id_marca INT NOT NULL,
  nombre_marca VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_marca)
);

-- Crear tabla tipo_metodo
CREATE TABLE tipo_metodo (
  id_metodo INT NOT NULL,
  nombre_tipo_metodo VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_metodo)
);

-- Crear tabla piso
CREATE TABLE piso (
  id_piso INT NOT NULL,
  numero_piso INT NOT NULL,
  PRIMARY KEY (id_piso)
);

-- Crear tabla habitacion
CREATE TABLE habitacion (
  id_habitacion INT NOT NULL,
  numero_habitacion INT NOT NULL,
  id_piso INT NOT NULL,
  PRIMARY KEY (id_habitacion),
  FOREIGN KEY (id_piso) REFERENCES piso(id_piso)
);

-- Crear tabla reserva
CREATE TABLE reserva (
  id_reserva INT NOT NULL,
  fecha_entrada DATE NOT NULL,
  fecha_salida DATE NOT NULL,
  costo_total INT NOT NULL,
  id_huesped INT NOT NULL,
  id_habitacion INT NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_huesped) REFERENCES huesped(id_huesped),
  FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion)
);

-- Crear tabla reserva_pago
CREATE TABLE reserva_pago (
  monto INT NOT NULL,
  fecha_pago DATE NOT NULL,
  detalles VARCHAR(50) NOT NULL,
  id_reserva INT NOT NULL,
  id_marca INT,
  id_metodo INT NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
  FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
  FOREIGN KEY (id_metodo) REFERENCES tipo_metodo(id_metodo)
);
