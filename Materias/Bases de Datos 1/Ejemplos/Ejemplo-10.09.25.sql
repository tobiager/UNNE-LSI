/* ==========================================================
   EMPRESA — MODELO DE RESERVAS (versión corregida)
   - Sin ciclos de cascada: equipo y reserva referencian solo a sala
   - Edificio se obtiene vía sala (sala -> edificio)
   ========================================================== */
USE master;
GO
IF DB_ID('EmpresaReservas') IS NOT NULL
BEGIN
  ALTER DATABASE EmpresaReservas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE EmpresaReservas;
END;
GO
CREATE DATABASE EmpresaReservas;
GO
USE EmpresaReservas;
GO

/* =================== TABLAS =================== */

/* 1) Departamento */
CREATE TABLE departamento (
  codigo_departamento INT        NOT NULL PRIMARY KEY,
  nombre              VARCHAR(80) NOT NULL
);

/* 2) Empleado */
CREATE TABLE empleado (
  dni_empleado        CHAR(8)     NOT NULL PRIMARY KEY,
  nombre              VARCHAR(50) NOT NULL,
  apellido            VARCHAR(50) NOT NULL,
  fecha_nacimiento    DATE        NOT NULL,
  CUIT                CHAR(11)    NOT NULL UNIQUE,
  email               VARCHAR(100)     NULL UNIQUE,
  codigo_departamento INT         NOT NULL,
  CONSTRAINT fk_empleado_departamento
    FOREIGN KEY (codigo_departamento)
    REFERENCES departamento(codigo_departamento)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
  CONSTRAINT ck_dni_8dig CHECK (dni_empleado NOT LIKE '%[^0-9]%' AND LEN(dni_empleado)=8),
  CONSTRAINT ck_cuit_11 CHECK (CUIT NOT LIKE '%[^0-9]%' AND LEN(CUIT)=11),
  CONSTRAINT ck_email_forma CHECK (email IS NULL OR email LIKE '%@%.%')
);

/* 3) Contactos telefónicos del empleado (multivaluado) */
CREATE TABLE empleado_contacto_telefonico (
  dni_empleado       CHAR(8)     NOT NULL,
  contacto_telefonico VARCHAR(20) NOT NULL,
  CONSTRAINT pk_empleado_contacto PRIMARY KEY (dni_empleado, contacto_telefonico),
  CONSTRAINT fk_contacto_empleado
    FOREIGN KEY (dni_empleado)
    REFERENCES empleado(dni_empleado)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

/* 4) Edificio */
CREATE TABLE edificio (
  codigo_edificio INT         NOT NULL PRIMARY KEY,
  telefono_iso    VARCHAR(20) NULL,
  calle           VARCHAR(50) NULL,
  numero          INT         NULL,
  codigo_postal   VARCHAR(10) NULL,
  nombre_ciudad   VARCHAR(50) NULL
);

/* 5) Sala (pertenece a un edificio) */
CREATE TABLE sala (
  codigo_sala     INT         NOT NULL PRIMARY KEY,
  ubicacion       VARCHAR(100) NOT NULL,
  codigo_edificio INT         NOT NULL,
  CONSTRAINT fk_sala_edificio
    FOREIGN KEY (codigo_edificio)
    REFERENCES edificio(codigo_edificio)
    ON UPDATE CASCADE
    ON DELETE CASCADE   -- si se elimina un edificio, caen sus salas
);

/* 6) Equipo (está en UNA sala -> edificio se infiere por la sala) */
CREATE TABLE equipo (
  numero_inventario INT          NOT NULL PRIMARY KEY,
  modelo            VARCHAR(50)  NOT NULL,
  descripcion       VARCHAR(100) NULL,
  codigo_sala       INT          NOT NULL,
  CONSTRAINT fk_equipo_sala
    FOREIGN KEY (codigo_sala)
    REFERENCES sala(codigo_sala)
    ON UPDATE CASCADE
    ON DELETE CASCADE   -- si se borra la sala, se eliminan sus equipos
);

/* 7) Reserva (empleado reserva una sala en una fecha/hora) */
CREATE TABLE reserva (
  dni_empleado    CHAR(8)  NOT NULL,
  codigo_sala     INT      NOT NULL,
  fecha_reserva   DATE     NOT NULL,
  hora_inicio     TIME     NOT NULL,
  hora_fin        TIME     NOT NULL,
  duracion AS DATEDIFF(MINUTE, hora_inicio, hora_fin),
  CONSTRAINT pk_reserva PRIMARY KEY (dni_empleado, codigo_sala, fecha_reserva, hora_inicio),
  CONSTRAINT fk_reserva_empleado
    FOREIGN KEY (dni_empleado)
    REFERENCES empleado(dni_empleado)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_reserva_sala
    FOREIGN KEY (codigo_sala)
    REFERENCES sala(codigo_sala)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,  -- mantener reservas históricas si se decide bloquear borrado de sala
  CONSTRAINT ck_horas_validas CHECK (hora_fin > hora_inicio)
);

/* =================== ÍNDICES ÚTILES =================== */
CREATE INDEX IX_empleado_apellido_nombre ON empleado(apellido, nombre);
CREATE INDEX IX_reserva_sala_fecha ON reserva(codigo_sala, fecha_reserva, hora_inicio);

/* =================== DATOS DE PRUEBA =================== */
INSERT INTO departamento VALUES (1,'Sistemas'),(2,'RRHH');

INSERT INTO empleado (dni_empleado,nombre,apellido,fecha_nacimiento,CUIT,email,codigo_departamento) VALUES
('12345678','Juan','Pérez','1990-05-20','20123456789','juan@empresa.com',1),
('87654321','Ana','Gómez','1992-03-15','20987654321','ana@empresa.com',2);

INSERT INTO empleado_contacto_telefonico VALUES
('12345678','3794123456'),
('12345678','3794987654'),
('87654321','3794555666');

INSERT INTO edificio VALUES
(100,'3794-123456','Av. Siempre Viva',742,'3400','Corrientes'),
(200,'3794-987654','San Martín',123,'3400','Resistencia');

INSERT INTO sala VALUES
(10,'Piso 1 - Sala de reuniones',100),
(20,'Piso 2 - Laboratorio',200);

INSERT INTO equipo VALUES
(1000,'Dell Optiplex','PC escritorio',10),
(2000,'HP Server','Servidor Rack',20);

INSERT INTO reserva (dni_empleado,codigo_sala,fecha_reserva,hora_inicio,hora_fin) VALUES
('12345678',10,'2025-09-15','10:00','12:00'),
('87654321',20,'2025-09-16','08:30','09:30');

GO

/* =================== CONSULTAS DE PRÁCTICA =================== */
-- 1) Empleados y su departamento
SELECT e.apellido, e.nombre, d.nombre AS departamento
FROM empleado e
JOIN departamento d ON d.codigo_departamento=e.codigo_departamento
ORDER BY e.apellido, e.nombre;

-- 2) Reservas con empleado, sala y edificio (edificio vía sala)
SELECT r.fecha_reserva, r.hora_inicio, r.hora_fin, r.duracion,
       e.apellido, e.nombre,
       s.ubicacion,
       ed.nombre_ciudad AS ciudad, ed.calle, ed.numero
FROM reserva r
JOIN empleado e ON e.dni_empleado=r.dni_empleado
JOIN sala s     ON s.codigo_sala=r.codigo_sala
JOIN edificio ed ON ed.codigo_edificio=s.codigo_edificio
ORDER BY r.fecha_reserva, r.hora_inicio;

-- 3) Equipos por edificio (vía sala)
SELECT ed.nombre_ciudad, s.ubicacion, eq.numero_inventario, eq.modelo
FROM equipo eq
JOIN sala s       ON s.codigo_sala=eq.codigo_sala
JOIN edificio ed  ON ed.codigo_edificio=s.codigo_edificio
ORDER BY ed.nombre_ciudad, s.ubicacion, eq.numero_inventario;
