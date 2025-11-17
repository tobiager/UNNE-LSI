

-- 1) Mostrar los edificios cuya cantidad de inmuebles con frente sea superior al promedio general de cantidad de inmuebles con frente por edificio.

--a.
SELECT e.nombre AS edificio, COUNT(i.inmueble_id) AS cantidad_frente FROM edificio e INNER JOIN inmueble i ON e.provincia_id = i.provincia_id AND e.localidad_id = i.localidad_id AND e.edificio_id = i.edificio_id WHERE i.frente = 1 GROUP BY e.provincia_id, e.localidad_id, e.edificio_id, e.nombre HAVING COUNT(i.inmueble_id) > ( SELECT AVG(cant) FROM ( SELECT COUNT(i2.inmueble_id) AS cant FROM inmueble i2 WHERE i2.frente = 1 GROUP BY i2.provincia_id, i2.localidad_id, i2.edificio_id ) AS temp ) ORDER BY cantidad_frente DESC;


--Verificación
SELECT COUNT(DISTINCT e.edificio_id) AS Cantidad_Edificios_Inmuebles
FROM edificio e 
INNER JOIN inmueble i ON e.provincia_id = i.provincia_id AND e.localidad_id = i.localidad_id AND e.edificio_id = i.edificio_id 
WHERE  i.frente = 1 
GROUP BY e.provincia_id, e.localidad_id, e.edificio_id
HAVING COUNT(i.inmueble_id) > (SELECT AVG(cant) 
                               FROM (SELECT COUNT(i2.inmueble_id) AS cant 
                                     FROM inmueble i2 
                                     WHERE i2.frente = 1 
                                     GROUP BY i2.provincia_id, i2.localidad_id, i2.edificio_id) AS temp)
--Con esto podemos verificar que existen 29 edificios cuya cantidad de inmuebles con frente sea superior al promedio general.



--2) Mostrar los edificios que tienen al menos un inmueble en un piso superior al cuarto y con frente.
--a.
SELECT e.nombre AS edificio FROM edificio e WHERE EXISTS ( SELECT null FROM inmueble i WHERE i.provincia_id = e.provincia_id AND i.localidad_id = e.localidad_id AND i.edificio_id = e.edificio_id AND i.nro_piso > 4 AND i.frente = 1 );

--Verificación
SELECT COUNT(e.edificio_id) AS Cantidad_Edificios_Con_Inmueble_Alto_Frente
FROM  edificio e 
WHERE EXISTS (SELECT 1 
              FROM inmueble i 
              WHERE i.provincia_id = e.provincia_id AND i.localidad_id = e.localidad_id AND i.edificio_id = e.edificio_id AND i.nro_piso > 4 AND i.frente = 1 )
--Con esto podemos verificar que existen 24 edificios que tienen al menos un inmueble en un piso superior al cuarto y con frente.

--3 Mostrar los datos de los inmuebles, el nombre del edificio, localidad, provincia y la zona a la que pertenecen. Exceptos los que están en las 2 zonas con mayor cantidad de inmuebles.
SELECT i.*, 
e.nombre AS Edificio,
l.nombre AS Localidad,
pr.nombre AS Provincia,
z.nombre AS Zona
FROM inmueble AS i
INNER JOIN edificio AS e ON i.provincia_id = e.provincia_id AND i.localidad_id = e.localidad_id AND i.edificio_id = e.edificio_id
INNER JOIN localidad AS l ON i.provincia_id = l.provincia_id AND i.localidad_id = l.localidad_id
INNER JOIN provincia AS pr ON i.provincia_id = pr.provincia_id
INNER JOIN zona AS z ON e.zona_id = z.zona_id 
WHERE  e.zona_id NOT IN (SELECT TOP 2 e2.zona_id
                         FROM inmueble AS i2
                         INNER JOIN edificio AS e2 ON i2.provincia_id = e2.provincia_id AND i2.localidad_id = e2.localidad_id AND i2.edificio_id = e2.edificio_id
                         GROUP BY e2.zona_id
                         ORDER BY COUNT(i2.inmueble_id) DESC )
ORDER BY pr.nombre, l.nombre, e.nombre, i.nro_piso

--4 Desarrolle un script que  resuelva la siguiente situación e indique la cantidad de registros devueltos: Se requiere acceder a un informe que muestre la cantidad de Inmuebles por piso y edificio de las 3 provincias mas poblada
SELECT
pr.nombre AS Provincia,
e.nombre AS Edificio,
i.nro_piso AS Piso,
COUNT(i.inmueble_id) AS Cantidad_Inmuebles
FROM inmueble AS i
INNER JOIN edificio AS e ON i.provincia_id = e.provincia_id AND i.localidad_id = e.localidad_id AND i.edificio_id = e.edificio_id
INNER JOIN provincia AS pr ON i.provincia_id = pr.provincia_id
WHERE i.provincia_id IN (SELECT TOP 3 provincia_id  
                         FROM provincia
                         ORDER BY poblacion DESC)
GROUP BY pr.nombre, e.nombre, i.nro_piso
ORDER BY pr.nombre, e.nombre, i.nro_piso

--5 Se solicita un informe que muestre el total de superficie cubierta de la zona 1. (Ingresar solo el valor de la parte ENTERA NUMÉRICA sin puntos  y sin redondear)
SELECT SUM(i.sup_cubierta) AS Total_Superficie_Zona_1
FROM inmueble AS i
INNER JOIN edificio AS e ON i.provincia_id = e.provincia_id AND i.localidad_id = e.localidad_id AND i.edificio_id = e.edificio_id 
WHERE e.zona_id = 1

