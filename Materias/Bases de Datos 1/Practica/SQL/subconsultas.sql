/* =========================================================
   Guía práctica de SUBCONSULTAS (T-SQL) – base_consorcio_2025
   ========================================================= */

USE base_consorcio_2025;
GO
SET NOCOUNT ON;

PRINT 'Ejecutando ejemplos de SUBCONSULTAS sobre base_consorcio_2025...';

----------------------------------------------------------------------
-- 1) Subconsulta ESCALAR (devuelve un solo valor) en SELECT
----------------------------------------------------------------------

-- Total gastado por edificio (columna calculada con subconsulta escalar)
SELECT 
    e.edificio_id,
    e.direccion,
    e.localidad_id,
    e.provincia_id,
    COALESCE((
        SELECT SUM(g.importe)
        FROM gasto g
        WHERE g.edificio_id = e.edificio_id
          AND g.provincia_id = e.provincia_id
          AND g.localidad_id = e.localidad_id
    ), 0) AS total_gastado
FROM edificio e
ORDER BY total_gastado DESC;

-- Última fecha de gasto por edificio (usa fecha_pago)
SELECT 
    e.edificio_id,
    e.direccion,
    (SELECT MAX(g.fecha_pago)
     FROM gasto g
     WHERE g.edificio_id = e.edificio_id
       AND g.provincia_id = e.provincia_id
       AND g.localidad_id = e.localidad_id) AS ultima_fecha_gasto
FROM edificio e;

----------------------------------------------------------------------
-- 2) Subconsulta en WHERE: MONO-REGISTRO (=, <, >, etc.)
----------------------------------------------------------------------

-- (2.a) Provincia con más edificios
SELECT TOP 1 e.provincia_id, COUNT(*) AS cant_edificios
FROM edificio e
GROUP BY e.provincia_id
ORDER BY COUNT(*) DESC;

-- (2.b) Edificios ubicados en la provincia con más edificios
SELECT e.edificio_id, e.direccion, e.provincia_id
FROM edificio e
WHERE e.provincia_id = (
  SELECT TOP 1 e2.provincia_id
  FROM edificio e2
  GROUP BY e2.provincia_id
  ORDER BY COUNT(*) DESC
);

----------------------------------------------------------------------
-- 3) Subconsulta en WHERE: MULTI-REGISTRO con IN / ANY(SOME) / ALL
----------------------------------------------------------------------

-- Edificios en las 3 provincias con más edificios (IN)
SELECT e.edificio_id, e.direccion, e.provincia_id
FROM edificio e
WHERE e.provincia_id IN (
  SELECT TOP 3 e2.provincia_id
  FROM edificio e2
  GROUP BY e2.provincia_id
  ORDER BY COUNT(*) DESC
)
ORDER BY e.provincia_id;

-- Gastos cuyo importe sea mayor que CUALQUIER promedio por tipo (ANY/SOME)
SELECT g.gasto_id, g.edificio_id, g.importe
FROM gasto g
WHERE g.importe > ANY (
  SELECT AVG(g2.importe)
  FROM gasto g2
  GROUP BY g2.tipo_gasto_id
)
ORDER BY g.importe DESC;

-- Gastos cuyo importe sea mayor que TODOS los promedios por tipo (ALL)
SELECT g.gasto_id, g.edificio_id, g.importe
FROM gasto g
WHERE g.importe > ALL (
  SELECT AVG(g2.importe)
  FROM gasto g2
  GROUP BY g2.tipo_gasto_id
)
ORDER BY g.importe DESC;

----------------------------------------------------------------------
-- 4) Subconsulta CORRELACIONADA con EXISTS / NOT EXISTS
----------------------------------------------------------------------

-- Zonas que TIENEN al menos 1 edificio (EXISTS)  -> zona.nombre
SELECT z.zona_id, z.nombre
FROM zona z
WHERE EXISTS (
  SELECT 1
  FROM edificio e
  WHERE e.zona_id = z.zona_id
);

-- Edificios SIN gastos asociados (NOT EXISTS)
SELECT e.edificio_id, e.direccion
FROM edificio e
WHERE NOT EXISTS (
  SELECT 1 
  FROM gasto g 
  WHERE g.edificio_id = e.edificio_id
    AND g.provincia_id = e.provincia_id
    AND g.localidad_id = e.localidad_id
);

----------------------------------------------------------------------
-- 5) Subconsulta en FROM (Tabla derivada)
----------------------------------------------------------------------

-- Total por tipo de gasto + ranking (tipo_gasto.nombre)
SELECT 
    tg.nombre       AS tipo_gasto,
    t.total_importe,
    DENSE_RANK() OVER (ORDER BY t.total_importe DESC) AS rk
FROM (
  SELECT g.tipo_gasto_id, SUM(g.importe) AS total_importe
  FROM gasto g
  GROUP BY g.tipo_gasto_id
) AS t
JOIN tipo_gasto tg ON tg.tipo_gasto_id = t.tipo_gasto_id
ORDER BY rk;

-- Promedio del total por edificio (agregado de agregados)
SELECT AVG(x.total_edificio) AS promedio_total_por_edificio
FROM (
  SELECT 
      e.edificio_id, 
      SUM(g.importe) AS total_edificio
  FROM edificio e
  LEFT JOIN gasto g 
    ON g.edificio_id = e.edificio_id
   AND g.provincia_id = e.provincia_id
   AND g.localidad_id = e.localidad_id
  GROUP BY e.edificio_id
) AS x;

----------------------------------------------------------------------
-- 6) Subconsultas en DML (INSERT / UPDATE / DELETE) - DEMO con ROLLBACK
----------------------------------------------------------------------

BEGIN TRAN;

-- 6.a) INSERT con subconsulta -> copiamos a #gasto_top los gastos de los 2 tipos más costosos
IF OBJECT_ID('tempdb..#gasto_top') IS NOT NULL DROP TABLE #gasto_top;
CREATE TABLE #gasto_top (
  gasto_id       INT,
  provincia_id   INT,
  localidad_id   INT,
  edificio_id    INT,
  periodo        INT,
  fecha_pago     DATETIME,
  tipo_gasto_id  INT,
  importe        DECIMAL(18,2)
);

INSERT INTO #gasto_top (gasto_id, provincia_id, localidad_id, edificio_id, periodo, fecha_pago, tipo_gasto_id, importe)
SELECT g.gasto_id, g.provincia_id, g.localidad_id, g.edificio_id, g.periodo, g.fecha_pago, g.tipo_gasto_id, g.importe
FROM gasto g
WHERE g.tipo_gasto_id IN (
  SELECT TOP 2 g2.tipo_gasto_id
  FROM gasto g2
  GROUP BY g2.tipo_gasto_id
  ORDER BY SUM(g2.importe) DESC
);

PRINT CONCAT('Filas copiadas a #gasto_top: ', @@ROWCOUNT);

-- 6.b) UPDATE con subconsulta mono-registro: +5% a gastos de la provincia con más edificios
UPDATE g
SET g.importe = g.importe * 1.05
FROM gasto g
JOIN edificio e
  ON e.edificio_id = g.edificio_id
 AND e.provincia_id = g.provincia_id
 AND e.localidad_id = g.localidad_id
WHERE e.provincia_id = (
  SELECT TOP 1 e2.provincia_id
  FROM edificio e2
  GROUP BY e2.provincia_id
  ORDER BY COUNT(*) DESC
);

PRINT CONCAT('Filas actualizadas (demo): ', @@ROWCOUNT);

-- 6.c) DELETE con NOT EXISTS: limpieza sobre la tabla temporal (demo)
DELETE gt
FROM #gasto_top gt
WHERE NOT EXISTS (
  SELECT 1 
  FROM edificio e 
  WHERE e.edificio_id  = gt.edificio_id
    AND e.provincia_id = gt.provincia_id
    AND e.localidad_id = gt.localidad_id
);

PRINT CONCAT('Filas borradas en #gasto_top (demo): ', @@ROWCOUNT);

-- Revertimos cambios de UPDATE/DELETE reales (eran demo)
ROLLBACK;  -- reemplazá por COMMIT si querés persistir

----------------------------------------------------------------------
-- 7) Subconsultas en HAVING
----------------------------------------------------------------------

-- Zonas cuyo total de gastos supera el promedio global de gastos por zona
SELECT e.zona_id, SUM(g.importe) AS total_zona
FROM edificio e
JOIN gasto g 
  ON g.edificio_id  = e.edificio_id
 AND g.provincia_id = e.provincia_id
 AND g.localidad_id = e.localidad_id
GROUP BY e.zona_id
HAVING SUM(g.importe) > (
  SELECT AVG(total_por_zona)
  FROM (
    SELECT e2.zona_id, SUM(g2.importe) AS total_por_zona
    FROM edificio e2
    JOIN gasto g2 
      ON g2.edificio_id  = e2.edificio_id
     AND g2.provincia_id = e2.provincia_id
     AND g2.localidad_id = e2.localidad_id
    GROUP BY e2.zona_id
  ) z
)
ORDER BY total_zona DESC;

----------------------------------------------------------------------
-- 8) Sugerencias de rendimiento (opcionales)
----------------------------------------------------------------------

/*
CREATE INDEX IX_gasto_edificio   ON gasto(provincia_id, localidad_id, edificio_id);
CREATE INDEX IX_gasto_tipo       ON gasto(tipo_gasto_id);
CREATE INDEX IX_edificio_prov    ON edificio(provincia_id);
CREATE INDEX IX_edificio_zona    ON edificio(zona_id);
CREATE INDEX IX_edificio_loc     ON edificio(localidad_id);
*/

PRINT 'Fin de la guía de SUBCONSULTAS.';
