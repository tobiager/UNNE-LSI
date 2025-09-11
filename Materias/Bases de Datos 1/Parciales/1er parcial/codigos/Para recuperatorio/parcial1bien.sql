CREATE DATABASE marketplaces;
USE marketplaces;

-- Tabla vendedor
CREATE TABLE vendedor
(
  cuit_vendedor INT NOT NULL,
  nombre_apellido VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  email VARCHAR(100),
  CONSTRAINT PK_vendedor PRIMARY KEY (cuit_vendedor),
  CONSTRAINT UQ_vendedor_email UNIQUE (email),
  CONSTRAINT CK_vendedor_edad CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 18)
);

-- Tabla categoria
CREATE TABLE categoria
(
  id_categoria INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_categoria PRIMARY KEY (id_categoria)
);

-- Tabla material
CREATE TABLE material
(
  id_material INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_material PRIMARY KEY (id_material)
);

-- Tabla metodo_pago
CREATE TABLE metodo_pago
(
  id_pago INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_metodo_pago PRIMARY KEY (id_pago)
);

-- Tabla ciudad
CREATE TABLE ciudad
(
  id_ciudad INT NOT NULL,
  nombre VARCHAR(200) NOT NULL,
  CONSTRAINT PK_ciudad PRIMARY KEY (id_ciudad)
);

-- Tabla producto
CREATE TABLE producto
(
  id_producto INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200),
  precio FLOAT NOT NULL,
  status_publicacion VARCHAR(10) NOT NULL,
  fecha_publicación DATE CONSTRAINT DF_producto_fecha_publicacion DEFAULT GETDATE(),
  id_categoria INT NOT NULL,
  cuit_vendedor INT NOT NULL,
  CONSTRAINT PK_producto PRIMARY KEY (id_producto),
  CONSTRAINT FK_producto_vendedor FOREIGN KEY (cuit_vendedor) REFERENCES vendedor(cuit_vendedor),
  CONSTRAINT FK_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
  CONSTRAINT CK_producto_status_publicacion CHECK (status_publicacion IN ('activa', 'pausada'))
);

-- Tabla cliente
CREATE TABLE cliente
(
  dni INT NOT NULL,
  nombre_apellido VARCHAR(100) NOT NULL,
  domicilio VARCHAR(200) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(50),
  id_ciudad INT NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (dni),
  CONSTRAINT FK_cliente_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
  CONSTRAINT UQ_cliente_email UNIQUE (email),
  CONSTRAINT UQ_cliente_telefono UNIQUE (telefono)
);

-- Tabla venta
CREATE TABLE venta
(
  nro_venta INT NOT NULL,
  nro_factura INT NOT NULL,
  fecha_venta DATE NOT NULL,
  dni INT NOT NULL,
  CONSTRAINT PK_venta PRIMARY KEY (nro_venta),
  CONSTRAINT FK_venta_cliente FOREIGN KEY (dni) REFERENCES cliente(dni)
);

-- Tabla venta_detalle
CREATE TABLE venta_detalle
(
  cantidad INT NOT NULL,
  precio_venta FLOAT NOT NULL,
  nro_venta INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_venta_detalle PRIMARY KEY (nro_venta, id_producto),
  CONSTRAINT FK_venta_detalle_venta FOREIGN KEY (nro_venta) REFERENCES venta(nro_venta),
  CONSTRAINT FK_venta_detalle_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Tabla resena
CREATE TABLE resena
(
  id_resena INT NOT NULL,
  calificacion INT NOT NULL,
  comentario VARCHAR(200) NOT NULL,
  nro_venta INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_resena PRIMARY KEY (id_resena, nro_venta, id_producto),
  CONSTRAINT FK_resena_venta_detalle FOREIGN KEY (nro_venta, id_producto) REFERENCES venta_detalle(nro_venta, id_producto),
  CONSTRAINT CK_resena_calificacion CHECK (calificacion BETWEEN 1 AND 10)
);

-- Tabla producto_material
CREATE TABLE producto_material
(
  porcentaje INT NOT NULL,
  id_producto INT NOT NULL,
  id_material INT NOT NULL,
  CONSTRAINT PK_producto_material PRIMARY KEY (id_producto, id_material),
  CONSTRAINT FK_producto_material_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  CONSTRAINT FK_producto_material_material FOREIGN KEY (id_material) REFERENCES material(id_material)
);

-- Tabla pago
CREATE TABLE pago
(
  importe FLOAT NOT NULL,
  nro_venta INT NOT NULL,
  id_pago INT NOT NULL,
  CONSTRAINT PK_pago PRIMARY KEY (nro_venta, id_pago),
  CONSTRAINT FK_pago_venta FOREIGN KEY (nro_venta) REFERENCES venta(nro_venta),
  CONSTRAINT FK_pago_metodo_pago FOREIGN KEY (id_pago) REFERENCES metodo_pago(id_pago)
);


-- Lote de datos representativo
-- tabla vendedor
INSERT INTO vendedor (cuit_vendedor, nombre_apellido, fecha_nacimiento, email) 
VALUES 
(123456789, 'Juan Perez', '1980-05-20', 'juan.perez@example.com'),
(987654321, 'Ana Lopez', '1995-03-15', 'ana.lopez@example.com');

-- tabla categoria
INSERT INTO categoria (id_categoria, nombre) 
VALUES 
(1, 'Construcción'),
(2, 'Decoración');

-- tabla material
INSERT INTO material (id_material, nombre) 
VALUES 
(1, 'Cemento'),
(2, 'Piedra');

-- tabla metodo_pago
INSERT INTO metodo_pago (id_pago, nombre) 
VALUES 
(1, 'Tarjeta de Crédito'),
(2, 'Efectivo');

-- tabla ciudad
INSERT INTO ciudad (id_ciudad, nombre) 
VALUES 
(1, 'Buenos Aires'),
(2, 'Rosario');

-- tabla producto
INSERT INTO producto (id_producto, nombre, descripcion, precio, status_publicacion, id_categoria) 
VALUES 
(1, 'Ladrillo', 'Ladrillo rojo de alta calidad', 10.50, 'activa', 1),
(2, 'Pintura', 'Pintura blanca para interiores', 25.00, 'pausada', 2);

-- tabla cliente
INSERT INTO cliente (dni, nombre_apellido, domicilio, email, telefono, id_ciudad) 
VALUES 
(12345678, 'Maria Garcia', 'Calle Falsa 123', 'maria.garcia@example.com', '555-1234', 1),
(87654321, 'Carlos Gutierrez', 'Av. Siempre Viva 742', 'carlos.gutierrez@example.com', NULL, 2);

-- tabla venta
INSERT INTO venta (nro_venta, nro_factura, fecha_venta, cuit_vendedor, dni) 
VALUES 
(1, 1001, '2024-09-10', 123456789, 12345678),
(2, 1002, '2024-09-11', 987654321, 87654321);

-- tabla venta_detalle
INSERT INTO venta_detalle (cantidad, precio_venta, nro_venta, id_producto) 
VALUES 
(10, 10.50, 1, 1),  -- Ladrillo
(5, 25.00, 2, 2);   -- Pintura

-- tabla resena
INSERT INTO resena (id_resena, calificacion, comentario, nro_venta, id_producto) 
VALUES 
(1, 8, 'Buen producto, recomendado', 1, 1),
(2, 7, 'Cumple su función', 2, 2);

-- tabla producto_material
INSERT INTO producto_material (porcentaje, id_producto, id_material) 
VALUES 
(60, 1, 1),  -- Ladrillo con Cemento
(40, 1, 2);  -- Ladrillo con Piedra

-- tabla pago
INSERT INTO pago (importe, nro_venta, id_pago) 
VALUES 
(105.00, 1, 1),  -- Pago con Tarjeta de Crédito
(125.00, 2, 2);  -- Pago en Efectivo


SELECT * FROM vendedor;
SELECT * FROM categoria;
SELECT * FROM material;
SELECT * FROM metodo_pago;
SELECT * FROM ciudad;
SELECT * FROM producto;
SELECT * FROM cliente;
SELECT * FROM venta;
SELECT * FROM venta_detalle;
SELECT * FROM resena;
SELECT * FROM producto_material;
SELECT * FROM pago;


-- -----------------------------------------
-- LOTE DE PRUEBA (ejemplo)
-- -----------------------------------------

-- tabla vendedor
-- INSERT inválido (edad menor a 18 años)
INSERT INTO vendedor (cuit_vendedor, nombre_apellido, fecha_nacimiento, email) 
VALUES (987654321, 'Pedro Lopez', '2010-01-01', 'pedro.lopez@example.com');


GO
-- tabla producto
-- INSERT inválido (status no válido)
INSERT INTO producto (id_producto, nombre, descripcion, precio, status_publicacion, id_categoria) 
VALUES (2, 'Arena', 'Arena fina', 5.25, 'vendida', 1);


GO
-- Insert para probar la restricción UNIQUE en el DNI de cliente y el email
-- INSERT inválido (DNI duplicado)
INSERT INTO cliente (dni, nombre_apellido, domicilio, email, telefono, id_ciudad) 
VALUES (12345678, 'Jose Gomez', 'Av. Siempre Viva 742', 'jose.gomez@example.com', '555-5678', 1);

GO
-- Insert para probar la restricción CHECK en calificación de la tabla resena
-- Insert inválido (calificación fuera de rango)
INSERT INTO resena (id_resena, calificacion, comentario, nro_venta, id_producto) 
VALUES (2, 15, 'Excelente', 1, 1);
-- Esto debería fallar debido a la restricción CK_resena_calificacion


