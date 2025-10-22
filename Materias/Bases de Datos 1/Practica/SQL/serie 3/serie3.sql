-- =====================================================================
-- SERIE Nº 3 - Soluciones (SQL Server)
-- Base: base_consorcio_2025
-- =====================================================================
SET NOCOUNT ON;
GO
USE base_consorcio_2025;
GO

/* ---------------------------------------------------------------------
   E1. Total de gastos por tipo de gasto
--------------------------------------------------------------------- */
SELECT * FROM tipo_gasto
SELECT  t.nombre,
        SUM(g.importe) AS [Importe Acumulado]
FROM gasto AS g
INNER JOIN tipo_gasto AS t
    ON t.tipo_gasto_id = g.tipo_gasto_id
GROUP BY t.nombre;

/* ---------------------------------------------------------------------
   E2. Edificio + Provincia + Localidad (ordenado)
--------------------------------------------------------------------- */
SELECT  p.nombre AS provincia,
        l.nombre AS localidad,
        e.nombre AS edificio
FROM edificio e
JOIN provincia p ON p.provincia_id = e.provincia_id
JOIN localidad l ON l.provincia_id = e.provincia_id
                AND l.localidad_id = e.localidad_id
ORDER BY p.nombre, l.nombre, e.nombre;
GO

/* ---------------------------------------------------------------------
   E3. TOP 10 edificios por monto total de gastos
--------------------------------------------------------------------- */
SELECT TOP (10)
       e.nombre      AS [Edificio],
       p.nombre      AS [Provincia],
       CAST(SUM(g.importe) AS DECIMAL(18,2)) AS [Total Gastos]
FROM gasto g
JOIN edificio e
  ON e.provincia_id = g.provincia_id
 AND e.localidad_id = g.localidad_id
 AND e.edificio_id  = g.edificio_id
JOIN provincia p
  ON p.provincia_id = e.provincia_id
GROUP BY
       e.edificio_id,   
       e.nombre,
       p.nombre
ORDER BY [Total Gastos] DESC;


/* ---------------------------------------------------------------------
   E4. Listar todas las provincias y, si tienen, sus localidades y edificios
--------------------------------------------------------------------- */
SELECT
    p.nombre AS Provincia,
    l.nombre AS Localidad,
    e.nombre AS Edificio
FROM provincia p
JOIN edificio  e
  ON e.provincia_id = p.provincia_id
JOIN localidad l
  ON l.provincia_id = e.provincia_id
 AND l.localidad_id = e.localidad_id

UNION ALL

-- Provincias sin edificios: una sola fila por provincia (localidad/edificio nulos)
SELECT
    p.nombre AS Provincia,
    CAST(NULL AS NVARCHAR(200)) AS Localidad,
    CAST(NULL AS NVARCHAR(200)) AS Edificio
FROM provincia p
WHERE NOT EXISTS (
    SELECT 1
    FROM edificio e
    WHERE e.provincia_id = p.provincia_id
)
ORDER BY Provincia, Localidad, Edificio;


/* ---------------------------------------------------------------------
   E5. Conserjes y, si corresponde, edificio asignado
--------------------------------------------------------------------- */
SELECT  per.apellido_nombre AS conserje,
        e.nombre            AS edificio
FROM conserje c
JOIN persona  per ON per.persona_id = c.conserje_id
LEFT JOIN edificio e ON e.conserje_id = c.conserje_id
ORDER BY conserje, edificio;
GO

/* ---------------------------------------------------------------------
   E6. Insertar edificio sin conserje ni administrador (con zona)
   - Seguro ante IDs: busca provincia/localidad/zona por nombre y calcula
     el siguiente edificio_id dentro de esa localidad.
   - Cambiá los NOMBRES si querés otro lugar.
--------------------------------------------------------------------- */

INSERT INTO edificio (provincia_id, localidad_id, edificio_id, nombre, direccion, zona_id, conserje_id, administrador_id)
VALUES (6, 1, 9999, 'EDIFICIO NUEVO', 'Calle Falsa 123', 1, NULL, NULL);
GO

-- Verificación Ejercicio 6
-- Busca el edificio recién insertado. Debe devolver 1 fila. ¡No olvides borrarlo si fue solo una prueba!
SELECT * FROM edificio WHERE edificio_id = 9999;
-- DELETE FROM edificio WHERE edificio_id = 9999;
GO

/* ---------------------------------------------------------------------
   E7. Edificios y leyenda si no tienen conserje
--------------------------------------------------------------------- */
SELECT  e.nombre AS edificio,
        ISNULL(per.apellido_nombre, N'Sin conserje asignado') AS conserje
FROM edificio e
LEFT JOIN conserje c      ON c.conserje_id   = e.conserje_id
LEFT JOIN persona  per    ON per.persona_id  = c.conserje_id
ORDER BY e.nombre;
GO

/* ---------------------------------------------------------------------
   E8. Cantidad de conserjes 50–60 años ASIGNADOS a algún edificio
--------------------------------------------------------------------- */

SELECT
    COUNT(*) AS 'Cantidad de conserjes entre 50 y 60 años'
FROM
    persona p
JOIN
    conserje c ON p.persona_id = c.conserje_id
JOIN
    edificio e ON c.conserje_id = e.conserje_id
WHERE
    GETDATE() >= DATEADD(YEAR, 50, p.fecha_nacimiento)
    AND GETDATE() < DATEADD(YEAR, 61, p.fecha_nacimiento);
GO


/* ---------------------------------------------------------------------
   E9. Promedio de edad de administradores ASIGNADOS a algún edificio
--------------------------------------------------------------------- */
SELECT
    AVG(CAST(DATEDIFF(day, p.fecha_nacimiento, GETDATE()) / 365.25 AS INT)) AS 'Promedio de edad de los administradores'
FROM
    persona p
JOIN
    administrador a ON p.persona_id = a.administrador_id
JOIN
    edificio e ON a.administrador_id = e.administrador_id;
GO


/* ---------------------------------------------------------------------
   E10. Edificios en provincias cuyo nombre contiene 'San'
--------------------------------------------------------------------- */
SELECT  p.nombre AS provincia,
        e.nombre AS edificio
FROM edificio e
JOIN provincia p ON p.provincia_id = e.provincia_id
WHERE p.nombre LIKE N'%San%'
ORDER BY p.nombre, e.nombre;
GO

/* ---------------------------------------------------------------------
   E11. Edificios por localidad en provincias con población > 3.000.000
--------------------------------------------------------------------- */
SELECT  p.nombre AS provincia,
        l.nombre AS localidad,
        COUNT(e.edificio_id) AS cantidad_edificios
FROM provincia p
JOIN localidad l ON l.provincia_id = p.provincia_id
LEFT JOIN edificio e
       ON e.provincia_id = l.provincia_id
      AND e.localidad_id = l.localidad_id
WHERE p.poblacion > 3000000
GROUP BY p.nombre, l.nombre
HAVING COUNT(e.edificio_id) > 0
ORDER BY p.nombre, l.nombre;
GO

/* ---------------------------------------------------------------------
   E12. Provincias con al menos 1 y menos de 5 edificios
--------------------------------------------------------------------- */
SELECT  p.nombre AS provincia,
        COUNT(*) AS cantidad_edificios
FROM edificio e
JOIN provincia p ON p.provincia_id = e.provincia_id
GROUP BY p.provincia_id, p.nombre
HAVING COUNT(*) BETWEEN 1 AND 4
ORDER BY cantidad_edificios DESC, p.nombre;
GO

/* ---------------------------------------------------------------------
   E13. Cantidad de conserjes 50–60 años (asignados o no)
--------------------------------------------------------------------- */

SELECT
    COUNT(*) AS 'Cantidad de conserjes entre 50 y 60 años'
FROM
    persona p
JOIN
    conserje c ON p.persona_id = c.conserje_id
WHERE
    GETDATE() >= DATEADD(YEAR, 50, p.fecha_nacimiento)
    AND GETDATE() < DATEADD(YEAR, 61, p.fecha_nacimiento);
GO


/* ---------------------------------------------------------------------
   E14. Edificios + provincia + localidad + conserje + administrador (solo NEA)
--------------------------------------------------------------------- */
SELECT  p.nombre  AS provincia,
        l.nombre  AS localidad,
        e.nombre  AS edificio,
        ISNULL(pc.apellido_nombre, N'—') AS conserje,
        ISNULL(pa.apellido_nombre, N'—') AS administrador
FROM edificio e
JOIN provincia p ON p.provincia_id = e.provincia_id
JOIN localidad l ON l.provincia_id = e.provincia_id
                AND l.localidad_id = e.localidad_id
LEFT JOIN conserje c   ON c.conserje_id = e.conserje_id
LEFT JOIN persona  pc  ON pc.persona_id = c.conserje_id
LEFT JOIN administrador a ON a.administrador_id = e.administrador_id
LEFT JOIN persona  pa  ON pa.persona_id = a.administrador_id
WHERE p.nombre IN (N'Chaco', N'Corrientes', N'Formosa', N'Misiones')
ORDER BY p.nombre, l.nombre, e.nombre;
GO

/* ---------------------------------------------------------------------
   E15. Cantidad de edificios por zona en la Mesopotamia (MIS, COR, ER)
--------------------------------------------------------------------- */
SELECT
    z.nombre AS 'Zona',
    COUNT(e.edificio_id) AS 'Cantidad de Edificios'
FROM
    edificio e
JOIN
    provincia p ON e.provincia_id = p.provincia_id
JOIN
    zona z ON e.zona_id = z.zona_id
WHERE
    p.nombre IN ('Misiones', 'Corrientes', 'Entre Rios')
GROUP BY
    z.nombre;
GO

/* ---------------------------------------------------------------------
   E16. Edificios con > $30.000 en LIMPIEZA en 2015
--------------------------------------------------------------------- */
SELECT
    e.nombre as 'Edificio',
    p.nombre as 'Provincia',
    l.nombre as 'Localidad',
    SUM(g.importe) AS 'Total Gastado en Limpieza 2015'
FROM
    gasto g
JOIN tipo_gasto tg ON g.tipo_gasto_id = tg.tipo_gasto_id
JOIN edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
JOIN provincia p ON e.provincia_id = p.provincia_id
JOIN localidad l ON e.provincia_id = l.provincia_id AND e.localidad_id = l.localidad_id
WHERE
    tg.nombre = 'Limpieza' AND YEAR(g.fecha_pago) = 2015
GROUP BY
    e.nombre, p.nombre, l.nombre
HAVING
    SUM(g.importe) > 30000;
GO

/* ---------------------------------------------------------------------
   E17. Edificios en las 2 zonas con mayor cantidad de edificios
--------------------------------------------------------------------- */
SELECT  e.nombre AS edificio,
        e.direccion,
        p.nombre AS provincia,
        l.nombre AS localidad,
        z.nombre AS zona
FROM edificio e
JOIN zona z      ON z.zona_id      = e.zona_id
JOIN provincia p ON p.provincia_id = e.provincia_id
JOIN localidad l ON l.provincia_id = e.provincia_id
                AND l.localidad_id = e.localidad_id
WHERE e.zona_id IN (
    SELECT TOP (2) e2.zona_id
    FROM edificio e2
    GROUP BY e2.zona_id
    ORDER BY COUNT(*) DESC
)
ORDER BY z.nombre, p.nombre, l.nombre, e.nombre;
GO

/* ---------------------------------------------------------------------
   E18. Conserjes > 50 años, NO asignados, en TOP 3 provincias por población
   Nota: se asume que persona tiene provincia_id/localidad_id de domicilio.
--------------------------------------------------------------------- */
SELECT
    p.apellido_nombre,
    p.estado_civil,
    DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) AS 'edad'
FROM
    persona p
JOIN
    conserje c ON p.persona_id = c.conserje_id
WHERE
    p.persona_id NOT IN (SELECT conserje_id FROM edificio WHERE conserje_id IS NOT NULL)
    AND GETDATE() >= DATEADD(YEAR, 51, p.fecha_nacimiento);
GO

/* ---------------------------------------------------------------------
   E19. Tipos de gasto NO registrados en Pcia. Buenos Aires (Feb/2015)
--------------------------------------------------------------------- */
SELECT
    tg.tipo_gasto_id,
    tg.nombre
FROM
    tipo_gasto tg
WHERE
    tg.tipo_gasto_id NOT IN (
        SELECT DISTINCT g.tipo_gasto_id
        FROM gasto g
        JOIN edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
        JOIN provincia p ON e.provincia_id = p.provincia_id
        WHERE p.nombre = 'Buenos Aires' AND YEAR(g.fecha_pago) = 2015 AND MONTH(g.fecha_pago) = 2
    );
GO

/* ---------------------------------------------------------------------
   E20. Provincias sin localidades cargadas
--------------------------------------------------------------------- */
SELECT p.nombre
FROM provincia p
WHERE NOT EXISTS (
    SELECT 1 FROM localidad l WHERE l.provincia_id = p.provincia_id
)
ORDER BY p.nombre;
GO

/* ---------------------------------------------------------------------
   E21. Personas que NO son administradores
--------------------------------------------------------------------- */
SELECT p.*
FROM persona p
WHERE NOT EXISTS (SELECT 1 FROM administrador a WHERE a.administrador_id = p.persona_id)
ORDER BY p.apellido_nombre;
GO

/* ---------------------------------------------------------------------
   E22. Personas que NO son ni administradores NI conserjes
--------------------------------------------------------------------- */
SELECT p.*
FROM persona p
WHERE NOT EXISTS (SELECT 1 FROM administrador a WHERE a.administrador_id = p.persona_id)
  AND NOT EXISTS (SELECT 1 FROM conserje     c WHERE c.conserje_id     = p.persona_id)
ORDER BY p.apellido_nombre;
GO

/* ---------------------------------------------------------------------
   E23. Edificios y personas que cumplen doble función (adm + cons)
        Solo en las 3 provincias con mayor población
--------------------------------------------------------------------- */
SELECT  pr.nombre  AS provincia,
        l.nombre   AS localidad,
        e.nombre   AS edificio,
        per.apellido_nombre AS persona
FROM edificio e
JOIN provincia pr ON pr.provincia_id = e.provincia_id
JOIN localidad l  ON l.provincia_id  = e.provincia_id
                 AND l.localidad_id  = e.localidad_id
JOIN administrador a ON a.administrador_id = e.administrador_id
JOIN conserje     c ON c.conserje_id     = e.conserje_id
JOIN persona per  ON per.persona_id      = a.administrador_id
WHERE e.administrador_id = e.conserje_id
  AND pr.provincia_id IN (
        SELECT TOP (3) provincia_id
        FROM provincia
        ORDER BY poblacion DESC
  )
ORDER BY pr.nombre, l.nombre, e.nombre, per.apellido_nombre;
GO
