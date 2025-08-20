@Realizar el punto 1 pero efectuando la multiplicación como sumas sucesivas.
@Llamando a una subrutina MUL, pasando los parámetros por referencia desde el programa principal a través de registros.
.data   @ creo mis variables asociados a unos valores
	var1: .word 5
	var2: .word 9
.text
ldr r1, =var1 @ guardo la pocision de memoria en r1 de dicha variable pasada por referencia
ldr r2, =var2
bl multiplicacion

multiplicacion: ldr r1, [r1] @ extraigo el valor que se encuentra en dicho parametro
				ldr r2, [r2]
				bucle:add r3, r3, r1
				sub r2 ,r2, #1
				cmp r2, #0
				beq fin
				b bucle
fin:wfi
.end