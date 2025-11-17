/*
Alumno: Orban Tobias
*/

USE base_consorcio_2025;
GO

/*==============================================================
  1) Localidades cuyo TOTAL de gastos supera el PROMEDIO GENERAL
     de los importes totales por localidad.
     Resultado esperado: 32 registros.
==============================================================*/
SELECT * FROM localidad;
WITH totales_localidad AS (
    SELECT 
        provincia_id,
        localidad_id,
        SUM(importe) AS total_gastos
    FROM gasto
    GROUP BY provincia_id, localidad_id
)
SELECT 
    provincia_id,
    localidad_id,
    total_gastos
FROM totales_localidad
WHERE total_gastos > (
    SELECT AVG(total_gastos * 1.0)
    FROM totales_localidad
)
ORDER BY provincia_id, localidad_id;
-- Para verificar cantidad:
-- SELECT COUNT(*) FROM (
--   SELECT provincia_id, localidad_id, total_gastos
--   FROM totales_localidad
--   WHERE total_gastos > (SELECT AVG(total_gastos * 1.0) FROM totales_localidad)
-- ) x;


/*==============================================================
  2) Diferencia entre el PROMEDIO del total por tipo de gasto 
     y los valores extremos (MÁXIMO y MÍNIMO) de esos totales.
     Un solo registro de salida.
==============================================================*/
WITH totales_por_tipo AS (
    SELECT 
        tipo_gasto_id,
        SUM(importe) AS total_gasto
    FROM gasto
    GROUP BY tipo_gasto_id
),
agregados AS (
    SELECT
        AVG(total_gasto * 1.0) AS promedio_general,
        MAX(total_gasto)       AS maximo_general,
        MIN(total_gasto)       AS minimo_general
    FROM totales_por_tipo
)
SELECT
    promedio_general,
    maximo_general,
    minimo_general,
    maximo_general - promedio_general AS variacion_respecto_al_max,
    minimo_general - promedio_general AS variacion_respecto_al_min
FROM agregados;
-- Debería dar exactamente 1 fila.


/*==============================================================
  3) Nombre de cada edificio + importe y fecha de su ÚLTIMO gasto.
==============================================================*/
WITH gastos_ordenados AS (
    SELECT
        g.provincia_id,
        g.localidad_id,
        g.edificio_id,
        e.nombre      AS edificio,
        g.importe,
        g.fecha_pago,
        ROW_NUMBER() OVER (
            PARTITION BY g.provincia_id, g.localidad_id, g.edificio_id
            ORDER BY g.fecha_pago DESC, g.gasto_id DESC
        ) AS rn
    FROM gasto g
    JOIN edificio e
      ON e.provincia_id = g.provincia_id
     AND e.localidad_id = g.localidad_id
     AND e.edificio_id  = g.edificio_id
)
SELECT
    edificio,
    importe    AS ultimo_importe,
    fecha_pago AS ultima_fecha_pago
FROM gastos_ordenados
WHERE rn = 1
ORDER BY edificio;
