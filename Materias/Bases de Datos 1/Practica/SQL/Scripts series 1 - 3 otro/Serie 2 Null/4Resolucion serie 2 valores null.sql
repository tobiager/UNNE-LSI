
--         Serie Nº 2 – Tratamiento de valores NULL
--                 Soluciones en un único script

GO

-- Ejercicio 1: Comparación con =
/*
 PREGUNTA: ¿Qué resultados se obtienen con: SELECT * FROM persona WHERE telefono = NULL;?
 RESPUESTA: La consulta no devuelve NINGUNA fila. En SQL, NULL representa un valor
            desconocido y no puede ser comparado con el operador =.
            La forma correcta es usar IS NULL.
*/
GO

-- Ejercicio 2: Listar las personas cuyo número de teléfono no está informado.
SELECT persona_id, apellido_nombre, telefono
FROM persona 
WHERE telefono IS NULL;
GO

-- Ejercicio 3: Mostrar las personas que tienen un teléfono cargado.
SELECT persona_id, apellido_nombre, telefono
FROM persona 
WHERE telefono IS NOT NULL;
GO

-- Ejercicio 4: Reemplazar los valores nulos del nombre y teléfono por el texto “(Sin dato)”.
SELECT
    ISNULL(apellido_nombre, '(Sin dato)') AS nombre_corregido,
    ISNULL(telefono, '(Sin dato)') AS telefono_corregido
FROM persona;
GO

-- Ejercicio 5: Usar COALESCE para múltiples reemplazos.
SELECT
    nombre,
    capital,
    COALESCE(nombre, capital, 'Desconocido') AS nombre_final
FROM provincia;
GO

-- Ejercicio 6: Listar los gastos cuyo importe no está informado.
SELECT gasto_id, periodo, importe
FROM gasto 
WHERE importe IS NULL;
GO

-- Ejercicio 7: Calcular el 10 % de cada importe (el cálculo con NULL da como resultado NULL).
SELECT gasto_id, periodo, importe
    importe,
    importe * 0.10 AS diez_porciento
FROM gasto;
GO

-- Ejercicio 8: Repetir el cálculo del 10 % reemplazando los nulos del importe por cero.
SELECT
    importe,
    ISNULL(importe, 0) * 0.10 AS diez_porciento_corregido
FROM gasto;
GO

-- Ejercicio 9: Comparar el promedio de importes (AVG ignora NULLs vs. incluyendo NULLs como cero).
SELECT
    AVG(importe) AS promedio_sin_nulos,
    AVG(ISNULL(importe, 0)) AS promedio_con_ceros
FROM gasto;
GO

-- Ejercicio 10: Verificar la diferencia entre COUNT(*) y COUNT(columna).
SELECT
    COUNT(*) AS total_filas_gastos,
    COUNT(importe) AS importes_informados
FROM gasto;
GO

-- Ejercicio 11: Ordenar por teléfono observando la posición de los nulos.
-- En orden ascendente (ASC), los NULLs aparecen primero.
SELECT apellido_nombre, telefono 
FROM persona 
ORDER BY telefono ASC;

-- En orden descendente (DESC), los NULLs aparecen al final.
SELECT apellido_nombre, telefono 
FROM persona 
ORDER BY telefono DESC;
GO

-- Ejercicio 12: Mostrar la longitud de los teléfonos, considerando 0 para los nulos.
SELECT
    apellido_nombre,
    telefono,
    ISNULL(LEN(telefono), 0) AS longitud_telefono
FROM persona;
GO

-- Ejercicio 13: Listar las personas sin fecha de nacimiento registrada.
SELECT * 
FROM persona 
WHERE fecha_nacimiento IS NULL;
GO

-- Ejercicio 14: Calcular la edad, considerando 0 para fechas de nacimiento nulas.
SELECT
    persona_id,
    apellido_nombre,
    ISNULL(DATEDIFF(year, fecha_nacimiento, GETDATE()), 0) AS edad
FROM persona;
GO

-- Ejercicio 15: Listar personas sin teléfono O sin estado civil cargado.
SELECT persona_id, apellido_nombre, telefono, estado_civil
FROM persona 
WHERE telefono IS NULL OR estado_civil IS NULL;
GO

-- Ejercicio 16: Mostrar administradores con texto condicional para residencia (usando CASE).
SELECT
    p.apellido_nombre,
    CASE
        WHEN a.vive_ahi = 'S' THEN 'Vive en el edificio'
        WHEN a.vive_ahi = 'N' THEN 'No vive en el edificio'
        ELSE 'Dato desconocido'
    END AS condicion_residencia
FROM administrador a
JOIN persona p ON a.administrador_id = p.persona_id;
GO

-- Ejercicio 17: Mostrar gastos reemplazando fechas nulas por una fecha simbólica.
SELECT
    gasto_id,
    importe,
    ISNULL(fecha_pago, '1900-01-01') AS fecha_corregida
FROM gasto;
GO

-- Ejercicio 18: Listar localidades reemplazando nombres nulos.
SELECT
    provincia_id,
    localidad_id,
    ISNULL(nombre, 'Sin nombre asignado') AS nombre_localidad
FROM localidad;
GO

-- Ejercicio 19: Mostrar provincias donde 'nombre' o 'poblacion' sea nula.
SELECT provincia_id, nombre, poblacion
FROM provincia 
WHERE nombre IS NULL OR poblacion IS NULL;
GO

-- Ejercicio 20: Listar personas ordenando primero aquellas con teléfono y al final las que tienen valor nulo.
SELECT
    apellido_nombre,
    telefono
FROM persona
ORDER BY
    CASE WHEN telefono IS NULL THEN 1 ELSE 0 END ASC, -- Lógica para poner NULLs al final
    telefono ASC; -- Orden secundario para los que sí tienen teléfono
GO