@Escribir un programa que calcule el producto entre dos números sin signo almacenados en la memoria del microprocesador:
@Llamando a una subrutina MUL, pasando los parámetros por referencia desde el programa principal a través de registros.
.data
	operador1: .word 4 @se guarda el valor en la variable operador1
	operador2: .word 6
.text
ldr r1, =operador1 @se guarda la direccion de memoria de operador1 en r1
ldr r2, =operador2
bl multiplicacion @1se hace un llamada a una subrutina llamada multiplicacion
bl suma
b fin
multiplicacion: ldr r1, [r1] @se extrae el valor de r1 que apuntaba a la direccion de memoria POR ELLO EL PASO DE PARAMETRO ES POR REFERENCIA
				ldr r2, [r2]
				mul r4 ,r1 ,r2 @se realiza la multiplicacion y se guarda en r4
				mov pc, lr @ vueleve de donde fue llamado multiplicacion esta info se guardo en pc que se la pasa a la lr para seguir con los siguientes subrrutinas
suma: add r3, r1, r2
mov pc, lr

fin:wfi
.end
