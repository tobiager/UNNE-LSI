-- 1. Probar UNIQUE en empleados (correo duplicado)
INSERT INTO empleados (empleado_id, nombre, correo)
VALUES (5, 'Juan Test', 'ana.lopez@tech.com');  -- ERROR: correo ya existe

-- 2. Probar CHECK en tareas (orden positivo)
INSERT INTO tareas (tarea_id, proyecto_id, orden, descripcion, fecha_inicio, fecha_fin, estado_id)
VALUES (5, 1, -1, 'Orden inválido', '2025-01-20', NULL, 1); -- ERROR: CK_TAREAS_ORDEN_POS

-- 3. Probar PK compuesta en asignaciones (mismo empleado dos veces en un proyecto)
INSERT INTO asignaciones (proyecto_id, empleado_id, rol_id, fecha_inicio, fecha_fin)
VALUES (1, 1, 2, '2025-01-20', NULL); -- ERROR: PK_ASIGNACIONES
