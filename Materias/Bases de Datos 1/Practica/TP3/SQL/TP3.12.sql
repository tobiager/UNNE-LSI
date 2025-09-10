-- EJ 12
CREATE TABLE Zona (
  id_zona   INT IDENTITY PRIMARY KEY,
  nombre    VARCHAR(60) NOT NULL UNIQUE,
  codigo    VARCHAR(10) NULL
);

CREATE TABLE Calle (
  id_calle  INT IDENTITY PRIMARY KEY,
  nombre    VARCHAR(120) NOT NULL UNIQUE,
  codigo    VARCHAR(20) NULL,
  id_zona   INT NOT NULL REFERENCES Zona(id_zona)
);

CREATE TABLE TipoUsuario (
  id_tipo_usuario INT IDENTITY PRIMARY KEY,
  nombre          VARCHAR(60) NOT NULL UNIQUE,
  porc_ajuste     DECIMAL(5,2) NOT NULL -- ej: -10.00 = -10%; 15.00 = +15%
);

CREATE TABLE Usuario (
  id_usuario     INT IDENTITY PRIMARY KEY,
  nro_socio      INT NOT NULL UNIQUE,
  apellido       VARCHAR(80) NOT NULL,
  nombre         VARCHAR(80) NOT NULL,
  id_tipo_usuario INT NOT NULL REFERENCES TipoUsuario(id_tipo_usuario)
);

CREATE TABLE Domicilio (
  id_domicilio INT IDENTITY PRIMARY KEY,
  id_usuario   INT NOT NULL REFERENCES Usuario(id_usuario),
  id_calle     INT NOT NULL REFERENCES Calle(id_calle),
  numero       VARCHAR(10) NOT NULL,
  piso         VARCHAR(10) NULL,
  dto          VARCHAR(10) NULL
);

CREATE TABLE Servicio (
  id_servicio  INT IDENTITY PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL UNIQUE,
  tipo         VARCHAR(20) NOT NULL CHECK (tipo IN ('TV','INTERNET','TELEFONIA','MENSAJERIA')),
  precio_base  DECIMAL(12,2) NOT NULL CHECK (precio_base >= 0)
);

CREATE TABLE Paquete (
  id_paquete   INT IDENTITY PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL UNIQUE,
  precio       DECIMAL(12,2) NOT NULL CHECK (precio >= 0)
);

CREATE TABLE PaqueteServicio (
  id_paquete  INT NOT NULL REFERENCES Paquete(id_paquete) ON DELETE CASCADE,
  id_servicio INT NOT NULL REFERENCES Servicio(id_servicio),
  CONSTRAINT PK_PaqueteServicio PRIMARY KEY (id_paquete, id_servicio)
);

CREATE TABLE UsuarioServicio (
  id_usuario  INT NOT NULL REFERENCES Usuario(id_usuario),
  id_servicio INT NOT NULL REFERENCES Servicio(id_servicio),
  fecha_alta  DATE NOT NULL,
  fecha_baja  DATE NULL,
  CONSTRAINT PK_UsuarioServicio PRIMARY KEY (id_usuario, id_servicio, fecha_alta),
  CONSTRAINT CK_US_Fechas CHECK (fecha_baja IS NULL OR fecha_baja >= fecha_alta)
);

CREATE TABLE UsuarioPaquete (
  id_usuario  INT NOT NULL REFERENCES Usuario(id_usuario),
  id_paquete  INT NOT NULL REFERENCES Paquete(id_paquete),
  fecha_alta  DATE NOT NULL,
  fecha_baja  DATE NULL,
  CONSTRAINT PK_UsuarioPaquete PRIMARY KEY (id_usuario, id_paquete, fecha_alta),
  CONSTRAINT CK_UP_Fechas CHECK (fecha_baja IS NULL OR fecha_baja >= fecha_alta)
);

CREATE TABLE Factura (
  id_factura          INT IDENTITY PRIMARY KEY,
  nro_factura         BIGINT NOT NULL UNIQUE,
  id_usuario          INT NOT NULL REFERENCES Usuario(id_usuario),
  id_domicilio        INT NOT NULL REFERENCES Domicilio(id_domicilio),
  periodo_mes         TINYINT NOT NULL CHECK (periodo_mes BETWEEN 1 AND 12),
  periodo_anio        SMALLINT NOT NULL CHECK (periodo_anio BETWEEN 2000 AND 2100),
  fecha_emision       DATE NOT NULL,
  fecha_vencimiento   DATE NOT NULL,
  -- snapshot del tipo de usuario al momento de facturar
  id_tipo_usuario_snapshot INT NOT NULL,
  porc_ajuste_snapshot     DECIMAL(5,2) NOT NULL,
  total               DECIMAL(12,2) NOT NULL CHECK (total >= 0)
);

CREATE TABLE DetalleFactura (
  id_detalle     INT IDENTITY PRIMARY KEY,
  id_factura     INT NOT NULL REFERENCES Factura(id_factura) ON DELETE CASCADE,
  tipo_concepto  VARCHAR(10) NOT NULL CHECK (tipo_concepto IN ('SERVICIO','PAQUETE')),
  id_servicio    INT NULL REFERENCES Servicio(id_servicio),
  id_paquete     INT NULL REFERENCES Paquete(id_paquete),
  descripcion    VARCHAR(150) NOT NULL,
  precio_unit    DECIMAL(12,2) NOT NULL CHECK (precio_unit >= 0),
  cantidad       INT NOT NULL CHECK (cantidad > 0),
  importe        AS (precio_unit * CAST(cantidad AS DECIMAL(12,2))) PERSISTED,
  CONSTRAINT CK_Detalle_FK
    CHECK (
      (tipo_concepto = 'SERVICIO' AND id_servicio IS NOT NULL AND id_paquete IS NULL)
      OR
      (tipo_concepto = 'PAQUETE'  AND id_paquete  IS NOT NULL AND id_servicio IS NULL)
    )
);
