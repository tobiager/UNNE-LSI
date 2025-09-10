-- Crear la base de datos
CREATE DATABASE ejer6_tp3;
GO

-- Usar la base de datos
USE ejer6_tp3;
GO

-- Crear tabla usuario
CREATE TABLE usuario (
  id_usuario INT NOT NULL,
  nombre_usuario VARCHAR(50) NOT NULL,
  correo_electronico VARCHAR(50) NOT NULL,
  fecha_registro DATE NOT NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE (nombre_usuario),
  UNIQUE (correo_electronico)
);

-- Crear tabla suscripcion
CREATE TABLE suscripcion (
  id_suscripcion INT NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  precio FLOAT NOT NULL,
  PRIMARY KEY (id_suscripcion)
);

-- Crear tabla historial_suscripcion
CREATE TABLE historial_suscripcion (
  id_historial_suscripcion INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  id_usuario INT NOT NULL,
  id_suscripcion INT NOT NULL,
  PRIMARY KEY (id_historial_suscripcion),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_suscripcion) REFERENCES suscripcion(id_suscripcion)
);
