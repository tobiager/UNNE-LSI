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

-- detalle de esos inmuebles
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

-- 1.3) Inmuebles que todavía NO están asignados a ningún edificio (valores nulos)
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

-- 2.3) Filtrar usando una función (ej: inmuebles con más de 5 caracteres en la descripción)
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
--    (para preguntas del estilo "mostrar los deptos del edificio X")
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
WHERE e.nombre = 'EDIFICIO-2481'   -- mismo nombre
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

-- 5.1) Edificio con MAYOR cantidad de inmuebles (subconsulta mono-registro)
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

-- 5.2) Inmuebles ubicados en provincias cuyo nombre está en una lista (IN)
-- Ejemplo: provincias 'Corrientes' y 'Chaco'
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

-- 5.3) Inmuebles que pertenecen a edificios de una provincia dada (subconsulta IN)
--    (misma lógica que JOIN, pero usando subconsulta multi-registro)
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
--     (subconsulta correlacionada en WHERE)
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

-- 6.3) Localidades que tienen inmuebles con superficie mayor a 100 m2 (EXISTS)
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

-- 7.1) Tabla derivada con estadísticas por edificio: 
--      cantidad de inmuebles y superficie promedio
--      luego se la junta con edificio para mostrar el nombre
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
  8) IDEAS PARA PREGUNTAS DE OPCIÓN MÚLTIPLE (VALIDACIONES RÁPIDAS)
-----------------------------------------------------------------------------*/

-- 8.1) ¿Cuántos inmuebles tiene el edificio con ID (provincia_id=1, localidad_id=1, edificio_id=1)?
SELECT COUNT(*) AS cant_inmuebles_edif_1_1_1
FROM inmueble
WHERE provincia_id = 1
  AND localidad_id = 1
  AND edificio_id  = 1;
GO

-- 8.2) ¿Cuál es la superficie cubierta promedio de los inmuebles de planta baja?
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
  9) MODELOS DE PREGUNTAS TIPO "INGRESAR EL VALOR" + VALIDACIÓN
     (numéricas típicas de parcial)
-----------------------------------------------------------------------------*/

-- 9.1) ¿Cuántos edificios tienen al menos un inmueble de planta baja
--      con superficie cubierta mayor a 80 m2?
--  → CONSULTA PARA ESCRIBIR EL NÚMERO EN MOODLE
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


-- VALIDACIÓN DETALLADA:
--  Ver qué edificios son y qué inmuebles cumplen la condición.
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

-- EXPLICACIÓN:
--  - La consulta principal usa COUNT(DISTINCT clave edificio) para obtener
--    la cantidad de edificios que tienen al menos un inmueble PB > 80 m2.
--  - Si cambian la condición (por ejemplo sup_cubierta > 100 o nro_piso = 1),
--    solo modificás el WHERE.
--  - La validación muestra el detalle para comprobar que el conteo tiene sentido.


-- 9.2) ¿Cuántos inmuebles tienen superficie mayor al promedio de su edificio?
--  (misma idea que 6.2 pero pidiendo la cantidad)
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

-- VALIDACIÓN DETALLADA:
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
-- EXPLICACIÓN:
--  - La consulta de conteo usa una subconsulta correlacionada en WHERE.
--  - La de validación usa CROSS APPLY para ver el promedio al lado.
--  - Para cambios de enunciado tipo "mayor o igual al promedio" solo
--    cambiás el operador: >  por  >= .


-- 9.3) ¿Cuántos edificios NO tienen ningún inmueble de planta baja?
--    (patrón NOT EXISTS + VALIDACIÓN)
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
-- EXPLICACIÓN:
--  - Patrón típico de "edificios que no tienen X" usando NOT EXISTS.
--  - Para cambiar la condición (por ejemplo, "sin inmuebles con sup > 100"),
--    solo cambiás el filtro dentro del NOT EXISTS.


-- 9.4) ¿Cuántos inmuebles de categoría "Alto" (piso >= 4)
--       existen en la provincia 'Corrientes'?


-- CONSULTA PARA ESCRIBIR EL NÚMERO
SELECT COUNT(*) AS cant_inmuebles_altos_corrientes
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Chaco'
  AND i.nro_piso >= 4;
GO

-- VALIDACIÓN DETALLADA: ver qué inmuebles son
SELECT 
    p.nombre AS provincia,
    i.inmueble_id,
    i.nro_piso,
    i.dpto,
    i.sup_cubierta
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Chaco'
  AND i.nro_piso >= 4
ORDER BY i.nro_piso, i.dpto;
GO

-- EXPLICACIÓN:
--  - El filtro de "categoría Alto" se simplifica a nro_piso >= 4.
--  - Si el enunciado cambiara a "Bajos (1 a 3)" o "PB", sólo
--    cambiás la condición de nro_piso en el WHERE.
--  - El JOIN con provincia sirve para filtrar por nombre legible,
--    no por código numérico.



--  9.5) ¿Cuántos edificios tienen una superficie total de inmuebles
--     superior a 500 m2?


-- CONSULTA PARA ESCRIBIR EL NÚMERO
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

-- VALIDACIÓN DETALLADA: listar esos edificios con su superficie total
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

-- EXPLICACIÓN:
--  - La tabla derivada t calcula la SUM(sup_cubierta) por edificio.
--  - La consulta externa cuenta cuántos edificios superan el umbral.
--  - Para modificar el enunciado (ej. "mayor o igual a 800 m2"),
--    sólo cambiás el valor y/o el operador en t.sup_total > 500.



--  9.6) ¿Cuántas localidades tienen más de 20 inmuebles?


-- CONSULTA PARA ESCRIBIR EL NÚMERO
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

-- VALIDACIÓN DETALLADA: ver esas localidades y su cantidad de inmuebles
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

-- EXPLICACIÓN:
--  - Típico patrón "grupo y filtro": primero agrupás por localidad
--    contando inmuebles; luego filtrás por la cantidad (> 20).
--  - Podría hacerse también con HAVING directamente:
--      SELECT provincia_id, localidad_id
--      FROM inmueble
--      GROUP BY provincia_id, localidad_id
--      HAVING COUNT(*) > 20;
--  - Cambiando el 20, adaptás rápido a otros enunciados.



--  9.7) ¿Cuántos inmuebles están en provincias 'Chaco' o 'Corrientes'
--       y NO están en planta baja?


-- CONSULTA PARA ESCRIBIR EL NÚMERO
SELECT COUNT(*) AS cant_inmuebles_chaco_corrientes_no_pb
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre IN ('Chaco', 'Corrientes')
  AND i.nro_piso <> 0;
GO

-- VALIDACIÓN DETALLADA: ver el detalle de esos inmuebles
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

-- EXPLICACIÓN:
--  - Se combinan dos ideas:
--      * Filtro por provincia usando IN (lista de valores).
--      * Exclusión de planta baja usando nro_piso <> 0.
--  - Para pedir "sólo planta baja", cambiás a nro_piso = 0.
--  - Para agregar más provincias, agregás nombres en el IN.

/*-----------------------------------------------------------------------------
  10) MODELOS TIPO MÚLTIPLE CHOICE CON INMUEBLE
      (opciones típicas y cómo validarlas)
-----------------------------------------------------------------------------*/

-- Supongamos una pregunta de parcial:
-- "Se desea conocer los inmuebles que NO tienen edificio asignado."
-- Salida: inmueble_id, nro_piso, dpto
--
-- En las opciones, podrían mostrar algo así:
--
--   A) WHERE provincia_id = 0 AND localidad_id = 0 AND edificio_id = 0
--   B) WHERE provincia_id IS NULL AND localidad_id IS NULL AND edificio_id IS NULL
--   C) WHERE inmueble_id IS NULL
--   D) WHERE provincia_id IS NULL OR localidad_id IS NULL OR edificio_id IS NULL
--
-- La correcta con este modelo de datos es la B).

-- Opción CORRECTA (patrón a recordar):
SELECT inmueble_id, nro_piso, dpto
FROM inmueble
WHERE provincia_id IS NULL
  AND localidad_id IS NULL
  AND edificio_id IS NULL;
GO

-- VALIDACIÓN RÁPIDA:
--  1) Contar cuántos registros cumplen la condición correcta:
SELECT COUNT(*) AS cant_inmuebles_sin_edificio_correcto
FROM inmueble
WHERE provincia_id IS NULL
  AND localidad_id IS NULL
  AND edificio_id IS NULL;

--  2) Comparar con una opción incorrecta (para entender por qué está mal).
--     Ejemplo: si en el parcial pusieran la opción D (OR en vez de AND):
SELECT COUNT(*) AS cant_inmuebles_con_algun_campo_nulo
FROM inmueble
WHERE provincia_id IS NULL
   OR localidad_id IS NULL
   OR edificio_id IS NULL;
GO
-- EXPLICACIÓN:
--  - En el modelo Consorcio, un inmueble sin edificio asignado tiene
--    la TRIPLE FK en NULL. Por eso usamos AND.
--  - Si usás OR, también agarrás inmuebles en estado inconsistente
--    donde solo una parte de la clave está nula.


-- Otro típico multiple choice:
-- "Inmuebles que pertenecen a edificios de la provincia 'Chaco' "
-- Pueden mezclar JOIN vs IN. El patrón correcto puede ser cualquiera
-- de estos dos (son equivalentes):

-- Versión con JOIN
SELECT i.inmueble_id, i.nro_piso, i.dpto
FROM inmueble i
JOIN provincia p
    ON p.provincia_id = i.provincia_id
WHERE p.nombre = 'Chaco';
GO

-- Versión con subconsulta IN (multi-registro)
SELECT i.inmueble_id, i.nro_piso, i.dpto
FROM inmueble i
WHERE i.provincia_id IN (
    SELECT provincia_id
    FROM provincia
    WHERE nombre = 'Chaco'
);
GO

-- VALIDACIÓN: comparar que ambas devuelvan la misma cantidad
SELECT 
    (SELECT COUNT(*) 
     FROM inmueble i
     JOIN provincia p
         ON p.provincia_id = i.provincia_id
     WHERE p.nombre = 'Chaco') AS cant_join,
    (SELECT COUNT(*) 
     FROM inmueble i
     WHERE i.provincia_id IN (
         SELECT provincia_id FROM provincia WHERE nombre = 'Chaco'
     )) AS cant_in;
GO
-- EXPLICACIÓN:
--  - Útil para justificar por qué elegís una opción que usa JOIN o IN.
--  - Mientras respeten la misma condición de filtro, ambas son correctas.


-- Multiple choice con EXISTS / NOT EXISTS:
-- "Localidades que tienen al menos un inmueble de planta baja"
--   A) JOIN + GROUP BY + HAVING
--   B) EXISTS
--   C) NOT EXISTS
--   D) INNER JOIN inmueble sin condición de piso
--
-- Patrón con EXISTS (muy probable que sea la opción correcta):

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

-- VALIDACIÓN alternativa con GROUP BY + HAVING (mismo resultado):
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
-- EXPLICACIÓN:
--  - Para justificar la opción con EXISTS podés decir que:
--    "EXISTS verifica la existencia de al menos un inmueble PB asociado
--     a la localidad, sin necesidad de agrupar."
--  - Y si quisieras cambiar nro_piso o agregar otra condición,
--    solo modificás el WHERE interno de EXISTS.

/*-----------------------------------------------------------------------------
  10.x) MC: INMUEBLES CON SUPERFICIE ENTRE 50 Y 100 m2
-----------------------------------------------------------------------------*/

-- Supongamos la pregunta:
-- "Se desea conocer los inmuebles cuya superficie cubierta esté entre
--  50 y 100 m2, inclusive."
--
-- Opciones típicas:
--   A) WHERE sup_cubierta > 50 AND sup_cubierta < 100
--   B) WHERE sup_cubierta >= 50 OR sup_cubierta <= 100
--   C) WHERE sup_cubierta BETWEEN 50 AND 100
--   D) WHERE sup_cubierta = 50 AND sup_cubierta = 100
--
-- La correcta es la C) porque BETWEEN es inclusivo (incluye 50 y 100).

-- Opción CORRECTA:
SELECT inmueble_id, nro_piso, dpto, sup_cubierta
FROM inmueble
WHERE sup_cubierta BETWEEN 50 AND 100;
GO

-- VALIDACIÓN: comparar con la versión "explícita" correcta
SELECT 
    (SELECT COUNT(*) 
     FROM inmueble
     WHERE sup_cubierta BETWEEN 50 AND 100) AS cant_between,
    (SELECT COUNT(*)
     FROM inmueble
     WHERE sup_cubierta >= 50
       AND sup_cubierta <= 100) AS cant_explicita;
GO

-- EXPLICACIÓN:
--  - BETWEEN 50 AND 100 es equivalente a >= 50 AND <= 100.
--  - La opción A excluye los bordes (50 y 100).
--  - La opción B con OR abarca casi todo (cualquier valor >= 50
--    o cualquier valor <= 100).


/*-----------------------------------------------------------------------------
  10.y) MC: EDIFICIOS SIN NINGÚN INMUEBLE ASIGNADO
-----------------------------------------------------------------------------*/

-- Pregunta:
-- "Se desea listar los edificios que NO tienen inmuebles asignados."
--
-- Opciones típicas:
--   A) SELECT ... FROM edificio e
--      INNER JOIN inmueble i ON ... WHERE i.inmueble_id IS NULL
--   B) SELECT ... FROM edificio e
--      LEFT JOIN inmueble i ON ...
--      WHERE i.inmueble_id IS NULL
--   C) SELECT ... FROM inmueble WHERE edificio_id IS NULL
--   D) SELECT ... FROM edificio WHERE provincia_id IS NULL
--
-- La correcta es la B) (patrón LEFT JOIN + IS NULL).

-- Patrón CORRECTO:
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

-- VALIDACIÓN: contar cuántos edificios salen
SELECT COUNT(*) AS cant_edificios_sin_inmuebles
FROM edificio e
LEFT JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE i.inmueble_id IS NULL;
GO

-- EXPLICACIÓN:
--  - El LEFT JOIN garantiza que aparezcan todos los edificios,
--    aunque no tengan inmuebles.
--  - El WHERE i.inmueble_id IS NULL filtra justamente los que
--    no encontraron coincidencias en inmueble.
--  - INNER JOIN con IS NULL nunca devuelve nada (por eso A es incorrecta).


/*-----------------------------------------------------------------------------
  10.z) MC: INMUEBLES CON SUPERFICIE MAYOR AL PROMEDIO DE SU EDIFICIO
-----------------------------------------------------------------------------*/

-- Pregunta:
-- "Se desea obtener los inmuebles cuya superficie cubierta sea mayor
--  al promedio de superficie de los inmuebles de su mismo edificio."
--
-- Opciones simplificadas:
--   A) WHERE sup_cubierta > (SELECT AVG(sup_cubierta) FROM inmueble)
--   B) WHERE sup_cubierta > (SELECT AVG(sup_cubierta)
--                            FROM inmueble i2
--                            WHERE i2.provincia_id = inmueble.provincia_id
--                              AND i2.localidad_id = inmueble.localidad_id
--                              AND i2.edificio_id  = inmueble.edificio_id)
--   C) WHERE sup_cubierta > (SELECT MAX(sup_cubierta) FROM inmueble)
--   D) WHERE sup_cubierta > (SELECT AVG(sup_cubierta)
--                            FROM inmueble i2
--                            WHERE i2.edificio_id = inmueble.inmueble_id)
--
-- La correcta es la B): subconsulta correlacionada por la clave del edificio.

-- Patrón CORRECTO (versión completa con alias):
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

-- VALIDACIÓN: mostrar el promedio al lado (tabla derivada)
SELECT 
    i.inmueble_id,
    i.provincia_id,
    i.localidad_id,
    i.edificio_id,
    i.sup_cubierta,
    t.sup_promedio_edificio
FROM inmueble i
JOIN (
    SELECT 
        provincia_id,
        localidad_id,
        edificio_id,
        AVG(sup_cubierta) AS sup_promedio_edificio
    FROM inmueble
    GROUP BY provincia_id, localidad_id, edificio_id
) AS t
    ON t.provincia_id = i.provincia_id
   AND t.localidad_id = i.localidad_id
   AND t.edificio_id  = i.edificio_id
WHERE i.sup_cubierta > t.sup_promedio_edificio
ORDER BY i.provincia_id, i.localidad_id, i.edificio_id, i.sup_cubierta DESC;
GO

-- EXPLICACIÓN:
--  - La opción A compara contra el promedio global de TODOS los inmuebles,
--    no por edificio (enunciado pide "su edificio").
--  - La opción B sí recalcula el promedio restringido al mismo edificio,
--    usando la clave compuesta.
--  - La validación con tabla derivada muestra el promedio por edificio
--    al lado de cada inmueble para revisar que el filtro tenga sentido.
