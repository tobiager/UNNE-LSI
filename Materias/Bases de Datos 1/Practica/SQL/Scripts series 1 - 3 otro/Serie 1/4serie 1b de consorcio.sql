
--         Serie Nº 1 B – Sentencias SQL (DML)

GO
USE base_consorcio_2025;
GO

-- Ejercicio Nº 1: Listar todas las personas nacidas en meses pares.
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE MONTH(fecha_nacimiento) % 2 = 0;
GO

-- Ejercicio Nº 2: Mostrar los edificios cuya dirección comienza con un número.
SELECT edificio_id, nombre, direccion
FROM edificio
WHERE direccion LIKE '[0-9]%';
GO

-- Ejercicio Nº 3: Listar las personas que cumplen años en el mes actual.
SELECT *
FROM persona
WHERE MONTH(fecha_nacimiento) = MONTH(GETDATE());
GO

-- Ejercicio Nº 4: Listar personas con longitud de nombre entre 20 y 25 caracteres.
SELECT
    persona_id,
    apellido_nombre,
    telefono,
    LEN(apellido_nombre) AS longitud_nombre
FROM persona
WHERE LEN(apellido_nombre) BETWEEN 20 AND 25
ORDER BY longitud_nombre DESC;
GO

-- Ejercicio Nº 5: Crear una tabla auxiliar con los gastos mayores a $50.000.
-- Para evitar errores si se ejecuta más de una vez, primero eliminamos la tabla si ya existe.
IF OBJECT_ID('gastos_mayores', 'U') IS NOT NULL
    DROP TABLE gastos_mayores;
GO

SELECT *
INTO gastos_mayores
FROM gasto
WHERE importe > 50000;

-- Opcional: Muestra el contenido de la tabla recién creada.
SELECT * FROM gastos_mayores;
GO


-- Ejercicio Nº 6: Mostrar administradores con un mensaje condicional.
SELECT
    p.apellido_nombre,
    a.vive_ahi,
    CASE
        WHEN a.vive_ahi = 'S' THEN 'Residente'
        WHEN a.vive_ahi = 'N' THEN 'No residente'
        ELSE 'Sin dato'
    END AS condicion_residencia
FROM administrador a
JOIN persona p ON a.administrador_id = p.persona_id;
GO

-- Ejercicio Nº 7: Listar personas cuyo apellido contenga "LL" o "RR".
SELECT persona_id, apellido_nombre
FROM persona
WHERE apellido_nombre LIKE '%LL%' OR apellido_nombre LIKE '%RR%';
GO

-- Ejercicio Nº 8: Mostrar los gastos pagados un fin de semana (sábado o domingo).
-- Nota: La numeración del día de la semana puede variar. En SQL Server, por defecto, 1=Domingo y 7=Sábado.
SELECT *
FROM gasto
WHERE DATEPART(weekday, fecha_pago) IN (1, 7);
GO

-- Ejercicio Nº 9: Gastos del primer trimestre > 20.000 y no pagados en fin de semana.


SELECT
    gasto_id,
    fecha_pago,
    importe,
    DATENAME(weekday, fecha_pago) AS Dia_de_la_semana
FROM
    gasto
WHERE
    MONTH(fecha_pago) IN (1, 2, 3)
    AND importe > 20000
    AND DATEPART(weekday, fecha_pago) NOT IN (1, 7); -- Excluye Domingo (1) y Sábado (7)
GO

-- Ejercicio Nº 10: Mostrar las personas que este año cumplen 30 años exactos.
SELECT
    apellido_nombre,
    fecha_nacimiento,
    YEAR(GETDATE()) - YEAR(fecha_nacimiento) as edad_este_año
FROM persona
WHERE YEAR(GETDATE()) - YEAR(fecha_nacimiento) = 30;
GO



--         Serie Nº 1 B – Funciones de fila 



-- Ejercicio 11: Nombres y apellidos en minúscula
-- Lista los nombres y apellidos de las personas en minúscula y sin espacios extra.
SELECT
    persona_id,
    TRIM(LOWER(apellido_nombre)) AS nombre_minuscula,
    apellido_nombre
FROM
    persona;
GO

-- Ejercicio 12: Prefijo de nombre y dirección corta de edificios
-- Muestra las primeras cuatro letras del nombre y los primeros diez caracteres de la dirección de los edificios.
SELECT
    nombre,
    LEFT(nombre, 4) AS prefijo,
    LEFT(direccion, 10) AS direccion_corta
FROM
    edificio;
GO

-- Ejercicio 13: Teléfonos no estandarizados
-- Lista a las personas cuyo número de teléfono no comienza con el prefijo "37".
SELECT
    persona_id,
    apellido_nombre,
    telefono
FROM
    persona
WHERE
    LEFT(telefono, 2) <> '37';
GO

-- Ejercicio 14: Nombres de zona en formato "Título"
-- Muestra los nombres de las zonas con la primera letra en mayúscula y el resto en minúscula.
SELECT
    zona_id,
    nombre,
    UPPER(LEFT(nombre, 1)) + LOWER(SUBSTRING(nombre, 2, LEN(nombre))) AS nombre_formateado
FROM
    zona;
GO

-- Ejercicio 15: Importe de gastos con incremento
-- Lista los gastos mostrando el importe original y el importe con un incremento del 12.5%, redondeado a 2 decimales.
SELECT
    gasto_id,
    importe,
    ROUND(importe * 1.125, 2) AS importe_ajustado
FROM
    gasto;
GO

-- Ejercicio 16: Importes negativos a positivos
-- Transforma los importes negativos a valores positivos y los redondea a un decimal.
-- (Si es necesario, inserte primero un registro de prueba como sugiere el ejercicio).
-- INSERT INTO gasto (importe) VALUES (-150.78);
SELECT
    gasto_id,
    importe,
    ROUND(ABS(importe), 1) AS importe_absoluto
FROM
    gasto;
GO

-- Ejercicio 17: Año y mes de la fecha de pago
-- Muestra el año y el mes de la fecha de pago de los gastos.
SELECT
    gasto_id,
    YEAR(fecha_pago) AS anio_pago,
    MONTH(fecha_pago) AS mes_pago,
    importe
FROM
    gasto;
GO

-- Ejercicio 18: Edad actual de las personas
-- Calcula y muestra la edad actual de las personas a partir de su fecha de nacimiento.
SELECT
    persona_id,
    apellido_nombre,
    DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS edad
FROM
    persona;
GO

-- Ejercicio 19: Fecha de pago formateada
-- Muestra la fecha de pago de los gastos en formato DD/MM/YYYY.
SELECT
    gasto_id,
    fecha_pago,
    CONVERT(VARCHAR, fecha_pago, 103) AS fecha_pago_formateada,
    importe
FROM
    gasto;
GO

-- Ejercicio 20: Descripción de gastos formateada
-- Concatena el período y el importe para crear una descripción formateada del gasto.
SELECT
    gasto_id,
    'Período: ' + CAST(periodo AS VARCHAR) + ' - Importe: $' + CAST(importe AS VARCHAR) AS descripcion_gasto
FROM
    gasto;
GO

-- Ejercicio 21: Cantidad y suma de importes por tipo de gasto
-- Muestra el número de registros y la suma total de importes para cada tipo de gasto.
SELECT
    tipo_gasto_id,
    COUNT(*) AS cantidad,
    SUM(importe) AS total_importe
FROM
    gasto
GROUP BY
    tipo_gasto_id;
GO

-- Ejercicio 22: Estadísticas completas por tipo de gasto
-- Para cada tipo de gasto, muestra la cantidad, el importe mínimo, máximo, promedio y total.
SELECT
    tipo_gasto_id,
    COUNT(*) AS cantidad,
    MIN(importe) AS minimo,
    MAX(importe) AS maximo,
    AVG(importe) AS promedio,
    SUM(importe) AS total
FROM
    gasto
GROUP BY
    tipo_gasto_id;
GO

-- Ejercicio 23: Total y promedio de importes por período
-- Muestra el total y promedio de importes, agrupados por período.
SELECT
    periodo,
    SUM(importe) AS total_periodo,
    AVG(importe) AS promedio_periodo
FROM
    gasto
GROUP BY
    periodo;
GO

-- Ejercicio 24: Total y cantidad de gastos por período y tipo
-- Agrupa los gastos por período y tipo de gasto, mostrando el total y la cantidad.
SELECT
    periodo,
    tipo_gasto_id,
    COUNT(*) AS cantidad,
    SUM(importe) AS total
FROM
    gasto
GROUP BY
    periodo,
    tipo_gasto_id;
GO

-- Ejercicio 25: Períodos con gastos totales superiores a 5,000,000
-- Filtra los períodos cuyo total de gastos supera los 5,000,000.
SELECT
    periodo,
    SUM(importe) AS total_periodo
FROM
    gasto
GROUP BY
    periodo
HAVING
    SUM(importe) > 5000000;
GO

-- Ejercicio 26: Períodos con promedio de importes alto
-- Muestra los períodos cuyo promedio de importes es mayor a 25,000, considerando solo gastos mayores a 4,000.
SELECT
    periodo,
    AVG(importe) AS promedio_periodo
FROM
    gasto
WHERE
    importe > 4000
GROUP BY
    periodo
HAVING
    AVG(importe) > 25000;
GO

-- Ejercicio 27: Total de gastos por año de pago
-- Calcula y muestra el total de gastos agrupado por el año de la fecha de pago.
SELECT
    YEAR(fecha_pago) AS anio_pago,
    SUM(importe) AS total_anual
FROM
    gasto
GROUP BY
    YEAR(fecha_pago);
GO

-- Ejercicio 28: Total y promedio de gastos por año y mes
-- Agrupa los gastos por año y mes de la fecha de pago, mostrando el total y el promedio.
SELECT
    YEAR(fecha_pago) AS anio_pago,
    MONTH(fecha_pago) AS mes_pago,
    SUM(importe) AS total_mensual,
    AVG(importe) AS promedio_mensual
FROM
    gasto
GROUP BY
    YEAR(fecha_pago),
    MONTH(fecha_pago);
GO

-- Ejercicio 29: Años con gastos totales inferiores a 15,000,000
-- Muestra los años cuyo total de gastos no supera los 15,000,000.
SELECT
    YEAR(fecha_pago) AS anio_pago,
    SUM(importe) AS total_anual
FROM
    gasto
GROUP BY
    YEAR(fecha_pago)
HAVING
    SUM(importe) <= 15000000;
GO

-- Ejercicio 30: Promedio de gastos redondeado por tipo
-- Muestra el promedio de gastos por tipo_gasto_id, redondeado a un decimal.
SELECT
    tipo_gasto_id,
    ROUND(AVG(importe), 1) AS promedio_redondeado
FROM
    gasto
GROUP BY
    tipo_gasto_id;
GO

-- Ejercicio 31: Promedios mensuales de gasto con condiciones
-- Calcula los promedios mensuales de gasto considerando solo importes mayores a 5,000 y redondea el resultado a 2 decimales.
SELECT
    YEAR(fecha_pago) AS anio_pago,
    MONTH(fecha_pago) AS mes_pago,
    ROUND(AVG(importe), 2) AS promedio_mensual
FROM
    gasto
WHERE
    importe > 5000
GROUP BY
    YEAR(fecha_pago),
    MONTH(fecha_pago);
GO

-- Ejercicio 32: Estadísticas completas por período
-- Para cada período, muestra la cantidad de registros, el total, promedio, máximo y mínimo de los importes.
SELECT
    periodo,
    COUNT(*) AS cantidad,
    SUM(importe) AS total,
    AVG(importe) AS promedio,
    MAX(importe) AS maximo,
    MIN(importe) AS minimo
FROM
    gasto
GROUP BY
    periodo;
GO

-- Ejercicio 33: Tipos de gasto con condiciones de cantidad y promedio
-- Lista los tipo_gasto_id que tienen menos de 1600 registros y un promedio de importes mayor a 5000.
SELECT
    tipo_gasto_id,
    COUNT(*) AS cantidad,
    AVG(importe) AS promedio
FROM
    gasto
GROUP BY
    tipo_gasto_id
HAVING
    COUNT(*) < 1600 AND AVG(importe) > 5000;
GO

-- Ejercicio 34: Gastos agrupados por rango de importe
-- Agrupa los gastos en rangos (bajo, medio, alto) y muestra la cantidad y el promedio de cada grupo, ordenado por rango.
SELECT
    CASE
        WHEN importe < 3000 THEN 'Bajo'
        WHEN importe BETWEEN 3000 AND 10000 THEN 'Medio'
        ELSE 'Alto'
    END AS rango_importe,
    COUNT(*) AS cantidad,
    AVG(importe) AS promedio
FROM
    gasto
GROUP BY
    CASE
        WHEN importe < 3000 THEN 'Bajo'
        WHEN importe BETWEEN 3000 AND 10000 THEN 'Medio'
        ELSE 'Alto'
    END
ORDER BY
    rango_importe ASC;
GO

-- Ejercicio 35: Años de pago con promedio anual condicionado
-- Muestra los años cuyo promedio de importes (considerando solo importes > 4000) no supera 22,000, ordenados de mayor a menor.
SELECT
    YEAR(fecha_pago) AS anio_pago,
    AVG(importe) AS promedio_anual
FROM
    gasto
WHERE
    importe > 4000
GROUP BY
    YEAR(fecha_pago)
HAVING
    AVG(importe) <= 22000
ORDER BY
    promedio_anual DESC;
GO