@ Hacer la multiplicacion sucesiva llamando a una sub-rutina


.data
    num1: .word 4
    num2: .word 3
.text
    ldr r1, =num1
    ldr r2, =num2
    ldr r1, [r1]
    ldr r2, [r2]
    bl multip
    b fin
multip:
    bucle:
        add r3, r3, r1
        sub r2, r2, #1
        cmp r2, #0
        beq retorno @ BackEqual, hace un back cuando la condicion de arriba se cumple (r2 - 0 = 0)
        b bucle @back to etiqueta (bucle)
    retorno: mov pc, lr @ Cuando se activa beq venimos hasta aca y regresamos a la posicion siguiente a bl
fin:
.end