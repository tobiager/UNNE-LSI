-- ============================================================
-- EJERCICIO 24 - PERSONAS QUE SON A LA VEZ CONSERJE Y ADMINISTRADOR
-- ============================================================
-- Mostrar los nombres de los edificios, a qué provincia pertenecen,
-- y los nombres de las personas que están asignadas como 
-- conserje y administrador (cumplen doble función).
--
-- Salida esperada:
-- apellido_nombre | Conserje en edificio | Provincia | Administrador en edificio | Provincia
-- ============================================================

USE base_consorcio_2025;
GO

/*-------------------------------------------------------------
  Paso 1: Verificar CUÁNTOS REGISTROS va a devolver el SELECT
  (mismas tablas y joins que la consulta final, pero con COUNT(*))

  Esta consulta debe devolver 100 (la cantidad de filas del resultado).
-------------------------------------------------------------*/
SELECT 
    COUNT(*) AS cantidad_registros_esperados
FROM persona p
JOIN conserje c 
    ON p.persona_id = c.conserje_id
JOIN administrador a 
    ON p.persona_id = a.administrador_id
-- Edificios donde figura como conserje
JOIN edificio e1 
    ON e1.conserje_id = c.conserje_id
JOIN provincia pr1 
    ON pr1.provincia_id = e1.provincia_id
-- Edificios donde figura como administrador
JOIN edificio e2 
    ON e2.administrador_id = a.administrador_id
JOIN provincia pr2 
    ON pr2.provincia_id = e2.provincia_id;
GO

/*-------------------------------------------------------------
  Paso 2: Consulta final con el detalle de cada registro
-------------------------------------------------------------*/
SELECT 
    p.apellido_nombre AS apellido_nombre,
    e1.nombre        AS [Conserje en edificio],
    pr1.nombre       AS [Provincia (Conserje)],
    e2.nombre        AS [Administrador en edificio],
    pr2.nombre       AS [Provincia (Administrador)]
FROM persona p
JOIN conserje c 
    ON p.persona_id = c.conserje_id
JOIN administrador a 
    ON p.persona_id = a.administrador_id
-- Edificios donde figura como conserje
JOIN edificio e1 
    ON e1.conserje_id = c.conserje_id
JOIN provincia pr1 
    ON pr1.provincia_id = e1.provincia_id
-- Edificios donde figura como administrador
JOIN edificio e2 
    ON e2.administrador_id = a.administrador_id
JOIN provincia pr2 
    ON pr2.provincia_id = e2.provincia_id
ORDER BY 
    p.apellido_nombre;
GO
