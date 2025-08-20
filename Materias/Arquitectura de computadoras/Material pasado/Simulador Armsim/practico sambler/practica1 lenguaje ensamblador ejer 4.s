					@Sumar los números 3 y 4 dejando el resultado en el registro R0
.text
mov r1, #3    @guardo los numeros a sumar 
mov r2, #4
add r0 , r1 , r2   @realizo la suma y lo guardo en r0 , en primera pocision se r0 se guarda el resultado de r1 suma r2
.end