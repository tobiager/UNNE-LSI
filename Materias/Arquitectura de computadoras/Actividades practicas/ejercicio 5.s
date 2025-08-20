.text
ldr r0, =5000
ldr r0, [r0]
ldr r1, =5004
ldr r1, [r1]
add r0, r0, r1
ldr r2, =5008
str r0, [r2]
.end
