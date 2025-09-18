-- Crear base de datos
CREATE DATABASE gestion_proyectos;
GO

-- Usar la base de datos
USE gestion_proyectos;
GO

-- Tabla de empleados
CREATE TABLE empleado (
    id_empleado INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) NOT NULL,
    CONSTRAINT PK_empleado PRIMARY KEY (id_empleado),
    CONSTRAINT UQ_empleado_correo UNIQUE (correo_electronico)
);

-- Tabla de roles
CREATE TABLE rol (
    id_rol INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_rol PRIMARY KEY (id_rol),
    CONSTRAINT UQ_rol_nombre UNIQUE (nombre)
);

-- Tabla de proyectos
CREATE TABLE proyecto (
    id_proyecto INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    CONSTRAINT PK_proyecto PRIMARY KEY (id_proyecto),
    CONSTRAINT CHK_proyecto_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

-- Tabla de asignaciones de empleados a proyectos
CREATE TABLE asignacion_empleado_proyecto (
    id_proyecto INT NOT NULL,
    id_empleado INT NOT NULL,
    id_rol INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    CONSTRAINT PK_asignacion_empleado_proyecto PRIMARY KEY (id_proyecto, id_empleado),
    CONSTRAINT FK_asignacion_proyecto FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
    CONSTRAINT FK_asignacion_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT FK_asignacion_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
    CONSTRAINT CHK_asignacion_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

-- Tabla de estados de tarea
CREATE TABLE estado_tarea (
    id_estado INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_estado PRIMARY KEY (id_estado),
    CONSTRAINT UQ_estado_nombre UNIQUE (nombre),
    CONSTRAINT CHK_estado_nombre CHECK (nombre IN ('Pendiente', 'En progreso', 'Finalizada'))
);

-- Tabla de tareas
CREATE TABLE tarea (
    id_tarea INT NOT NULL,
    id_proyecto INT NOT NULL,
    numero_orden INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    id_estado INT NOT NULL,
    
    -- Restricciones
    CONSTRAINT PK_tarea PRIMARY KEY (id_tarea),
    CONSTRAINT FK_tarea_proyecto FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
    CONSTRAINT FK_tarea_estado FOREIGN KEY (id_estado) REFERENCES estado_tarea(id_estado),
    CONSTRAINT UQ_tarea_orden UNIQUE (id_proyecto, numero_orden),
    CONSTRAINT CHK_tarea_fechas CHECK (fecha_fin >= fecha_inicio)
);
GO

-- Agregar restricción DEFAULT como instrucción separada
ALTER TABLE tarea
ADD CONSTRAINT DEF_tarea_estado DEFAULT 1 FOR id_estado;
GO













-- Insertar roles
INSERT INTO rol (id_rol, nombre) VALUES
(1, 'Director de Proyecto'),
(2, 'Analista Funcional'),
(3, 'Desarrollador'),
(4, 'Tester'),
(5, 'Diseñador');

-- Insertar estados de tarea
INSERT INTO estado_tarea (id_estado, nombre) VALUES
(1, 'Pendiente'),
(2, 'En progreso'),
(3, 'Finalizada');

-- Insertar empleados
INSERT INTO empleado (id_empleado, nombre, correo_electronico) VALUES
(1, 'Ana Torres', 'ana.torres@techsolutions.com'),
(2, 'Luis Gómez', 'luis.gomez@techsolutions.com'),
(3, 'María López', 'maria.lopez@techsolutions.com'),
(4, 'Carlos Ruiz', 'carlos.ruiz@techsolutions.com');

-- Insertar proyectos
INSERT INTO proyecto (id_proyecto, nombre, fecha_inicio, fecha_fin) VALUES
(1, 'Sistema de Inventario', '2025-08-01', NULL),
(2, 'Portal Web Clientes', '2025-07-15', '2025-09-30');

-- Insertar asignaciones
INSERT INTO asignacion_empleado_proyecto (id_proyecto, id_empleado, id_rol, fecha_inicio, fecha_fin) VALUES
(1, 1, 1, '2025-08-01', NULL), -- Ana como directora
(1, 2, 3, '2025-08-01', NULL), -- Luis como desarrollador
(1, 3, 2, '2025-08-05', NULL), -- María como analista
(2, 4, 4, '2025-07-15', '2025-09-30'); -- Carlos como tester

-- Insertar tareas
INSERT INTO tarea (id_tarea, id_proyecto, numero_orden, descripcion, fecha_inicio, fecha_fin, id_estado) VALUES
(1, 1, 1, 'Diseño de base de datos', '2025-08-01', '2025-08-05', 3),
(2, 1, 2, 'Desarrollo backend', '2025-08-06', '2025-08-20', 2),
(3, 1, 3, 'Pruebas unitarias', '2025-08-21', '2025-08-30', 1),
(4, 2, 1, 'Maquetado inicial', '2025-07-15', '2025-07-20', 3),
(5, 2, 2, 'Integración con API', '2025-07-21', '2025-08-10', 2);






-- Violación de UNIQUE en correo
INSERT INTO empleado (id_empleado, nombre, correo_electronico)
VALUES (5, 'Duplicado', 'ana.torres@techsolutions.com'); -- ERROR

-- Violación de CHECK en fechas
INSERT INTO tarea (id_tarea, id_proyecto, numero_orden, descripcion, fecha_inicio, fecha_fin, id_estado)
VALUES (6, 1, 4, 'Tarea inválida', '2025-08-10', '2025-08-01', 1); -- ERROR

-- Violación de PK en asignación (empleado ya asignado al proyecto)
INSERT INTO asignacion_empleado_proyecto (id_proyecto, id_empleado, id_rol, fecha_inicio, fecha_fin)
VALUES (1, 1, 2, '2025-08-10', NULL); -- ERROR






-- Ver todos los empleados
SELECT * FROM empleado;

-- Ver todos los roles
SELECT * FROM rol;

-- Ver todos los proyectos
SELECT * FROM proyecto;

-- Ver todas las asignaciones de empleados a proyectos con detalle
SELECT 
    a.id_proyecto,
    p.nombre AS nombre_proyecto,
    a.id_empleado,
    e.nombre AS nombre_empleado,
    r.nombre AS rol,
    a.fecha_inicio,
    a.fecha_fin
FROM asignacion_empleado_proyecto a
JOIN empleado e ON a.id_empleado = e.id_empleado
JOIN proyecto p ON a.id_proyecto = p.id_proyecto
JOIN rol r ON a.id_rol = r.id_rol;

-- Ver todos los estados de tarea
SELECT * FROM estado_tarea;

-- Ver todas las tareas con nombre de proyecto y estado
SELECT 
    t.id_tarea,
    t.id_proyecto,
    p.nombre AS nombre_proyecto,
    t.numero_orden,
    t.descripcion,
    t.fecha_inicio,
    t.fecha_fin,
    et.nombre AS estado
FROM tarea t
JOIN proyecto p ON t.id_proyecto = p.id_proyecto
JOIN estado_tarea et ON t.id_estado = et.id_estado;

-- Ver tareas pendientes por proyecto
SELECT 
    p.nombre AS proyecto,
    t.descripcion,
    t.fecha_inicio,
    t.fecha_fin
FROM tarea t
JOIN proyecto p ON t.id_proyecto = p.id_proyecto
JOIN estado_tarea e ON t.id_estado = e.id_estado
WHERE e.nombre = 'Pendiente';

-- Ver empleados asignados por rol y proyecto
SELECT 
    r.nombre AS rol,
    e.nombre AS empleado,
    p.nombre AS proyecto
FROM asignacion_empleado_proyecto a
JOIN empleado e ON a.id_empleado = e.id_empleado
JOIN rol r ON a.id_rol = r.id_rol
JOIN proyecto p ON a.id_proyecto = p.id_proyecto
ORDER BY r.nombre;
