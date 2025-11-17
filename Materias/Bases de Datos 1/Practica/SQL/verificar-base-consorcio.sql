USE base_consorcio_2025; 
GO 
SELECT 'provincia' AS tabla, COUNT(*) AS cantidad_registros FROM provincia 
UNION ALL 
SELECT 'localidad' AS tabla, COUNT(*) AS cantidad_registros FROM localidad 
UNION ALL SELECT 'zona' AS tabla, COUNT(*) AS cantidad_registros FROM zona 
UNION ALL SELECT 'persona' AS tabla, COUNT(*) AS cantidad_registros FROM persona 
UNION ALL SELECT 'conserje' AS tabla, COUNT(*) AS cantidad_registros FROM conserje 
UNION ALL SELECT 'administrador' AS tabla, COUNT(*) AS cantidad_registros FROM administrador 
UNION ALL SELECT 'tipo_gasto' AS tabla, COUNT(*) AS cantidad_registros FROM tipo_gasto 
UNION ALL SELECT 'edificio' AS tabla, COUNT(*) AS cantidad_registros FROM edificio 
UNION ALL SELECT 'gasto' AS tabla, COUNT(*) AS cantidad_registros FROM gasto 
UNION ALL SELECT 'inmueble' AS tabla, COUNT(*) AS cantidad_registros FROM inmueble; 
GO