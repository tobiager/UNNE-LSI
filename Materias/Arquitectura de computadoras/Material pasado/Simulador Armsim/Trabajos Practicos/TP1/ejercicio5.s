.text
ldr r0, =0x5000
ldr r0, [r0]
ldr r1, =0x5004
ldr r1, [r1]
add r1, r1, r0
ldr r3, =0x5008
str r1, [r3]
ldr r3, [r3] @extra para control
.end
