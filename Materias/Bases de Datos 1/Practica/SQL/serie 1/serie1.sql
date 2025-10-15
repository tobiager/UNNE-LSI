/* ================================================================
   Serie Nº 1 — Consultas 1..21 (Modelo Consorcio 2025)
   Base: base_consorcio_2025
   ================================================================ */
USE base_consorcio_2025;
GO

-- 1) Listar todo el contenido de persona
SELECT * 
FROM dbo.persona;

-- 2) apellido_nombre y fecha_nacimiento
SELECT apellido_nombre, fecha_nacimiento
FROM dbo.persona;

-- 3) Precedencias aritméticas (10 y 12)
SELECT 
  4 + 5 * 3 / 2 - 1      AS expr1,
  (4 + 5) * 3 / 2 - 1    AS expr2;

-- 4) Gasto de edificios + 20% en 3 formatos (ROUND)
--    Asumo columna importe en dbo.gasto; agrego por edificio.
SELECT 
  e.provincia_id, e.localidad_id, e.edificio_id, e.nombre,
  SUM(g.importe) * 1.20                                   AS [Sin formato],
  ROUND(SUM(g.importe) * 1.20, 1)                         AS [Redondeado a 1 digito],
  ROUND(SUM(g.importe) * 1.20, 1, 1)                      AS [Truncado a 1 digito]  -- 3er arg=1 trunca (T-SQL)
FROM dbo.edificio AS e
JOIN dbo.gasto    AS g
  ON g.provincia_id = e.provincia_id
 AND g.localidad_id = e.localidad_id
 AND g.edificio_id  = e.edificio_id
GROUP BY e.provincia_id, e.localidad_id, e.edificio_id, e.nombre;

-- 5) Provincias: nombre y poblacion
SELECT nombre, poblacion
FROM dbo.provincia;

-- 6) Códigos de provincia presentes en edificio (DISTINCT)
SELECT DISTINCT provincia_id
FROM dbo.edificio;

-- 7) Primeras 4 personas ordenadas por las 7 primeras letras del apellido_nombre
SELECT TOP (4) *
FROM dbo.persona
ORDER BY LEFT(apellido_nombre, 7);

-- 8) Igual que 7) pero incluyendo empatados (WITH TIES)
SELECT TOP (4) WITH TIES *
FROM dbo.persona
ORDER BY LEFT(apellido_nombre, 7);

-- 9) Primeras 4 personas por todo el apellido_nombre (WITH TIES)
SELECT TOP (4) WITH TIES *
FROM dbo.persona
ORDER BY apellido_nombre;

-- 10) Nombre y dirección de edificios de “Buenos Aires” (provincia_id = 2)
SELECT nombre, direccion
FROM dbo.edificio
WHERE provincia_id = 2;

-- 11) Edificios cuyo nombre comienza con 'EDIFICIO-3'
SELECT *
FROM dbo.edificio
WHERE nombre LIKE 'EDIFICIO-3%';

-- 12) Una sola columna “Datos personales” para mujeres (sexo = 'F')
SELECT 
  CONCAT(apellido_nombre, ' - ', ISNULL(telefono,''), ' - ',
         CONVERT(char(10), fecha_nacimiento, 23)) AS [Datos personales]
FROM dbo.persona
WHERE sexo = 'F';

-- 13) Gastos con importes entre 10 y 100
SELECT *
FROM dbo.gasto
WHERE importe BETWEEN 10.00 AND 100.00;

-- 14) Personas nacidas en la década del 60 (orden fecha descendente)
SELECT *
FROM dbo.persona
WHERE fecha_nacimiento >= '1960-01-01'
  AND fecha_nacimiento <  '1970-01-01'
ORDER BY fecha_nacimiento DESC;

-- 15) Localidades de provincias 1 (Capital Federal) y 2 (Buenos Aires),
--     ordenadas alfabéticamente dentro de cada provincia
SELECT provincia_id, nombre
FROM dbo.localidad
WHERE provincia_id IN (1, 2)
ORDER BY provincia_id, nombre;

-- 16) Edificios con 'N' en la posición 5 de la dirección
SELECT *
FROM dbo.edificio
WHERE SUBSTRING(direccion, 5, 1) = 'N';

-- 17) Los 237 gastos menos costosos
SELECT TOP (237) *
FROM dbo.gasto
ORDER BY importe ASC;

-- 18) Importes repetidos dentro de los 237 más baratos (sin CTE para evitar “;WITH”)
SELECT t.importe, COUNT(*) AS repeticiones
FROM (
  SELECT TOP (237) importe
  FROM dbo.gasto
  ORDER BY importe ASC
) AS t
GROUP BY t.importe
HAVING COUNT(*) > 1
ORDER BY t.importe;

-- 19) Incremento por tramos y ordenar por importe desc
--     (<10000 -> +15%; 10000–20000 -> +10%; >20000 -> +5%)
SELECT 
  g.*,
  CASE 
    WHEN importe < 10000 THEN importe * 1.15
    WHEN importe BETWEEN 10000 AND 20000 THEN importe * 1.10
    ELSE importe * 1.05
  END AS importe_con_incremento
FROM dbo.gasto AS g
ORDER BY importe DESC;

-- 20) En una sola fila: cantidad de casados (C) y solteros (S)
SELECT
  SUM(CASE WHEN estado_civil = 'C' THEN 1 ELSE 0 END) AS casados,
  SUM(CASE WHEN estado_civil = 'S' THEN 1 ELSE 0 END) AS solteros
FROM dbo.persona;

-- 21) Suma total de gastos, cantidad y promedio
SELECT
  SUM(importe) AS suma_total,
  COUNT(*)     AS cantidad_gastos,
  AVG(importe) AS promedio
FROM dbo.gasto;
