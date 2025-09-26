
CREATE DATABASE recuperatorio_primer_parcial_2025;
GO
USE recuperatorio_primer_parcial_2025;
GO

-- === Catalogos / Tipificaciones ===
CREATE TABLE especie (
  especie_id INT IDENTITY(1,1) PRIMARY KEY,
  nombre      VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE raza (
  raza_id    INT IDENTITY(1,1) PRIMARY KEY,
  especie_id INT NOT NULL,
  nombre     VARCHAR(40) NOT NULL,
  CONSTRAINT UQ_raza UNIQUE (especie_id, nombre),
  CONSTRAINT FK_raza_especie
    FOREIGN KEY (especie_id) REFERENCES especie(especie_id)
);

-- Estados de mascota (1..4)
CREATE TABLE estado_mascota (
  estado_id  TINYINT PRIMARY KEY,
  nombre     VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO estado_mascota (estado_id, nombre) VALUES
 (1,'No disponible'),
 (2,'Disponible'),
 (3,'En adopción'),
 (4,'Adoptado');

-- === Nucleo ===
CREATE TABLE mascota (
  mascota_id      INT IDENTITY(1,1) PRIMARY KEY,
  nombre          VARCHAR(40) NULL,
  anio_nacimiento SMALLINT NULL
    CONSTRAINT CK_mascota_anio CHECK (anio_nacimiento BETWEEN 1980 AND YEAR(GETDATE())),
  fecha_alta      DATE NOT NULL CONSTRAINT DF_mascota_fecha_alta DEFAULT (CAST(GETDATE() AS DATE)),
  estado_id       TINYINT NOT NULL CONSTRAINT DF_mascota_estado DEFAULT (1),
  raza_id         INT NOT NULL,
  CONSTRAINT FK_mascota_raza    FOREIGN KEY (raza_id)   REFERENCES raza(raza_id),
  CONSTRAINT FK_mascota_estado  FOREIGN KEY (estado_id) REFERENCES estado_mascota(estado_id)
);

CREATE TABLE adoptante (
  adoptante_id     INT IDENTITY(1,1) PRIMARY KEY,
  dni              CHAR(8) NOT NULL,
  nombre           VARCHAR(40) NOT NULL,
  apellido         VARCHAR(40) NOT NULL,
  domicilio        VARCHAR(80) NOT NULL,
  telefono         VARCHAR(20) NOT NULL,
  edad             TINYINT NOT NULL
    CONSTRAINT CK_adoptante_edad CHECK (edad BETWEEN 18 AND 100),
  fecha_inscripcion DATE NOT NULL 
    CONSTRAINT DF_adoptante_fecha DEFAULT (CAST(GETDATE() AS DATE)),
  CONSTRAINT UQ_adoptante_dni UNIQUE (dni),
  -- Si querés forzar que SIEMPRE sea la fecha del sistema (incluso si intentan pasar otra):
  CONSTRAINT CK_adoptante_fecha_hoy CHECK (fecha_inscripcion = CAST(GETDATE() AS DATE))
);

CREATE TABLE empleado (
  empleado_id      INT IDENTITY(1,1) PRIMARY KEY,
  dni              CHAR(8)  NOT NULL,
  nombre           VARCHAR(40) NOT NULL,
  apellido         VARCHAR(40) NOT NULL,
  direccion        VARCHAR(80) NOT NULL,
  telefono         VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL
    CONSTRAINT CK_emp_mayor CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 18),
  fecha_ingreso    DATE NOT NULL,
  cargo            VARCHAR(40) NOT NULL,
  CONSTRAINT UQ_empleado_dni UNIQUE (dni),

  -- >> CHECK a nivel de tabla (ahora sí puede usar ambas columnas)
  CONSTRAINT CK_emp_fechas CHECK (fecha_ingreso >= fecha_nacimiento)
);


-- Cada adopción: una mascota, un adoptante, un empleado
CREATE TABLE adopcion (
  adopcion_id   INT IDENTITY(1,1) PRIMARY KEY, -- número de operación incremental
  fecha_adopcion DATE NOT NULL,
  mascota_id     INT NOT NULL,
  adoptante_id   INT NOT NULL,
  empleado_id    INT NOT NULL,
  CONSTRAINT FK_adopcion_mascota   FOREIGN KEY (mascota_id)   REFERENCES mascota(mascota_id),
  CONSTRAINT FK_adopcion_adoptante FOREIGN KEY (adoptante_id) REFERENCES adoptante(adoptante_id),
  CONSTRAINT FK_adopcion_empleado  FOREIGN KEY (empleado_id)  REFERENCES empleado(empleado_id),
  -- “Una mascota puede ser adoptada una sola vez”
  CONSTRAINT UQ_adopcion_mascota UNIQUE (mascota_id)
);
