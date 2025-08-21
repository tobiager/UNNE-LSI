@Escribir un programa que calcule el producto entre dos números sin signo almacenados en la memoria del microprocesador:
@2Llamando a una subrutina MUL para efectuar la operación, pasando los parámetros por valor desde el programa principal a través de registros.

.data @variables con la que trabaja el programa
	operador1: .word 2
	operador2: .word 3
.text @para trabajar con variables, que se pasan los parametros por valor primero se debe obten dichos valore
ldr r1 , =operador1 @llamo a el op1 a r1
ldr r1, [r1] @ guardo el valor de op1 en r1
ldr r2, =operador2
ldr r2, [r2]
bl multip @llama a la subrrutina multip (multip: mul r3, r1, r2)
bl suma 
b fin
multip: mul r3, r1, r2 @realiza la operacion
mov pc, lr @ vuelve de la posicion en que la llamron
suma: add r1, r1, r2
 mov pc, lr
 fin:wfi @termina
.end
