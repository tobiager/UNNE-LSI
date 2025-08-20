@  Llamando a una subrutina MUL para efectuar la operación, pasando los parámetros por valor
@  desde el programa principal a través de registros.

.data
    num1: .word 2
    num2: .word 4
.text

    ldr r1, =num1
    ldr r2, =num2
    ldr r1, [r1]
    ldr r2, [r2]
    bl multip
    b fin
    multip:
        mul r3, r1, r2
        mov pc, lr
fin:
.end