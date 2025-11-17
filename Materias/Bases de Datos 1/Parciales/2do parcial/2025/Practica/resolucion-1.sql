/*=====================================================
2do Parcial Practico	
=======================================================*/

-- Pregunta 1
--Mostrar los edificios cuya cantidad de inmuebles con balcón sea inferior 
--al promedio general de cantidad de inmuebles con balcón por edificio.

--OPCION C
SELECT e.nombre AS edificio, COUNT(i.inmueble_id) AS cantidad_balcon 
FROM edificio e 
INNER JOIN inmueble i 
	ON e.provincia_id = i.provincia_id 
	AND e.localidad_id = i.localidad_id 
	AND e.edificio_id = i.edificio_id
WHERE i.balcon = 1 
GROUP BY e.provincia_id, e.localidad_id, e.edificio_id, e.nombre 
HAVING COUNT(i.inmueble_id) < 
( 
	SELECT AVG(cant) 
	FROM ( 
		SELECT COUNT(i2.inmueble_id) AS cant 
		FROM inmueble i2 
		WHERE i2.balcon = 1 
		GROUP BY i2.provincia_id, i2.localidad_id, i2.edificio_id 
		) AS temp 
) 
ORDER BY cantidad_balcon DESC;


--PREGUNTA 2
--Opcion B
SELECT e.nombre AS edificio
FROM edificio e
WHERE EXISTS (
    SELECT null
    FROM inmueble i
    WHERE i.provincia_id = e.provincia_id
      AND i.localidad_id = e.localidad_id
      AND i.edificio_id = e.edificio_id
      AND i.sup_cubierta IS NULL 
	  AND (i.nro_piso IN(2,3))
);

--Pregunta 3 
--Mostrar los datos de los inmuebles, el nombre del edificio, localidad, provincia 
--y la zona a la que pertenecen. Excepto los que están en las 4 zonas con menor cantidad de inmuebles.

WITH inmuebles_por_zona AS (
    SELECT 
        e.zona_id,
        COUNT(*) AS cant_inmuebles
    FROM edificio e
    JOIN inmueble i
        ON i.provincia_id = e.provincia_id
       AND i.localidad_id = e.localidad_id
       AND i.edificio_id  = e.edificio_id
    GROUP BY e.zona_id
),
zonas_con_menos_inmuebles AS (
    SELECT TOP 4 zona_id
    FROM inmuebles_por_zona
    ORDER BY cant_inmuebles ASC
)
SELECT
    p.nombre  AS provincia,
    l.nombre  AS localidad,
    e.nombre  AS edificio,
    e.zona_id AS zona,
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
WHERE e.zona_id NOT IN (
    SELECT zona_id
    FROM zonas_con_menos_inmuebles
);

-- Cantidad de inmuebles por zona (todas las zonas)
SELECT 
    e.zona_id,
    COUNT(*) AS cant_inmuebles
FROM edificio e
JOIN inmueble i
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
GROUP BY e.zona_id
ORDER BY cant_inmuebles DESC;   -- de mayor a menor
GO

--Pregunta 4
--ver cuántos inmuebles tiene cada edificio de la provincia menos poblada
WITH provincia_menos_poblada AS (
    SELECT TOP 1 provincia_id
    FROM provincia
    ORDER BY poblacion ASC   -- menor población primero
),
inmuebles_prov_min AS (
    SELECT 
        e.provincia_id,
        e.localidad_id,
        e.edificio_id,
        e.nombre AS nombre_edificio,
        i.nro_piso,
        COUNT(*) AS cant_inmuebles
    FROM edificio e
    JOIN inmueble i
        ON i.provincia_id = e.provincia_id
       AND i.localidad_id = e.localidad_id
       AND i.edificio_id  = e.edificio_id
    WHERE e.provincia_id = (SELECT provincia_id FROM provincia_menos_poblada)
    GROUP BY 
        e.provincia_id,
        e.localidad_id,
        e.edificio_id,
        e.nombre,
        i.nro_piso
)

SELECT *
FROM inmuebles_prov_min
ORDER BY cant_inmuebles DESC, edificio_id, nro_piso;
GO

--Pregunta 5
--Se solicita un informe para conocer el total de superficie cubierta de las zonas 4, 5 y 6.
--(Ingresar solo la parte ENTERA numérica, sin puntos y sin redondear)

SELECT 
    CAST(FLOOR(SUM(i.sup_cubierta)) AS BIGINT) AS total_sup_cubierta_zonas_4_5_6
FROM inmueble i
JOIN edificio e
    ON i.provincia_id = e.provincia_id
   AND i.localidad_id = e.localidad_id
   AND i.edificio_id  = e.edificio_id
WHERE e.zona_id IN (4, 5, 6);
GO