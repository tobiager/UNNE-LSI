-- Crear la base de datos
CREATE DATABASE ejer3_tp3;
GO

-- Usar la base de datos
USE ejer3_tp3;
GO

-- Crear tabla cargo
CREATE TABLE cargo (
  id_cargo INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_cargo)
);

-- Crear tabla tag
CREATE TABLE tag (
  id_tag INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_tag)
);

-- Crear tabla proyecto
CREATE TABLE proyecto (
  id_proyecto INT NOT NULL,
  nombre_proyecto VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_proyecto)
);

-- Crear tabla proyecto_tag
CREATE TABLE proyecto_tag (
  id_tag INT NOT NULL,
  id_proyecto INT NOT NULL,
  PRIMARY KEY (id_tag, id_proyecto),
  FOREIGN KEY (id_tag) REFERENCES tag(id_tag),
  FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto)
);

-- Crear tabla empleado
CREATE TABLE empleado (
  id_empleado INT NOT NULL,
  nombre_completo VARCHAR(200) NOT NULL,
  id_cargo INT NOT NULL,
  PRIMARY KEY (id_empleado),
  FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);

-- Crear tabla asigna_en
CREATE TABLE asigna_en (
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  id_empleado INT NOT NULL,
  id_proyecto INT NOT NULL,
  PRIMARY KEY (id_empleado, id_proyecto),
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
  FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto)
);
