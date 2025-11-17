/* =====================================================================
   Machete SQL – Consultas y Subconsultas (SQL Server + base consorcio)
   ---------------------------------------------------------------------

   ORDEN LÓGICO EN EL QUE SQL "PIENSA" UNA CONSULTA:

   1) FROM        -> qué tablas uso y cómo las uno (JOIN)
   2) WHERE       -> filtro filas sin agrupar todavía
   3) GROUP BY    -> agrupo filas
   4) HAVING      -> filtro grupos (con SUM, COUNT, etc.)
   5) SELECT      -> elijo qué columnas o expresiones mostrar
   6) ORDER BY    -> orden final de las filas

   ORDEN EN EL QUE LA ESCRIBIMOS: SELECT ... FROM ... WHERE ... GROUP BY ...
====================================================================== */

----------------------------------------------------------------------
-- 0) CONTEXTO
----------------------------------------------------------------------
-- Ajustar el nombre si la base se llama distinto en el parcial
USE base_consorcio_2025;
GO

SET NOCOUNT ON;
GO


/* =====================================================================
   1) SELECT BÁSICO + FROM + ORDER BY
   ---------------------------------------------------------------------
   SELECT: qué columnas quiero ver
   FROM:   de qué tabla las saco
   ORDER BY: cómo ordeno el resultado
====================================================================== */

-- Ej 1.1: todas las columnas de una tabla
SELECT *
FROM provincia;


-- Ej 1.2: solo algunas columnas + alias
SELECT
    provincia_id AS [ID de la Provincia],
    nombre AS [Nombre de la Provincia]
FROM provincia
ORDER BY [Nombre de la Provincia];  -- orden alfabético


-- Ej 1.3: SELECT DISTINCT para eliminar duplicados
-- ¿Para qué sirve? Cuando hay muchos registros con el mismo valor,
-- y solo me interesa ver cada valor una sola vez.
SELECT DISTINCT provincia_id
FROM edificio
ORDER BY provincia_id;


-- Ej 1.4: TOP para ver solo los primeros N registros (SQL Server)
SELECT TOP (10) *
FROM persona
ORDER BY persona_id;


/* =====================================================================
   2) WHERE – FILTROS DE FILAS (ANTES DEL GROUP BY)
   ---------------------------------------------------------------------
   WHERE se usa para condicionar filas individuales.
   Solo puede usar columnas "normales", no agregaciones como SUM().
====================================================================== */

-- Operadores básicos: =, <>, >, <, >=, <=
-- Ej 2.1: edificios de una provincia específica
SELECT *
FROM edificio
WHERE provincia_id = 6;

-- Ej 2.1.2: edificios de una provincia específica (mostrando el nombre de la provincia en vez del id)
SELECT  
    p.nombre AS provincia,       -- nombre de la provincia
    e.localidad_id,
    e.edificio_id,
    e.nombre,
    e.direccion,
    e.zona_id,
    e.conserje_id,
    e.administrador_id
FROM edificio e
INNER JOIN provincia p
    ON e.provincia_id = p.provincia_id   -- relación entre las tablas
WHERE p.provincia_id = 6;               -- o WHERE p.nombre = 'X'

-- Ej 2.2: BETWEEN (rango inclusivo)
SELECT *
FROM gasto
WHERE importe BETWEEN 1000 AND 5000
ORDER BY importe;


-- Ej 2.3: IN (lista de valores)
SELECT *
FROM provincia
WHERE nombre IN (N'Chaco', N'Corrientes', N'Formosa', N'Misiones');


-- Ej 2.4: LIKE (patrones de texto)
--   %  = cualquier cantidad de caracteres
--   _  = un solo carácter
SELECT *
FROM provincia
WHERE nombre LIKE N'San%';  -- empieza con "San"


-- Ej 2.5: IS NULL / IS NOT NULL
-- Mostrar edificios sin conserje asignado
SELECT *
FROM edificio
WHERE conserje_id IS NULL;


/* =====================================================================
   3) JOIN – UNIR TABLAS RELACIONADAS
   ---------------------------------------------------------------------
   Los JOINs se definen siempre en el FROM.

   INNER JOIN: solo filas que matchean en ambas tablas.
   LEFT JOIN:  todas las filas de la izquierda y lo que matchee de la derecha.
====================================================================== */

-- Ej 3.1: edificios con nombre de provincia
SELECT
    e.edificio_id,
    e.nombre        AS edificio,
    p.nombre        AS provincia
FROM edificio e
INNER JOIN provincia p
    ON p.provincia_id = e.provincia_id
ORDER BY provincia, edificio;


-- Ej 3.2: edificios con provincia + localidad (PK compuesta)
SELECT
    p.nombre AS provincia,
    l.nombre AS localidad,
    e.nombre AS edificio
FROM edificio e
INNER JOIN provincia p
    ON p.provincia_id = e.provincia_id
INNER JOIN localidad l
    ON l.provincia_id = e.provincia_id
   AND l.localidad_id = e.localidad_id
ORDER BY p.nombre, l.nombre, e.nombre;


-- Ej 3.3: LEFT JOIN cuando el lado derecho puede faltar
-- Edificios y conserje (si lo tienen)
SELECT
    e.nombre               AS edificio,
    per.apellido_nombre    AS conserje
FROM edificio e
LEFT JOIN conserje c
    ON c.conserje_id = e.conserje_id     -- puede ser NULL
LEFT JOIN persona per
    ON per.persona_id = c.conserje_id
ORDER BY edificio;


/* =====================================================================
   4) FUNCIONES DE AGREGACIÓN + GROUP BY + HAVING
   ---------------------------------------------------------------------
   Funciones de agregación: SUM, COUNT, AVG, MIN, MAX.

   - GROUP BY agrupa filas.
   - HAVING filtra GRUPOS (como un WHERE pero de agrupación).
====================================================================== */

-- Ej 4.1: cantidad de edificios por provincia
SELECT
    provincia_id,
    COUNT(*) AS cantidad_edificios
FROM edificio
GROUP BY provincia_id;

-- Ej 4.1.2: cantidad de edificios por provincia (mostrando el nombre en vez del id)
SELECT
    p.nombre AS provincia,
    COUNT(*) AS cantidad_edificios
FROM edificio e
INNER JOIN	provincia p
	ON p.provincia_id = e.provincia_id
GROUP BY p.nombre
ORDER BY cantidad_edificios DESC;


-- Ej 4.2: total de gastos por tipo de gasto
SELECT
    tg.tipo_gasto_id,
    tg.nombre              AS tipo_gasto,
    SUM(g.importe)         AS total_gastado
FROM gasto g
INNER JOIN tipo_gasto tg
    ON tg.tipo_gasto_id = g.tipo_gasto_id
GROUP BY tg.tipo_gasto_id, tg.nombre
ORDER BY total_gastado DESC;


-- Ej 4.3: provincias con más de 4 edificios (GROUP BY + HAVING)
SELECT
    p.provincia_id,
    p.nombre AS provincia,
    COUNT(*) AS cantidad_edificios
FROM edificio e
INNER JOIN provincia p
    ON p.provincia_id = e.provincia_id
GROUP BY p.provincia_id, p.nombre
HAVING COUNT(*) > 4      -- condición SOBRE EL GRUPO
ORDER BY cantidad_edificios DESC;


/* =====================================================================
   5) ORDEN LÓGICO DEMOSTRADO CON UN EJEMPLO COMPLETO
   ---------------------------------------------------------------------
   Objetivo: "Listar las provincias con la cantidad de edificios,
   solo las que tienen más de 4, ordenadas de mayor a menor."

   1) FROM edificio JOIN provincia
   2) WHERE ... (si hubiera filtros por filas)
   3) GROUP BY provincia
   4) HAVING COUNT(*) > 4
   5) SELECT columnas + COUNT(*)
   6) ORDER BY cantidad_edificios DESC
====================================================================== */

SELECT
    p.nombre AS provincia,
    COUNT(*) AS cantidad_edificios
FROM edificio e
INNER JOIN provincia p
    ON p.provincia_id = e.provincia_id
-- WHERE ...  (filtros por filas irían acá)
GROUP BY p.nombre
HAVING COUNT(*) > 4
ORDER BY cantidad_edificios DESC;
GO


/* =====================================================================
   6) SUBCONSULTAS – CASOS TÍPICOS
   ---------------------------------------------------------------------
   TIPOS PRINCIPALES:
   - Subconsulta ESCALAR (devuelve un solo valor)   -> se combina con =, >, etc.
   - Subconsulta MULTI-REGISTRO con IN / NOT IN
   - Subconsulta CORRELACIONADA con EXISTS / NOT EXISTS
   - Subconsulta en FROM (tabla derivada)
   - Subconsulta en SELECT (columna calculada)
====================================================================== */

----------------------------------------------------------------------
-- 6.1) SUBCONSULTA ESCALAR (UN SOLO VALOR)
--     Se usa como si fuera un "número" / "texto" en la comparación.
----------------------------------------------------------------------

-- Ej 6.1.a: provincias con población mayor que el promedio general
SELECT
    p.provincia_id,
    p.nombre,
    p.poblacion
FROM provincia p
WHERE p.poblacion >
(
    SELECT AVG(p2.poblacion)      -- subconsulta devuelve un solo valor
    FROM provincia p2
);


-- Ej 6.1.b: edificios cuyo total de gastos supera el promedio
--           de gastos por edificio.
-- Paso 1: calcular total por edificio (GROUP BY)
-- Paso 2: comparar con promedio global (subconsulta escalar)
SELECT
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS edificio,
    SUM(g.importe) AS total_edificio
FROM gasto g
INNER JOIN edificio e
    ON e.provincia_id = g.provincia_id
   AND e.localidad_id = g.localidad_id
   AND e.edificio_id  = g.edificio_id
GROUP BY e.provincia_id, e.localidad_id, e.edificio_id, e.nombre
HAVING SUM(g.importe) >
(
    SELECT AVG(total_gastos)
    FROM (
        SELECT
            provincia_id,
            localidad_id,
            edificio_id,
            SUM(importe) AS total_gastos
        FROM gasto
        GROUP BY provincia_id, localidad_id, edificio_id
    ) AS x
);
GO


----------------------------------------------------------------------
-- 6.2) SUBCONSULTA CON IN (MULTI-REGISTRO)
--     Cuando la subconsulta devuelve una LISTA de valores.
----------------------------------------------------------------------

-- Ej 6.2.a: provincias que tienen al menos 4 edificios
SELECT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE p.provincia_id IN (
    SELECT e.provincia_id
    FROM edificio e
    GROUP BY e.provincia_id
    HAVING COUNT(*) >= 4
);


-- Ej 6.2.b: edificios ubicados en esas provincias "grandes"
SELECT
    e.nombre AS edificio,
    p.nombre AS provincia
FROM edificio e
INNER JOIN provincia p
    ON p.provincia_id = e.provincia_id
WHERE e.provincia_id IN (
    SELECT e2.provincia_id
    FROM edificio e2
    GROUP BY e2.provincia_id
    HAVING COUNT(*) >= 4
);
GO


----------------------------------------------------------------------
-- 6.3) EXISTS / NOT EXISTS (SUBCONSULTAS CORRELACIONADAS)
--     La subconsulta hace referencia a la fila externa.
--     Muy útil para "tiene / no tiene X asociado".
----------------------------------------------------------------------

-- Ej 6.3.a: provincias que TIENEN al menos un edificio
SELECT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE EXISTS (
    SELECT 1
    FROM edificio e
    WHERE e.provincia_id = p.provincia_id
);


-- Ej 6.3.b: provincias que NO tienen edificios
SELECT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE NOT EXISTS (
    SELECT 1
    FROM edificio e
    WHERE e.provincia_id = p.provincia_id
);


-- Ej 6.3.c: personas que no son ni conserjes ni administradores
SELECT
    p.persona_id,
    p.apellido_nombre
FROM persona p
WHERE NOT EXISTS (
          SELECT 1
          FROM conserje c
          WHERE c.conserje_id = p.persona_id
      )
  AND NOT EXISTS (
          SELECT 1
          FROM administrador a
          WHERE a.administrador_id = p.persona_id
      )
ORDER BY p.apellido_nombre;
GO


----------------------------------------------------------------------
-- 6.4) SUBCONSULTA EN FROM (TABLA DERIVADA)
--     Sirve cuando necesitás primero un resultado agrupado y luego
--     volver a unirlo con otras tablas o aplicar más filtros.
----------------------------------------------------------------------

-- Ej 6.4.a: tabla derivada con total gastado por edificio
--           luego filtro solo los que superan 50.000
SELECT
    t.provincia_id,
    t.localidad_id,
    t.edificio_id,
    e.nombre AS edificio,
    t.total_gastos
FROM (
    SELECT
        provincia_id,
        localidad_id,
        edificio_id,
        SUM(importe) AS total_gastos
    FROM gasto
    GROUP BY provincia_id, localidad_id, edificio_id
) AS t
INNER JOIN edificio e
    ON e.provincia_id = t.provincia_id
   AND e.localidad_id = t.localidad_id
   AND e.edificio_id  = t.edificio_id
WHERE t.total_gastos > 50000
ORDER BY t.total_gastos DESC;
GO


----------------------------------------------------------------------
-- 6.5) SUBCONSULTAS EN SELECT (COLUMNAS CALCULADAS)
--     Cada fila de la consulta externa dispara la subconsulta.
--     Útil para "traer un dato agregado relacionado".
----------------------------------------------------------------------

-- Ej 6.5.a: cada provincia con la cantidad de edificios que tiene
SELECT
    p.provincia_id,
    p.nombre AS provincia,
    (
        SELECT COUNT(*)
        FROM edificio e
        WHERE e.provincia_id = p.provincia_id
    ) AS cantidad_edificios
FROM provincia p
ORDER BY cantidad_edificios DESC;


-- Ej 6.5.b: cada edificio con su total de gastos
SELECT
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS edificio,
    (
        SELECT SUM(g.importe)
        FROM gasto g
        WHERE g.provincia_id = e.provincia_id
          AND g.localidad_id = e.localidad_id
          AND g.edificio_id  = e.edificio_id
    ) AS total_gastos
FROM edificio e
ORDER BY total_gastos DESC;
GO


/* =====================================================================
   7) PATRONES TÍPICOS DE EXAMEN CON BASE CONSORCIO
   ---------------------------------------------------------------------
   Estas consultas son "esqueletos" que podés adaptar rápido.
====================================================================== */

----------------------------------------------------------------------
-- 7.1) "Edificios en las N zonas con más edificios"
----------------------------------------------------------------------

SELECT
    e.nombre AS edificio,
    z.nombre AS zona
FROM edificio e
INNER JOIN zona z
    ON z.zona_id = e.zona_id
WHERE e.zona_id IN (
    SELECT TOP (2) e2.zona_id      -- cambiar 2 por el número que pidan
    FROM edificio e2
    GROUP BY e2.zona_id
    ORDER BY COUNT(*) DESC
);


----------------------------------------------------------------------
-- 7.2) "Localidades donde hay más de un edificio"
----------------------------------------------------------------------

SELECT
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS edificio
FROM edificio e
INNER JOIN (
    SELECT
        provincia_id,
        localidad_id
    FROM edificio
    GROUP BY provincia_id, localidad_id
    HAVING COUNT(*) > 1
) AS x
    ON x.provincia_id = e.provincia_id
   AND x.localidad_id = e.localidad_id;


----------------------------------------------------------------------
-- 7.3) "Conserjes mayores de 50 años que NO están asignados"
----------------------------------------------------------------------

SELECT
    p.persona_id,
    p.apellido_nombre,
    DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) AS edad
FROM persona p
INNER JOIN conserje c
    ON c.conserje_id = p.persona_id
WHERE DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) > 50
  AND NOT EXISTS (
        SELECT 1
        FROM edificio e
        WHERE e.conserje_id = c.conserje_id
  )
ORDER BY edad DESC;


----------------------------------------------------------------------
-- 7.4) "Personas con doble rol: conserje y administrador"
----------------------------------------------------------------------

SELECT
    p.persona_id,
    p.apellido_nombre
FROM persona p
INNER JOIN conserje c
    ON c.conserje_id = p.persona_id
INNER JOIN administrador a
    ON a.administrador_id = p.persona_id;


----------------------------------------------------------------------
-- 7.5) "Edificios que superaron X pesos en gasto de 'Limpieza' en 2015"
----------------------------------------------------------------------

SELECT
    e.nombre       AS edificio,
    p.nombre       AS provincia,
    l.nombre       AS localidad,
    SUM(g.importe) AS total_limpieza_2015
FROM gasto g
INNER JOIN tipo_gasto tg
    ON tg.tipo_gasto_id = g.tipo_gasto_id
INNER JOIN edificio e
    ON e.provincia_id = g.provincia_id
   AND e.localidad_id = g.localidad_id
   AND e.edificio_id  = g.edificio_id
INNER JOIN provincia p
    ON p.provincia_id = e.provincia_id
INNER JOIN localidad l
    ON l.provincia_id = e.provincia_id
   AND l.localidad_id = e.localidad_id
WHERE tg.nombre = N'Limpieza'
  AND YEAR(g.fecha_pago) = 2015
GROUP BY e.nombre, p.nombre, l.nombre
HAVING SUM(g.importe) > 30000          -- cambiar monto si el enunciado dice otro
ORDER BY total_limpieza_2015 DESC;
GO


/* =====================================================================
   FIN DEL MACHETE
   ---------------------------------------------------------------------
   Clave para el parcial:
   - Identificar si el problema es:
       * simple (SELECT + WHERE + JOIN)
       * agrupado (SUM/COUNT + GROUP BY + HAVING)
       * o si pide "provincias que..." según condición sobre edificios
         (ahí es casi seguro que va EXISTS/IN con subconsulta).
====================================================================== */
