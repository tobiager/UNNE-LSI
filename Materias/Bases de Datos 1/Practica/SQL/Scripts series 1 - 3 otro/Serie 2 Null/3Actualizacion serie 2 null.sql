USE consorcio_test_update;
GO

-- ======================================================
-- Lote de actualización para insertar valores NULL
-- ======================================================

-- Tabla administrador
UPDATE administrador
SET vive_ahi = NULL
WHERE administrador_id % 5 = 0;

-- Tabla conserje
UPDATE conserje
SET jornada_laboral = NULL
WHERE conserje_id % 4 = 0;

-- Tabla edificio
UPDATE edificio
SET direccion = NULL
WHERE edificio_id % 6 = 0;

UPDATE edificio
SET nombre = NULL
WHERE edificio_id % 10 = 0;

UPDATE edificio
SET zona_id = NULL
WHERE zona_id % 5 = 0;

UPDATE edificio
SET administrador_id = NULL
WHERE administrador_id % 7 = 0;

UPDATE edificio
SET conserje_id = NULL
WHERE conserje_id % 5 = 0;

-- Tabla gasto
UPDATE gasto
SET importe = NULL
WHERE gasto_id % 8 = 0;

UPDATE gasto
SET fecha_pago = NULL
WHERE gasto_id % 12 = 0;

UPDATE gasto
SET tipo_gasto_id = NULL
WHERE tipo_gasto_id % 6 = 0;

UPDATE gasto
SET periodo = NULL
WHERE gasto_id % 10 = 0;

UPDATE gasto
SET provincia_id = NULL
WHERE gasto_id % 9 = 0;

UPDATE gasto
SET localidad_id = NULL
WHERE gasto_id % 15 = 0;

UPDATE gasto
SET edificio_id = NULL
WHERE gasto_id % 11 = 0;

-- Tabla localidad
UPDATE localidad
SET nombre = NULL
WHERE localidad_id % 5 = 0;

-- Tabla persona
UPDATE persona
SET telefono = NULL
WHERE persona_id % 6 = 0;

UPDATE persona
SET estado_civil = NULL
WHERE persona_id % 7 = 0;

UPDATE persona
SET apellido_nombre = NULL
WHERE persona_id % 8 = 0;

UPDATE persona
SET fecha_nacimiento = NULL
WHERE persona_id % 9 = 0;

-- Tabla provincia
UPDATE provincia
SET nombre = NULL
WHERE provincia_id % 7 = 0;

UPDATE provincia
SET capital = NULL
WHERE provincia_id % 6 = 0;

UPDATE provincia
SET poblacion = NULL
WHERE provincia_id % 5 = 0;

UPDATE provincia
SET superficie_km2 = NULL
WHERE provincia_id % 8 = 0;

UPDATE provincia
SET cantidad_departamentos = NULL
WHERE provincia_id % 9 = 0;

-- Tabla tipo_gasto
UPDATE tipo_gasto
SET nombre = NULL
WHERE tipo_gasto_id % 4 = 0;

-- Tabla zona
UPDATE zona
SET nombre = NULL
WHERE zona_id % 3 = 0;
GO
