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

[1]> (defun cantidad-alumnos (lista-notas)
  "Devuelve la cantidad de alumnos en la lista de notas."
  (length lista-notas)) ; Utiliza la función length para obtener la longitud de la lista, que representa la cantidad de alumnos.

(defun libreta-primer-alumno (lista-notas)
  "Devuelve el número de libreta del primer alumno en la lista de notas."
  (if (null lista-notas) ; Verifica si la lista de notas está vacía.
      (print "La lista de notas está vacía.") ; Si está vacía, imprime un mensaje.
      (nth 0 (first lista-notas)))) ; Si no está vacía, utiliza nth para obtener el número de libreta del primer alumno.

(defun nota-ultimo-alumno (lista-notas)
  "Devuelve la nota del último alumno en la lista de notas."
  (if (null lista-notas) ; Verifica si la lista de notas está vacía.
      (print "La lista de notas está vacía.") ; Si está vacía, imprime un mensaje.
      (nth 1 (first (reverse lista-notas))))) ; Si no está vacía, utiliza nth para obtener la nota del último alumno, invirtiendo la lista primero.

(defun regularizado-primer-alumno (lista-notas)
  "Indica si el primer alumno de la lista regularizó la materia."
  (cond ((null lista-notas) ; Verifica si la lista de notas está vacía.
         (print "La lista de notas está vacía.")) ; Si está vacía, imprime un mensaje.
        ((>= (nth 1 (first lista-notas)) 6) ; Comprueba si la nota del primer alumno es mayor o igual a 6.
         (print "Sí, el primer alumno regularizó la materia.")) ; Si es así, imprime un mensaje indicando que el alumno regularizó la materia.
        (t
         (print "No, el primer alumno no regularizó la materia.")))) ; Si no es así, imprime un mensaje indicando que el alumno no regularizó la materia.

(defun obtener-lista-notas ()
  "Solicita al usuario que ingrese la lista de notas por teclado."
  (print "Ingrese la lista de notas de los alumnos:") ; Solicita al usuario que ingrese la lista de notas.
  (read)) ; Lee la entrada del usuario y devuelve la lista de notas ingresada.

(defun resolver-consultas ()
  "Resuelve las consultas sobre la lista de notas de los alumnos ingresada por el usuario."
  (let ((lista-notas (obtener-lista-notas))) ; Obtiene la lista de notas ingresada por el usuario.
    (print "a. Cantidad de alumnos:") ; Imprime la consulta de cantidad de alumnos.
    (print (cantidad-alumnos lista-notas)) ; Llama a la función cantidad-alumnos para obtener la cantidad de alumnos e imprime el resultado.
    (print "b. Número de libreta del primer alumno:") ; Imprime la consulta de número de libreta del primer alumno.
    (print (libreta-primer-alumno lista-notas)) ; Llama a la función libreta-primer-alumno para obtener el número de libreta del primer alumno e imprime el resultado.
    (print "c. Nota del último alumno:") ; Imprime la consulta de nota del último alumno.
    (print (nota-ultimo-alumno lista-notas)) ; Llama a la función nota-ultimo-alumno para obtener la nota del último alumno e imprime el resultado.
    (print "d. ¿Ha regularizado la materia el primer alumno?") ; Imprime la consulta sobre si el primer alumno ha regularizado la materia.
    (regularizado-primer-alumno lista-notas)))) ; Llama a la función regularizado-primer-alumno para verificar si el primer alumno ha regularizado la materia.

;;; Ejemplo de uso:
;; (resolver-consultas) ; Esta línea llama a la función resolver-consultas para probar el código.


CANTIDAD-ALUMNOS
[2]> 
LIBRETA-PRIMER-ALUMNO
[3]> 
NOTA-ULTIMO-ALUMNO
[4]> 
REGULARIZADO-PRIMER-ALUMNO
[5]> 
OBTENER-LISTA-NOTAS
[6]> 
RESOLVER-CONSULTAS
[7]> (resolver-consultas)

"Ingrese la lista de notas de los alumnos:" ((1234 7) (5678 5) (91011 8) (1213 4) (1415 6))

"a. Cantidad de alumnos:" 
5 
"b. Número de libreta del primer alumno:" 
1234 
"c. Nota del último alumno:" 
6 
"d. ¿Ha regularizado la materia el primer alumno?" 
"Sí, el primer alumno regularizó la materia." 
"Sí, el primer alumno regularizó la materia."
[8]> 