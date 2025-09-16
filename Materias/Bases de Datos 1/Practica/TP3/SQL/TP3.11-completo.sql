/* =========================================================
   TP3 – Ej. 11 (Consultas por producto)
   Script físico + comentarios (formato “parcial”)
   Motor: SQL Server (Transact-SQL)
   ========================================================= */

/* =========================================
   0) Preparación: recrear base de datos
   - No usar master para trabajar
   - Liberar sesiones si la BD existe
   ========================================= */
CREATE DATABASE ejer11_tp3_2025;
GO
USE ejer11_tp3_2025;
GO


/* =========================================================
   1) Tablas (DDL) + Restricciones nombradas
   Buenas prácticas:
   - Nombrar PK/FK/UQ/CHK/DEFAULT
   - Tipos adecuados (dinero = DECIMAL(p,s))
   - NOT NULL donde corresponde
   ========================================================= */

-- cliente (entidad fuerte)
CREATE TABLE dbo.cliente (
    id_cliente   INT IDENTITY,
    email        VARCHAR(120) NOT NULL,
    apellido     VARCHAR(80)  NOT NULL,
    nombre       VARCHAR(80)  NOT NULL,
    fecha_alta   DATE NOT NULL
        CONSTRAINT DF_cliente_fecha_alta DEFAULT (GETDATE()),
    CONSTRAINT PK_cliente        PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_cliente_email  UNIQUE  (email)
);

-- vendedor (entidad fuerte)
CREATE TABLE dbo.vendedor (
    id_vendedor  INT IDENTITY,
    apellido     VARCHAR(80)  NOT NULL,
    nombre       VARCHAR(80)  NOT NULL,
    email        VARCHAR(120) NOT NULL,
    CONSTRAINT PK_vendedor        PRIMARY KEY (id_vendedor),
    CONSTRAINT UQ_vendedor_email  UNIQUE  (email)
);

-- producto (catálogo)
CREATE TABLE dbo.producto (
    id_producto  INT IDENTITY,
    nombre       VARCHAR(120)  NOT NULL,
    sku          VARCHAR(50)   NOT NULL,
    precio       DECIMAL(12,2) NOT NULL,
    stock        INT           NOT NULL,
    CONSTRAINT PK_producto          PRIMARY KEY (id_producto),
    CONSTRAINT UQ_producto_sku      UNIQUE  (sku),
    CONSTRAINT CHK_producto_precio  CHECK   (precio >= 0),
    CONSTRAINT CHK_producto_stock   CHECK   (stock  >= 0)
);

-- categoria_consulta (catálogo)
CREATE TABLE dbo.categoria_consulta (
    id_categoria INT IDENTITY,
    nombre       VARCHAR(80) NOT NULL,
    CONSTRAINT PK_categoria_consulta         PRIMARY KEY (id_categoria),
    CONSTRAINT UQ_categoria_consulta_nombre  UNIQUE  (nombre)
);

-- consulta (hecho: pregunta y eventual respuesta)
CREATE TABLE dbo.consulta (
    id_consulta       INT IDENTITY,
    id_cliente        INT NOT NULL,
    id_producto       INT NOT NULL,
    id_categoria      INT NOT NULL,
    fecha_pregunta    DATETIME2 NOT NULL
        CONSTRAINT DF_consulta_fecha_pregunta DEFAULT (SYSDATETIME()),
    texto_pregunta    VARCHAR(800)  NOT NULL,
    id_vendedor_resp  INT NULL,
    fecha_respuesta   DATETIME2 NULL,
    texto_respuesta   VARCHAR(1000) NULL,
    CONSTRAINT PK_consulta PRIMARY KEY (id_consulta),

    -- Integridad referencial (modelo)
    CONSTRAINT FK_consulta_cliente   FOREIGN KEY (id_cliente)
        REFERENCES dbo.cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT FK_consulta_producto  FOREIGN KEY (id_producto)
        REFERENCES dbo.producto(id_producto),
    CONSTRAINT FK_consulta_categoria FOREIGN KEY (id_categoria)
        REFERENCES dbo.categoria_consulta(id_categoria),
    CONSTRAINT FK_consulta_vendedor  FOREIGN KEY (id_vendedor_resp)
        REFERENCES dbo.vendedor(id_vendedor),

    -- Coherencia de respuesta (o todo NULL, o todo completo)
    CONSTRAINT CHK_consulta_respuesta CHECK (
        (texto_respuesta IS NULL AND id_vendedor_resp IS NULL AND fecha_respuesta IS NULL)
        OR
        (texto_respuesta IS NOT NULL AND id_vendedor_resp IS NOT NULL AND fecha_respuesta IS NOT NULL)
    )
);
GO


/* =========================================================
   2) Datos representativos (DML válidos)
   - Prueban FKs, DEFAULTs y el CHECK compuesto
   ========================================================= */
INSERT INTO dbo.cliente (email, apellido, nombre) VALUES
('ana@example.com',  'martinez',  'ana'),
('luis@example.com', 'fernandez', 'luis');

INSERT INTO dbo.vendedor (apellido, nombre, email) VALUES
('gomez', 'laura',  'laura.gomez@example.com'),
('perez', 'carlos', 'carlos.perez@example.com');

INSERT INTO dbo.producto (nombre, sku, precio, stock) VALUES
('notebook lenovo', 'SKU001', 350000.00, 10),
('mouse logitech',  'SKU002',  15000.00, 50);

INSERT INTO dbo.categoria_consulta (nombre) VALUES
('garantia'),
('envio');

-- Una consulta sin respuesta + otra respondida
INSERT INTO dbo.consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES
(1, 1, 1, N'¿Cuál es la garantía de este producto?'),
(2, 2, 2, N'¿Cuánto tarda el envío?');

INSERT INTO dbo.consulta
(id_cliente, id_producto, id_categoria, texto_pregunta, id_vendedor_resp, fecha_respuesta, texto_respuesta)
VALUES
(1, 2, 1, N'¿El mouse tiene garantía?', 1, SYSDATETIME(), N'Sí, tiene 12 meses de garantía');
GO


/* =========================================================
   3) Banco de PRUEBAS (ejecutar de a UNA; deben FALLAR)
   - Permite mostrar el nombre de la constraint que salta
   ========================================================= */

-- (A) UNIQUE
-- INSERT INTO dbo.cliente (email, apellido, nombre) VALUES ('ana@example.com', 'lopez', 'pedro');             -- UQ_cliente_email
-- INSERT INTO dbo.vendedor (apellido, nombre, email) VALUES ('rodriguez', 'maria', 'laura.gomez@example.com'); -- UQ_vendedor_email
-- INSERT INTO dbo.producto (nombre, sku, precio, stock) VALUES ('teclado genius', 'SKU001', 5000, 20);         -- UQ_producto_sku
-- INSERT INTO dbo.categoria_consulta (nombre) VALUES ('garantia');                                              -- UQ_categoria_consulta_nombre

-- (B) CHECK
-- INSERT INTO dbo.producto (nombre, sku, precio, stock) VALUES ('monitor samsung', 'SKU003', -10000, 5); -- CHK_producto_precio
-- INSERT INTO dbo.producto (nombre, sku, precio, stock) VALUES ('impresora hp',   'SKU004',  50000, -2); -- CHK_producto_stock

-- (C) FK inexistentes
-- INSERT INTO dbo.consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES (99, 1, 1, 'X'); -- FK_consulta_cliente
-- INSERT INTO dbo.consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES (1, 99, 1, 'X'); -- FK_consulta_producto
-- INSERT INTO dbo.consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES (1, 1, 99, 'X'); -- FK_consulta_categoria

-- (D) Coherencia de respuesta
-- INSERT INTO dbo.consulta (id_cliente, id_producto, id_categoria, texto_pregunta, texto_respuesta)
-- VALUES (1, 1, 1, 'X', 'Respuesta sin vendedor ni fecha'); -- CHK_consulta_respuesta

-- (E) NOT NULL
-- INSERT INTO dbo.cliente (email, apellido, nombre) VALUES ('nuevo@example.com', NULL, 'sin_apellido'); -- NOT NULL en apellido
GO


/* =========================================================
   4) Verificación rápida de DEFAULTs
   ========================================================= */
INSERT INTO dbo.cliente (email, apellido, nombre)
VALUES ('default@example.com', 'default', 'default');

INSERT INTO dbo.consulta (id_cliente, id_producto, id_categoria, texto_pregunta)
VALUES (1, 1, 1, 'Probar default de fecha_pregunta');

SELECT id_cliente, email, fecha_alta
FROM dbo.cliente
WHERE email = 'default@example.com';

SELECT id_consulta, fecha_pregunta, texto_pregunta
FROM dbo.consulta
WHERE texto_pregunta = 'Probar default de fecha_pregunta';
GO


/* =========================================================
   5) Consultas de verificación (JOINs)
   - LEFT JOIN a vendedor: respuesta es opcional
   ========================================================= */
SELECT 
    c.id_consulta,
    cl.apellido + ', ' + cl.nombre AS cliente,
    p.nombre AS producto,
    cat.nombre AS categoria,
    c.fecha_pregunta,
    c.texto_pregunta,
    v.apellido + ', ' + v.nombre AS vendedor_respuesta,
    c.fecha_respuesta,
    c.texto_respuesta
FROM dbo.consulta c
JOIN dbo.cliente           cl  ON c.id_cliente   = cl.id_cliente
JOIN dbo.producto          p   ON c.id_producto  = p.id_producto
JOIN dbo.categoria_consulta cat ON c.id_categoria = cat.id_categoria
LEFT JOIN dbo.vendedor     v   ON c.id_vendedor_resp = v.id_vendedor;

SELECT id_producto, nombre, sku, precio, stock
FROM dbo.producto;
GO

/* =========================================================
   6) (Opcional) Índice útil para estado de respuesta
   * Ya hay índices por UNIQUE (email/sku/nombre)
   ========================================================= */
-- CREATE INDEX IX_consulta_estado ON dbo.consulta (id_vendedor_resp) INCLUDE (fecha_pregunta);
