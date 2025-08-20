						@leer el dato presente en la direccion de memoria 0x5000 dejandolo en el registro r6 
.text
mov r1 , #0x5000 		@ guarda la lo que esta en la posisiocn de memoria 5000 en r1
ldr r6, [r1]			@y lee lo que esta en r1 mientras que lo guarda en r6
.end