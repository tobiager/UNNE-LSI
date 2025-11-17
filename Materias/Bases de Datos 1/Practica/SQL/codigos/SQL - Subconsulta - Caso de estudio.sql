/* =========================================================
   Consorcio 2025 — Subconsultas vs JOIN (Agrupaciones)
   Orban Tobias
   ========================================================= */


USE base_consorcio_2025;

GO

SET NOCOUNT ON;

------------------------------------------------------------
-- 1) Edificios de PROVINCIAS con MÁS de 4 edificios
--    Mecanismo recomendado: GROUP BY + HAVING (tabla derivada / CTE) + JOIN
--    Justificación:
--      - Contamos por provincia (agregado) y filtramos con HAVING > 4.
--      - Luego unimos para recuperar CADA edificio de esas provincias.
------------------------------------------------------------

;WITH provincias_con_mas_de_4 AS (
  SELECT e.provincia_id, COUNT(*) AS cant_edificios
  FROM dbo.edificio AS e
  GROUP BY e.provincia_id
  HAVING COUNT(*) > 4
)
SELECT 
  p.nombre   AS provincia,
  e.provincia_id,
  e.localidad_id,
  e.edificio_id,
  e.nombre   AS edificio
FROM provincias_con_mas_de_4 AS pc
JOIN dbo.edificio  AS e ON e.provincia_id = pc.provincia_id
JOIN dbo.provincia AS p ON p.provincia_id = e.provincia_id
ORDER BY p.nombre, e.localidad_id, e.edificio_id;

-- Validación 1 (b): Provincias que cumplen la condición (>4) + cantidades
SELECT provincia_id, COUNT(*) AS cantidad
FROM dbo.edificio
GROUP BY provincia_id
HAVING COUNT(*) > 4
ORDER BY cantidad DESC;
-- -> Las provincias listadas arriba deben corresponder a las de la consulta principal.


------------------------------------------------------------
-- 2) Edificios de LOCALIDADES con MÁS de 1 edificio
--    Mecanismo recomendado: GROUP BY + HAVING por clave compuesta
--    (provincia_id, localidad_id) + JOIN
--    Justificación:
--      - La “unidad” es la localidad (provincia_id, localidad_id).
--      - Contamos edificios por localidad y filtramos > 1.
--      - Luego unimos para devolver TODOS los edificios de esas localidades.
------------------------------------------------------------

;WITH localidades_con_mas_de_1 AS (
  SELECT e.provincia_id, e.localidad_id, COUNT(*) AS cant_edificios
  FROM dbo.edificio AS e
  GROUP BY e.provincia_id, e.localidad_id
  HAVING COUNT(*) > 1
)
SELECT
  p.nombre AS provincia,
  l.nombre AS localidad,
  e.provincia_id, e.localidad_id, e.edificio_id,
  e.nombre AS edificio
FROM localidades_con_mas_de_1 AS lc
JOIN dbo.edificio  AS e ON  e.provincia_id = lc.provincia_id
                        AND e.localidad_id = lc.localidad_id
JOIN dbo.provincia AS p ON p.provincia_id = e.provincia_id
JOIN dbo.localidad AS l ON  l.provincia_id = e.provincia_id
                        AND l.localidad_id = e.localidad_id
ORDER BY p.nombre, l.nombre, e.edificio_id;

-- Validación 2 (b): Localidades que cumplen (>1) + cantidades
SELECT provincia_id, localidad_id, COUNT(*) AS cantidad
FROM dbo.edificio
GROUP BY provincia_id, localidad_id
HAVING COUNT(*) > 1
ORDER BY provincia_id, localidad_id;
-- -> Las parejas (provincia_id, localidad_id) listadas deben coincidir
--    con las devueltas por la consulta principal.