-- Crear la base de datos
CREATE DATABASE ejer8_tp3;
GO

-- Usar la base de datos
USE ejer8_tp3;
GO

-- Tabla sucursal
CREATE TABLE sucursal (
  id_sucursal INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  pais VARCHAR(100) NOT NULL,
  provincia VARCHAR(100) NOT NULL,
  direccion VARCHAR(150) NOT NULL,
  PRIMARY KEY (id_sucursal)
);

-- Tabla material
CREATE TABLE material (
  id_material INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_material),
  UNIQUE (nombre)
);

-- Tabla camion
CREATE TABLE camion (
  id_camion INT NOT NULL,
  patente VARCHAR(20) NOT NULL,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  capacidad_max_tn INT NOT NULL,
  km_totales INT NOT NULL,
  PRIMARY KEY (id_camion),
  UNIQUE (patente)
);

-- Tabla categoria_lic
CREATE TABLE categoria_lic (
  id_categoria_lic INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_categoria_lic)
);

-- Tabla chofer
CREATE TABLE chofer (
  id_chofer INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  doc_identidad VARCHAR(20) NOT NULL,
  id_categoria_lic INT NOT NULL,
  id_sucursal INT NOT NULL,
  PRIMARY KEY (id_chofer),
  FOREIGN KEY (id_categoria_lic) REFERENCES categoria_lic(id_categoria_lic),
  FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
  UNIQUE (doc_identidad)
);

-- Tabla camion_material
CREATE TABLE camion_material (
  id_camion INT NOT NULL,
  id_material INT NOT NULL,
  PRIMARY KEY (id_camion, id_material),
  FOREIGN KEY (id_camion) REFERENCES camion(id_camion),
  FOREIGN KEY (id_material) REFERENCES material(id_material)
);

-- Tabla asignacion_chofer
CREATE TABLE asignacion_chofer (
  id_asignacion INT NOT NULL,
  fecha_desde DATE NOT NULL,
  fecha_hasta DATE NOT NULL,
  id_chofer INT NOT NULL,
  id_camion INT NOT NULL,
  PRIMARY KEY (id_asignacion),
  FOREIGN KEY (id_chofer) REFERENCES chofer(id_chofer),
  FOREIGN KEY (id_camion) REFERENCES camion(id_camion)
);

-- Tabla viaje
CREATE TABLE viaje (
  id_viaje INT NOT NULL,
  fecha_salida DATE NOT NULL,
  fecha_llegada DATE NOT NULL,
  duracion_dias INT NOT NULL,
  id_sucursal_salida INT NOT NULL,
  id_camion INT NOT NULL,
  id_chofer INT NOT NULL,
  id_material INT NOT NULL,
  id_sucursal_destino INT NOT NULL,
  PRIMARY KEY (id_viaje),
  FOREIGN KEY (id_sucursal_salida) REFERENCES sucursal(id_sucursal),
  FOREIGN KEY (id_camion) REFERENCES camion(id_camion),
  FOREIGN KEY (id_chofer) REFERENCES chofer(id_chofer),
  FOREIGN KEY (id_material) REFERENCES material(id_material),
  FOREIGN KEY (id_sucursal_destino) REFERENCES sucursal(id_sucursal)
);
