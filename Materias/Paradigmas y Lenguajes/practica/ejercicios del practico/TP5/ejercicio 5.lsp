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
  (let ((lista) (numero))
    (print "Ingresar una lista:")
    (setq lista (read))
    (print "Ingrese un numero:")
    (setq numero (read))
    (if (and (listp lista) (not (endp lista)) (numberp numero))
        (progn (pprint (potencia lista numero)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun potencia (lista numero)
  (if (endp lista)
      nil
      (cons (list (first lista) (expt (first lista) numero))(potencia (rest lista) numero))))

INGRESAR
[2]> 
POTENCIA
[3]> (ingresar)

"Ingresar una lista:" (1 2 3 4 5 6 7 8 9 10)

"Ingrese un numero:" 3

((1 1) (2 8) (3 27) (4 64) (5 125) (6 216) (7 343) (8 512) (9 729) (10 1000))

[4]> (ingresar)

"Ingresar una lista:" (2 4 6)

"Ingrese un numero:" 2

((2 4) (4 16) (6 36))

[5]> (ingresar)

"Ingresar una lista:" (1 2 3 4 5)

"Ingrese un numero:" -1

((1 1) (2 1/2) (3 1/3) (4 1/4) (5 1/5))

[6]> (ingresar)

"Ingresar una lista:" (1 2 3 4 5 a )

"Ingrese un numero:" 1

*** - EXPT: A is not a number
Es posible continuar en los siguientes puntos:
USE-VALUE      :R1      Input a value to be used instead.
ABORT          :R2      Abort main loop
Break 1 [7]> 