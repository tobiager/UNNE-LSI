/* ============================================================
   Machete SQL – Base Consorcio (para parcial)
   ============================================================ */

---------------------------------------------------------------
-- 0) CONTEXTO (ajustá el nombre si lo cambian en el parcial)
---------------------------------------------------------------
-- USE base_consorcio_2025;
-- GO

SET NOCOUNT ON;
GO

/* ============================================================
   1) EXPLORACIÓN RÁPIDA – VER QUÉ HAY EN LAS TABLAS
   ============================================================ */

-- Primeras filas de cada tabla (podés comentar lo que no uses)
SELECT TOP (20) * FROM provincia;
SELECT TOP (20) * FROM localidad;
SELECT TOP (20) * FROM zona;
SELECT TOP (20) * FROM persona;
SELECT TOP (20) * FROM conserje;
SELECT TOP (20) * FROM administrador;
SELECT TOP (20) * FROM tipo_gasto;
SELECT TOP (20) * FROM edificio;
SELECT TOP (20) * FROM gasto;
GO


/* ============================================================
   2) CONSULTAS SIMPLES (SELECT + WHERE + ORDER BY)
   ============================================================ */

-- 2.1. Provincias con nombre que contenga un texto
SELECT *
FROM provincia
WHERE nombre LIKE '%San%'
ORDER BY nombre;

-- 2.2. Personas mayores de 60 años (aprox)
SELECT
    persona_id,
    apellido_nombre,
    fecha_nacimiento,
    DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS edad
FROM persona
WHERE DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 60
ORDER BY edad DESC;

-- 2.3. Gastos de un período específico (ej: marzo 2013)
SELECT *
FROM gasto
WHERE YEAR (fecha_pago) = 2013 AND MONTH (fecha_pago) = 3 
ORDER BY fecha_pago;
GO


/* ============================================================
   3) JOIN BÁSICOS SOBRE CONSORCIO
   ============================================================ */

-- 3.1. Edificio + provincia + localidad
SELECT
    p.nombre AS provincia,
    l.nombre AS localidad,
    e.nombre AS edificio
FROM edificio e
JOIN provincia p
  ON p.provincia_id = e.provincia_id
JOIN localidad l
  ON l.provincia_id = e.provincia_id
 AND l.localidad_id = e.localidad_id
ORDER BY p.nombre, l.nombre, e.nombre;

-- 3.2. Edificio + zona + provincia
SELECT
    e.nombre AS edificio,
    z.nombre AS zona,
    p.nombre AS provincia
FROM edificio e
LEFT JOIN zona z
  ON z.zona_id = e.zona_id
JOIN provincia p
  ON p.provincia_id = e.provincia_id
ORDER BY provincia, zona, edificio;

-- 3.3. Edificio + conserje + administrador (si existen)
SELECT
    e.nombre AS edificio,
    pc.apellido_nombre AS conserje,
    pa.apellido_nombre AS administrador
FROM edificio e
LEFT JOIN conserje c
  ON c.conserje_id = e.conserje_id
LEFT JOIN persona pc
  ON pc.persona_id = c.conserje_id
LEFT JOIN administrador a
  ON a.administrador_id = e.administrador_id
LEFT JOIN persona pa
  ON pa.persona_id = a.administrador_id
ORDER BY edificio;
GO

--3.4 Conserjes que no son Administradores
SELECT c.conserje_id, p.apellido_nombre, c.jornada_laboralFROM conserje cINNER JOIN persona p ON c.conserje_id = p.persona_idLEFT JOIN administrador a ON c.conserje_id = a.administrador_idWHERE a.administrador_id IS NULL;

SELECT *
FROM conserje AS c
WHERE conserje_id NOT IN ( SELECT a.administrador_id
FROM administrador AS a
)

--Todos los conserjes que no son administradores y todos los administradores que no son conserjes
SELECT 
    c.conserje_id        AS id_persona,
    p.apellido_nombre    AS nombre,
    c.jornada_laboral    AS jornada,
    'Conserje que NO es administrador' AS tipo
FROM conserje c
INNER JOIN persona p 
    ON c.conserje_id = p.persona_id
LEFT JOIN administrador a 
    ON c.conserje_id = a.administrador_id
WHERE a.administrador_id IS NULL

UNION ALL

SELECT 
    a.administrador_id   AS id_persona,
    p.apellido_nombre    AS nombre,
    NULL                 AS jornada,
    'Administrador que NO es conserje' AS tipo
FROM administrador a
INNER JOIN persona p 
    ON a.administrador_id = p.persona_id
LEFT JOIN conserje c 
    ON c.conserje_id = a.administrador_id
WHERE c.conserje_id IS NULL;

/* ============================================================
   4) AGREGACIONES + GROUP BY + HAVING
   ============================================================ */

-- 4.1. Cantidad de edificios por provincia
SELECT
    p.nombre AS provincia,
    COUNT(*) AS cantidad_edificios
FROM edificio e
JOIN provincia p
  ON p.provincia_id = e.provincia_id
GROUP BY p.nombre
ORDER BY cantidad_edificios DESC;

-- 4.2. Edificios por localidad (solo localidades con al menos 2)
SELECT
    p.nombre AS provincia,
    l.nombre AS localidad,
    COUNT(*) AS cantidad_edificios
FROM edificio e
JOIN localidad l
  ON l.provincia_id = e.provincia_id
 AND l.localidad_id = e.localidad_id
JOIN provincia p
  ON p.provincia_id = e.provincia_id
GROUP BY p.nombre, l.nombre
HAVING COUNT(*) >= 2
ORDER BY p.nombre, l.nombre;

-- 4.3. Total de gastos por tipo de gasto
SELECT
    tg.nombre AS tipo_gasto,
    SUM(g.importe) AS total_gastado
FROM gasto g
JOIN tipo_gasto tg
  ON tg.tipo_gasto_id = g.tipo_gasto_id
GROUP BY tg.nombre
ORDER BY total_gastado DESC;

-- 4.4. Total de gastos por edificio en un año
SELECT
    e.nombre AS edificio,
    SUM(g.importe) AS total_gastado_en_2017
FROM gasto g
JOIN edificio e
  ON e.provincia_id = g.provincia_id
 AND e.localidad_id = g.localidad_id
 AND e.edificio_id  = g.edificio_id
WHERE YEAR(g.fecha_pago) = 2017
GROUP BY e.nombre
ORDER BY total_gastado_en_2017 DESC;
GO


/* ============================================================
   5) TOP N – RANKINGS
   ============================================================ */

-- 5.1. TOP 5 provincias con más edificios
SELECT TOP (5)
    p.nombre AS provincia,
    COUNT(*) AS cantidad_edificios
FROM edificio e
JOIN provincia p
  ON p.provincia_id = e.provincia_id
GROUP BY p.nombre
ORDER BY cantidad_edificios DESC;

-- 5.2. TOP 3 edificios por total de gastos históricos
SELECT TOP (3)
    e.nombre AS edificio,
    p.nombre AS provincia,
    SUM(g.importe) AS total_gastado
FROM gasto g
JOIN edificio e
  ON e.provincia_id = g.provincia_id
 AND e.localidad_id = g.localidad_id
 AND e.edificio_id  = g.edificio_id
JOIN provincia p
  ON p.provincia_id = e.provincia_id
GROUP BY e.nombre, p.nombre
ORDER BY total_gastado DESC;
GO


/* ============================================================
   6) SUBCONSULTAS ESCALARES (1 SOLO VALOR)
   ============================================================ */

-- 6.1. Edificios cuyo gasto total supera el promedio general de gastos por edificio
SELECT
    e.nombre AS edificio,
    SUM(g.importe) AS total_edificio
FROM gasto g
JOIN edificio e
  ON e.provincia_id = g.provincia_id
 AND e.localidad_id = g.localidad_id
 AND e.edificio_id  = g.edificio_id
GROUP BY e.nombre
HAVING SUM(g.importe) >
(
    SELECT AVG(total_gastos)
    FROM (
        SELECT SUM(g2.importe) AS total_gastos
        FROM gasto g2
        GROUP BY g2.provincia_id, g2.localidad_id, g2.edificio_id
    ) AS x
);

-- 6.2. Provincias cuya población es mayor al promedio de todas
SELECT
    p.nombre,
    p.poblacion
FROM provincia p
WHERE p.poblacion >
(
    SELECT AVG(p2.poblacion)
    FROM provincia p2
);
GO


/* ============================================================
   7) SUBCONSULTAS CON IN (MULTI-REGISTRO)
   ============================================================ */

-- 7.1. Provincias con más de 4 edificios
SELECT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE p.provincia_id IN (
    SELECT e.provincia_id
    FROM edificio e
    GROUP BY e.provincia_id
    HAVING COUNT(*) > 4
);

-- 7.2. Edificios ubicados en provincias con más de 4 edificios
SELECT
    e.nombre AS edificio,
    p.nombre AS provincia
FROM edificio e
JOIN provincia p
  ON p.provincia_id = e.provincia_id
WHERE e.provincia_id IN (
    SELECT e2.provincia_id
    FROM edificio e2
    GROUP BY e2.provincia_id
    HAVING COUNT(*) > 4
);

-- 7.3. Edificios en las 3 zonas con mayor cantidad de edificios
SELECT
    e.nombre AS edificio,
    z.nombre AS zona
FROM edificio e
JOIN zona z
  ON z.zona_id = e.zona_id
WHERE e.zona_id IN (
    SELECT TOP (3) e2.zona_id
    FROM edificio e2
    GROUP BY e2.zona_id
    ORDER BY COUNT(*) DESC
);
GO


/* ============================================================
   8) EXISTS / NOT EXISTS (SUBCONSULTAS CORRELACIONADAS)
   ============================================================ */

-- 8.1. Provincias que tienen al menos un edificio
SELECT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE EXISTS (
    SELECT 1
    FROM edificio e
    WHERE e.provincia_id = p.provincia_id
);

-- 8.2. Provincias que NO tienen edificios
SELECT
    p.provincia_id,
    p.nombre AS provincia
FROM provincia p
WHERE NOT EXISTS (
    SELECT 1
    FROM edificio e
    WHERE e.provincia_id = p.provincia_id
);

-- 8.3. Tipos de gasto que se usaron al menos una vez en 2013
SELECT
    tg.tipo_gasto_id,
    tg.nombre
FROM tipo_gasto tg
WHERE EXISTS (
    SELECT 1
    FROM gasto g
    WHERE g.tipo_gasto_id = tg.tipo_gasto_id
      AND YEAR(g.fecha_pago) = 2013
);

-- 8.4. Personas que NO son ni conserjes ni administradores
SELECT
    p.persona_id,
    p.apellido_nombre
FROM persona p
WHERE NOT EXISTS (
          SELECT 1 FROM conserje c WHERE c.conserje_id = p.persona_id
      )
  AND NOT EXISTS (
          SELECT 1 FROM administrador a WHERE a.administrador_id = p.persona_id
      )
ORDER BY p.apellido_nombre;
GO


/* ============================================================
   9) SUBCONSULTAS EN FROM (TABLAS DERIVADAS)
   ============================================================ */

-- 9.1. Tabla derivada con total de gastos por edificio y luego filtrar
SELECT
    t.edificio_id,
    t.provincia_id,
    t.localidad_id,
    t.total_gastos,
    e.nombre  AS edificio,
    p.nombre  AS provincia,
    l.nombre  AS localidad
FROM (
    SELECT
        provincia_id,
        localidad_id,
        edificio_id,
        SUM(importe) AS total_gastos
    FROM gasto
    GROUP BY provincia_id, localidad_id, edificio_id
) AS t
JOIN edificio e
  ON e.provincia_id = t.provincia_id
 AND e.localidad_id = t.localidad_id
 AND e.edificio_id  = t.edificio_id
JOIN provincia p
  ON p.provincia_id = t.provincia_id
JOIN localidad l
  ON l.provincia_id = t.provincia_id
 AND l.localidad_id = t.localidad_id
WHERE t.total_gastos > 50000
ORDER BY t.total_gastos DESC;

-- 9.2. Promedio de gasto mensual por edificio (usando periodo)
SELECT
    x.provincia_id,
    x.localidad_id,
    x.edificio_id,
    e.nombre AS edificio,
    AVG(x.total_mes) AS promedio_mensual
FROM (
    SELECT
        provincia_id,
        localidad_id,
        edificio_id,
        periodo,
        SUM(importe) AS total_mes
    FROM gasto
    GROUP BY provincia_id, localidad_id, edificio_id, periodo
) AS x
JOIN edificio e
  ON e.provincia_id = x.provincia_id
 AND e.localidad_id = x.localidad_id
 AND e.edificio_id  = x.edificio_id
GROUP BY x.provincia_id, x.localidad_id, x.edificio_id, e.nombre;
GO


/* ============================================================
   10) SUBCONSULTAS EN SELECT (COLUMNAS CALCULADAS)
   ============================================================ */

-- 10.1. Cada edificio con su total de gastos (subconsulta en SELECT)
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

-- 10.2. Provincias con cantidad de edificios (subconsulta en SELECT)
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
GO


/* ============================================================
   11) PATRONES CON PERSONAS / EDADES / ROLES
   ============================================================ */

-- 11.1. Conserjes entre 50 y 60 años (asignados o no)
SELECT
    p.persona_id,
    p.apellido_nombre,
    DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) AS edad
FROM persona p
JOIN conserje c
  ON c.conserje_id = p.persona_id
WHERE DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) BETWEEN 50 AND 60
ORDER BY edad DESC;

-- 11.2. Conserjes > 50 años que NO están asignados a ningún edificio
SELECT
    p.persona_id,
    p.apellido_nombre,
    DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) AS edad
FROM persona p
JOIN conserje c
  ON c.conserje_id = p.persona_id
WHERE DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) > 50
  AND NOT EXISTS (
        SELECT 1
        FROM edificio e
        WHERE e.conserje_id = c.conserje_id
  )
ORDER BY edad DESC;

-- 11.3. Personas que son a la vez conserje y administrador (doble rol)
SELECT
    p.persona_id,
    p.apellido_nombre
FROM persona p
JOIN conserje c
  ON c.conserje_id = p.persona_id
JOIN administrador a
  ON a.administrador_id = p.persona_id;
GO


/* ============================================================
   12) PATRONES TÍPICOS DE EXAMEN (SUBCONSULTA + GROUP BY)
   ============================================================ */

-- 12.1. Edificios ubicados en localidades donde hay más de 1 edificio
SELECT
    e.provincia_id,
    e.localidad_id,
    e.edificio_id,
    e.nombre AS edificio
FROM edificio e
JOIN (
    SELECT provincia_id, localidad_id
    FROM edificio
    GROUP BY provincia_id, localidad_id
    HAVING COUNT(*) > 1
) AS x
  ON x.provincia_id = e.provincia_id
 AND x.localidad_id = e.localidad_id;

-- 12.2. Edificios en provincias que pertenecen al TOP 3 de población
SELECT
    e.nombre AS edificio,
    p.nombre AS provincia
FROM edificio e
JOIN provincia p
  ON p.provincia_id = e.provincia_id
WHERE p.provincia_id IN (
    SELECT TOP (3) provincia_id
    FROM provincia
    ORDER BY poblacion DESC
);
GO

USE base_consorcio_2025;
GO

/* =========================================================
   13) SUBCONSULTAS CON OPERADORES DE COMPARACIÓN (MONO-REGISTRO)
   ---------------------------------------------------------
   - La subconsulta devuelve UNA sola fila y UNA columna
   - Se usan: =, <, >, <=, >=, <> etc.
   ========================================================= */

-- 13.a) Provincia con MAYOR población
SELECT  p.provincia_id,
        p.nombre,
        p.poblacion,
        p.cantidad_departamentos
FROM    provincia p
WHERE   p.poblacion = (
            SELECT MAX(p2.poblacion)      -- un solo valor
            FROM   provincia p2
        );

-- 13.b) Gastos con importe MAYOR al importe promedio general
SELECT  g.gasto_id,
        g.provincia_id,
        g.localidad_id,
        g.edificio_id,
        g.tipo_gasto_id,
        g.importe
FROM    gasto g
WHERE   g.importe > (
            SELECT AVG(g2.importe)        -- un solo valor (promedio)
            FROM   gasto g2
        );


/* =========================================================
   14) SUBCONSULTAS CON OPERADORES DE CONJUNTOS (MULTI-REGISTRO)
   ------------------------------------------------------------
   - La subconsulta devuelve VARIAS filas (una sola columna)
   - Se usan: IN / NOT IN / ANY / ALL
   ========================================================= */

-- 14.a) Edificios que están en provincias con más de 20 departamentos
--      (la subconsulta devuelve un CONJUNTO de provincia_id)
SELECT  e.provincia_id,
        e.localidad_id,
        e.edificio_id,
        e.nombre      AS nombre_edificio
FROM    edificio e
WHERE   e.provincia_id IN (
            SELECT  p.provincia_id
            FROM    provincia p
            WHERE   p.cantidad_departamentos > 20
        );

-- 14.b) Gastos cuyo importe es mayor que ALGÚN gasto del tipo 'LUZ'
--      (ejemplo con ANY)
SELECT  g.gasto_id,
        g.tipo_gasto_id,
        g.importe
FROM    gasto g
WHERE   g.importe > ANY (
            SELECT  g2.importe
            FROM    gasto g2
            JOIN    tipo_gasto tg
                    ON tg.tipo_gasto_id = g2.tipo_gasto_id
            WHERE   tg.nombre = 'LUZ'
        );

-- 14.c) Gastos cuyo importe es mayor que TODOS los gastos del tipo 'AGUA'
--      (ejemplo con ALL)
SELECT  g.gasto_id,
        g.tipo_gasto_id,
        g.importe
FROM    gasto g
WHERE   g.importe > ALL (
            SELECT  g2.importe
            FROM    gasto g2
            JOIN    tipo_gasto tg
                    ON tg.tipo_gasto_id = g2.tipo_gasto_id
            WHERE   tg.nombre = 'AGUA'
        );


/* =========================================================
   15) SUBCONSULTAS CORRELACIONADAS CON EXISTS
   ------------------------------------------
   - La subconsulta depende de la fila actual de la consulta externa
   - Se re-evalúa por cada fila (usa alias de fuera adentro)
   - EXISTS devuelve TRUE/FALSE (prueba de existencia)
   ========================================================= */

-- 15.a) Provincias que tienen al menos un edificio
SELECT  p.provincia_id,
        p.nombre AS nombre_provincia
FROM    provincia p
WHERE   EXISTS (
            SELECT 1
            FROM   edificio e
            WHERE  e.provincia_id = p.provincia_id   -- correlación
        );

-- 15.b) Provincias que NO tienen edificios (NOT EXISTS)
SELECT  p.provincia_id,
        p.nombre AS nombre_provincia
FROM    provincia p
WHERE   NOT EXISTS (
            SELECT 1
            FROM   edificio e
            WHERE  e.provincia_id = p.provincia_id
        );

-- 15.c) Localidades donde EXISTE al menos un gasto asociado
SELECT  l.provincia_id,
        l.localidad_id,
        l.nombre AS nombre_localidad
FROM    localidad l
WHERE   EXISTS (
            SELECT 1
            FROM   gasto g
            WHERE  g.provincia_id = l.provincia_id
            AND    g.localidad_id = l.localidad_id
        );


/* =========================================================
   16) SUBCONSULTAS EN CLAUSULA FROM (TABLAS DERIVADAS)
   ---------------------------------------------------
   - La subconsulta se usa como "tabla temporal" en el FROM
   - Siempre necesita un alias
   ========================================================= */

-- 16.a) Total de gasto por edificio y filtramos los que superan cierto importe
--      La subconsulta en FROM arma la "tabla" de totales.
SELECT  e.provincia_id,
        e.localidad_id,
        e.edificio_id,
        e.nombre           AS nombre_edificio,
        t.total_gasto
FROM    (
            SELECT  provincia_id,
                    localidad_id,
                    edificio_id,
                    SUM(importe) AS total_gasto
            FROM    gasto
            GROUP BY provincia_id, localidad_id, edificio_id
        ) AS t                          -- tabla derivada
JOIN    edificio e
        ON  e.provincia_id = t.provincia_id
        AND e.localidad_id = t.localidad_id
        AND e.edificio_id  = t.edificio_id
WHERE   t.total_gasto > 100000;         -- ejemplo de filtro

-- 16.b) Promedio de gasto por tipo_gasto, y luego filtramos los más caros
SELECT  tg.nombre        AS tipo_gasto,
        stats.promedio_importe,
        stats.cantidad_registros
FROM    (
            SELECT  tipo_gasto_id,
                    AVG(importe) AS promedio_importe,
                    COUNT(*)     AS cantidad_registros
            FROM    gasto
            GROUP BY tipo_gasto_id
        ) AS stats                      -- tabla derivada
JOIN    tipo_gasto tg
        ON tg.tipo_gasto_id = stats.tipo_gasto_id
WHERE   stats.promedio_importe > 5000;

-- 16.c) (Más avanzado) Gasto de mayor importe por edificio usando ROW_NUMBER()
SELECT  *
FROM   (
          SELECT  g.gasto_id,
                  g.provincia_id,
                  g.localidad_id,
                  g.edificio_id,
                  g.importe,
                  ROW_NUMBER() OVER(
                      PARTITION BY g.provincia_id, g.localidad_id, g.edificio_id
                      ORDER BY g.importe DESC
                  ) AS rn
          FROM    gasto g
       ) AS x
WHERE  x.rn = 1;    -- el gasto de mayor importe por edificio


/* ============================================================
   FIN DEL MACHETE
   ============================================================ */
