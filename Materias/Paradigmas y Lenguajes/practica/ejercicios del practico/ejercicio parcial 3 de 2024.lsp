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

[1]> (defun ingresar ()
  (let ((mes1) (mes2) (mes3))
    (print "Ingresar el consumo del mes 1: ")
    (setq mes1 (read))
    (print "Ingresar el consumo del mes 2: ")
    (setq mes2 (read))
    (print "Ingresar el consumo del mes 3: ")
    (setq mes3 (read))
    (if (and (numberp mes1) (numberp mes2) (numberp mes3))
        (progn
          (pprint (iguales mes1 mes2 mes3))
          (pprint (lista (promedio mes1 mes2 mes3)))))))

(defun promedio (mes1 mes2 mes3)
  (/ (+ mes1 mes2 mes3) 3))

(defun iguales (mes1 mes2 mes3)
  (= mes1 mes2 mes3))

(defun lista (promedio)
  (cond
    ((< promedio 80) (list 'bajo promedio))
    ((and (>= promedio 80) (< promedio 120)) (list 'medio promedio))
    ((>= promedio 120) (list 'alto promedio))))


INGRESAR
[2]> 
PROMEDIO
[3]> 
IGUALES
[4]> 
LISTA
[5]> (ingresar)

"Ingresar el consumo del mes 1: " 1

"Ingresar el consumo del mes 2: " 1

"Ingresar el consumo del mes 3: " 1

T
(BAJO 1)

[6]> (ingresar)

"Ingresar el consumo del mes 1: " 2

"Ingresar el consumo del mes 2: " 3

"Ingresar el consumo del mes 3: " 4

NIL
(BAJO 3)

[7]> (ingresar)

"Ingresar el consumo del mes 1: " 100

"Ingresar el consumo del mes 2: " 200

"Ingresar el consumo del mes 3: " bajo

NIL
[8]> 