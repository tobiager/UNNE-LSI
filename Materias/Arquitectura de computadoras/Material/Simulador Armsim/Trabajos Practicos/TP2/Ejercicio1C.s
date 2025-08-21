@ Llamando a una subrutina MUL, pasando los parámetros por referencia desde el programa
@ principal a través de registros.

.data
    num1: .word 2
    num2: .word 4
.text

    ldr r1, =num1
    ldr r2, =num2
    bl multip
    b fin
    multip:
        ldr r1, [r1]
        ldr r2, [r2]
        mul r3, r1, r2
        mov pc, lr
fin:
.end