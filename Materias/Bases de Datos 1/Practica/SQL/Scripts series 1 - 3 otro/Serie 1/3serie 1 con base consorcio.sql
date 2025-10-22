-- ============================================
-- SERIE Nº 1 – Sentencias SQL (DML)
-- Sentencias Básicas y Cláusulas WHERE / ORDER BY
-- ============================================


go
USE base_consorcio_2025;
go


-- Ejercicio 1: Listar todo el contenido de la tabla persona
SELECT * FROM persona;

-- Ejercicio 2: Mostrar apellido_nombre y fecha_nacimiento
SELECT apellido_nombre, fecha_nacimiento FROM persona;

-- Ejercicio 3: Precedencia de operadores aritméticos
SELECT 
    4 + 5 * 3 / 2 - 1 AS resultado1,       -- Esperado: 10
    (4 + 5) * 3 / 2 - 1 AS resultado2;     -- Esperado: 12

-- Ejercicio 4: Mostrar importe y aumento del 20% en 3 formatos
SELECT 
    importe AS [Sin formato],
    ROUND(importe * 1.2, 1) AS [Redondeado a 1 decimal],
    ROUND(importe * 1.2, 1, 1) AS [Truncado a 1 decimal]
FROM gasto;

-- Ejercicio 5: Listar nombre y población de cada provincia
SELECT nombre, poblacion FROM provincia;

-- Ejercicio 6: Listar códigos de provincia sin repetir
SELECT DISTINCT provincia_id FROM edificio;

-- Ejercicio 7: Listar 4 primeras personas ordenadas por las primeras 7 letras del nombre
SELECT TOP 4 * 
FROM persona 
ORDER BY LEFT(apellido_nombre, 7);

-- Ejercicio 8: Igual al anterior pero incluyendo repetidos (WITH TIES)
SELECT TOP 4 WITH TIES * 
FROM persona 
ORDER BY LEFT(apellido_nombre, 7);

-- Ejercicio 9: Ordenar por todo el campo apellido_nombre con WITH TIES
SELECT TOP 4 WITH TIES * 
FROM persona 
ORDER BY apellido_nombre;

-- Ejercicio 10: Mostrar nombre y dirección de edificios en provincia_id = 2 (Buenos Aires)
SELECT nombre, direccion 
FROM edificio 
WHERE provincia_id = 2;

-- Ejercicio 11: Mostrar edificios cuyo nombre comienza con 'EDIFICIO-3'
SELECT * 
FROM edificio 
WHERE nombre LIKE 'EDIFICIO-3%';

-- Ejercicio 12: Mostrar datos personales de mujeres en una sola columna
SELECT 
    apellido_nombre + ' - ' + telefono + ' - ' + CONVERT(VARCHAR, fecha_nacimiento, 103) AS [Datos personales]
FROM persona 
WHERE sexo = 'F';

-- Ejercicio 13: Mostrar gastos entre 10 y 100
SELECT * 
FROM gasto 
WHERE importe BETWEEN 10.00 AND 100.00;

-- Ejercicio 14: Personas nacidas en la década del 60, orden descendente
SELECT * 
FROM persona 
WHERE YEAR(fecha_nacimiento) BETWEEN 1960 AND 1969 
ORDER BY fecha_nacimiento DESC;

-- Ejercicio 15: Localidades de provincias 1 y 2, ordenadas alfabéticamente
SELECT * 
FROM localidad 
WHERE provincia_id IN (1, 2) 
ORDER BY provincia_id, nombre;

-- Ejercicio 16: Edificios con letra 'N' en la posición 5 de la dirección
SELECT * 
FROM edificio 
WHERE SUBSTRING(direccion, 5, 1) = 'N';

-- Ejercicio 17: Mostrar los 237 gastos menos costosos
SELECT TOP 237 * 
FROM gasto 
ORDER BY importe ASC;

-- Ejercicio 18: Mostrar gastos con importes repetidos
SELECT * 
FROM gasto 
WHERE importe IN (
    SELECT importe 
    FROM gasto 
    GROUP BY importe 
    HAVING COUNT(*) > 1
);

-- Ejercicio 19: Calcular incremento según rango de importe
SELECT 
    gasto_id,
    importe,
    CASE 
        WHEN importe < 10000 THEN importe * 1.15
        WHEN importe BETWEEN 10000 AND 20000 THEN importe * 1.10
        ELSE importe * 1.05
    END AS importe_incrementado
FROM gasto
ORDER BY importe DESC;

-- Ejercicio 20: Mostrar cantidad de casados y solteros
SELECT 
    SUM(CASE WHEN estado_civil = 'C' THEN 1 ELSE 0 END) AS Casados,
    SUM(CASE WHEN estado_civil = 'S' THEN 1 ELSE 0 END) AS Solteros
FROM persona;

-- Ejercicio 21: Suma total, cantidad y promedio de gastos
SELECT 
    SUM(importe) AS Total_Gastos,
    COUNT(*) AS Cantidad_Gastos,
    AVG(importe) AS Promedio_Gastos
FROM gasto;
