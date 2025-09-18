CREATE DATABASE primer_parcial_2024;
GO
USE primer_parcial_2024;
GO

/*
CUIT validando que sea una cadena numerica y de 11 digitos y que la EDAD del vendedor sea 18 o mayor
*/
CREATE TABLE Vendedor
(
  cuit VARCHAR(11) NOT NULL CONSTRAINT CK_cuit_valido CHECK (LEN(cuit) = 11 AND cuit NOT LIKE '%[^0-9]%'),
  nombre VARCHAR(30) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  correo VARCHAR(40) NOT NULL,
  CONSTRAINT PK_cuit PRIMARY KEY (cuit),
  CONSTRAINT UQ_cuit UNIQUE (cuit),
  CONSTRAINT UQ_correo UNIQUE (correo),
  CONSTRAINT CK_vendedor_mayor CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 18)
);

/*
Estado puede ser ACTIVO o PAUSADA y DEFAULT de fecha de actual
*/
CREATE TABLE Producto
(
  nombre VARCHAR(30) NOT NULL,
  descripcion VARCHAR(40),
  precio DECIMAL(12,2) NOT NULL,
  categoria VARCHAR(40) NOT NULL,
  id_producto INT NOT NULL,
  estado VARCHAR(30) NOT NULL CHECK (estado IN ('activo','pausada')),
  fecha_publicacion DATE NOT NULL DEFAULT GETDATE(),
  cuit VARCHAR(11) NOT NULL,
  CONSTRAINT PK_producto PRIMARY KEY (id_producto),
  CONSTRAINT FK_cuit_vendedor FOREIGN KEY (cuit) REFERENCES Vendedor(cuit),
  CONSTRAINT UQ_id_producto UNIQUE (id_producto)
);

CREATE TABLE Material
(
  material VARCHAR(40) NOT NULL,
  id_material INT NOT NULL,
  CONSTRAINT PK_id_material PRIMARY KEY (id_material),
  CONSTRAINT UQ_material UNIQUE (material)
);

/*
dni del cliente numerico y de 8 digitos
*/
CREATE TABLE Cliente
(
  dni VARCHAR(8) NOT NULL CONSTRAINT CK_dni_valido CHECK (LEN(dni) = 8 AND dni NOT LIKE '%[^0-9]%'),
  apellido VARCHAR(40) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  domicilio VARCHAR(30) NOT NULL,
  ciudad VARCHAR(40) NOT NULL,
  correo VARCHAR(40) NOT NULL,
  numero_telefono VARCHAR(30),
  id_cliente INT NOT NULL,
  CONSTRAINT PK_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT UQ_correo UNIQUE (correo),
  CONSTRAINT UQ_telefono UNIQUE (numero_telefono),
  CONSTRAINT UQ_cliente UNIQUE (id_cliente),
  CONSTRAINT UQ_dni UNIQUE (dni)
);

/*
DEFAULT de fecha actual, el total decimal mayor a 0
*/
CREATE TABLE Ventas
(
  id_venta INT NOT NULL,
  fecha DATETIME NOT NULL DEFAULT GETDATE(),
  numero_facturacion INT NOT NULL,
  total DECIMAL(12,2) NOT NULL CHECK (total >= 0),
  cuit CHAR(11) NOT NULL,
  id_cliente INT NOT NULL,
  CONSTRAINT PK_id_venta PRIMARY KEY (id_venta),
  CONSTRAINT FK_cuit FOREIGN KEY (cuit) REFERENCES Vendedor(cuit),
  CONSTRAINT FK_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  CONSTRAINT UQ_venta UNIQUE (id_venta),
  CONSTRAINT UQ_facturacion UNIQUE (numero_facturacion)
);

CREATE TABLE Metodo_de_pago
(
  nombre VARCHAR(40) NOT NULL,
  tipo VARCHAR(40) NOT NULL,
  CONSTRAINT PK_nombre PRIMARY KEY (nombre)
);

CREATE TABLE Asignar_metodo
(
  nombre VARCHAR(40) NOT NULL,
  id_venta INT NOT NULL,
  CONSTRAINT FK_nombre FOREIGN KEY (nombre) REFERENCES Metodo_de_pago(nombre),
  CONSTRAINT FK_id_venta FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta)
);
/*
La cantidad y el precio >0
*/
CREATE TABLE Venta_detalles
(
  cantidad INT NOT NULL CHECK (cantidad > 0),
  precio DECIMAL(12,2) NOT NULL CHECK (precio > 0),
  id_venta INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_id_venta_producto PRIMARY KEY (id_venta, id_producto),
  CONSTRAINT FK_id_venta FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
  CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

/*
La calificacion del 1-10
*/
CREATE TABLE Reseña
(
  calificacion TINYINT NOT NULL CONSTRAINT CK_reseña_clasificacion CHECK (calificacion BETWEEN 1 AND 10),
  comentario VARCHAR(60) NOT NULL,
  id_reseña INT NOT NULL,
  id_cliente INT NOT NULL,
  id_venta INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT PK_id_reseña PRIMARY KEY (id_reseña),
  CONSTRAINT FK_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  CONSTRAINT FK_id_venta_producto FOREIGN KEY (id_venta, id_producto) REFERENCES Venta_detalles(id_venta, id_producto)
);

CREATE TABLE Producto_material
(
  porcentaje TINYINT NOT NULL,
  id_material INT NOT NULL,
  id_producto INT NOT NULL,
  CONSTRAINT FK_id_material FOREIGN KEY (id_material) REFERENCES Material(id_material),
  CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  CONSTRAINT UQ_id_material_producto UNIQUE (id_material, id_producto)
);

