-- Serie 3. Resolucion.

USE base_consorcio_2025;
GO

-- Ejercicio 1: Importe total acumulado por tipo de gasto.
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

-- Ejercicio 2: Listar edificios con su provincia y localidad.
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

-- Ejercicio 3: Los diez edificios con mayor monto total de gastos.
SELECT TOP 10
    e.nombre AS 'Edificio',
    p.nombre AS 'Provincia',
    SUM(g.importe) AS 'Total Gastos'
FROM
    gasto g
JOIN
    edificio e ON g.provincia_id = e.provincia_id AND g.localidad_id = e.localidad_id AND g.edificio_id = e.edificio_id
JOIN
    provincia p ON e.provincia_id = p.provincia_id
GROUP BY
    e.nombre,
    p.nombre
ORDER BY
    'Total Gastos' DESC;
GO

-- Ejercicio 4: Listar todas las provincias y sus edificios si los tienen.
SELECT
    p.nombre AS 'Provincia',
    l.nombre AS 'Localidad',
    e.nombre AS 'Edificio'
FROM
    provincia p
LEFT JOIN
    localidad l ON p.provincia_id = l.provincia_id
LEFT JOIN
    edificio e ON l.provincia_id = e.provincia_id AND l.localidad_id = e.localidad_id
ORDER BY
    p.nombre,
    l.nombre;
GO


-- Ejercicio 4: Listar todas las provincias y sus edificios.
-- Se empieza uniendo los 100 edificios con sus localidades y provincias.
-- Luego, con RIGHT JOIN, se asegura que las provincias que no tuvieron coincidencias (porque no tienen edificios)
-- también se incluyan en el resultado final, logrando los 101 registros esperados.
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

-- Ejercicio 5: Nombres de conserjes y el edificio asignado (si aplica).
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

-- Ejercicio 6: Insertar un nuevo edificio sin conserje ni administrador.
-- NOTA: Se asume que la provincia 6, localidad 1 y zona 1 existen.
INSERT INTO edificio (provincia_id, localidad_id, edificio_id, nombre, direccion, zona_id, conserje_id, administrador_id)
VALUES (6, 1, 9999, 'EDIFICIO NUEVO', 'Calle Falsa 123', 1, NULL, NULL);
GO

-- Ejercicio 7: Mostrar todos los edificios, indicando si no tienen conserje.
SELECT
    e.nombre AS 'Edificio',
    COALESCE(p.apellido_nombre, 'Sin conserje asignado') AS 'Conserje'
FROM
    edificio e
LEFT JOIN
    persona p ON e.conserje_id = p.persona_id;
GO

-- Ejercicio 8: Contar conserjes asignados entre 50 y 60 años.
SELECT
    COUNT(*) AS 'Cantidad de conserjes entre 50 y 60 años'
FROM
    persona p
JOIN
    conserje c ON p.persona_id = c.conserje_id
JOIN
    edificio e ON c.conserje_id = e.conserje_id
WHERE
    DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) BETWEEN 50 AND 60;
GO




-- Ejercicio 9: Promedio de edad de los administradores asignados.
SELECT
    AVG(DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE())) AS 'Promedio de edad de los administradores'
FROM
    persona p
JOIN
    administrador a ON p.persona_id = a.administrador_id
JOIN
    edificio e ON a.administrador_id = e.administrador_id;
GO

-- Ejercicio 10: Edificios en provincias que contengan "San".
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

-- Ejercicio 11: Cantidad de edificios por localidad en provincias con más de 3M de habitantes.
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




-- Ejercicio 12: Provincias con al menos uno y menos de cinco edificios.
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


-- Ejercicio 13: Contar la cantidad de conserjes entre 50 y 60 años, 
-- sin importar si están asignados o no a un edificio. 

-- Contar TODOS los conserjes cuya fecha actual está entre su cumpleaños 50 y 61.
SELECT
    COUNT(*) AS 'Cantidad de conserjes entre 50 y 60 años'
FROM
    persona p
-- Se une con conserje para filtrar solo a las personas que tienen ese rol.
JOIN
    conserje c ON p.persona_id = c.conserje_id
WHERE
    -- Condición precisa: la fecha de hoy debe ser...
    -- 1. Mayor o igual a la fecha de su 50º cumpleaños.
    GETDATE() >= DATEADD(YEAR, 50, p.fecha_nacimiento)
    -- Y 2. Menor que la fecha de su 61º cumpleaños.
AND GETDATE() <  DATEADD(YEAR, 61, p.fecha_nacimiento);
GO

-- Ejercicio 14: Listar edificios del NEA con sus responsables.
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

-- Ejercicio 15: Cantidad de edificios por zona en la Mesopotamia.
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

-- Ejercicio 16: Edificios con gasto en limpieza > $30000 en 2015.
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

-- Ejercicio 17: Edificios en las dos zonas con más edificios.
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

-- Ejercicio 18: Conserjes mayores de 50 años no asignados en las provincias más pobladas.
-- NOTA: La condición de provincia no se puede aplicar directamente a una persona sin edificio.
-- Esta consulta busca conserjes no asignados que cumplen la condición de edad.
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
    AND DATEDIFF(YEAR, p.fecha_nacimiento, GETDATE()) > 50;
GO

-- Ejercicio 19: Tipos de gasto no registrados en Buenos Aires en Feb/2015.
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

-- Ejercicio 20: Provincias que no tienen localidades cargadas.
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

-- Ejercicio 21: Mostrar todas las personas que no son administradores.
SELECT
    *
FROM
    persona
WHERE
    persona_id NOT IN (SELECT administrador_id FROM administrador);
GO

-- Ejercicio 22: Mostrar todas las personas que no son ni administradores ni conserjes.
SELECT
    *
FROM
    persona
WHERE
    persona_id NOT IN (SELECT administrador_id FROM administrador)
    AND persona_id NOT IN (SELECT conserje_id FROM conserje);
GO

-- Ejercicio 23: Edificios con personal de doble función en las 3 provincias más pobladas.
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




