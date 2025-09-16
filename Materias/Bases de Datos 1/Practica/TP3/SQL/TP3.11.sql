-- =========================================
-- Crear base de datos
-- =========================================
CREATE DATABASE ejer11_tp3_2025;
GO

USE ejer11_tp3_2025;
GO

-- =========================================
-- Tablas principales
-- =========================================
CREATE TABLE cliente (
    id_cliente   INT IDENTITY PRIMARY KEY,
    email        VARCHAR(120) NOT NULL,
    apellido     VARCHAR(80) NOT NULL,
    nombre       VARCHAR(80) NOT NULL,
    fecha_alta   DATE NOT NULL CONSTRAINT DF_cliente_fecha_alta DEFAULT (GETDATE()),
    CONSTRAINT UQ_cliente_email UNIQUE (email)
);

CREATE TABLE vendedor (
    id_vendedor  INT IDENTITY PRIMARY KEY,
    apellido     VARCHAR(80) NOT NULL,
    nombre       VARCHAR(80) NOT NULL,
    email        VARCHAR(120) NOT NULL,
    CONSTRAINT UQ_vendedor_email UNIQUE (email)
);

CREATE TABLE producto (
    id_producto  INT IDENTITY PRIMARY KEY,
    nombre       VARCHAR(120) NOT NULL,
    sku          VARCHAR(50) NOT NULL,
    precio       DECIMAL(12,2) NOT NULL,
    stock        INT NOT NULL,
    CONSTRAINT UQ_producto_sku UNIQUE (sku),
    CONSTRAINT CHK_producto_precio CHECK (precio >= 0),
    CONSTRAINT CHK_producto_stock CHECK (stock >= 0)
);

CREATE TABLE categoria_consulta (
    id_categoria INT IDENTITY PRIMARY KEY,
    nombre       VARCHAR(80) NOT NULL,
    CONSTRAINT UQ_categoria_consulta_nombre UNIQUE (nombre)
);

CREATE TABLE consulta (
    id_consulta       INT IDENTITY PRIMARY KEY,
    id_cliente        INT NOT NULL,
    id_producto       INT NOT NULL,
    id_categoria      INT NOT NULL,
    fecha_pregunta    DATETIME2 NOT NULL CONSTRAINT DF_consulta_fecha_pregunta DEFAULT (SYSDATETIME()),
    texto_pregunta    VARCHAR(800) NOT NULL,
    id_vendedor_resp  INT NULL,
    fecha_respuesta   DATETIME2 NULL,
    texto_respuesta   VARCHAR(1000) NULL,
    CONSTRAINT FK_consulta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT FK_consulta_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT FK_consulta_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_consulta(id_categoria),
    CONSTRAINT FK_consulta_vendedor FOREIGN KEY (id_vendedor_resp) REFERENCES vendedor(id_vendedor),
    CONSTRAINT CHK_consulta_respuesta CHECK (
        (texto_respuesta IS NULL AND id_vendedor_resp IS NULL AND fecha_respuesta IS NULL)
        OR
        (texto_respuesta IS NOT NULL AND id_vendedor_resp IS NOT NULL AND fecha_respuesta IS NOT NULL)
    )
);

-- =========================================
-- Datos válidos
-- =========================================
INSERT INTO cliente (email, apellido, nombre) VALUES
('ana@example.com', 'martinez', 'ana'),
('luis@example.com', 'fernandez', 'luis');

INSERT INTO vendedor (apellido, nombre, email) VALUES
('gomez', 'laura', 'laura.gomez@example.com'),
('perez', 'carlos', 'carlos.perez@example.com');

INSERT INTO producto (nombre, sku, precio, stock) VALUES
('notebook lenovo', 'SKU001', 350000.00, 10),
('mouse logitech', 'SKU002', 15000.00, 50);

INSERT INTO categoria_consulta (nombre) VALUES
('garantia'),
('envio');

INSERT INTO consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES
(1, 1, 1, '¿Cuál es la garantía de este producto?'),
(2, 2, 2, '¿Cuánto tarda el envío?');

INSERT INTO consulta (id_cliente, id_producto, id_categoria, texto_pregunta, id_vendedor_resp, fecha_respuesta, texto_respuesta) VALUES
(1, 2, 1, '¿El mouse tiene garantía?', 1, GETDATE(), 'Sí, tiene 12 meses de garantía');

-- =========================================
-- Datos inválidos (provocarán error al ejecutar)
-- =========================================
-- UQ_cliente_email: email duplicado
INSERT INTO cliente (email, apellido, nombre) VALUES
('ana@example.com', 'lopez', 'pedro');

-- UQ_vendedor_email: email duplicado
INSERT INTO vendedor (apellido, nombre, email) VALUES
('rodriguez', 'maria', 'laura.gomez@example.com');

-- UQ_producto_sku: SKU duplicado
INSERT INTO producto (nombre, sku, precio, stock) VALUES
('teclado genius', 'SKU001', 5000, 20);

-- CHK_producto_precio: precio negativo
INSERT INTO producto (nombre, sku, precio, stock) VALUES
('monitor samsung', 'SKU003', -10000, 5);

-- CHK_producto_stock: stock negativo
INSERT INTO producto (nombre, sku, precio, stock) VALUES
('impresora hp', 'SKU004', 50000, -2);

-- UQ_categoria_consulta_nombre: nombre duplicado
INSERT INTO categoria_consulta (nombre) VALUES
('garantia');

-- FK_consulta_cliente: cliente inexistente
INSERT INTO consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES
(99, 1, 1, 'Consulta inválida');

-- FK_consulta_producto: producto inexistente
INSERT INTO consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES
(1, 99, 1, 'Consulta inválida');

-- FK_consulta_categoria: categoría inexistente
INSERT INTO consulta (id_cliente, id_producto, id_categoria, texto_pregunta) VALUES
(1, 1, 99, 'Consulta inválida');

-- CHK_consulta_respuesta: texto_respuesta sin vendedor o fecha
INSERT INTO consulta (id_cliente, id_producto, id_categoria, texto_pregunta, texto_respuesta) VALUES
(1, 1, 1, 'Consulta con incoherencia', 'Respuesta sin vendedor ni fecha');

-- =========================================
-- Consultas de verificación
-- =========================================
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
FROM consulta c
JOIN cliente cl ON c.id_cliente = cl.id_cliente
JOIN producto p ON c.id_producto = p.id_producto
JOIN categoria_consulta cat ON c.id_categoria = cat.id_categoria
LEFT JOIN vendedor v ON c.id_vendedor_resp = v.id_vendedor;

SELECT id_producto, nombre, sku, precio, stock
FROM producto;
