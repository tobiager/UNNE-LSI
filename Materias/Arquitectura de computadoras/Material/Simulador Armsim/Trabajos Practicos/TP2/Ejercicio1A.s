@  Sin hacer llamadas a subrutinas, resolviendo el problema desde el programa principal.
.data
    num1: .word 2
    num2: .word 4
.text

    ldr r1, =num1
    ldr r2, =num2
    ldr r1, [r1]
    ldr r2, [r2]
    mul r3, r1, r2

.end




