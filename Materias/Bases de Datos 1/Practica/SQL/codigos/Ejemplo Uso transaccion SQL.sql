/*
use consorcio
go
Drop table movimientos
Drop table cuentas

Create table cuentas (idcuenta int identity(1,1) Primary Key, 
numcuenta varchar(20) UNIQUE, 
saldo decimal (10))

Create table movimientos (id int identity(1,1) Primary Key, 
numcuenta varchar(20), 
importe decimal(10), 
fec_mov datetime,
constraint FK_Mov_ctas FOREIGN KEY (numcuenta) References cuentas (numcuenta) )

insert into cuentas values ('200700000001', 0)
insert into cuentas values ('200700000002',1000)
*/

select * from cuentas
select * from movimientos

-- 1er caso. Sin manejo de transaccion
DECLARE @importe DECIMAL(18,2),@CuentaOrigen VARCHAR(12),	@CuentaDestino VARCHAR(12)
/* Asignamos el importe de la transferencia y las cuentas de origen y destino*/
SET @importe = 500.00 
SET @CuentaOrigen  = '200700000002' 
--SET @CuentaDestino = '200700000001' 
SET @CuentaDestino = '200700000003' -- Para producir el error
	/* Descontamos el importe de la cuenta origen */
	UPDATE cuentas SET saldo = saldo - @importe 
	WHERE numcuenta = @CuentaOrigen 
	/* Registramos el movimiento */
	INSERT INTO movimientos (NUMCUENTA, IMPORTE, FEC_MOV)
    VALUES (@CuentaOrigen, @IMPORTE * -1, getdate())
	/* Incrementamos el importe de la cuenta destino */
	UPDATE cuentas SET SALDO = SALDO + @importe WHERE NUMCUENTA = @CuentaDestino 
	/* Registramos el movimiento */
	INSERT INTO movimientos (NUMCUENTA,  IMPORTE, FEC_MOV)
    VALUES (@Cuentadestino,  @IMPORTE, getdate())
select * from cuentas 
select * from movimientos
-- Conclusion: Hizo 1er update, 1er insert, 2do update y NO HIZO 2do. insert.



-- 2do. caso. CON manejo de transaccion
DECLARE @importe DECIMAL(18,2),@CuentaOrigen VARCHAR(12),	@CuentaDestino VARCHAR(12)
SET @importe = 500.00 
SET @CuentaOrigen  = '200700000002' 
--SET @CuentaDestino = '200700000001' 
SET @CuentaDestino = '200700000003' 
SET LOCK_TIMEOUT 5 -- Tiempo de espera del recurso. Si no defino queda esperando en forma indefinida.
BEGIN TRY -- Comienza un bloque de codigo Transact -SQL
			--SELECT @@TRANCOUNT
			BEGIN TRANSACTION  -- O solo BEGIN TRAN 
			/* Descontamos el importe de la cuenta origen */
			UPDATE CUENTAS SET SALDO = SALDO - @importe WHERE NUMCUENTA = @CuentaOrigen 
			/* Registramos el movimiento */
			INSERT INTO MOVIMIENTOS (NUMCUENTA, IMPORTE, FEC_MOV)
            VALUES (@CuentaOrigen, @IMPORTE * -1, getdate())
			/* Incrementamos el importe de la cuenta destino */
			UPDATE CUENTAS SET SALDO = SALDO + @importe WHERE NUMCUENTA = @CuentaDestino 
			/* Registramos el movimiento */
			INSERT INTO MOVIMIENTOS (NUMCUENTA,  IMPORTE, FEC_MOV)
            VALUES (@Cuentadestino,  @IMPORTE, getdate())
			/* Confirmamos la transaccion*/ 
			COMMIT TRANSACTION -- O solo COMMIT 
			--SELECT @@TRANCOUNT
	END TRY -- Finaliza bloque de codigo TRANSACT-SQL
	BEGIN CATCH -- Inicia BLOQUE DE CODIGO SQL QUE CAPTURA ERROR DEL BLOQUE ANTERIOR SI OCURRIESE
			/* Hay un error, deshacemos los cambios*/ 
			--SELECT @@TRANCOUNT
		IF @@TRANCOUNT > 0 
			BEGIN
				ROLLBACK TRANSACTION -- O solo ROLLBACK
				PRINT 'Se ha producido un error en la transaccion!'
				SELECT ERROR_MESSAGE()
			END	
		ELSE
			BEGIN
				PRINT 'Se ha producido un error!'
				SELECT ERROR_MESSAGE()
			END	
	END CATCH
select * from cuentas 
select * from movimientos






