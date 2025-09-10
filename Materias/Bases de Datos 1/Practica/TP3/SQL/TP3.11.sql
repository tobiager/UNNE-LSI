-- EJ 11
CREATE TABLE Cliente (
  id_cliente    INT IDENTITY PRIMARY KEY,
  email         VARCHAR(120) NOT NULL UNIQUE,
  apellido      VARCHAR(80) NOT NULL,
  nombre        VARCHAR(80) NOT NULL,
  fecha_alta    DATE NOT NULL DEFAULT (GETDATE())
);

CREATE TABLE Vendedor (
  id_vendedor   INT IDENTITY PRIMARY KEY,
  apellido      VARCHAR(80) NOT NULL,
  nombre        VARCHAR(80) NOT NULL,
  email         VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE Producto (
  id_producto   INT IDENTITY PRIMARY KEY,
  nombre        VARCHAR(120) NOT NULL,
  sku           VARCHAR(50) NOT NULL UNIQUE,
  precio        DECIMAL(12,2) NOT NULL CHECK (precio >= 0),
  stock         INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE CategoriaConsulta (
  id_categoria  INT IDENTITY PRIMARY KEY,
  nombre        VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE Consulta (
  id_consulta        INT IDENTITY PRIMARY KEY,
  id_cliente         INT NOT NULL REFERENCES Cliente(id_cliente),
  id_producto        INT NOT NULL REFERENCES Producto(id_producto),
  id_categoria       INT NOT NULL REFERENCES CategoriaConsulta(id_categoria),
  fecha_pregunta     DATETIME2 NOT NULL DEFAULT (SYSDATETIME()),
  texto_pregunta     VARCHAR(800) NOT NULL,
  -- Respuesta (opcional, única)
  id_vendedor_resp   INT NULL REFERENCES Vendedor(id_vendedor),
  fecha_respuesta    DATETIME2 NULL,
  texto_respuesta    VARCHAR(1000) NULL,
  -- coherencia: si hay texto_respuesta debe haber id_vendedor_resp y fecha_respuesta
  CONSTRAINT CK_Consulta_Respuesta
    CHECK (
      (texto_respuesta IS NULL AND id_vendedor_resp IS NULL AND fecha_respuesta IS NULL)
      OR
      (texto_respuesta IS NOT NULL AND id_vendedor_resp IS NOT NULL AND fecha_respuesta IS NOT NULL)
    )
);
