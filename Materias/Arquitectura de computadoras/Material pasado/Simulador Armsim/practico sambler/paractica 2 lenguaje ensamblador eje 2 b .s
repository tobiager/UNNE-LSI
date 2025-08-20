@Realizar el punto 1 pero efectuando la multiplicación como sumas sucesivas.
@Llamando a una subrutina MUL para efectuar la operación, pasando los parámetros por valor desde el programa principal a través de registros.
.data
	 valor1: .word 3
	 valor2: .word 4
			@ se puede inicializar un auxiliar pero el programa lo hace automaticamente
.text
ldr r1, =valor1
ldr r1, [r1]
ldr r2, =valor2
ldr r2, [r2]
bl multiplicacion

multiplicacion: add r3, r3, r1 @ sumo a r3=0 con r1 =3 y lo guarda en r3
                sub r2, r2, #1 @ resto a r2=4 ,1 locual queda guardado remplasando 
                cmp r2, #0 @compara a el valor r2 con el cero si son iguales
                beq fin @ verifica que el resultado anterior no es cero por lo tanto deja volver a llamar a multiplicacion
                b multiplicacion
fin:wfi
.end
