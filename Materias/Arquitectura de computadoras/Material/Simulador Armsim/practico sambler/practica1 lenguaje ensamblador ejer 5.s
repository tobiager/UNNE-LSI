@Sumar el contenido de la dirección 0x5000 con la dirección 0x5004 dejando el resultado en 0x5008

.text
ldr r1, =0x5000 @asigno a r1 la posicion de memoria
ldr r1, [r1]

ldr r2, =0x5004 @asigno a r2 la posisiocn de memoria 5004
ldr r2, [r2]

add r1, r0, r1
ldr r3, =5008
str r1, [r3]
.end