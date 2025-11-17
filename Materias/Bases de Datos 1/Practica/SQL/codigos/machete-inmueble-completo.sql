/* ============================================================================
   Machete SQL - Parcial 2 (Modelo Consorcio + INMUEBLE)
   Foco: tabla inmueble y relaciones con edificio / localidad / provincia
   ============================================================================ */

USE base_consorcio_2025;
GO

/*-----------------------------------------------------------------------------
  0) VERIFICACIONES GENERALES
-----------------------------------------------------------------------------*/

-- Cantidad de registros por tabla principal del modelo + inmueble
SELECT 'provincia'   AS tabla, COUNT(*) AS cantidad_registros FROM provincia
UNION ALL
SELECT 'localidad'   AS tabla, COUNT(*) FROM localidad
UNION ALL
SELECT 'zona'        AS tabla, COUNT(*) FROM zona
UNION ALL
SELECT 'persona'     AS tabla, COUNT(*) FROM persona
UNION ALL
SELECT 'conserje'    AS tabla, COUNT(*) FROM conserje
UNION ALL
SELECT 'administrador' AS tabla, COUNT(*) FROM administrador
UNION ALL
SELECT 'tipo_gasto'  AS tabla, COUNT(*) FROM tipo_gasto
UNION ALL
SELECT 'edificio'    AS tabla, COUNT(*) FROM edificio
UNION ALL
SELECT 'gasto'       AS tabla, COUNT(*) FROM gasto
UNION ALL
SELECT 'inmueble'    AS tabla, COUNT(*) FROM inmueble;
GO

-- Ver cantidad total de inmuebles y cuántos están asignados a un edificio
SELECT 
    COUNT(*) AS total_inmuebles,
    SUM(CASE WHEN provincia_id IS NULL THEN 0 ELSE 1 END) AS inmuebles_asignados_a_edificio,
    SUM(CASE WHEN provincia_id IS NULL THEN 1 ELSE 0 END) AS inmuebles_sin_edificio
FROM inmueble;
GO


/*-----------------------------------------------------------------------------
  1) FILTROS SIMPLES SOBRE INMUEBLES (WHERE, IS NULL, BETWEEN)
-----------------------------------------------------------------------------*/

-- 1.1) Inmuebles de planta baja (nro_piso = 0)
-- Ver cuántos hay
SELECT COUNT(*) AS cantidad_pb
FROM inmueble
WHERE nro_piso = 0;

-- Detalle de esos inmuebles
SELECT *
FROM inmueble
WHERE nro_piso = 0
ORDER BY inmueble_id;
GO

-- 1.2) Inmuebles con superficie cubierta entre 80 y 100 m2
SELECT inmueble_id, nro_piso, dpto, sup_cubierta
FROM inmueble
WHERE sup_cubierta BETWEEN 80 AND 100
ORDER BY sup_cubierta DESC;
GO

-- 1.3) Inmuebles que NO están asignados a ningún edificio (FK nulas)
SELECT inmueble_id, nro_piso, dpto, sup_cubierta
FROM inmueble
WHERE provincia_id IS NULL
  AND localidad_id IS NULL
  AND edificio_id IS NULL;
GO


/*-----------------------------------------------------------------------------
  2) FUNCIONES DE FILA EN SELECT Y WHERE
-----------------------------------------------------------------------------*/

-- 2.1) Descripción legible del departamento (concatenación + CAST)
SELECT 
    inmueble_id,
    'Piso ' + CAST(nro_piso AS VARCHAR(3)) + ' - Dpto ' + dpto AS descripcion_inmueble,
    ROUND(sup_cubierta, 2) AS sup_redondeada
FROM inmueble;
GO

-- 2.2) Clasificar inmuebles según piso (CASE) 
--    PB, Bajos (1-3), Altos (4 o más)
SELECT
    inmueble_id,
    nro_piso,
    dpto,
    CASE 
        WHEN nro_piso = 0 THEN 'PB'
        WHEN nro_piso BETWEEN 1 AND 3 THEN 'Bajo'
        ELSE 'Alto'
    END AS categoria_piso
FROM inmueble
ORDER BY nro_piso, dpto;
GO

-- 2.3) Filtrar usando una función (ej: descripción con más de 10 caracteres)
SELECT 
    inmueble_id,
    'Piso ' + CAST(nro_piso AS VARCHAR(3)) + ' - Dpto ' + dpto AS descripcion_inmueble
FROM inmueble
WHERE LEN('Piso ' + CAST(nro_piso AS VARCHAR(3)) + ' - Dpto ' + dpto) > 10;
GO


/*-----------------------------------------------------------------------------
  3) COMBINACIONES INTERNAS Y EXTERNAS (JOIN)
-----------------------------------------------------------------------------*/

-- 3.1) INNER JOIN: inmuebles con datos del edificio
-- Paso 1: ver cuántos inmuebles tiene cada edificio
SELECT 
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS nombre_edificio,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
GROUP BY 
    e.provincia_id, e.localidad_id, e.edificio_id, e.nombre
ORDER BY cant_inmuebles DESC;
GO

-- 3.2) Listar inmuebles de un edificio dado (por nombre)
-- Verificación: cuántos inmuebles tiene ese edificio
SELECT 
    e.nombre AS edificio,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE e.nombre = 'EDIFICIO-2481'   -- cambiar por el nombre que pidan
GROUP BY e.nombre;

-- Consulta final (detalle)
SELECT
    e.nombre AS edificio,
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE e.nombre = 'EDIFICIO-2481'
ORDER BY i.nro_piso, i.dpto;
GO

-- 3.3) LEFT JOIN: edificios que NO tienen inmuebles cargados
SELECT 
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS nombre_edificio
FROM edificio e
LEFT JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE i.inmueble_id IS NULL;
GO

-- 3.4) INNER JOIN con ubicación completa (provincia + localidad + edificio + inmueble)
SELECT
    p.nombre                 AS provincia,
    l.nombre                 AS localidad,
    e.nombre                 AS edificio,
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM inmueble i
JOIN edificio e
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
JOIN localidad l
    ON e.provincia_id = l.provincia_id
   AND e.localidad_id = l.localidad_id
JOIN provincia p
    ON p.provincia_id = e.provincia_id
ORDER BY p.nombre, l.nombre, e.nombre, i.nro_piso, i.dpto;
GO


/*-----------------------------------------------------------------------------
  4) AGRUPAMIENTOS Y FUNCIONES AGREGADAS (GROUP BY, HAVING)
-----------------------------------------------------------------------------*/

-- 4.1) Cantidad de inmuebles por provincia
SELECT 
    p.nombre AS provincia,
    COUNT(*) AS cant_inmuebles
FROM provincia p
JOIN inmueble i
    ON i.provincia_id = p.provincia_id
GROUP BY p.nombre
ORDER BY cant_inmuebles DESC;
GO

-- 4.2) Superficie promedio de inmuebles por edificio
SELECT 
    e.nombre AS edificio,
    AVG(i.sup_cubierta) AS sup_promedio,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
GROUP BY e.nombre
ORDER BY sup_promedio DESC;
GO

-- 4.3) Edificios con más de 10 inmuebles (uso de HAVING)
SELECT 
    e.nombre AS edificio,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
GROUP BY e.nombre
HAVING COUNT(*) > 10
ORDER BY cant_inmuebles DESC;
GO


/*-----------------------------------------------------------------------------
  5) SUBCONSULTAS NO CORRELACIONADAS
     - Mono-registro (=) 
     - Multi-registro (IN)
-----------------------------------------------------------------------------*/

-- 5.1) Edificio con MAYOR cantidad de inmuebles
-- Paso 1: Cantidad de inmuebles por edificio
SELECT 
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS edificio,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
GROUP BY e.provincia_id, e.localidad_id, e.edificio_id, e.nombre
ORDER BY cant_inmuebles DESC;

-- Paso 2: Usar subconsulta para quedarnos solo con el máximo
SELECT 
    e.nombre AS edificio,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
GROUP BY e.nombre
HAVING COUNT(*) = (
    SELECT MAX(cant_inmuebles)
    FROM (
        SELECT 
            e2.provincia_id,
            e2.localidad_id,
            e2.edificio_id,
            COUNT(*) AS cant_inmuebles
        FROM edificio e2
        JOIN inmueble i2
            ON i2.provincia_id = e2.provincia_id
           AND i2.localidad_id = e2.localidad_id
           AND i2.edificio_id  = e2.edificio_id
        GROUP BY e2.provincia_id, e2.localidad_id, e2.edificio_id
    ) AS t
);
GO

-- 5.2) Inmuebles ubicados en provincias 'Corrientes' y 'Chaco'
SELECT 
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    p.nombre AS provincia
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre IN ('Corrientes', 'Chaco')
ORDER BY p.nombre, i.inmueble_id;
GO

-- 5.3) Inmuebles que pertenecen a edificios de una provincia dada (IN)
SELECT 
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM inmueble i
WHERE i.provincia_id IN (
    SELECT provincia_id
    FROM provincia
    WHERE nombre = 'Chaco'      -- cambiar por provincia que pidan
);
GO


/*-----------------------------------------------------------------------------
  6) SUBCONSULTAS CORRELACIONADAS (EXISTS y en WHERE)
-----------------------------------------------------------------------------*/

-- 6.1) Provincias que tienen al menos un inmueble en planta baja (nro_piso = 0)
SELECT 
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = p.provincia_id
      AND i.nro_piso = 0
);
GO

-- 6.2) Inmuebles cuya superficie es mayor que el promedio de su propio edificio
SELECT 
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta,
    e.nombre AS edificio
FROM inmueble i
JOIN edificio e
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE i.sup_cubierta > (
    SELECT AVG(i2.sup_cubierta)
    FROM inmueble i2
    WHERE i2.provincia_id = i.provincia_id
      AND i2.localidad_id = i.localidad_id
      AND i2.edificio_id  = i.edificio_id
);
GO

-- 6.3) Localidades que tienen inmuebles con superficie mayor a 100 m2
SELECT DISTINCT
    l.provincia_id,
    l.localidad_id,
    l.nombre AS localidad
FROM localidad l
WHERE EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = l.provincia_id
      AND i.localidad_id = l.localidad_id
      AND i.sup_cubierta > 100
);
GO


/*-----------------------------------------------------------------------------
  7) SUBCONSULTA EN FROM (TABLA DERIVADA)
-----------------------------------------------------------------------------*/

-- 7.1) Tabla derivada con estadísticas por edificio
SELECT 
    e.nombre AS edificio,
    stats.cant_inmuebles,
    stats.sup_promedio
FROM (
    SELECT 
        provincia_id,
        localidad_id,
        edificio_id,
        COUNT(*) AS cant_inmuebles,
        AVG(sup_cubierta) AS sup_promedio
    FROM inmueble
    GROUP BY provincia_id, localidad_id, edificio_id
) AS stats
JOIN edificio e
    ON e.provincia_id = stats.provincia_id
   AND e.localidad_id = stats.localidad_id
   AND e.edificio_id  = stats.edificio_id
ORDER BY stats.cant_inmuebles DESC;
GO


/*-----------------------------------------------------------------------------
  8) IDEAS PARA PREGUNTAS NUMÉRICAS RÁPIDAS
-----------------------------------------------------------------------------*/

-- 8.1) ¿Cuántos inmuebles tiene el edificio con ID (provincia_id=1, localidad_id=1, edificio_id=1)?
SELECT COUNT(*) AS cant_inmuebles_edif_1_1_1
FROM inmueble
WHERE provincia_id = 1
  AND localidad_id = 1
  AND edificio_id  = 1;
GO

-- 8.2) Superficie cubierta promedio de los inmuebles de planta baja
SELECT AVG(sup_cubierta) AS sup_promedio_pb
FROM inmueble
WHERE nro_piso = 0;
GO

-- 8.3) ¿Cuántos inmuebles NO tienen edificio asignado?
SELECT COUNT(*) AS inmuebles_sin_edificio
FROM inmueble
WHERE provincia_id IS NULL
  AND localidad_id IS NULL
  AND edificio_id IS NULL;
GO

-- 8.4) ¿Cuántos inmuebles hay en la provincia 'Corrientes'?
SELECT COUNT(*) AS inmuebles_corrientes
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Corrientes';
GO


/*-----------------------------------------------------------------------------
  9) MODELOS "INGRESAR EL VALOR" + VALIDACIÓN (numéricas típicas)
-----------------------------------------------------------------------------*/

-- 9.1) ¿Cuántos edificios tienen al menos un inmueble de planta baja
--      con superficie cubierta mayor a 80 m2?

-- CONSULTA PARA ESCRIBIR EL NÚMERO (COUNT sobre DISTINCT edificios)
SELECT COUNT(*) AS cant_edificios_pb_grande
FROM (
    SELECT DISTINCT 
        e.provincia_id,
        e.localidad_id,
        e.edificio_id
    FROM edificio e
    JOIN inmueble i
        ON i.provincia_id = e.provincia_id
       AND i.localidad_id = e.localidad_id
       AND i.edificio_id  = e.edificio_id
    WHERE i.nro_piso = 0
      AND i.sup_cubierta > 80
) AS x;
GO

-- VALIDACIÓN: ver qué edificios son
SELECT DISTINCT
    p.nombre AS provincia,
    l.nombre AS localidad,
    e.nombre AS edificio
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
JOIN localidad l
    ON l.provincia_id = e.provincia_id
   AND l.localidad_id = e.localidad_id
JOIN provincia p
    ON p.provincia_id = e.provincia_id
WHERE i.nro_piso = 0
  AND i.sup_cubierta > 80
ORDER BY p.nombre, l.nombre, e.nombre;
GO


-- 9.2) ¿Cuántos inmuebles tienen superficie mayor al promedio de su edificio?
SELECT COUNT(*) AS cant_inmuebles_mayor_promedio_edificio
FROM inmueble i
WHERE i.sup_cubierta > (
    SELECT AVG(i2.sup_cubierta)
    FROM inmueble i2
    WHERE i2.provincia_id = i.provincia_id
      AND i2.localidad_id = i.localidad_id
      AND i2.edificio_id  = i.edificio_id
);
GO

-- VALIDACIÓN: ver cada inmueble con el promedio de su edificio
SELECT 
    i.inmueble_id,
    i.provincia_id,
    i.localidad_id,
    i.edificio_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta,
    prom.sup_promedio_edificio
FROM inmueble i
CROSS APPLY (
    SELECT AVG(i2.sup_cubierta) AS sup_promedio_edificio
    FROM inmueble i2
    WHERE i2.provincia_id = i.provincia_id
      AND i2.localidad_id = i.localidad_id
      AND i2.edificio_id  = i.edificio_id
) AS prom
WHERE i.sup_cubierta > prom.sup_promedio_edificio
ORDER BY i.provincia_id, i.localidad_id, i.edificio_id, i.sup_cubierta DESC;
GO


-- 9.3) ¿Cuántos edificios NO tienen ningún inmueble de planta baja?
SELECT COUNT(*) AS cant_edificios_sin_pb
FROM edificio e
WHERE NOT EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = e.provincia_id
      AND i.localidad_id = e.localidad_id
      AND i.edificio_id  = e.edificio_id
      AND i.nro_piso = 0
);
GO

-- VALIDACIÓN: listar esos edificios
SELECT 
    p.nombre AS provincia,
    l.nombre AS localidad,
    e.nombre AS edificio
FROM edificio e
JOIN localidad l
    ON l.provincia_id = e.provincia_id
   AND l.localidad_id = e.localidad_id
JOIN provincia p
    ON p.provincia_id = e.provincia_id
WHERE NOT EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = e.provincia_id
      AND i.localidad_id = e.localidad_id
      AND i.edificio_id  = e.edificio_id
      AND i.nro_piso = 0
)
ORDER BY p.nombre, l.nombre, e.nombre;
GO


-- 9.4) ¿Cuántos inmuebles de categoría "Alto" (piso >= 4)
--       existen en la provincia 'Corrientes'?

SELECT COUNT(*) AS cant_inmuebles_altos_corrientes
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Corrientes'
  AND i.nro_piso >= 4;
GO

-- VALIDACIÓN:
SELECT 
    p.nombre AS provincia,
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Corrientes'
  AND i.nro_piso >= 4
ORDER BY i.nro_piso, i.dpto;
GO


-- 9.5) ¿Cuántos edificios tienen una superficie total de inmuebles > 500 m2?
SELECT COUNT(*) AS cant_edificios_sup_total_mayor_500
FROM (
    SELECT 
        provincia_id,
        localidad_id,
        edificio_id,
        SUM(sup_cubierta) AS sup_total
    FROM inmueble
    GROUP BY provincia_id, localidad_id, edificio_id
) AS t
WHERE t.sup_total > 500;
GO

-- VALIDACIÓN: listar esos edificios y su superficie total
SELECT 
    p.nombre AS provincia,
    l.nombre AS localidad,
    e.nombre AS edificio,
    t.sup_total
FROM (
    SELECT 
        provincia_id,
        localidad_id,
        edificio_id,
        SUM(sup_cubierta) AS sup_total
    FROM inmueble
    GROUP BY provincia_id, localidad_id, edificio_id
) AS t
JOIN edificio e
    ON e.provincia_id = t.provincia_id
   AND e.localidad_id = t.localidad_id
   AND e.edificio_id  = t.edificio_id
JOIN localidad l
    ON l.provincia_id = e.provincia_id
   AND l.localidad_id = e.localidad_id
JOIN provincia p
    ON p.provincia_id = e.provincia_id
WHERE t.sup_total > 500
ORDER BY p.nombre, l.nombre, e.nombre;
GO


-- 9.6) ¿Cuántas localidades tienen más de 20 inmuebles?
SELECT COUNT(*) AS cant_localidades_con_mas_de_20_inmuebles
FROM (
    SELECT 
        provincia_id,
        localidad_id,
        COUNT(*) AS cant_inmuebles
    FROM inmueble
    GROUP BY provincia_id, localidad_id
) AS t
WHERE t.cant_inmuebles > 20;
GO

-- VALIDACIÓN:
SELECT 
    p.nombre AS provincia,
    l.nombre AS localidad,
    t.cant_inmuebles
FROM (
    SELECT 
        provincia_id,
        localidad_id,
        COUNT(*) AS cant_inmuebles
    FROM inmueble
    GROUP BY provincia_id, localidad_id
) AS t
JOIN localidad l
    ON l.provincia_id = t.provincia_id
   AND l.localidad_id = t.localidad_id
JOIN provincia p
    ON p.provincia_id = t.provincia_id
WHERE t.cant_inmuebles > 20
ORDER BY t.cant_inmuebles DESC;
GO


-- 9.7) ¿Cuántos inmuebles están en provincias 'Chaco' o 'Corrientes'
--       y NO están en planta baja?
SELECT COUNT(*) AS cant_inmuebles_chaco_corrientes_no_pb
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre IN ('Chaco', 'Corrientes')
  AND i.nro_piso <> 0;
GO

-- VALIDACIÓN:
SELECT 
    p.nombre AS provincia,
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre IN ('Chaco', 'Corrientes')
  AND i.nro_piso <> 0
ORDER BY p.nombre, i.nro_piso, i.dpto;
GO


/*-----------------------------------------------------------------------------
  10) MODELOS TIPO MÚLTIPLE CHOICE CON INMUEBLE
-----------------------------------------------------------------------------*/

-- 10.1) MC: inmuebles que NO tienen edificio asignado
-- Opción correcta:
SELECT inmueble_id, nro_piso, dpto
FROM inmueble
WHERE provincia_id IS NULL
  AND localidad_id IS NULL
  AND edificio_id IS NULL;
GO

-- VALIDACIÓN rápida
SELECT COUNT(*) AS cant_inmuebles_sin_edificio_correcto
FROM inmueble
WHERE provincia_id IS NULL
  AND localidad_id IS NULL
  AND edificio_id IS NULL;

SELECT COUNT(*) AS cant_inmuebles_con_algun_campo_nulo
FROM inmueble
WHERE provincia_id IS NULL
   OR localidad_id IS NULL
   OR edificio_id IS NULL;
GO


-- 10.2) MC: inmuebles que pertenecen a edificios de la provincia 'Chaco'

-- Versión JOIN
SELECT i.inmueble_id, i.nro_piso, i.dpto
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Chaco';
GO

-- Versión IN
SELECT i.inmueble_id, i.nro_piso, i.dpto
FROM inmueble i
WHERE i.provincia_id IN (
    SELECT provincia_id
    FROM provincia
    WHERE nombre = 'Chaco'
);
GO

-- VALIDACIÓN
SELECT 
    (SELECT COUNT(*) 
     FROM inmueble i
     JOIN provincia p
         ON p.provincia_id = i.provincia_id
     WHERE p.nombre = 'Chaco') AS cant_join,
    (SELECT COUNT(*)
     FROM inmueble i
     WHERE i.provincia_id IN (
         SELECT provincia_id
         FROM provincia
         WHERE nombre = 'Chaco'
     )) AS cant_in;
GO


-- 10.3) MC: localidades que tienen al menos un inmueble de planta baja

-- EXISTS
SELECT DISTINCT
    l.provincia_id,
    l.localidad_id,
    l.nombre AS localidad
FROM localidad l
WHERE EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = l.provincia_id
      AND i.localidad_id = l.localidad_id
      AND i.nro_piso = 0
);
GO

-- Versión agrupada
SELECT 
    l.provincia_id,
    l.localidad_id,
    l.nombre AS localidad
FROM localidad l
JOIN inmueble i
    ON i.provincia_id = l.provincia_id
   AND i.localidad_id = l.localidad_id
WHERE i.nro_piso = 0
GROUP BY l.provincia_id, l.localidad_id, l.nombre;
GO


-- 10.4) MC: inmuebles con superficie entre 50 y 100 m2 (inclusive)
SELECT inmueble_id, nro_piso, dpto, sup_cubierta
FROM inmueble
WHERE sup_cubierta BETWEEN 50 AND 100;
GO

-- VALIDACIÓN
SELECT 
    (SELECT COUNT(*) 
     FROM inmueble
     WHERE sup_cubierta BETWEEN 50 AND 100) AS cant_between,
    (SELECT COUNT(*)
     FROM inmueble
     WHERE sup_cubierta >= 50
       AND sup_cubierta <= 100) AS cant_explicita;
GO


-- 10.5) MC: edificios sin ningún inmueble asignado (LEFT JOIN + IS NULL)
SELECT 
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS edificio
FROM edificio e
LEFT JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE i.inmueble_id IS NULL;
GO

-- VALIDACIÓN
SELECT COUNT(*) AS cant_edificios_sin_inmuebles
FROM edificio e
LEFT JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE i.inmueble_id IS NULL;
GO


-- 10.6) MC: inmuebles con superficie mayor al promedio de su edificio
SELECT 
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta,
    e.nombre AS edificio
FROM inmueble i
JOIN edificio e
    ON e.provincia_id = i.provincia_id
   AND e.localidad_id = i.localidad_id
   AND e.edificio_id  = i.edificio_id
WHERE i.sup_cubierta > (
    SELECT AVG(i2.sup_cubierta)
    FROM inmueble i2
    WHERE i2.provincia_id = i.provincia_id
      AND i2.localidad_id = i.localidad_id
      AND i2.edificio_id  = i.edificio_id
);
GO


/*-----------------------------------------------------------------------------
  11) MÁS ESCENARIOS NUMÉRICOS / COMBINADOS
-----------------------------------------------------------------------------*/

-- 11.1) Cantidad de inmuebles por categoría de piso (PB/Bajo/Alto)
SELECT 
    CASE 
        WHEN nro_piso = 0 THEN 'PB'
        WHEN nro_piso BETWEEN 1 AND 3 THEN 'Bajo'
        ELSE 'Alto'
    END AS categoria_piso,
    COUNT(*) AS cant_inmuebles
FROM inmueble
GROUP BY 
    CASE 
        WHEN nro_piso = 0 THEN 'PB'
        WHEN nro_piso BETWEEN 1 AND 3 THEN 'Bajo'
        ELSE 'Alto'
    END;
GO

-- 11.2) Edificios que tienen TODOS sus inmuebles en pisos altos (>=4)
SELECT COUNT(*) AS cant_edificios_solo_altos
FROM edificio e
WHERE EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = e.provincia_id
      AND i.localidad_id = e.localidad_id
      AND i.edificio_id  = e.edificio_id
)
AND NOT EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = e.provincia_id
      AND i.localidad_id = e.localidad_id
      AND i.edificio_id  = e.edificio_id
      AND i.nro_piso < 4
);
GO

-- 11.3) Inmuebles con sup_cubierta > promedio general de sup_cubierta
SELECT COUNT(*) AS cant_inmuebles_mayor_promedio_general
FROM inmueble i
WHERE i.sup_cubierta > (
    SELECT AVG(sup_cubierta) FROM inmueble
);
GO

-- 11.4) Inmuebles en edificios que NO registraron gastos en 2017
SELECT COUNT(*) AS cant_inmuebles_en_edificios_sin_gastos_2017
FROM inmueble i
WHERE NOT EXISTS (
    SELECT 1
    FROM gasto g
    WHERE g.provincia_id = i.provincia_id
      AND g.localidad_id = i.localidad_id
      AND g.edificio_id  = i.edificio_id
      AND YEAR(g.fecha_pago) = 2017
);
GO


/*-----------------------------------------------------------------------------
  12) MC ADICIONALES (EXISTS / NOT EXISTS / LOCALIDAD / GASTO)
-----------------------------------------------------------------------------*/

-- 12.1) Localidades que NO tienen inmuebles asignados (LEFT JOIN)
SELECT 
    l.provincia_id,
    l.localidad_id,
    l.nombre AS localidad
FROM localidad l
LEFT JOIN inmueble i
    ON i.provincia_id = l.provincia_id
   AND i.localidad_id = l.localidad_id
WHERE i.inmueble_id IS NULL;
GO

-- 12.2) Localidades que NO tienen inmuebles asignados (NOT EXISTS)
SELECT 
    l.provincia_id,
    l.localidad_id,
    l.nombre AS localidad
FROM localidad l
WHERE NOT EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = l.provincia_id
      AND i.localidad_id = l.localidad_id
);
GO

-- 12.3) Inmuebles en edificios que NO registraron gastos en periodo 3 de 2016
SELECT 
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM inmueble i
WHERE NOT EXISTS (
    SELECT 1
    FROM gasto g
    WHERE g.provincia_id = i.provincia_id
      AND g.localidad_id = i.localidad_id
      AND g.edificio_id  = i.edificio_id
      AND g.periodo = 3
      AND YEAR(g.fecha_pago) = 2016
);
GO

-- 12.4) Provincias con al menos un inmueble PB con sup_cubierta > 120
SELECT DISTINCT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = p.provincia_id
      AND i.nro_piso = 0
      AND i.sup_cubierta > 120
);
GO


/*-----------------------------------------------------------------------------
  13) PLANTILLAS "LISTO PARA MODIFICAR EN EL PARCIAL"
-----------------------------------------------------------------------------*/

-- 13.1) Plantilla de conteo con subconsulta correlacionada por edificio
SELECT COUNT(*) AS cantidad_resultado
FROM inmueble i
WHERE i.sup_cubierta > (
    SELECT AVG(i2.sup_cubierta)
    FROM inmueble i2
    WHERE i2.provincia_id = i.provincia_id
      AND i2.localidad_id = i.localidad_id
      AND i2.edificio_id  = i.edificio_id
);
GO

-- 13.2) Plantilla con NOT EXISTS para "sin X"
SELECT COUNT(*) AS cantidad_resultado
FROM edificio e
WHERE NOT EXISTS (
    SELECT 1
    FROM inmueble i
    WHERE i.provincia_id = e.provincia_id
      AND i.localidad_id = e.localidad_id
      AND i.edificio_id  = e.edificio_id
      -- acá adentro va la condición que NO querés que exista
      -- ej: AND i.nro_piso = 0 
      --     AND i.sup_cubierta > 80
);
GO

-- 13.3) Plantilla con tabla derivada para estadísticos por edificio
SELECT 
    e.nombre AS edificio,
    stats.cant_inmuebles,
    stats.sup_promedio
FROM (
    SELECT 
        provincia_id,
        localidad_id,
        edificio_id,
        COUNT(*) AS cant_inmuebles,
        AVG(sup_cubierta) AS sup_promedio
    FROM inmueble
    GROUP BY provincia_id, localidad_id, edificio_id
) AS stats
JOIN edificio e
    ON e.provincia_id = stats.provincia_id
   AND e.localidad_id = stats.localidad_id
   AND e.edificio_id  = stats.edificio_id;
GO

-- 13.4) Plantilla JOIN vs IN por provincias (para adaptar en el parcial)
SELECT i.inmueble_id, i.nro_piso, i.dpto
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre IN ('NOMBRE_PROVINCIA_1', 'NOMBRE_PROVINCIA_2');
GO

SELECT i.inmueble_id, i.nro_piso, i.dpto
FROM inmueble i
WHERE i.provincia_id IN (
    SELECT provincia_id
    FROM provincia
    WHERE nombre IN ('NOMBRE_PROVINCIA_1', 'NOMBRE_PROVINCIA_2')
);
GO
