  i i i i i i i       ooooo    o        ooooooo   ooooo   ooooo
  I I I I I I I      8     8   8           8     8     o  8    8
  I  \ `+' /  I      8         8           8     8        8    8
   \  `-+-'  /       8         8           8      ooooo   8oooo
    `-__|__-'        8         8           8           8  8
        |            8     o   8           8     o     8  8
  ------+------       ooooo    8oooooo  ooo8ooo   ooooo   8

Welcome to GNU CLISP 2.49 (2010-07-07) <http://clisp.cons.org/>

Copyright (c) Bruno Haible, Michael Stoll 1992, 1993
Copyright (c) Bruno Haible, Marcus Daniels 1994-1997
Copyright (c) Bruno Haible, Pierpaolo Bernardi, Sam Steingold 1998
Copyright (c) Bruno Haible, Sam Steingold 1999-2000
Copyright (c) Sam Steingold, Bruno Haible 2001-2010

Type :h and hit Enter for context help.

[1]> (defun temperatura-primer-dia-entre-40-y-45 (max_temp)
  "Evalúa si la temperatura registrada el primer día está comprendida entre los 40 y 45 grados."
  (let ((temp-primer-dia (first max_temp))) ; Obtiene la temperatura del primer día.
    (print (and (>= temp-primer-dia 40) (<= temp-primer-dia 45))))) ; Imprime si la temperatura del primer día está entre 40 y 45 grados.

(defun temperatura-de-40 (max_temp)
  "Evalúa si en alguno de los días del mes la máxima fue de 40 grados."
  (print (if (member 40 max_temp) 't 'nil))) ; Imprime si 40 grados está presente en la lista de temperaturas máximas.

(defun temperatura-primer-y-ultimo-iguales (max_temp)
  "Evalúa si la temperatura del primer y último día son IGUALES."
  (print (= (first max_temp) (first (reverse max_temp))))) ; Imprime si la temperatura del primer día es igual a la del último día.

(defun ingresar-datos ()
  "Solicita al usuario ingresar la lista de temperaturas máximas del mes."
  (print "Ingrese la lista de temperaturas máximas del mes:") ; Solicita al usuario ingresar la lista de temperaturas máximas del mes.
  (read)) ; Lee la entrada del usuario y devuelve la lista de temperaturas.

(defun resolver-consultas ()
  "Resuelve las consultas especificadas sobre la lista de temperaturas máximas del mes."
  (let ((max_temp (ingresar-datos))) ; Obtiene la lista de temperaturas máximas ingresada por el usuario.
    (print "a. ¿La temperatura registrada el primer día está entre 40 y 45 grados?")
    (temperatura-primer-dia-entre-40-y-45 max_temp) ; Llama a la función para evaluar la temperatura del primer día.
    (print "b. ¿Hubo alguna temperatura de 40 grados?")
    (temperatura-de-40 max_temp) ; Llama a la función para verificar si hubo alguna temperatura de 40 grados.
    (print "c. ¿La temperatura del primer y último día son iguales?")
    (temperatura-primer-y-ultimo-iguales max_temp))) ; Llama a la función para verificar si la temperatura del primer y último día son iguales.

;; Ejemplo de uso:
;; (resolver-consultas) ; Esta línea llama a la función resolver-consultas para probar el código.


TEMPERATURA-PRIMER-DIA-ENTRE-40-Y-45
[2]> 
TEMPERATURA-DE-40
[3]> 
TEMPERATURA-PRIMER-Y-ULTIMO-IGUALES
[4]> 
INGRESAR-DATOS
[5]> 
RESOLVER-CONSULTAS
[6]> (resolver-consultas)

"Ingrese la lista de temperaturas máximas del mes:" (40 41 32 38 40)


"a. ¿La temperatura registrada el primer día está entre 40 y 45 grados?" 
T 
"b. ¿Hubo alguna temperatura de 40 grados?" 
T 
"c. ¿La temperatura del primer y último día son iguales?" 
T 
T
[7]> 