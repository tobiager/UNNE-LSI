CREATE DATABASE municipalidad;
GO
USE municipalidad
GO

CREATE TABLE INSPECTOR
(
  id_inspector INT NOT NULL,
  CONSTRAINT PK_ISPECTOR_id PRIMARY KEY (id_inspector)

);

CREATE TABLE CONDUCTOR
(
  id_conductor INT NOT NULL,
  CONSTRAINT PK_CONDUCTOR_id PRIMARY KEY (id_conductor)
);

CREATE TABLE PROVINCIA
(
  nombre_provincia VARCHAR(20) NOT NULL,
  id_provincia INT NOT NULL,
  CONSTRAINT PK_PROVINCIA_id PRIMARY KEY (id_provincia)
);

CREATE TABLE LOCALIDAD
(
  nombre_localidad VARCHAR(50) NOT NULL,
  id_localidad INT NOT NULL,
  id_provincia INT NOT NULL,
  id_conductor INT NOT NULL,
  CONSTRAINT PK_LOCALIDAD_id PRIMARY KEY (id_localidad),
  CONSTRAINT FK_LOCALIDAD_id_provincia FOREIGN KEY (id_provincia) REFERENCES PROVINCIA(id_provincia),
  CONSTRAINT FK_LOCALIDAD_id_conductor FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor)
);

CREATE TABLE VEHICULO
(
  patente VARCHAR(20) NOT NULL,
  anio_fabricacion DATE NOT NULL,
  tarjeta_Verde INT NOT NULL,
  chasis VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  marca VARCHAR(20) NOT NULL,
  id_conductor INT NOT NULL,
  CONSTRAINT PK_VEHICULO_patente PRIMARY KEY (patente),
  CONSTRAINT FK_VEHICULO_id FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor),
  CONSTRAINT UQ_VEHICULO_chasis UNIQUE (chasis)
);

CREATE TABLE SEGURO
(
  poliza_seguro INT NOT NULL,
  patente VARCHAR(20) NOT NULL,
  CONSTRAINT PK_SEGURO_poliza PRIMARY KEY (poliza_seguro),
  CONSTRAINT FK_SEGURO_patente FOREIGN KEY (patente) REFERENCES VEHICULO(patente),
  CONSTRAINT UQ_SEGURO_patente UNIQUE (patente)
);

CREATE TABLE CARNET
(
  DNI INT NOT NULL,
  domicilio VARCHAR(50) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  nro_carnet INT NOT NULL,
  id_carnet INT NOT NULL,
  id_conductor INT NOT NULL,
  CONSTRAINT PK_CARNET_id PRIMARY KEY (id_carnet),
  CONSTRAINT FK_CARNET_id FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor),
  CONSTRAINT UQ_CARNET_dni UNIQUE (DNI)
);

CREATE TABLE INFRACCION
(
  id_infraccion INT NOT NULL,
  lugar VARCHAR(50) NOT NULL,
  fecha DATE NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
  id_conductor INT NOT NULL,
  CONSTRAINT PK_INFRACCION_id PRIMARY KEY (id_infraccion),
  CONSTRAINT FK_INFRACCION_id FOREIGN KEY (id_conductor) REFERENCES CONDUCTOR(id_conductor)
);

CREATE TABLE PAGO
(
  id_pago INT NOT NULL,
  monto FLOAT NOT NULL,
  CONSTRAINT PK_PAGO_id PRIMARY KEY (id_pago)
);

CREATE TABLE ACTA
(
  id_acta INT NOT NULL,
  id_inspector INT NOT NULL,
  id_infraccion INT NOT NULL,
  id_pago INT NOT NULL,
  CONSTRAINT PK_ACTA_id PRIMARY KEY (id_acta),
  CONSTRAINT FK_ACTA_id_inspector FOREIGN KEY (id_inspector) REFERENCES INSPECTOR(id_inspector),
  CONSTRAINT FK_ACTA_id_infraccion FOREIGN KEY (id_infraccion) REFERENCES INFRACCION(id_infraccion),
  CONSTRAINT FK_ACTA_id_pago FOREIGN KEY (id_pago) REFERENCES PAGO(id_pago)
);

CREATE TABLE PAIS
(
  id_pais INT NOT NULL,
  nombre_pais VARCHAR(20) NOT NULL,
  id_provincia INT NOT NULL,
  CONSTRAINT PK_PAIS_id PRIMARY KEY (id_pais),
  CONSTRAINT FK_PAIS_id_provincia FOREIGN KEY (id_provincia) REFERENCES PROVINCIA(id_provincia)
);

--LOTE DE DATOS--
-- Registro válido
INSERT INTO INSPECTOR (id_inspector) VALUES (1);

-- Registro inválido (clave primaria duplicada)
INSERT INTO INSPECTOR (id_inspector) VALUES (1);

-- Registro válido
INSERT INTO CONDUCTOR (id_conductor) VALUES (1);

-- Registro inválido (clave primaria duplicada)
INSERT INTO CONDUCTOR (id_conductor) VALUES (1);

-- Registro válido
INSERT INTO PROVINCIA (nombre_provincia, id_provincia) VALUES ('Buenos Aires', 1);

-- Registro inválido (clave primaria duplicada)
INSERT INTO PROVINCIA (nombre_provincia, id_provincia) VALUES ('Cordoba', 1);

-- Registro válido
INSERT INTO LOCALIDAD (nombre_localidad, id_localidad, id_provincia, id_conductor) 
VALUES ('Mar del Plata', 1, 1, 1);

-- Registro inválido (clave foránea inexistente en `PROVINCIA`)
INSERT INTO LOCALIDAD (nombre_localidad, id_localidad, id_provincia, id_conductor) 
VALUES ('La Plata', 2, 999, 1);
-- Registro válido
INSERT INTO VEHICULO (patente, anio_fabricacion, tarjeta_Verde, chasis, modelo, marca, id_conductor) 
VALUES ('ABC123', '2020-01-01', 12345, 'CHS001', 'Sedan', 'Toyota', 1);

-- Registro inválido (clave foránea inexistente en `CONDUCTOR`)
INSERT INTO VEHICULO (patente, anio_fabricacion, tarjeta_Verde, chasis, modelo, marca, id_conductor) 
VALUES ('DEF456', '2019-01-01', 54321, 'CHS002', 'SUV', 'Ford', 999);
-- Registro válido
INSERT INTO SEGURO (poliza_seguro, patente) 
VALUES (123456, 'ABC123');

-- Registro inválido (clave foránea inexistente en `VEHICULO`)
INSERT INTO SEGURO (poliza_seguro, patente) 
VALUES (789012, 'ZZZ999');
-- Registro válido
INSERT INTO CARNET (DNI, domicilio, nombre, telefono, nro_carnet, id_carnet, id_conductor) 
VALUES (12345678, 'Calle Falsa 123', 'Juan', '123456789', 1001, 1, 1);

-- Registro inválido (clave única `DNI` duplicada)
INSERT INTO CARNET (DNI, domicilio, nombre, telefono, nro_carnet, id_carnet, id_conductor) 
VALUES (12345678, 'Avenida Siempreviva 742', 'Pedro', '987654321', 1002, 2, 1);
-- Registro válido
INSERT INTO INFRACCION (id_infraccion, lugar, fecha, descripcion, id_conductor) 
VALUES (1, 'Ruta 2', '2023-06-01', 'Exceso de velocidad', 1);

-- Registro inválido (clave foránea inexistente en `CONDUCTOR`)
INSERT INTO INFRACCION (id_infraccion, lugar, fecha, descripcion, id_conductor) 
VALUES (2, 'Ruta 3', '2023-06-05', 'No uso de cinturón', 999);
-- Registro válido
INSERT INTO PAGO (id_pago, monto) 
VALUES (1, 500.00);

-- Registro inválido (clave primaria duplicada)
INSERT INTO PAGO (id_pago, monto) 
VALUES (1, 700.00);
-- Registro válido
INSERT INTO ACTA (id_acta, id_inspector, id_infraccion, id_pago) 
VALUES (1, 1, 1, 1);

-- Registro inválido (clave foránea inexistente en `PAGO`)
INSERT INTO ACTA (id_acta, id_inspector, id_infraccion, id_pago) 
VALUES (2, 1, 1, 999);
-- Registro válido
INSERT INTO PAIS (id_pais, nombre_pais, id_provincia) 
VALUES (1, 'Argentina', 1);

-- Registro inválido (clave foránea inexistente en `PROVINCIA`)
INSERT INTO PAIS (id_pais, nombre_pais, id_provincia) 
VALUES (2, 'Brasil', 999);

select * from VEHICULO;
select * from CARNET;	
select * from CONDUCTOR;
select * from INFRACCION;
select * from SEGURO;
