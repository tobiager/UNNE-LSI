.data
oper1: .word 5
oper2: .word 4

.text
ldr r1, =oper1
ldr r2, =oper2
ldr r2, [r2] 
push {r1, r2} 
bl suma2
mov r4, r3
add r2, r2, r1 
b fin 
suma2:
pop {r1, r2}
add r3, r1, r2 
mov pc, lr 
fin: wfi 
.end