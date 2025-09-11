CREATE DATABASE marketplaces7;
USE marketplaces7;


CREATE TABLE categoria
(
  nombre VARCHAR(100) NOT NULL,
  id_categoria INT NOT NULL,
  CONSTRAINT PK_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE vendedor
(
  cuit_vendedor INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  email VARCHAR(100),
  CONSTRAINT PK_vendedor PRIMARY KEY (cuit_vendedor),
  CONSTRAINT UQ_vendedor_email UNIQUE (email),
  CONSTRAINT CK_vendedor_edad CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 18)
);

CREATE TABLE metodo_pago
(
  nombre VARCHAR(100) NOT NULL,
  id_pago INT NOT NULL,
  CONSTRAINT PK_metodo_pago PRIMARY KEY (id_pago)
);

CREATE TABLE ciudad
(
  id_ciudad INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_ciudad PRIMARY KEY (id_ciudad)
);

CREATE TABLE material
(
  id_material INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  CONSTRAINT PK_material PRIMARY KEY (id_material)
);

CREATE TABLE producto
(
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(100),
  precio FLOAT NOT NULL,
  status_publicacion VARCHAR(10) NOT NULL,
  fecha_publicacion DATE CONSTRAINT DF_producto_fecha_publicacion DEFAULT GETDATE(),
  id_producto INT NOT NULL,
  id_categoria INT NOT NULL,
  cuit_vendedor INT NOT NULL,
  CONSTRAINT PK_producto PRIMARY KEY (id_producto),
  CONSTRAINT FK_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
  CONSTRAINT FK_producto_vendedor FOREIGN KEY (cuit_vendedor) REFERENCES vendedor(cuit_vendedor),
  CONSTRAINT UQ_producto_fecha_publicacion UNIQUE (fecha_publicacion)
  CONSTRAINT CK_producto_status_publicacion CHECK (status_publicacion IN ('activa', 'pausada'))
);

CREATE TABLE cliente
(
  dni INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  domicilio VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(50),
  id_ciudad INT NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (dni),
  CONSTRAINT FK_cliente_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
  CONSTRAINT UQ_cliente_email UNIQUE (email),
  CONSTRAINT UQ_cliente_telefono UNIQUE (telefono)
);

CREATE TABLE producto_material
(
  id_material INT NOT NULL,
  porcentaje INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_producto_material PRIMARY KEY (id_material, id_producto),
  CONSTRAINT FK_producto_material_id_material FOREIGN KEY (id_material) REFERENCES material(id_material),
  CONSTRAINT FK_producto_material_id_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE venta
(
  nro_venta INT NOT NULL,
  nro_factura INT NOT NULL,
  fecha_venta DATE NOT NULL,
  dni INT NOT NULL,
  CONSTRAINT PK_venta PRIMARY KEY (nro_venta),
  CONSTRAINT FK_venta_DNI FOREIGN KEY (dni) REFERENCES cliente(dni)
);

CREATE TABLE pago
(
  importe INT NOT NULL,
  id_pago INT NOT NULL,
  nro_venta INT NOT NULL,
  CONSTRAINT PK_pago PRIMARY KEY (id_pago, nro_venta),
  CONSTRAINT FK_pago_id_pago FOREIGN KEY (id_pago) REFERENCES metodo_pago(id_pago),
  CONSTRAINT FK_pago_nro_venta FOREIGN KEY (nro_venta) REFERENCES venta(nro_venta)
);

CREATE TABLE venta_detalle
(
  cantidad INT NOT NULL,
  precio_venta INT NOT NULL,
  nro_venta INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_venta_detalle PRIMARY KEY (nro_venta, id_producto),
  CONSTRAINT FK_venta_detalle_nro_venta FOREIGN KEY (nro_venta) REFERENCES venta(nro_venta),
  CONSTRAINT venta_detalle_id_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE resena
(
  id_resena INT NOT NULL,
  calificacion INT NOT NULL,
  comentario VARCHAR(100) NOT NULL,
  nro_venta INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_resena PRIMARY KEY (id_resena, nro_venta, id_producto),
  CONSTRAINT FK_resena_nro_venta_id_producto FOREIGN KEY (nro_venta, id_producto) REFERENCES venta_detalle(nro_venta, id_producto),
  CONSTRAINT CK_resena_calificacion CHECK (calificacion BETWEEN 1 AND 10)
);

--Lote de prueba 

INSERT INTO vendedor (cuit_vendedor, nombre, apellido, fecha_nacimiento, email) 
VALUES 
(123456789, 'Juan', 'Perez', '1980-05-20', 'juan.perez@example.com'),
(987654321, 'Ana', 'Lopez', '1995-03-15', 'ana.lopez@example.com');

INSERT INTO categoria (id_categoria, nombre) 
VALUES 
(1, 'hogar'),
(2, 'jardin'),
(3, 'decoracion');

INSERT INTO producto (id_producto, nombre, descripcion, precio, status_publicacion, fecha_publicacion, id_categoria, cuit_vendedor) 
VALUES 
(1, 'celular', 'Alta gama', 100, 'activa', 2023-12-20, 1, 1),
(2, 'Pomelo', 'Amarillo', 50, 'pausada', 2021-12-19, 2, 2);


INSERT INTO producto_material (id_producto, id_material, porcentaje) 
VALUES 
(1, 1, 60),
(2, 2, 40);

INSERT INTO material (id_material, nombre) 
VALUES 
(1, 'madera'),
(2, 'metal'),
(3, 'vidrio');

INSERT INTO venta_detalle (nro_venta, id_producto, cantidad, precio_venta) 
VALUES 
(1, 1, 2, 50),
(2, 2, 4, 100);

INSERT INTO venta (nro_venta, nro_factura, fecha_venta, dni) 
VALUES 
(1, 1, 20/4/2019, 20147554), 
(2, 2, 20/4/2018, 21147554); 

INSERT INTO pago (nro_venta, id_pago, importe) 
VALUES 
(1, 1, 100), 
(2, 2, 50),                                      
(3, 3, 50);

INSERT INTO metodo_pago (id_pago, nombre) 
VALUES 
(1, 'Efectivo'), 
(2, 'Tarjeta credito'), 
(3, 'Transferencia bancaria'); 

INSERT INTO cliente (dni, nombre, apellido, domicilio, email, telefono, id_ciudad) 
VALUES 
(20154558, 'Lucas', 'Romani', 'Roca 1021', 'lr@gmail.com', '379-5013454', 1). 
(20154558, 'Marcos', 'Galperin', 'Bolivar 1021', 'mr@gmail.com', '379-5013478', 2); 

INSERT INTO cliente (id_ciudad, nombre) 
VALUES 
(1, 'Corrientes'),
(2, 'Parana');  

SELECT FROM * resena; 
SELECT FROM * venta_detalle;
SELECT FROM * producto_material;
SELECT FROM * producto;
SELECT FROM * material;
SELECT FROM * venta;
SELECT FROM * vendedor;
SELECT FROM * pago;
SELECT FROM * metodo_pago;
SELECT FROM * cliente;
SELECT FROM * ciudad;


--Pruebas restricciones
-- tabla vendedor
-- INSERT inv�lido (edad menor a 18 a�os)
INSERT INTO vendedor (cuit_vendedor, nombre_apellido, fecha_nacimiento, email) 
VALUES (987654321, 'Pedro Lopez', '2010-01-01', 'pedro.lopez@example.com');


GO
-- tabla producto
-- INSERT inv�lido (status no v�lido)
INSERT INTO producto (id_producto, nombre, descripcion, precio, status_publicacion, id_categoria) 
VALUES (2, 'Arena', 'Arena fina', 5.25, 'vendida', 1);


GO
-- Insert para probar la restricci�n UNIQUE en el DNI de cliente y el email
-- INSERT inv�lido (DNI duplicado)
INSERT INTO cliente (dni, nombre_apellido, domicilio, email, telefono, id_ciudad) 
VALUES (12345678, 'Jose Gomez', 'Av. Siempre Viva 742', 'jose.gomez@example.com', '555-5678', 1);

GO
-- Insert para probar la restricci�n CHECK en calificaci�n de la tabla resena
-- Insert inv�lido (calificaci�n fuera de rango)
INSERT INTO resena (id_resena, calificacion, comentario, nro_venta, id_producto) 
VALUES (2, 15, 'Excelente', 1, 1);
-- Esto deber�a fallar debido a la restricci�n CK_resena_calificacion






