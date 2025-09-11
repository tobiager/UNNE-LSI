/* ==========================================================
   CARGA DE DATOS DE PRUEBA — MODELO “Ventas” (tp3_7)
   Requiere: tablas ventas.* + triggers + vista ya creados
   ========================================================== */
USE tp3_7;
SET NOCOUNT ON;

/* 1) Semillas maestras (sin dependencias) */
INSERT INTO ventas.Rubro (descripcion) VALUES
 ('Perfumería'),
 ('Lácteos'),
 ('Cotillón'),
 ('Juguetería'),
 ('Gaseosas'),
 ('Remedios');

INSERT INTO ventas.Proveedor (nombre, telefono, direccion) VALUES
 ('Distribuidora Norte',  '3794-111111', 'Av. 3 de Abril 1200'),
 ('Mayorista Centro',     '3794-222222', 'Junín 450'),
 ('Proveeduría Corr',     '3794-333333', 'San Martín 999'),
 ('Logística Litoral',    '3794-444444', 'Av. Armenia 200'),
 ('Farmacorp',            '3794-555555', 'Belgrano 77'),
 ('Bebidas del NEA',      '3794-666666', 'Ruta 12 km 8');

INSERT INTO ventas.MetodoPago (descripcion) VALUES
 ('Efectivo'),
 ('Débito'),
 ('Crédito'),
 ('Transferencia'),
 ('Mercado Pago');

INSERT INTO ventas.Sucursal (nombre, ciudad) VALUES
 ('Sucursal Centro', 'Corrientes'),
 ('Sucursal Norte',  'Resistencia'),
 ('Sucursal Sur',    'Corrientes');

/* 2) Vendedores (asignados a sucursal) */
INSERT INTO ventas.Vendedor (nombre, id_sucursal) VALUES
 ('Juan Pérez',        1),
 ('Sofía Ramírez',     1),
 ('Lucas González',    2),
 ('Carla Benítez',     2),
 ('Marta Fernández',   3),
 ('Diego Ledesma',     3);

/* 3) Artículos (stock + precio + rubro + proveedor) */
INSERT INTO ventas.Articulo (codigo_articulo, nombre, stock, precio_unitario, id_rubro, id_proveedor) VALUES
 ('P100', 'Shampoo 500ml',          40,  3200, 1, 1),
 ('P101', 'Colonia 100ml',          25,  5600, 1, 1),
 ('L200', 'Leche Entera 1L',        80,  1500, 2, 2),
 ('L201', 'Yogur Frutilla 200g',    90,   900, 2, 2),
 ('C300', 'Velas Cumpleaños x12',   50,  1200, 3, 3),
 ('C301', 'Piñata Mediana',         20,  7500, 3, 3),
 ('J400', 'Auto a Fricción',        35, 12500, 4, 4),
 ('J401', 'Rompecabezas 500p',      30,  9800, 4, 4),
 ('G500', 'Gaseosa Cola 2.25L',     70,  3800, 5, 6),
 ('G501', 'Agua Mineral 2L',        60,  2200, 5, 6),
 ('R600', 'Paracetamol 500mg x10',  55,  2100, 6, 5),
 ('R601', 'Ibuprofeno 400mg x10',   50,  2600, 6, 5);

/* 4) Tickets + Líneas (usa variables para capturar ids) */

/* --- Ticket 1: sucursal 1 / vendedor 1 / efectivo --- */
INSERT INTO ventas.Ticket (id_vendedor, id_metodo, id_sucursal)
VALUES (1, 1, 1);
DECLARE @t1 INT = SCOPE_IDENTITY();

INSERT INTO ventas.LineaTicket (id_ticket, codigo_articulo, cantidad, precio_unitario) VALUES
 (@t1, 'L200',  3, 1500),   -- 3 leches
 (@t1, 'G500',  2, 3800),   -- 2 gaseosas
 (@t1, 'P100',  1, 3200);   -- 1 shampoo

/* --- Ticket 2: sucursal 2 / vendedora 4 / tarjeta crédito --- */
INSERT INTO ventas.Ticket (id_vendedor, id_metodo, id_sucursal)
VALUES (4, 3, 2);
DECLARE @t2 INT = SCOPE_IDENTITY();

INSERT INTO ventas.LineaTicket (id_ticket, codigo_articulo, cantidad, precio_unitario) VALUES
 (@t2, 'J400',  1, 12500),
 (@t2, 'J401',  2,  9800),
 (@t2, 'G501',  4,  2200);

/* --- Ticket 3: sucursal 3 / vendedora 5 / débito --- */
INSERT INTO ventas.Ticket (id_vendedor, id_metodo, id_sucursal)
VALUES (5, 2, 3);
DECLARE @t3 INT = SCOPE_IDENTITY();

INSERT INTO ventas.LineaTicket (id_ticket, codigo_articulo, cantidad, precio_unitario) VALUES
 (@t3, 'R600',  2, 2100),
 (@t3, 'R601',  1, 2600),
 (@t3, 'G500',  1, 3800);

/* --- Ticket 4: sucursal 1 / vendedora 2 / Mercado Pago --- */
INSERT INTO ventas.Ticket (id_vendedor, id_metodo, id_sucursal)
VALUES (2, 5, 1);
DECLARE @t4 INT = SCOPE_IDENTITY();

INSERT INTO ventas.LineaTicket (id_ticket, codigo_articulo, cantidad, precio_unitario) VALUES
 (@t4, 'C300',  5, 1200),
 (@t4, 'C301',  1, 7500),
 (@t4, 'L201',  6,  900);

/* --- Ticket 5: sucursal 2 / vendedor 3 / transferencia --- */
INSERT INTO ventas.Ticket (id_vendedor, id_metodo, id_sucursal)
VALUES (3, 4, 2);
DECLARE @t5 INT = SCOPE_IDENTITY();

INSERT INTO ventas.LineaTicket (id_ticket, codigo_articulo, cantidad, precio_unitario) VALUES
 (@t5, 'P101',  2, 5600),
 (@t5, 'G501',  3, 2200),
 (@t5, 'L200',  6, 1500);

/* 5) Consultas de verificación */

/* Totales por ticket (vista) */
SELECT * FROM ventas.vw_TicketConTotal ORDER BY id_ticket;

/* Stock actual (debe reflejar los descuentos de líneas) */
SELECT codigo_articulo, nombre, stock
FROM ventas.Articulo
ORDER BY codigo_articulo;

/* Ventas por sucursal y método (ejemplo de análisis) */
SELECT s.nombre AS Sucursal, mp.descripcion AS MetodoPago,
       COUNT(DISTINCT t.id_ticket) AS Tickets,
       SUM(lt.precio_total)        AS Importe
FROM ventas.Ticket t
JOIN ventas.Sucursal s   ON s.id_sucursal = t.id_sucursal
JOIN ventas.MetodoPago mp ON mp.id_metodo = t.id_metodo
JOIN ventas.LineaTicket lt ON lt.id_ticket = t.id_ticket
GROUP BY s.nombre, mp.descripcion
ORDER BY Sucursal, MetodoPago;

/* Top 5 artículos más vendidos (por cantidad) */
SELECT a.codigo_articulo, a.nombre,
       SUM(lt.cantidad) AS Unidades, SUM(lt.precio_total) AS Facturado
FROM ventas.LineaTicket lt
JOIN ventas.Articulo a ON a.codigo_articulo = lt.codigo_articulo
GROUP BY a.codigo_articulo, a.nombre
ORDER BY Unidades DESC, Facturado DESC;

/* Control: intentá vender sin stock (debe fallar) */
BEGIN TRY
  INSERT INTO ventas.LineaTicket (id_ticket, codigo_articulo, cantidad, precio_unitario)
  VALUES (@t1, 'C301', 9999, 7500);  -- supera stock
END TRY
BEGIN CATCH
  SELECT 'OK: trigger de stock actuó' AS Resultado, ERROR_MESSAGE() AS Mensaje;
END CATCH;

/* Control: intentá ticket con sucursal distinta al vendedor (debe fallar) */
BEGIN TRY
  INSERT INTO ventas.Ticket (id_vendedor, id_metodo, id_sucursal)
  VALUES (1, 1, 2);  -- vendedor 1 es de sucursal 1
END TRY
BEGIN CATCH
  SELECT 'OK: trigger de sucursal actuó' AS Resultado, ERROR_MESSAGE() AS Mensaje;
END CATCH;
