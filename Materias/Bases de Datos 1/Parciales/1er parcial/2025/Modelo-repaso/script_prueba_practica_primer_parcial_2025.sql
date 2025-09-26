USE practica_primer_parcial_2025;
GO

/*========================
  EMPLEADOS
  ========================*/
INSERT INTO empleados (empleado_id, nombre, correo)
VALUES 
  (1, 'Ana Lopez', 'ana.lopez@tech.com'),
  (2, 'Bruno Martinez', 'bruno.martinez@tech.com'),
  (3, 'Carla Gomez', 'carla.gomez@tech.com'),
  (4, 'Diego Perez', 'diego.perez@tech.com');
GO

/*========================
  PROYECTOS
  ========================*/
INSERT INTO proyectos (proyecto_id, nombre, fecha_inicio, fecha_fin)
VALUES
  (1, 'Sistema de Inventario', '2025-01-10', NULL),
  (2, 'Plataforma E-commerce', '2025-02-01', NULL);
GO

/*========================
  ASIGNACIONES (empleados en proyectos con rol)
  ========================*/
INSERT INTO asignaciones (proyecto_id, empleado_id, rol_id, fecha_inicio, fecha_fin)
VALUES
  (1, 1, 1, '2025-01-10', NULL), -- Ana = directora proyecto 1
  (1, 2, 3, '2025-01-12', NULL), -- Bruno = desarrollador
  (1, 3, 4, '2025-01-12', NULL), -- Carla = tester
  (2, 1, 2, '2025-02-01', NULL), -- Ana = analista en proyecto 2
  (2, 4, 3, '2025-02-02', NULL); -- Diego = desarrollador
GO

/*========================
  TAREAS de proyectos
  ========================*/
INSERT INTO tareas (tarea_id, proyecto_id, orden, descripcion, fecha_inicio, fecha_fin, estado_id)
VALUES
  (1, 1, 1, 'Relevar requisitos', '2025-01-10', '2025-01-15', 3), -- finalizada
  (2, 1, 2, 'Diseñar base de datos', '2025-01-16', NULL, 2),       -- en progreso
  (3, 2, 1, 'Configurar hosting', '2025-02-01', NULL, 1),          -- pendiente
  (4, 2, 2, 'Desarrollar frontend', '2025-02-05', NULL, 1);        -- pendiente
GO

/*========================
  CHEQUEO RÁPIDO
  ========================*/
SELECT * FROM empleados;
SELECT * FROM proyectos;
SELECT * FROM asignaciones;
SELECT * FROM tareas;
