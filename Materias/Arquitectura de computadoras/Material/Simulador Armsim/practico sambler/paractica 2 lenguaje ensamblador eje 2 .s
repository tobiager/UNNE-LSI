@Realizar el punto 1 pero efectuando la multiplicación como sumas sucesivas.
@Sin hacer llamadas a subrutinas, resolviendo el problema desde el programa principal
.text
		mov r1, #5  @se guarda los valore en r1 y r2
		mov r2, #5
bucle:      @ creamos una subrutina llamada bucle (ya que cuandra con la consigna)
	   add r3, r3, r1 @ sumamos r3 y r1 teniendo en cuenta que r3 es igual a cero (esto podemos inicializar si queremos antes del bucle pero en compilador asumer como cero)
	   sub r2, r2, #1 @restamos a r2 1 para ir quitando iteraciones al bucle para llegara a cero
	   cmp r2, #0 @comparamos r2 con una bandera de para para detener el blucle . si esto no sucede salta el beq a b que hace que vuelva al bucle
	   beq fin @pregunta si la ultima intruccion es dio como resultado igual
	   b bucle
	   fin:wfi
.end