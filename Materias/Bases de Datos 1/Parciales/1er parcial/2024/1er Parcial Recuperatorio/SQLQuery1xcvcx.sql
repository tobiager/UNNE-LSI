Version base de datos sql: 2022

CREATE DATABASE playa_estacionamiento;
GO
USE playa_estacionamiento;
GO


CREATE TABLE tipo
(
  id_tipo INT NOT NULL,
  tipo_vehiculo VARCHAR(100) NOT NULL,
  CONSTRAINT PK_tipo PRIMARY KEY (id_tipo)
);

CREATE TABLE conductor_habilitado
(
  dni INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  CONSTRAINT PK_conductor_habilitado PRIMARY KEY (dni),
  CONSTRAINT UQ_conductor_habilitado_telefono UNIQUE (telefono)
);

CREATE TABLE Nivel
(
  id_nivel INT NOT NULL,
  numero INT NOT NULL,
  ubicacion VARCHAR(100) NOT NULL,
  CONSTRAINT PK_Nivel PRIMARY KEY (id_nivel)
);

CREATE TABLE lugar_estacionamiento
(
  id_lugar INT NOT NULL,
  numero INT NOT NULL,
  ubicacion VARCHAR(100) NOT NULL,
  id_tipo INT NOT NULL,
  id_nivel INT NOT NULL,
  CONSTRAINT PK_lugar_estacionamiento PRIMARY KEY (id_lugar),
  CONSTRAINT FK_tipo_id_tipo FOREIGN KEY (id_tipo) REFERENCES tipo(id_tipo),
  CONSTRAINT FK_Nivel_id_nivel FOREIGN KEY (id_nivel) REFERENCES Nivel(id_nivel)
);

CREATE TABLE tiempo_uso
(
  id_tiempo_uso INT NOT NULL,
  fraccion_tiempo VARCHAR(100) NOT NULL,
  CONSTRAINT PK_tiempo_uso PRIMARY KEY (id_tiempo_uso)
);

CREATE TABLE playa_estacionamiento
(
  id_playa INT NOT NULL,
  edificio VARCHAR(100) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  hora_ingreso TIME NOT NULL,
  fecha_salida DATE,
  hora_salida TIME,
  id_lugar INT NOT NULL,
  id_tiempo_uso INT NOT NULL,
  CONSTRAINT PK_ playa_estacionamiento PRIMARY KEY (id_playa),
  CONSTRAINT FK_lugar_estacionamiento_id_lugar FOREIGN KEY (id_lugar) REFERENCES lugar_estacionamiento(id_lugar),
  CONSTRAINT FK_tiempo_uso_id_tiempo_uso FOREIGN KEY (id_tiempo_uso) REFERENCES tiempo_uso(id_tiempo_uso)
);

CREATE TABLE vehiculo
(
  patente VARCHAR(100) NOT NULL,
  color VARCHAR(100) NOT NULL,
  id_tipo INT NOT NULL,
  id_playa INT NOT NULL,
  CONSTRAINT PK_vehiculo PRIMARY KEY (patente),
  CONSTRAINT FK_tipo_id_tipo FOREIGN KEY (id_tipo) REFERENCES tipo(id_tipo),
  CONSTRAINT FK_playa_estacionamiento_id_playa FOREIGN KEY (id_playa) REFERENCES playa_estacionamiento(id_playa)
);

CREATE TABLE conductor_vehiculo
(
  patente VARCHAR(100) NOT NULL,
  dni INT NOT NULL,
  CONSTRAINT PK_conductor_vehiculo PRIMARY KEY (patente, dni),
  CONSTRAINT FK_vehiculo_patente FOREIGN KEY (patente) REFERENCES vehiculo(patente),
  CONSTRAINT FK_conductor_habilitado_dni FOREIGN KEY (dni) REFERENCES conductor_habilitado(dni)
);


--RESTRICCIONES

--fecha ingreso por defecto
ALTER TABLE playa_estacionamiento
ADD CONSTRAINT DF_playa_fecha_ingreso
DEFAULT CONVERT(DATE, GETDATE()) FOR fecha_ingreso;

ALTER TABLE playa_estacionamiento
ADD CONSTRAINT DF_playa_fecha_salida
CHECK (fecha_salida >= fecha_ingreso);



--DATOS PRUEBAS

-- Datos para la tabla tipo
INSERT INTO tipo (id_tipo, tipo_vehiculo) VALUES
(1, 'Auto'),
(2, 'Moto'),
(3, 'Camioneta');

-- Datos para la tabla conductor_habilitado
INSERT INTO conductor_habilitado (dni, nombre, apellido, fecha_nacimiento, direccion, telefono) VALUES
(12345678, 'Juan', 'P�rez', '1980-01-01', 'Calle Falsa 123', '123-4567'),
(87654321, 'Ana', 'Garc�a', '1990-02-02', 'Avenida Siempre Viva 456', '765-4321');

-- Datos para la tabla Nivel
INSERT INTO Nivel (id_nivel, numero, ubicacion) VALUES
(1, 1, 'Subsuelo'),
(2, 2, 'Planta Baja'),
(3, 3, 'Primer Piso');

-- Datos para la tabla lugar_estacionamiento
INSERT INTO lugar_estacionamiento (id_lugar, numero, ubicacion, id_tipo, id_nivel) VALUES
(1, 101, 'Subsuelo', 1, 1),
(2, 102, 'Planta Baja', 2, 2),
(3, 103, 'Primer Piso', 3, 3);

-- Datos para la tabla tiempo_uso
INSERT INTO tiempo_uso (id_tiempo_uso, fraccion_tiempo) VALUES
(1, '1 hora'),
(2, '2 dias'),
(3, '3 semanas');
(4, '3 meses');

-- Datos para la tabla playa_estacionamiento
INSERT INTO playa_estacionamiento (id_playa, edificio, nombre, fecha_ingreso, hora_ingreso, fecha_salida, hora_salida, id_lugar, id_tiempo_uso) VALUES
(1, 'Edificio A', 'Playa Norte', '2024-09-23', '08:00:00', NULL, NULL, 1, 1),
(2, 'Edificio B', 'Playa Sur', '2024-09-23', '09:00:00', NULL, NULL, 2, 2);

-- Datos para la tabla vehiculo
INSERT INTO vehiculo (patente, color, id_tipo, id_playa) VALUES
('ABC123', 'Rojo', 1, 1),
('XYZ789', 'Azul', 2, 2);

-- Datos para la tabla conductor_vehiculo
INSERT INTO conductor_vehiculo (patente, dni) VALUES
('ABC123', 12345678),
('XYZ789', 87654321);



--SELECTS
SELECT * FROM tipo;
SELECT * FROM conductor_habilitado;
SELECT * FROM Nivel;
SELECT * FROM lugar_estacionamiento;
SELECT * FROM tiempo_uso;
SELECT * FROM playa_estacionamiento;
SELECT * FROM vehiculo;
SELECT * FROM conductor_vehiculo;

--PRUEBA RESTRICCIONES

--PRUEBA RESTRICCIONES
--pk
INSERT INTO conductor_habilitado (dni, nombre, apellido, fecha_nacimiento, direccion, telefono) VALUES
(12345678, 'Juan', 'P�rez', '1980-01-01', 'Calle Falsa 123', '123-4567');

--UQ otro cliente con mismo telefono
INSERT INTO conductor_habilitado (dni, nombre, apellido, fecha_nacimiento, direccion, telefono) VALUES
(54345678, 'Lucas', 'P�rez', '1980-01-01', 'Calle Falsa 123', '123-4567');

--NULL
INSERT INTO conductor_habilitado (dni, nombre, apellido, fecha_nacimiento, direccion, telefono) VALUES
(54345678, 'Lucas', NULL , '1980-01-01', 'Calle Falsa 123', '123-4567');

--CHECK
INSERT INTO playa_estacionamiento (id_playa, edificio, nombre, fecha_ingreso, hora_ingreso, fecha_salida, hora_salida, id_lugar, id_tiempo_uso) VALUES
(1, 'Edificio A', 'Playa Norte', '2024-09-22', '08:00:00', NULL, NULL, 1, 1);

--default fecha ingreso
INSERT INTO playa_estacionamiento (id_playa, edificio, nombre, hora_ingreso, fecha_salida, hora_salida, id_lugar, id_tiempo_uso) VALUES
(1, 'Edificio A', 'Playa Norte', '08:00:00', NULL, NULL, 1, 1);

--fk tipo 4 que no existe
INSERT INTO vehiculo (patente, color, id_tipo, id_playa) VALUES
('ABC123', 'Rojo', 4, 1);