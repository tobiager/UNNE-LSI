.data
oper1: .word 5
oper2: .word 4
.text
ldr r1, =oper1
ldr r2, =oper2
bl multi
b fin
multi: ldr r1, [r1]
       ldr r2, [r2]
       mul r4, r1, r2
       mov pc, lr
fin: wfi
.end