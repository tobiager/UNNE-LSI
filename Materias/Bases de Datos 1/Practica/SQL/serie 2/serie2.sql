USE base_consorcio_2025;
GO

-- ================================================
-- SERIE Nº 2 – Tratamiento de valores NULL (T-SQL)
-- Modelo: base_consorcio_2025 (2025)
-- ================================================

-- Ejercicio 1
-- ¿Qué devuelve: SELECT * FROM persona WHERE telefono = NULL ?
-- Respuesta: NINGUNA FILA (toda comparación = con NULL es UNKNOWN).
-- Correcto: usar IS NULL.
-- (Demostración)
SELECT TOP (0) * FROM persona WHERE telefono = NULL; -- 0 filas
SELECT * FROM persona WHERE telefono IS NULL;         -- correcto

-- Ejercicio 2
-- Personas cuyo teléfono no está informado
SELECT persona_id, apellido_nombre, telefono
FROM persona
WHERE telefono IS NULL
ORDER BY apellido_nombre;

-- Ejercicio 3
-- Personas que SÍ tienen teléfono cargado
SELECT persona_id, apellido_nombre, telefono
FROM persona
WHERE telefono IS NOT NULL
ORDER BY apellido_nombre;

-- Ejercicio 4
-- Reemplazar valores nulos de nombre y teléfono por '(Sin dato)'
SELECT persona_id,
       ISNULL(apellido_nombre, '(Sin dato)') AS apellido_nombre,
       ISNULL(telefono, '(Sin dato)')        AS telefono
FROM persona
ORDER BY apellido_nombre;

-- Ejercicio 5
-- Mostrar nombre de provincia; si es nulo, usar capital; si ambos nulos, 'Desconocido'
SELECT provincia_id,
       COALESCE(nombre, capital, 'Desconocido') AS nombre_resuelto,
       nombre, capital
FROM provincia
ORDER BY provincia_id;

-- Ejercicio 6
-- Gastos cuyo importe NO está informado
SELECT gasto_id, provincia_id, localidad_id, edificio_id, periodo, fecha_pago, tipo_gasto_id, importe
FROM gasto
WHERE importe IS NULL
ORDER BY gasto_id;

-- Ejercicio 7
-- Calcular 10% de cada importe (sin alterar la tabla) y observar qué pasa con NULL
-- Si importe es NULL => resultado del 10% también es NULL
SELECT gasto_id, importe, (importe * 0.10) AS diez_por_ciento
FROM gasto
ORDER BY gasto_id;

-- Ejercicio 8
-- Repetir el 10% pero reemplazando NULL por 0
SELECT gasto_id, importe,
       (ISNULL(importe, 0) * 0.10) AS diez_por_ciento_sin_null
FROM gasto
ORDER BY gasto_id;

-- Ejercicio 9
-- Promedio de importes: natural (IGNORA NULLs) vs reemplazando NULL por 0
SELECT AVG(importe)                    AS avg_natural_ignora_nulls,
       AVG(CAST(ISNULL(importe,0) AS DECIMAL(18,2))) AS avg_reemplazando_por_cero
FROM gasto;

-- Ejercicio 10
-- Diferencia entre COUNT(*) y COUNT(columna)
SELECT COUNT(*)        AS total_filas,
       COUNT(importe)  AS importes_no_nulos,
       (COUNT(*) - COUNT(importe)) AS importes_nulos
FROM gasto;

-- Ejercicio 11
-- Ordenar por teléfono ASC y DESC observando la posición de los NULLs
-- (SQL Server: ASC => NULLs primero; DESC => NULLs último)
SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY telefono ASC, apellido_nombre;

SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY telefono DESC, apellido_nombre;

-- (Extra: forzar NULL al final en ASC)
-- ORDER BY CASE WHEN telefono IS NULL THEN 1 ELSE 0 END, telefono;

-- Ejercicio 12
-- Longitud de teléfono, considerando 0 cuando es NULL
SELECT persona_id, apellido_nombre, telefono,
       CASE WHEN telefono IS NULL THEN 0 ELSE LEN(telefono) END AS largo_telefono
FROM persona
ORDER BY apellido_nombre;

-- Ejercicio 13
-- Personas sin fecha de nacimiento
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE fecha_nacimiento IS NULL
ORDER BY apellido_nombre;

-- Ejercicio 14
-- Edad de cada persona; 0 si la fecha de nacimiento es NULL
-- (Aproximación simple con DATEDIFF YEAR)
SELECT persona_id, apellido_nombre, fecha_nacimiento,
       CASE
         WHEN fecha_nacimiento IS NULL THEN 0
         ELSE DATEDIFF(YEAR, fecha_nacimiento, GETDATE())
       END AS edad
FROM persona
ORDER BY apellido_nombre;

-- Ejercicio 15
-- Personas que NO tienen teléfono O NO tienen estado_civil cargado (nulo)
SELECT persona_id, apellido_nombre, telefono, estado_civil
FROM persona
WHERE telefono IS NULL
   OR estado_civil IS NULL
ORDER BY apellido_nombre;

-- Ejercicio 16
-- Administradores: texto según viven/no viven/desconocido
-- vive_ahi: 'S','N' o NULL
SELECT a.administrador_id,
       p.apellido_nombre,
       a.vive_ahi,
       CASE
         WHEN a.vive_ahi = 'S' THEN 'Vive en el edificio'
         WHEN a.vive_ahi = 'N' THEN 'No vive en el edificio'
         ELSE 'Dato desconocido'
       END AS condicion
FROM administrador a
LEFT JOIN persona p ON p.persona_id = a.administrador_id
ORDER BY p.apellido_nombre;

-- Ejercicio 17
-- Gastos con fechas nulas reemplazadas por simbólica '1900-01-01'
SELECT gasto_id, periodo,
       ISNULL(CONVERT(date, fecha_pago), CONVERT(date, '19000101')) AS fecha_pago_resuelta,
       fecha_pago
FROM gasto
ORDER BY gasto_id;

-- Ejercicio 18
-- Localidades mostrando su nombre, o 'Sin nombre asignado' si es NULL
SELECT l.provincia_id, l.localidad_id,
       ISNULL(l.nombre, 'Sin nombre asignado') AS nombre_resuelto
FROM localidad AS l
ORDER BY l.provincia_id, l.localidad_id;

-- Ejercicio 19
-- Provincias donde AL MENOS una de (nombre, poblacion) sea nula
SELECT provincia_id, nombre, poblacion
FROM provincia
WHERE nombre IS NULL
   OR poblacion IS NULL
ORDER BY provincia_id;

-- Ejercicio 20
-- Personas ordenadas primero con teléfono cargado y al final las de teléfono NULL
SELECT persona_id, apellido_nombre, telefono
FROM persona
ORDER BY CASE WHEN telefono IS NULL THEN 1 ELSE 0 END,
         telefono;
	