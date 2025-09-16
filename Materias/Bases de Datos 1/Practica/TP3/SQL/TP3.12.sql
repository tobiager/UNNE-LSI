-- =========================================
-- Limpieza opcional: eliminar la base si existe
-- Permite reejecutar el script sin errores por objetos existentes
-- =========================================
IF DB_ID('ejer12_tp3_2025') IS NOT NULL
BEGIN
    ALTER DATABASE ejer12_tp3_2025 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ejer12_tp3_2025;
END
GO


-- =========================================
-- Crear base de datos
-- =========================================
CREATE DATABASE ejer12_tp3_2025;
GO

USE ejer12_tp3_2025;
GO

-- =========================================
-- Tablas principales
-- =========================================
CREATE TABLE zona (
    id_zona INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    codigo VARCHAR(10) NULL,
    CONSTRAINT UQ_zona_nombre UNIQUE (nombre)
);

CREATE TABLE calle (
    id_calle INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    codigo VARCHAR(20) NULL,
    id_zona INT NOT NULL,
    CONSTRAINT UQ_calle_nombre UNIQUE (nombre),
    CONSTRAINT FK_calle_zona FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
);

CREATE TABLE tipo_usuario (
    id_tipo_usuario INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    porc_ajuste DECIMAL(5,2) NOT NULL,
    CONSTRAINT UQ_tipo_usuario_nombre UNIQUE (nombre)
);

CREATE TABLE usuario (
    id_usuario INT IDENTITY PRIMARY KEY,
    nro_socio INT NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    id_tipo_usuario INT NOT NULL,
    CONSTRAINT UQ_usuario_nro_socio UNIQUE (nro_socio),
    CONSTRAINT FK_usuario_tipo_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id_tipo_usuario)
);

CREATE TABLE domicilio (
    id_domicilio INT IDENTITY PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_calle INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    piso VARCHAR(10) NULL,
    dto VARCHAR(10) NULL,
    CONSTRAINT FK_domicilio_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT FK_domicilio_calle FOREIGN KEY (id_calle) REFERENCES calle(id_calle)
);

CREATE TABLE servicio (
    id_servicio INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    precio_base DECIMAL(12,2) NOT NULL,
    CONSTRAINT UQ_servicio_nombre UNIQUE (nombre),
    CONSTRAINT CHK_servicio_tipo CHECK (tipo IN ('TV','INTERNET','TELEFONIA','MENSAJERIA')),
    CONSTRAINT CHK_servicio_precio CHECK (precio_base >= 0)
);

CREATE TABLE paquete (
    id_paquete INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(12,2) NOT NULL,
    CONSTRAINT UQ_paquete_nombre UNIQUE (nombre),
    CONSTRAINT CHK_paquete_precio CHECK (precio >= 0)
);

CREATE TABLE paquete_servicio (
    id_paquete INT NOT NULL,
    id_servicio INT NOT NULL,
    CONSTRAINT PK_paquete_servicio PRIMARY KEY (id_paquete, id_servicio),
    CONSTRAINT FK_paquete_servicio_paquete FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete) ON DELETE CASCADE,
    CONSTRAINT FK_paquete_servicio_servicio FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

CREATE TABLE usuario_servicio (
    id_usuario INT NOT NULL,
    id_servicio INT NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE NULL,
    CONSTRAINT PK_usuario_servicio PRIMARY KEY (id_usuario, id_servicio, fecha_alta),
    CONSTRAINT FK_usuario_servicio_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT FK_usuario_servicio_servicio FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio),
    CONSTRAINT CHK_usuario_servicio_fechas CHECK (fecha_baja IS NULL OR fecha_baja >= fecha_alta)
);

CREATE TABLE usuario_paquete (
    id_usuario INT NOT NULL,
    id_paquete INT NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE NULL,
    CONSTRAINT PK_usuario_paquete PRIMARY KEY (id_usuario, id_paquete, fecha_alta),
    CONSTRAINT FK_usuario_paquete_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT FK_usuario_paquete_paquete FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete),
    CONSTRAINT CHK_usuario_paquete_fechas CHECK (fecha_baja IS NULL OR fecha_baja >= fecha_alta)
);

CREATE TABLE factura (
    id_factura INT IDENTITY PRIMARY KEY,
    nro_factura BIGINT NOT NULL,
    id_usuario INT NOT NULL,
    id_domicilio INT NOT NULL,
    periodo_mes TINYINT NOT NULL,
    periodo_anio SMALLINT NOT NULL,
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    id_tipo_usuario_snapshot INT NOT NULL,
    porc_ajuste_snapshot DECIMAL(5,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    CONSTRAINT UQ_factura_nro UNIQUE (nro_factura),
    CONSTRAINT FK_factura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT FK_factura_domicilio FOREIGN KEY (id_domicilio) REFERENCES domicilio(id_domicilio),
    CONSTRAINT CHK_factura_mes CHECK (periodo_mes BETWEEN 1 AND 12),
    CONSTRAINT CHK_factura_anio CHECK (periodo_anio BETWEEN 2000 AND 2100),
    CONSTRAINT CHK_factura_total CHECK (total >= 0)
);

CREATE TABLE detalle_factura (
    id_detalle INT IDENTITY PRIMARY KEY,
    id_factura INT NOT NULL,
    tipo_concepto VARCHAR(10) NOT NULL,
    id_servicio INT NULL,
    id_paquete INT NULL,
    descripcion VARCHAR(150) NOT NULL,
    precio_unit DECIMAL(12,2) NOT NULL,
    cantidad INT NOT NULL,
    importe AS (precio_unit * CAST(cantidad AS DECIMAL(12,2))) PERSISTED,
    CONSTRAINT FK_detalle_factura_factura FOREIGN KEY (id_factura) REFERENCES factura(id_factura) ON DELETE CASCADE,
    CONSTRAINT FK_detalle_factura_servicio FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio),
    CONSTRAINT FK_detalle_factura_paquete FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete),
    CONSTRAINT CHK_detalle_factura_precio CHECK (precio_unit >= 0),
    CONSTRAINT CHK_detalle_factura_cantidad CHECK (cantidad > 0),
    CONSTRAINT CHK_detalle_factura_fk CHECK (
        (tipo_concepto = 'SERVICIO' AND id_servicio IS NOT NULL AND id_paquete IS NULL)
        OR
        (tipo_concepto = 'PAQUETE' AND id_paquete IS NOT NULL AND id_servicio IS NULL)
    ),
    CONSTRAINT CHK_detalle_factura_tipo CHECK (tipo_concepto IN ('SERVICIO','PAQUETE'))
);

-- =========================================
-- Datos válidos
-- =========================================
INSERT INTO zona (nombre, codigo) VALUES
('zona norte', 'ZN1'),
('zona sur', 'ZS1');

INSERT INTO calle (nombre, codigo, id_zona) VALUES
('avenida siempre viva', 'C001', 1),
('calle falsa', 'C002', 2);

INSERT INTO tipo_usuario (nombre, porc_ajuste) VALUES
('residencial', 0.00),
('comercial', 15.00);

INSERT INTO usuario (nro_socio, apellido, nombre, id_tipo_usuario) VALUES
(1001, 'martinez', 'ana', 1),
(1002, 'fernandez', 'luis', 2);

INSERT INTO domicilio (id_usuario, id_calle, numero, piso, dto) VALUES
(1, 1, '123', '1', 'A'),
(2, 2, '456', NULL, NULL);

INSERT INTO servicio (nombre, tipo, precio_base) VALUES
('internet 100mb', 'INTERNET', 5000.00),
('tv cable', 'TV', 3000.00),
('telefonia fija', 'TELEFONIA', 2000.00);

INSERT INTO paquete (nombre, precio) VALUES
('combo hogar', 7000.00),
('pack full', 9500.00);

INSERT INTO paquete_servicio (id_paquete, id_servicio) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(2, 3);

INSERT INTO usuario_servicio (id_usuario, id_servicio, fecha_alta, fecha_baja) VALUES
(1, 1, '2025-09-01', NULL),
(1, 2, '2025-09-01', NULL);

INSERT INTO usuario_paquete (id_usuario, id_paquete, fecha_alta, fecha_baja) VALUES
(2, 1, '2025-09-05', NULL);

-- Factura 1: solo servicio internet 100mb (usuario 1, domicilio 1)
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000001, 1, 1, 9, 2025, '2025-09-10', '2025-09-20', 1, 0.00, 5000.00);

INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(1, 'SERVICIO', 1, 'internet 100mb', 5000.00, 1);

-- Factura 2: paquete combo hogar (usuario 2, domicilio 2)
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000002, 2, 2, 9, 2025, '2025-09-11', '2025-09-21', 2, 15.00, 7000.00);

INSERT INTO detalle_factura (id_factura, tipo_concepto, id_paquete, descripcion, precio_unit, cantidad) VALUES
(2, 'PAQUETE', 1, 'combo hogar', 7000.00, 1);

-- Factura 3: múltiples conceptos (usuario 1, domicilio 1)
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000003, 1, 1, 9, 2025, '2025-09-12', '2025-09-22', 1, 0.00, 8000.00);

INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(3, 'SERVICIO', 2, 'tv cable', 3000.00, 1);

INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(3, 'SERVICIO', 1, 'internet 100mb', 5000.00, 1);

-- =========================================
-- Datos inválidos (provocarán error al ejecutar)
-- =========================================
-- UQ_zona_nombre: duplicado
INSERT INTO zona (nombre, codigo) VALUES ('zona norte', 'ZNX');

-- FK_calle_zona: id_zona inexistente
INSERT INTO calle (nombre, codigo, id_zona) VALUES ('calle nueva', 'C999', 99);

-- UQ_usuario_nro_socio: duplicado
INSERT INTO usuario (nro_socio, apellido, nombre, id_tipo_usuario) VALUES (1001, 'lopez', 'mario', 1);

-- FK_usuario_tipo_usuario: tipo inexistente
INSERT INTO usuario (nro_socio, apellido, nombre, id_tipo_usuario) VALUES (1003, 'gomez', 'lucia', 99);

-- FK_domicilio_usuario: usuario inexistente
INSERT INTO domicilio (id_usuario, id_calle, numero) VALUES (99, 1, '789');

-- FK_domicilio_calle: calle inexistente
INSERT INTO domicilio (id_usuario, id_calle, numero) VALUES (1, 99, '789');

-- UQ_servicio_nombre: duplicado
INSERT INTO servicio (nombre, tipo, precio_base) VALUES ('internet 100mb', 'INTERNET', 4500.00);

-- CHK_servicio_tipo: valor no permitido
INSERT INTO servicio (nombre, tipo, precio_base) VALUES ('streaming plus', 'STREAMING', 2500.00);

-- CHK_servicio_precio: precio negativo
INSERT INTO servicio (nombre, tipo, precio_base) VALUES ('test negativo', 'TV', -1.00);

-- UQ_paquete_nombre: duplicado
INSERT INTO paquete (nombre, precio) VALUES ('combo hogar', 6000.00);

-- CHK_paquete_precio: precio negativo
INSERT INTO paquete (nombre, precio) VALUES ('pack invalido', -10.00);

-- PK_paquete_servicio: repetido
INSERT INTO paquete_servicio (id_paquete, id_servicio) VALUES (1, 1);

-- CHK_usuario_servicio_fechas: baja anterior al alta
INSERT INTO usuario_servicio (id_usuario, id_servicio, fecha_alta, fecha_baja) VALUES (1, 1, '2025-09-10', '2025-09-01');

-- CHK_usuario_paquete_fechas: baja anterior al alta
INSERT INTO usuario_paquete (id_usuario, id_paquete, fecha_alta, fecha_baja) VALUES (2, 1, '2025-09-10', '2025-09-01');

-- UQ_factura_nro: duplicado
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000001, 1, 1, 9, 2025, '2025-09-15', '2025-09-25', 1, 0.00, 100.00);

-- CHK_factura_mes: fuera de rango
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000099, 1, 1, 13, 2025, '2025-09-15', '2025-09-25', 1, 0.00, 100.00);

-- CHK_factura_anio: fuera de rango
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000100, 1, 1, 9, 1999, '2025-09-15', '2025-09-25', 1, 0.00, 100.00);

-- CHK_factura_total: total negativo
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000101, 1, 1, 9, 2025, '2025-09-15', '2025-09-25', 1, 0.00, -1.00);

-- FK_factura_usuario: usuario inexistente
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000102, 99, 1, 9, 2025, '2025-09-15', '2025-09-25', 1, 0.00, 100.00);

-- FK_factura_domicilio: domicilio inexistente
INSERT INTO factura (nro_factura, id_usuario, id_domicilio, periodo_mes, periodo_anio, fecha_emision, fecha_vencimiento, id_tipo_usuario_snapshot, porc_ajuste_snapshot, total) VALUES
(1000000103, 1, 99, 9, 2025, '2025-09-15', '2025-09-25', 1, 0.00, 100.00);

-- CHK_detalle_factura_tipo: valor inválido
INSERT INTO detalle_factura (id_factura, tipo_concepto, descripcion, precio_unit, cantidad) VALUES
(1, 'OTRO', 'invalido', 100.00, 1);

-- CHK_detalle_factura_fk: tipo SERVICIO sin id_servicio
INSERT INTO detalle_factura (id_factura, tipo_concepto, descripcion, precio_unit, cantidad) VALUES
(1, 'SERVICIO', 'falta id_servicio', 100.00, 1);

-- CHK_detalle_factura_fk: tipo PAQUETE sin id_paquete
INSERT INTO detalle_factura (id_factura, tipo_concepto, descripcion, precio_unit, cantidad) VALUES
(2, 'PAQUETE', 'falta id_paquete', 100.00, 1);

-- CHK_detalle_factura_precio: negativo
INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(1, 'SERVICIO', 1, 'precio negativo', -1.00, 1);

-- CHK_detalle_factura_cantidad: no positiva
INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(1, 'SERVICIO', 1, 'cantidad cero', 100.00, 0);

-- FK_detalle_factura_factura: factura inexistente
INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(99, 'SERVICIO', 1, 'factura inexistente', 100.00, 1);

-- FK_detalle_factura_servicio: servicio inexistente
INSERT INTO detalle_factura (id_factura, tipo_concepto, id_servicio, descripcion, precio_unit, cantidad) VALUES
(1, 'SERVICIO', 99, 'servicio inexistente', 100.00, 1);

-- FK_detalle_factura_paquete: paquete inexistente
INSERT INTO detalle_factura (id_factura, tipo_concepto, id_paquete, descripcion, precio_unit, cantidad) VALUES
(2, 'PAQUETE', 99, 'paquete inexistente', 100.00, 1);

-- =========================================
-- Consultas de verificación
-- =========================================
-- Zonas y calles
SELECT c.id_calle, c.nombre AS calle, z.nombre AS zona, c.codigo
FROM calle c
JOIN zona z ON c.id_zona = z.id_zona
ORDER BY z.nombre, c.nombre;

-- Usuarios con tipo y domicilios
SELECT u.id_usuario, u.nro_socio, u.apellido + ', ' + u.nombre AS usuario,
       tu.nombre AS tipo_usuario, tu.porc_ajuste,
       d.id_domicilio, ca.nombre AS calle, d.numero, d.piso, d.dto
FROM usuario u
JOIN tipo_usuario tu ON u.id_tipo_usuario = tu.id_tipo_usuario
LEFT JOIN domicilio d ON d.id_usuario = u.id_usuario
LEFT JOIN calle ca ON ca.id_calle = d.id_calle
ORDER BY u.id_usuario;

-- Servicios y paquetes
SELECT s.id_servicio, s.nombre, s.tipo, s.precio_base FROM servicio s ORDER BY s.id_servicio;
SELECT p.id_paquete, p.nombre, p.precio FROM paquete p ORDER BY p.id_paquete;

-- Detalle de paquetes y sus servicios
SELECT ps.id_paquete, p.nombre AS paquete, ps.id_servicio, s.nombre AS servicio
FROM paquete_servicio ps
JOIN paquete p ON p.id_paquete = ps.id_paquete
JOIN servicio s ON s.id_servicio = ps.id_servicio
ORDER BY ps.id_paquete, ps.id_servicio;

-- Altas de usuario por servicio/paquete vigentes (fecha_baja IS NULL)
SELECT 'servicio' AS tipo, us.id_usuario, u.apellido + ', ' + u.nombre AS usuario,
       s.nombre AS concepto, us.fecha_alta, us.fecha_baja
FROM usuario_servicio us
JOIN usuario u ON u.id_usuario = us.id_usuario
JOIN servicio s ON s.id_servicio = us.id_servicio
WHERE us.fecha_baja IS NULL
UNION ALL
SELECT 'paquete', up.id_usuario, u.apellido + ', ' + u.nombre,
       p.nombre, up.fecha_alta, up.fecha_baja
FROM usuario_paquete up
JOIN usuario u ON u.id_usuario = up.id_usuario
JOIN paquete p ON p.id_paquete = up.id_paquete
WHERE up.fecha_baja IS NULL
ORDER BY tipo, id_usuario;

-- Facturas con importes de detalle y cálculo
SELECT f.id_factura, f.nro_factura, f.id_usuario, f.id_domicilio,
       f.periodo_mes, f.periodo_anio, f.total,
       d.id_detalle, d.tipo_concepto, d.descripcion, d.precio_unit, d.cantidad, d.importe
FROM factura f
LEFT JOIN detalle_factura d ON d.id_factura = f.id_factura
ORDER BY f.id_factura, d.id_detalle;

-- Suma de detalle por factura vs total de factura
SELECT f.id_factura,
       SUM(d.importe) AS suma_detalles,
       f.total AS total_factura,
       (SUM(d.importe) - f.total) AS diferencia
FROM factura f
LEFT JOIN detalle_factura d ON d.id_factura = f.id_factura
GROUP BY f.id_factura, f.total
ORDER BY f.id_factura;
