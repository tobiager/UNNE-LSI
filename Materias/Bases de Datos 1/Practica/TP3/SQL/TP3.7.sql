/* ==========================================================
     MODELO “Ventas
   BD: tp3_7  |  Motor: SQL Server 2016+
   ========================================================== */
SET NOCOUNT ON;
SET XACT_ABORT ON;

/* 0) (Re)crear Base */
USE master;
IF DB_ID('tp3_7') IS NOT NULL
BEGIN
  ALTER DATABASE tp3_7 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE tp3_7;
END;
GO
CREATE DATABASE tp3_7;
GO
USE tp3_7;
GO

/* 1) Schema */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name=N'ventas')
  EXEC('CREATE SCHEMA ventas AUTHORIZATION dbo');
GO

/* ==========================================================
   2) Tablas
   ========================================================== */

/* ---- RUBRO ---- */
CREATE TABLE ventas.Rubro(
  id_rubro       INT IDENTITY(1,1) NOT NULL,
  descripcion    VARCHAR(80)       NOT NULL,
  CONSTRAINT PK_Rubro PRIMARY KEY (id_rubro),
  CONSTRAINT UQ_Rubro_descripcion UNIQUE (descripcion),
  CONSTRAINT CK_Rubro_desc CHECK (LEN(LTRIM(RTRIM(descripcion))) > 0)
);

/* ---- PROVEEDOR ---- */
CREATE TABLE ventas.Proveedor(
  id_proveedor   INT IDENTITY(1,1) NOT NULL,
  nombre         VARCHAR(120)      NOT NULL,
  telefono       VARCHAR(25)       NULL,
  direccion      VARCHAR(140)      NULL,
  CONSTRAINT PK_Proveedor PRIMARY KEY (id_proveedor),
  CONSTRAINT UQ_Proveedor_nombre UNIQUE (nombre),
  CONSTRAINT CK_Proveedor_nombre CHECK (LEN(LTRIM(RTRIM(nombre))) > 0)
);

/* ---- METODO DE PAGO ---- */
CREATE TABLE ventas.MetodoPago(
  id_metodo      INT IDENTITY(1,1) NOT NULL,
  descripcion    VARCHAR(60)       NOT NULL,
  CONSTRAINT PK_MetodoPago PRIMARY KEY (id_metodo),
  CONSTRAINT UQ_MetodoPago_desc UNIQUE (descripcion),
  CONSTRAINT CK_MetodoPago_desc CHECK (LEN(LTRIM(RTRIM(descripcion))) > 0)
);

/* ---- SUCURSAL ---- */
CREATE TABLE ventas.Sucursal(
  id_sucursal    INT IDENTITY(1,1) NOT NULL,
  nombre         VARCHAR(80)       NOT NULL,
  ciudad         VARCHAR(80)       NOT NULL,
  CONSTRAINT PK_Sucursal PRIMARY KEY (id_sucursal),
  CONSTRAINT UQ_Sucursal_nombre UNIQUE (nombre),
  CONSTRAINT CK_Sucursal_nombre CHECK (LEN(LTRIM(RTRIM(nombre))) > 0),
  CONSTRAINT CK_Sucursal_ciudad CHECK (LEN(LTRIM(RTRIM(ciudad))) > 0)
);

/* ---- VENDEDOR ---- */
CREATE TABLE ventas.Vendedor(
  id_vendedor    INT IDENTITY(1,1) NOT NULL,
  nombre         VARCHAR(80)       NOT NULL,
  id_sucursal    INT               NOT NULL,
  CONSTRAINT PK_Vendedor PRIMARY KEY (id_vendedor),
  CONSTRAINT CK_Vendedor_nombre CHECK (LEN(LTRIM(RTRIM(nombre))) > 0),
  CONSTRAINT FK_Vendedor_Sucursal
    FOREIGN KEY (id_sucursal) REFERENCES ventas.Sucursal(id_sucursal)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* ---- ARTICULO ---- */
CREATE TABLE ventas.Articulo(
  codigo_articulo  VARCHAR(30)     NOT NULL,   -- alfanumérico
  nombre           VARCHAR(120)    NOT NULL,
  stock            INT             NOT NULL CONSTRAINT DF_Articulo_stock DEFAULT(0),
  precio_unitario  DECIMAL(12,2)   NOT NULL,
  id_rubro         INT             NOT NULL,
  id_proveedor     INT             NOT NULL,
  CONSTRAINT PK_Articulo PRIMARY KEY (codigo_articulo),
  CONSTRAINT UQ_Articulo_nombre UNIQUE (nombre),
  CONSTRAINT CK_Articulo_stock  CHECK (stock >= 0),
  CONSTRAINT CK_Articulo_precio CHECK (precio_unitario > 0),
  CONSTRAINT FK_Articulo_Rubro
    FOREIGN KEY (id_rubro) REFERENCES ventas.Rubro(id_rubro)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_Articulo_Proveedor
    FOREIGN KEY (id_proveedor) REFERENCES ventas.Proveedor(id_proveedor)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* ---- TICKET ---- */
CREATE TABLE ventas.Ticket(
  id_ticket     INT IDENTITY(1,1)  NOT NULL,
  fecha         DATETIME2(0)       NOT NULL CONSTRAINT DF_Ticket_fecha DEFAULT (SYSUTCDATETIME()),
  id_vendedor   INT                NOT NULL,
  id_metodo     INT                NOT NULL,
  id_sucursal   INT                NOT NULL,
  CONSTRAINT PK_Ticket PRIMARY KEY (id_ticket),
  CONSTRAINT FK_Ticket_Vendedor
    FOREIGN KEY (id_vendedor) REFERENCES ventas.Vendedor(id_vendedor)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_Ticket_MetodoPago
    FOREIGN KEY (id_metodo) REFERENCES ventas.MetodoPago(id_metodo)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT FK_Ticket_Sucursal
    FOREIGN KEY (id_sucursal) REFERENCES ventas.Sucursal(id_sucursal)
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

/* ---- LINEA TICKET ---- */
CREATE TABLE ventas.LineaTicket(
  id_ticket        INT            NOT NULL,
  codigo_articulo  VARCHAR(30)    NOT NULL,
  cantidad         INT            NOT NULL,
  precio_unitario  DECIMAL(12,2)  NOT NULL,
  -- precio_total calculado
  precio_total     AS (CAST(cantidad AS DECIMAL(12,2)) * precio_unitario) PERSISTED,
  CONSTRAINT PK_LineaTicket PRIMARY KEY (id_ticket, codigo_articulo),
  CONSTRAINT FK_LineaTicket_Ticket
    FOREIGN KEY (id_ticket) REFERENCES ventas.Ticket(id_ticket)
      ON UPDATE NO ACTION ON DELETE CASCADE,  -- si borro ticket, borra líneas
  CONSTRAINT FK_LineaTicket_Articulo
    FOREIGN KEY (codigo_articulo) REFERENCES ventas.Articulo(codigo_articulo)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT CK_LineaTicket_cantidad CHECK (cantidad > 0),
  CONSTRAINT CK_LineaTicket_precio CHECK (precio_unitario > 0)
);
GO

/* ==========================================================
   3) Índices (para FKs y consultas típicas)
   ========================================================== */
CREATE INDEX IX_Vendedor_Sucursal      ON ventas.Vendedor(id_sucursal);
CREATE INDEX IX_Articulo_Rubro         ON ventas.Articulo(id_rubro);
CREATE INDEX IX_Articulo_Proveedor     ON ventas.Articulo(id_proveedor);
CREATE INDEX IX_Ticket_Vendedor        ON ventas.Ticket(id_vendedor);
CREATE INDEX IX_Ticket_Metodo          ON ventas.Ticket(id_metodo);
CREATE INDEX IX_Ticket_Sucursal        ON ventas.Ticket(id_sucursal);
CREATE INDEX IX_LineaTicket_Articulo   ON ventas.LineaTicket(codigo_articulo);
GO

/* ==========================================================
   4) Vista de totales por ticket
   ========================================================== */
GO
CREATE VIEW ventas.vw_TicketConTotal
AS
SELECT
  t.id_ticket,
  t.fecha,
  t.id_vendedor,
  t.id_metodo,
  t.id_sucursal,
  SUM(lt.precio_total) AS total
FROM ventas.Ticket t
LEFT JOIN ventas.LineaTicket lt
  ON lt.id_ticket = t.id_ticket
GROUP BY t.id_ticket, t.fecha, t.id_vendedor, t.id_metodo, t.id_sucursal;
GO

/* ==========================================================
   5) Reglas de negocio con TRIGGERS
   ========================================================== */

-- (a) Ticket debe registrarse en la misma sucursal del vendedor
IF OBJECT_ID('ventas.trg_Ticket_SucursalVendedor','TR') IS NOT NULL
  DROP TRIGGER ventas.trg_Ticket_SucursalVendedor;
GO
CREATE TRIGGER ventas.trg_Ticket_SucursalVendedor
ON ventas.Ticket
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;
  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN ventas.Vendedor v ON v.id_vendedor = i.id_vendedor
    WHERE v.id_sucursal <> i.id_sucursal
  )
  BEGIN
    RAISERROR('El ticket debe registrarse en la misma sucursal del vendedor.',16,1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
GO

-- (b) Stock: validar y actualizar al insertar/actualizar/borrar líneas
IF OBJECT_ID('ventas.trg_LineaTicket_IU_Stock','TR') IS NOT NULL
  DROP TRIGGER ventas.trg_LineaTicket_IU_Stock;
GO
CREATE TRIGGER ventas.trg_LineaTicket_IU_Stock
ON ventas.LineaTicket
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  -- si es UPDATE, reponer lo que estaba antes
  IF EXISTS (SELECT 1 FROM deleted)
  BEGIN
    UPDATE a
      SET a.stock = a.stock + d.cantidad
    FROM ventas.Articulo a
    JOIN deleted d ON d.codigo_articulo = a.codigo_articulo;
  END

  -- validar stock suficiente para lo nuevo
  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN ventas.Articulo a ON a.codigo_articulo = i.codigo_articulo
    WHERE a.stock < i.cantidad
  )
  BEGIN
    RAISERROR('Stock insuficiente para uno o más artículos.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END

  -- descontar por lo nuevo
  UPDATE a
    SET a.stock = a.stock - i.cantidad
  FROM ventas.Articulo a
  JOIN inserted i ON i.codigo_articulo = a.codigo_articulo;
END;
GO

IF OBJECT_ID('ventas.trg_LineaTicket_D_Stock','TR') IS NOT NULL
  DROP TRIGGER ventas.trg_LineaTicket_D_Stock;
GO
CREATE TRIGGER ventas.trg_LineaTicket_D_Stock
ON ventas.LineaTicket
AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE a
    SET a.stock = a.stock + d.cantidad
  FROM ventas.Articulo a
  JOIN deleted d ON d.codigo_articulo = a.codigo_articulo;
END;
GO

PRINT '✅ Esquema tp3_7 creado OK (modelo Ventas con restricciones, índices, vista y triggers).';
