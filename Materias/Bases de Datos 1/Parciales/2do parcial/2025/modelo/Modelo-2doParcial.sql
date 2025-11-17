/* ============================================================
   Modelo 2do Parcial
   Orban Tobias
   ============================================================ */

/* Pregunta 1
La administración desea analizar los edificios más costosos en gastos anuales.
Se requiere determinar:
¿Cuántos edificios tuvieron un importe total de gastos en 2017 superior al 
promedio general de gastos por edificio en el mismo año.?

Ingresar el valor obtenido.
*/
-- Cantidad de edificios con gasto total 2017 > promedio de gastos por edificio en 2017
SELECT COUNT(*) AS cantidad_edificios
FROM (
    -- Totales de gasto por edificio en 2017
    SELECT 
        g.provincia_id,
        g.localidad_id,
        g.edificio_id,
        SUM(g.importe) AS total_2017
    FROM gasto g
    WHERE YEAR(g.fecha_pago) = 2017
    GROUP BY 
        g.provincia_id,
        g.localidad_id,
        g.edificio_id
) t
WHERE t.total_2017 >
(
    -- Promedio general de gasto por edificio en 2017
    SELECT AVG(total_x_edificio)
    FROM (
        SELECT 
            SUM(g2.importe) AS total_x_edificio
        FROM gasto g2
        WHERE YEAR(g2.fecha_pago) = 2017
        GROUP BY 
            g2.provincia_id,
            g2.localidad_id,
            g2.edificio_id
    ) x
);
GO

/* Pregunta 2
Se requiere conocer el listado de personas dados de alta como conserjes 
y que no están dados de alta como administradores. Para los conserjes asignados
a edificios, mostrar el nombre del edificio y la localidad. 

Salida: Apellido y Nombre | Jornada laboral | Edificio | Localidad
*/

--Opcion C
SELECT p.apellido_nombre AS 'Apellido y Nombre', c.jornada_laboral AS 'Jornada Laboral',
   e.nombre AS 'Edificio',l.nombre AS Localidad
   FROM conserje c
   INNER JOIN persona p ON c.conserje_id = p.persona_id
   LEFT JOIN edificio e ON c.conserje_id = e.conserje_id
   LEFT JOIN localidad l ON e.provincia_id = l.provincia_id
   AND e.localidad_id = l.localidad_id
   LEFT JOIN administrador a ON c.conserje_id = a.administrador_id
   WHERE a.administrador_id IS NULL;

-- Conserjes que no son Administradores
SELECT *
FROM conserje AS c
WHERE conserje_id NOT IN ( SELECT a.administrador_id
FROM administrador AS a
)
-- La opción correcta es la C porque usa LEFT JOIN administrador + IS NULL,
-- obteniendo conserjes que no son administradores. Las otras opciones
-- filtran mal: A compara contra edificio y B elige los que sí son administradores.


/* Pregunta 3
La administración necesita obtener un informe con los edificios que no registraron 
ningún gasto en el período 2 del año 2016 , junto con el nombre del administrador asignado (si existe). 
Se requiere que los edificios sin administrador también aparezcan en el listado, mostrando el texto 'Sin administrador'.
*/

-- Opcion D
 SELECT e.nombre AS edificio, COALESCE(p.apellido_nombre, 'Sin administrador') AS administrador
	FROM edificio e
	LEFT JOIN administrador a ON e.administrador_id = a.administrador_id
	LEFT JOIN persona p ON a.administrador_id = p.persona_id
	WHERE NOT EXISTS (
	   SELECT null
	   FROM gasto g
	   WHERE e.provincia_id = g.provincia_id AND e.localidad_id = g.localidad_id
	   AND e.edificio_id = g.edificio_id
	   AND (g.periodo = 2 AND YEAR(fecha_pago) = 2016)
   );

-- VALIDACIÓN: ¿Cuántos edificios NO registraron gastos en período 2 del año 2016?
SELECT COUNT(*) AS cantidad_edificios_sin_gastos
FROM edificio e
WHERE NOT EXISTS (
    SELECT 1
    FROM gasto g
    WHERE g.provincia_id = e.provincia_id
      AND g.localidad_id = e.localidad_id
      AND g.edificio_id = e.edificio_id
      AND g.periodo = 2
      AND YEAR(g.fecha_pago) = 2016
);

-- La Opción D porque:
-- Usa NOT EXISTS sobre gasto con la clave completa del edificio
-- (provincia_id, localidad_id, edificio_id) y el período 2 de 2016,
-- devolviendo solo edificios sin gastos en ese período/año.
-- Usa LEFT JOIN con administrador y COALESCE para mostrar 'Sin administrador'
-- cuando el edificio no tiene administrador asignado.
