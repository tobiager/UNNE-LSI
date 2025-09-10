-- Crear la base de datos
CREATE DATABASE ejer2_tp3;
GO

-- Seleccionar la base de datos para trabajar
USE ejer2_tp3;
GO

-- Crear tablas
CREATE TABLE colegio (
  id_colegio INT NOT NULL,
  nombre_colegio VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_colegio)
);

CREATE TABLE editorial (
  id_editorial INT NOT NULL,
  nombre_editorial VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_editorial)
);

CREATE TABLE profesor (
  id_profesor INT NOT NULL,
  nombre_profesor VARCHAR(50) NOT NULL,
  apellido_profesor VARCHAR(50) NOT NULL,
  id_colegio INT NOT NULL,
  PRIMARY KEY (id_profesor),
  FOREIGN KEY (id_colegio) REFERENCES colegio(id_colegio)
);

CREATE TABLE asignatura (
  id_asignatura INT NOT NULL,
  nombre_asignatura VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_asignatura)
);

CREATE TABLE curso (
  id_curso INT NOT NULL,
  nombre_curso VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_curso)
);

CREATE TABLE libro (
  id_libro INT NOT NULL,
  titulo_libro VARCHAR(50) NOT NULL,
  id_editorial INT NOT NULL,
  PRIMARY KEY (id_libro),
  FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
);

CREATE TABLE prestamo (
  id_prestamo INT NOT NULL,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  id_profesor INT NOT NULL,
  id_asignatura INT NOT NULL,
  id_curso INT NOT NULL,
  id_libro INT NOT NULL,
  PRIMARY KEY (id_prestamo),
  FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor),
  FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura),
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
  FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);


