Drop table detalle
drop table detalle2

use adventureworks2008R2
go
Drop table detalle
-- Creo tabla detalle SIN INDICES
Select * 
into detalle
from Sales.SalesOrderDetail -- 121317 registros

sp_help detalle
go
sp_help 'Sales.SalesOrderDetail' 
go
----------------------------------------------------------------------------------------------------------------------
-- COMPARO COSTO ENTRE TABLAS CON INDICE Y SIN INDICE (MOSTRAR PLAN DE EJECUCION ESTIAMADA)
-- TABLA ORIGINAL TIENE INDICE AGRUPADO
select * from detalle 
Where SalesOrderID = 46359 and  SalesOrderDetailID = 10100

select * from Sales.SalesOrderDetail 
Where SalesOrderID = 46359 and SalesOrderDetailID =10100

-- BORRO INDICE 
--ALTER TABLE dbo.detalle Drop CONSTRAINT 	PK_detalle 
--  DROP INDEX PK_detalle on detalle
-- CREO INDICE NONCLUSTERED PRIMARY KEY 
/* Alternativa: Opcion 2
CREATE UNIQUE NONCLUSTERED INDEX PK_detalle 
    ON detalle (SalesOrderID,SalesOrderDetailID); */
    
-- CREO INDICE NO AGRUPADO
ALTER TABLE dbo.detalle ADD CONSTRAINT
	PK_detalle PRIMARY KEY NONCLUSTERED 
	(
	SalesOrderID,
	SalesOrderDetailID
	) -- ON [PRIMARY]
GO

sp_help detalle
go
sp_help 'Sales.SalesOrderDetail' 
go
-- Comparo tiempos de acceso con indice agrupado y sin agrupar.
select * from detalle 
Where SalesOrderID = 46359  and  SalesOrderDetailID = 10100

select * from Sales.SalesOrderDetail 
Where SalesOrderID = 46359  and SalesOrderDetailID =10100

-- Borro y creo indice agrupado
 ALTER TABLE dbo.detalle Drop CONSTRAINT 	PK_detalle 
   
ALTER TABLE dbo.detalle ADD CONSTRAINT
	PK_detalle PRIMARY KEY CLUSTERED 
	(
	SalesOrderID,
	SalesOrderDetailID
	) -- ON [PRIMARY]
GO
-- Vuelvo a comparar tiempos de acceso.
select * from detalle 
Where SalesOrderID = 46359  and  SalesOrderDetailID = 10100

select * from Sales.SalesOrderDetail 
Where SalesOrderID = 46359  and SalesOrderDetailID =10100

----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------
-- Busqueda por  parte de un indice.
-- CREO INDICE  PRIMARY KEY con 3 campos
ALTER TABLE dbo.detalle Drop CONSTRAINT 	PK_detalle 

ALTER TABLE dbo.detalle ADD CONSTRAINT
	PK_detalle PRIMARY KEY NONCLUSTERED 
	(
	SalesOrderID,
	SalesOrderDetailID,
	ProductID
	)  ON [PRIMARY]

GO
sp_help detalle

-- Comparo plan de ejecucion entre las tres opciones.

SET STATISTICS TIME ON
-- Index Seek	
select * from detalle 
Where SalesOrderID = 46359   and  SalesOrderDetailID = 10100 and ProductID=722

--Index Seek
select * from detalle 
Where SalesOrderID = 46359   and  SalesOrderDetailID = 10100 --and ProductID=722

--Index Seek
select * from detalle 
Where SalesOrderID = 46359  -- and  SalesOrderDetailID = 10100 --and ProductID=722

-- Index scan
select * from detalle 
Where /*SalesOrderID = 46359   and*/  SalesOrderDetailID = 10100 and ProductID=722


-- Full scan
select * from detalle 
Where /*SalesOrderID = 46359   and  SalesOrderDetailID = 10100 and */ ProductID=722

-- USO de HINTS: son parámetros que pasamos a las sentencias SQL para influir en el optimizador de la base de datos.
-- Forzo el Index scan pero es menos eficiente.
select * from detalle  WITH (INDEX=PK_detalle)
Where /*SalesOrderID = 46359   and  SalesOrderDetailID = 10100 and */ ProductID=722



-- uso de include en indices
-- CREO OTRA TABLA EN BASE A DETALLE
Select * 
into detalle2
from detalle -- 121317 registros


-- Creo indice e incluyo una columna de la tabla.
--select * from detalle2
drop index   ix_CarrierTrackingNumber on detalle2

Create Index ix_CarrierTrackingNumber on detalle2(CarrierTrackingNumber)
include (UnitPrice)
-- Sin columna Incluida
Create Index ix_CarrierTrackingNumber_detalle on detalle(CarrierTrackingNumber)
--1ra Prueba:
-- Busco por indice y muestro solo el dato del indice
select CarrierTrackingNumber
from detalle2
where CarrierTrackingNumber like '0F82%'
-- Busco por indice y muestro solo el indice
select CarrierTrackingNumber
from detalle
where CarrierTrackingNumber like '0F82%'


--2da. Prueba
-- Busco por indice y muestro la columna incluida
select CarrierTrackingNumber, UnitPrice
from detalle2
where CarrierTrackingNumber like '0F82%'

-- Busco por indice y muestro la columna NO incluida
select CarrierTrackingNumber, UnitPrice
from detalle
where CarrierTrackingNumber like '0F82%'


-- CONCLUSION: El include sirve para agregar datos al indice y evitar el acceso a la tabla.