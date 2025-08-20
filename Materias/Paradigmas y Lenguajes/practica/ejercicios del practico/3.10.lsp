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

[1]>  (defun cantidad-alumnos (lista-notas)
  "Devuelve la cantidad de alumnos en la lista de notas."
  (length lista-notas))

(defun libreta-primer-alumno (lista-notas)
  "Devuelve el número de libreta del primer alumno en la lista de notas."
  (if (null lista-notas)
      (print "La lista de notas está vacía.")
      (nth 0 (first lista-notas))))

(defun nota-ultimo-alumno (lista-notas)
  "Devuelve la nota del último alumno en la lista de notas."
  (if (null lista-notas)
      (print "La lista de notas está vacía.")
      (nth 1 (first (reverse lista-notas)))))

(defun regularizado-primer-alumno (lista-notas)
  "Indica si el primer alumno de la lista regularizó la materia."
  (cond ((null lista-notas)
         (print "La lista de notas está vacía."))
        ((>= (nth 1 (first lista-notas)) 6)
         (print "Sí, el primer alumno regularizó la materia."))
        (t
         (print "No, el primer alumno no regularizó la materia."))))

(defun obtener-lista-notas ()
  "Solicita al usuario que ingrese la lista de notas por teclado."
  (print "Ingrese la lista de notas de los alumnos:")
  (read))

(defun resolver-consultas ()
  "Resuelve las consultas sobre la lista de notas de los alumnos ingresada por el usuario."
  (let ((lista-notas (obtener-lista-notas)))
    (print "a. Cantidad de alumnos:")
    (print (cantidad-alumnos lista-notas))
    (print "b. Número de libreta del primer alumno:")
    (print (libreta-primer-alumno lista-notas))
    (print "c. Nota del último alumno:")
    (print (nota-ultimo-alumno lista-notas))
    (print "d. ¿Ha regularizado la materia el primer alumno?")
    (regularizado-primer-alumno lista-notas)))

;;; Ejemplo de uso:
;; (resolver-consultas)

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