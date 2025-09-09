-- Creo una base de datos
Create database prueba_log
go
use prueba_log
go

-- Prueba crecimiento archivo de log
create table crecimiento_log
(id int identity primary key,
col1 varchar(100),
col2 varchar(200))

-- Inserto un primer registros
begin tran
	insert into crecimiento_log
	values ('Primer registro', 'Primer registro bis....')
-- Confirmo el insert
commit
-- Miro tamaño archivo de log de la base

-- Comienzo una insercion masiva de registros en una transaccion
begin tran
	declare @var int 
	set @var =1
	while @var < 15
	begin
		insert into crecimiento_log
		select col1,col2 from crecimiento_log
		print convert(varchar(10), @var)
		set @var = @var+ 1
	end
	
-- NO CONFIMO LA TRANSACCION
	
	
-- Consulto registros insertados
select * from crecimiento_log

-- Vuelvo a mirar tamaño archivo de Log de la base

-- Sin confirmar la transaccion reinicio la instancia y consulto de nuevo la tabla
select * from crecimiento_log
-- Que paso???
-- Conclusion:
