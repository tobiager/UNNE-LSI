USE base_consorcio_2025;
GO

-- Hago determinístico el cálculo de día de semana (domingo=1 ... sábado=7)
SET DATEFIRST 7; 
GO

/* =========================================================
   SERIE 1B – Sentencias SQL (DML)  |  Modelo Consorcio 2025
   ========================================================= */

-- Ejercicio 1
-- Personas nacidas en meses pares (2, 4, 6, 8, 10, 12)
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE MONTH(fecha_nacimiento) % 2 = 0
ORDER BY apellido_nombre;

-- Ejercicio 2
-- Edificios cuya dirección comienza con un número
SELECT provincia_id, localidad_id, edificio_id, nombre, direccion
FROM edificio
WHERE direccion LIKE '[0-9]%'
ORDER BY provincia_id, localidad_id, edificio_id;

-- Ejercicio 3
-- Personas que cumplen años en el mes actual
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE MONTH(fecha_nacimiento) = MONTH(GETDATE());

-- Ejercicio 4
-- Personas con longitud de apellido_nombre entre 20 y 25, ordenado desc por longitud
SELECT persona_id,
       apellido_nombre,
       LEN(apellido_nombre) AS largo
FROM persona
WHERE LEN(apellido_nombre) BETWEEN 20 AND 25
ORDER BY largo DESC, apellido_nombre;

-- Ejercicio 5
-- Crear tabla auxiliar desde gasto con importes > 50.000
IF OBJECT_ID('dbo.gasto_mayor_50000', 'U') IS NOT NULL
    DROP TABLE dbo.gasto_mayor_50000;
SELECT *
INTO dbo.gasto_mayor_50000
FROM gasto
WHERE importe > 50000;

-- (Opcional) índice para acelerar consultas típicas por periodo y edificio
-- CREATE INDEX IX_gasto_mayor_50000_periodo ON dbo.gasto_mayor_50000(periodo);

-- Ejercicio 6
-- Administradores con columna calculada de residencia
SELECT a.administrador_id,
       p.apellido_nombre,
       a.vive_ahi,
       CASE 
         WHEN a.vive_ahi = 'S' THEN 'Residente'
         WHEN a.vive_ahi = 'N' THEN 'No residente'
         ELSE 'Sin dato'
       END AS condicion_residencia
FROM administrador a
LEFT JOIN persona p ON p.persona_id = a.administrador_id
ORDER BY p.apellido_nombre;

-- Ejercicio 7
-- Personas cuyo apellido contenga doble letra “LL” o “RR”
SELECT persona_id, apellido_nombre
FROM persona
WHERE apellido_nombre LIKE '%LL%' OR apellido_nombre LIKE '%RR%'
ORDER BY apellido_nombre;

-- Ejercicio 8
-- Gastos pagados un fin de semana (sábado o domingo)
-- (fecha_pago no nula, y DATEPART(WEEKDAY) IN (1=Dom,7=Sáb) con DATEFIRST 7)
SELECT g.*
FROM gasto g
WHERE g.fecha_pago IS NOT NULL
  AND DATEPART(WEEKDAY, g.fecha_pago) IN (1, 7)
ORDER BY g.fecha_pago DESC;

-- Ejercicio 9
-- Gastos del primer trimestre (ene–mar) con importe > 20.000
-- y que NO hayan sido pagados en fin de semana
-- periodo = AAAAMM ⇒ (periodo % 100) ∈ (1,2,3)
SELECT g.*
FROM gasto g
WHERE (g.periodo % 100) BETWEEN 1 AND 3
  AND g.importe > 20000
  AND (
        g.fecha_pago IS NULL
        OR DATEPART(WEEKDAY, g.fecha_pago) NOT IN (1, 7)
      )
ORDER BY g.periodo, g.importe DESC;

-- Ejercicio 10
-- Personas que este año cumplen 30 años exactos
-- (independiente de si ya cumplieron o no: el año de nacimiento define que cumplen 30 en este año)
SELECT persona_id, apellido_nombre, fecha_nacimiento
FROM persona
WHERE YEAR(fecha_nacimiento) = YEAR(GETDATE()) - 30
ORDER BY apellido_nombre;


