USE base_consorcio_2025;
GO

--------------------------------------------------------------------------------
-- Ejercicio 1: Importe total por tipo de gasto
--------------------------------------------------------------------------------
SELECT
    tg.nombre,
    SUM(g.importe) AS 'Importe Acumulado'
FROM
    gasto g
JOIN
    tipo_gasto tg ON g.tipo_gasto_id = tg.tipo_gasto_id
GROUP BY
    tg.nombre;
GO

-- Verificación Ejercicio 1
-- La suma total de esta consulta debe coincidir con la suma de la columna 'Importe Acumulado' de tu solución.
SELECT SUM(importe) AS 'Total General de Todos los Gastos' FROM gasto;
GO

--------------------------------------------------------------------------------
-- Ejercicio 2: Listar edificios con su provincia y localidad
--------------------------------------------------------------------------------
SELECT
    p.nombre AS 'Provincia',
    l.nombre AS 'Localidad',
    e.nombre AS 'Consorcio'
FROM
    edificio e
JOIN
    localidad l ON e.provincia_id = l.provincia_id AND e.localidad_id = l.localidad_id
JOIN
    provincia p ON l.provincia_id = p.provincia_id
ORDER BY
    p.nombre,
    l.nombre,
    e.nombre;
GO

-- Verificación Ejercicio 2
-- El número de filas devuelto debe ser 100, que es el total de edificios en la tabla.
SELECT COUNT(*) AS 'Conteo Total de Edificios' FROM edificio;
GO

--------------------------------------------------------------------------------
-- Ejercicio 3: Los diez edificios con mayor gasto total
--------------------------------------------------------------------------------
SELECT TOP 10
    e.nombre AS 'Edificio',
    p.nombre AS 'Provincia',
    SUM(g.importe) AS 'Total Gastos'
FROM
    gasto g
INNER JOIN
    edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
INNER JOIN
    provincia p ON e.provincia_id = p.provincia_id
GROUP BY
    e.nombre,
    p.nombre
ORDER BY
    'Total Gastos' DESC;
GO

-- Verificación Ejercicio 3
-- Revisa la lista completa de gastos por edificio para confirmar que los 10 primeros de tu solución son correctos.
SELECT e.nombre, SUM(g.importe) AS 'TotalGastos'
FROM gasto g
JOIN edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
GROUP BY e.nombre
ORDER BY TotalGastos DESC;
GO

--------------------------------------------------------------------------------
-- Ejercicio 4: Listar todas las provincias y sus edificios
--------------------------------------------------------------------------------
SELECT
    p.nombre AS 'Provincia',
    l.nombre AS 'Localidad',
    e.nombre AS 'Edificio'
FROM
    edificio e
JOIN
    localidad l ON e.provincia_id = l.provincia_id AND e.localidad_id = l.localidad_id
RIGHT JOIN
    provincia p ON l.provincia_id = p.provincia_id
ORDER BY
    p.nombre,
    l.nombre;
GO

-- Verificación Ejercicio 4
-- El resultado debe ser 101. Se compone de los 100 edificios + 1 provincia sin datos.
SELECT (SELECT COUNT(*) FROM edificio) + (SELECT COUNT(*) FROM provincia p WHERE p.provincia_id NOT IN (SELECT DISTINCT provincia_id FROM localidad));
GO

--------------------------------------------------------------------------------
-- Ejercicio 5: Nombres de conserjes y edificio asignado
--------------------------------------------------------------------------------
SELECT
    pe.apellido_nombre,
    ed.nombre AS 'Edificio'
FROM
    conserje c
JOIN
    persona pe ON c.conserje_id = pe.persona_id
LEFT JOIN
    edificio ed ON c.conserje_id = ed.conserje_id
ORDER BY
    pe.apellido_nombre;
GO

-- Verificación Ejercicio 5
-- El número de filas de la solución debe coincidir con este conteo total de conserjes.
SELECT COUNT(*) AS 'Total de Conserjes' FROM conserje;
GO

--------------------------------------------------------------------------------
-- Ejercicio 6: Insertar un nuevo edificio
--------------------------------------------------------------------------------
INSERT INTO edificio (provincia_id, localidad_id, edificio_id, nombre, direccion, zona_id, conserje_id, administrador_id)
VALUES (6, 1, 9999, 'EDIFICIO NUEVO', 'Calle Falsa 123', 1, NULL, NULL);
GO

-- Verificación Ejercicio 6
-- Busca el edificio recién insertado. Debe devolver 1 fila. ¡No olvides borrarlo si fue solo una prueba!
SELECT * FROM edificio WHERE edificio_id = 9999;
-- DELETE FROM edificio WHERE edificio_id = 9999;
GO

--------------------------------------------------------------------------------
-- Ejercicio 7: Edificios y estado del conserje
--------------------------------------------------------------------------------
SELECT
    e.nombre AS 'Edificio',
    COALESCE(p.apellido_nombre, 'Sin conserje asignado') AS 'Conserje'
FROM
    edificio e
LEFT JOIN
    persona p ON e.conserje_id = p.persona_id;
GO

-- Verificación Ejercicio 7
-- Este número debe coincidir con las filas que dicen "Sin conserje asignado" en tu solución.
SELECT COUNT(*) AS 'Edificios con conserje_id NULO' FROM edificio WHERE conserje_id IS NULL;
GO

--------------------------------------------------------------------------------
-- Ejercicio 8: Contar conserjes asignados entre 50 y 60 años
--------------------------------------------------------------------------------
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

-- Verificación Ejercicio 8
-- Lista a los conserjes que cumplen la condición. El conteo de esta lista debe ser 25.
SELECT p.apellido_nombre, p.fecha_nacimiento
FROM persona p
JOIN conserje c ON p.persona_id = c.conserje_id
JOIN edificio e ON c.conserje_id = e.conserje_id
WHERE GETDATE() >= DATEADD(YEAR, 50, p.fecha_nacimiento) AND GETDATE() < DATEADD(YEAR, 61, p.fecha_nacimiento);
GO

--------------------------------------------------------------------------------
-- Ejercicio 9: Promedio de edad de administradores asignados
--------------------------------------------------------------------------------
SELECT
    AVG(CAST(DATEDIFF(day, p.fecha_nacimiento, GETDATE()) / 365.25 AS INT)) AS 'Promedio de edad de los administradores'
FROM
    persona p
JOIN
    administrador a ON p.persona_id = a.administrador_id
JOIN
    edificio e ON a.administrador_id = e.administrador_id;
GO

-- Verificación Ejercicio 9
-- Lista la edad precisa de cada administrador asignado para que puedas verificar el promedio manualmente.
SELECT p.apellido_nombre, DATEDIFF(hour, p.fecha_nacimiento, GETDATE()) / 8766.0 AS 'Edad Precisa'
FROM persona p
JOIN administrador a ON p.persona_id = a.administrador_id
JOIN edificio e ON a.administrador_id = e.administrador_id;
GO

--------------------------------------------------------------------------------
-- Ejercicio 10: Edificios en provincias que contengan "San"
--------------------------------------------------------------------------------
SELECT
    e.nombre AS 'Edificio',
    p.nombre AS 'Provincia'
FROM
    edificio e
JOIN
    provincia p ON e.provincia_id = p.provincia_id
WHERE
    p.nombre LIKE '%San%';
GO

-- Verificación Ejercicio 10
-- El número de filas de la solución debe coincidir con este conteo.
SELECT COUNT(*) AS 'Total Edificios en Provincias con "San"'
FROM edificio
WHERE provincia_id IN (SELECT provincia_id FROM provincia WHERE nombre LIKE '%San%');
GO

--------------------------------------------------------------------------------
-- Ejercicio 11: Edificios en provincias con más de 3M de habitantes
--------------------------------------------------------------------------------
SELECT
    p.nombre AS 'Provincia',
    l.nombre AS 'Localidad',
    COUNT(e.edificio_id) AS 'Cantidad de Edificios'
FROM
    provincia p
JOIN
    localidad l ON p.provincia_id = l.provincia_id
JOIN
    edificio e ON l.provincia_id = e.provincia_id AND l.localidad_id = e.localidad_id
WHERE
    p.poblacion > 3000000
GROUP BY
    p.nombre,
    l.nombre
ORDER BY
    p.nombre,
    l.nombre;
GO

-- Verificación Ejercicio 11
-- La suma de la columna 'Cantidad de Edificios' de la solución debe dar este mismo número.
SELECT COUNT(*) AS 'Total Edificios en Provincias de +3M Habitantes'
FROM edificio
WHERE provincia_id IN (SELECT provincia_id FROM provincia WHERE poblacion > 3000000);
GO

--------------------------------------------------------------------------------
-- Ejercicio 12: Provincias con entre 1 y 4 edificios
--------------------------------------------------------------------------------
SELECT
    p.nombre AS 'Provincia',
    COUNT(e.edificio_id) AS 'Cantidad de Edificios'
FROM
    provincia p
JOIN
    edificio e ON p.provincia_id = e.provincia_id
GROUP BY
    p.nombre
HAVING
    COUNT(e.edificio_id) >= 1 AND COUNT(e.edificio_id) < 5;
GO

-- Verificación Ejercicio 12
-- Revisa el conteo de edificios de todas las provincias para confirmar manualmente cuáles tienen entre 1 y 4.
SELECT p.nombre AS 'Provincia', COUNT(e.edificio_id) AS 'Cantidad de Edificios'
FROM provincia p
LEFT JOIN edificio e ON p.provincia_id = e.provincia_id
GROUP BY p.nombre
ORDER BY 2;
GO

--------------------------------------------------------------------------------
-- Ejercicio 13: Contar todos los conserjes entre 50 y 60 años
--------------------------------------------------------------------------------
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

-- Verificación Ejercicio 13
-- Lista a todos los conserjes con su edad para verificar el conteo. El resultado debe ser 59.
SELECT p.apellido_nombre, p.fecha_nacimiento
FROM persona p
JOIN conserje c ON p.persona_id = c.conserje_id
WHERE GETDATE() >= DATEADD(YEAR, 50, p.fecha_nacimiento) AND GETDATE() < DATEADD(YEAR, 61, p.fecha_nacimiento);
GO

--------------------------------------------------------------------------------
-- Ejercicio 14: Listar edificios del NEA
--------------------------------------------------------------------------------
SELECT
    e.nombre AS 'Edificio',
    pr.nombre AS 'Provincia',
    l.nombre AS 'Localidad',
    p_conserje.apellido_nombre AS 'Conserje',
    p_admin.apellido_nombre AS 'Administrador'
FROM
    edificio e
JOIN
    provincia pr ON e.provincia_id = pr.provincia_id
JOIN
    localidad l ON e.provincia_id = l.provincia_id AND e.localidad_id = l.localidad_id
LEFT JOIN
    persona p_conserje ON e.conserje_id = p_conserje.persona_id
LEFT JOIN
    persona p_admin ON e.administrador_id = p_admin.persona_id
WHERE
    pr.nombre IN ('Chaco', 'Corrientes', 'Formosa', 'Misiones');
GO

-- Verificación Ejercicio 14
-- El número de filas de tu solución debe coincidir con este conteo.
SELECT COUNT(*) AS 'Total Edificios en el NEA'
FROM edificio e
JOIN provincia p ON e.provincia_id = p.provincia_id
WHERE p.nombre IN ('Chaco', 'Corrientes', 'Formosa', 'Misiones');
GO

--------------------------------------------------------------------------------
-- Ejercicio 15: Cantidad de edificios por zona en la Mesopotamia
--------------------------------------------------------------------------------
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

-- Verificación Ejercicio 15
-- La suma de 'Cantidad de Edificios' de tu solución debe ser igual a este conteo.
SELECT COUNT(*) AS 'Total Edificios en Mesopotamia'
FROM edificio e
JOIN provincia p ON e.provincia_id = p.provincia_id
WHERE p.nombre IN ('Misiones', 'Corrientes', 'Entre Rios');
GO

--------------------------------------------------------------------------------
-- Ejercicio 16: Edificios con gasto en limpieza > $30000 en 2015
--------------------------------------------------------------------------------
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

-- Verificación Ejercicio 16
-- Revisa la lista completa de gastos de limpieza en 2015 para ver cuáles superan los 30000.
SELECT e.nombre, SUM(g.importe) as 'TotalLimpieza2015'
FROM gasto g
JOIN tipo_gasto tg ON g.tipo_gasto_id = tg.tipo_gasto_id
JOIN edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
WHERE tg.nombre = 'Limpieza' AND YEAR(g.fecha_pago) = 2015
GROUP BY e.nombre
ORDER BY 2 DESC;
GO

--------------------------------------------------------------------------------
-- Ejercicio 17: Edificios en las dos zonas con más edificios
--------------------------------------------------------------------------------
SELECT
    p.nombre AS 'Provincia',
    l.nombre AS 'Localidad',
    e.nombre AS 'Edificio',
    z.nombre AS 'Zona',
    e.direccion
FROM
    edificio e
JOIN
    zona z ON e.zona_id = z.zona_id
JOIN
    provincia p ON e.provincia_id = p.provincia_id
JOIN
    localidad l ON e.provincia_id = l.provincia_id AND e.localidad_id = l.localidad_id
WHERE
    e.zona_id IN (SELECT TOP 2 zona_id FROM edificio GROUP BY zona_id ORDER BY COUNT(*) DESC);
GO

-- Verificación Ejercicio 17
-- Identifica las 2 zonas con más edificios. La suma de sus conteos debe coincidir con las filas de tu solución.
SELECT TOP 2 z.nombre, COUNT(*) AS 'Cantidad'
FROM edificio e JOIN zona z ON e.zona_id = z.zona_id
GROUP BY z.nombre
ORDER BY 2 DESC;
GO

--------------------------------------------------------------------------------
-- Ejercicio 18: Conserjes mayores de 50 años no asignados
--------------------------------------------------------------------------------
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

-- Verificación Ejercicio 18
-- Lista todos los conserjes no asignados junto a su edad precisa para verificar el filtro manualmente.
SELECT p.apellido_nombre, DATEDIFF(hour, p.fecha_nacimiento, GETDATE()) / 8766.0 AS 'Edad'
FROM persona p
JOIN conserje c ON p.persona_id = c.conserje_id
WHERE p.persona_id NOT IN (SELECT conserje_id FROM edificio WHERE conserje_id IS NOT NULL);
GO

--------------------------------------------------------------------------------
-- Ejercicio 19: Tipos de gasto no registrados en Buenos Aires en Feb/2015
--------------------------------------------------------------------------------
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

-- Verificación Ejercicio 19
-- Ejecuta esta consulta para ver qué tipos de gasto SÍ se registraron. Los que no estén en esta lista son la respuesta correcta.
SELECT DISTINCT tg.nombre
FROM gasto g
JOIN tipo_gasto tg ON g.tipo_gasto_id = tg.tipo_gasto_id
JOIN edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
JOIN provincia p ON e.provincia_id = p.provincia_id
WHERE p.nombre = 'Buenos Aires' AND YEAR(g.fecha_pago) = 2015 AND MONTH(g.fecha_pago) = 2;
GO

--------------------------------------------------------------------------------
-- Ejercicio 20: Provincias que no tienen localidades cargadas
--------------------------------------------------------------------------------
SELECT
    p.nombre
FROM
    provincia p
LEFT JOIN
    localidad l ON p.provincia_id = l.provincia_id
GROUP BY
    p.provincia_id, p.nombre
HAVING
    COUNT(l.localidad_id) = 0;
GO

-- Verificación Ejercicio 20
-- La diferencia entre el total de provincias y las provincias con localidades debe dar la respuesta.
SELECT (SELECT COUNT(*) FROM provincia) - (SELECT COUNT(DISTINCT provincia_id) FROM localidad) AS 'Provincias sin Localidades';
GO

--------------------------------------------------------------------------------
-- Ejercicio 21: Personas que no son administradores
--------------------------------------------------------------------------------
SELECT * FROM persona WHERE persona_id NOT IN (SELECT administrador_id FROM administrador);
GO

-- Verificación Ejercicio 21
-- El resultado de esta resta debe coincidir con el número de filas de tu solución.
SELECT (SELECT COUNT(*) FROM persona) - (SELECT COUNT(*) FROM administrador) AS 'Personas que no son Administradores';
GO

--------------------------------------------------------------------------------
-- Ejercicio 22: Personas que no son ni administradores ni conserjes
--------------------------------------------------------------------------------
SELECT * FROM persona WHERE persona_id NOT IN (SELECT administrador_id FROM administrador)
AND persona_id NOT IN (SELECT conserje_id FROM conserje);
GO

-- Verificación Ejercicio 22
-- El resultado de esta consulta debe coincidir con el número de filas de tu solución.
SELECT COUNT(*)
FROM persona
WHERE persona_id NOT IN (SELECT administrador_id FROM administrador UNION SELECT conserje_id FROM conserje);
GO

--------------------------------------------------------------------------------
-- Ejercicio 23: Edificios con personal de doble función en las 3 provincias más pobladas
--------------------------------------------------------------------------------
SELECT
    e.nombre AS 'Edificio',
    p.apellido_nombre AS 'Persona con doble función',
    pr.nombre AS 'Provincia'
FROM
    edificio e
JOIN
    persona p ON e.administrador_id = p.persona_id
JOIN
    provincia pr ON e.provincia_id = pr.provincia_id
WHERE
    e.administrador_id = e.conserje_id
    AND e.provincia_id IN (SELECT TOP 3 provincia_id FROM provincia ORDER BY poblacion DESC);
GO

-- Verificación Ejercicio 23
-- Si esta consulta da 0, tu solución principal siempre dará 0, confirmando que no hay datos que cumplan la condición.
SELECT COUNT(*) AS 'Total Personas con Doble Rol' FROM edificio WHERE administrador_id = conserje_id AND administrador_id IS NOT NULL;
GO