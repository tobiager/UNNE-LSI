@escribir el dato 6 en la direccion de memoria 0x5000
.text
mov r1 , #0x5000
mov r2 , #6
str r2, [r1] @str guarda el registro de r2=6 a r1 que corresponde a la posicion de memoria 0x5000
.end