@ Realizar la multiplicacion como suma sucesivas sin llamar a sub-rutinas
.data
    num1: .word 4
    num2: .word 3
.text
    ldr r1, =num1
    ldr r2, =num2
    ldr r1, [r1]
    ldr r2, [r2]
bucle:
    add r3, r3, r1
    sub r2, r2, #1
    cmp r2, #0
    beq fin
    b bucle
fin:
.end
