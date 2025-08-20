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
  (let ((lista1) (lista2))
    (print "Ingresar una lista:")
    (setq lista1 (read))
    (print "Ingrese una lista:")
    (setq lista2 (read))
    (if (and (listp lista1) (listp lista2))
        (pprint (sublistas-no-sumables lista1 lista2))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun sublistas-no-sumables (lista1 lista2)
  (cond 
    ((or (endp lista1) (endp lista2)) nil)
    ((or (not (numberp (first lista1))) (not (numberp (first lista2))))
     (cons (list (first lista1) (first lista2)) 
           (sublistas-no-sumables (rest lista1) (rest lista2))))
    (t (sublistas-no-sumables (rest lista1) (rest lista2)))))



INGRESAR
[2]> 
SUBLISTAS-NO-SUMABLES
[3]> (ingresar)

"Ingresar una lista:" (1 2 3 () abc 5 a b (a b c 1))


"Ingrese una lista:" (a b nazi 12 32 43 (a 1 2) ab)

((1 A) (2 B) (3 NAZI) (NIL 12) (ABC 32) (A (A 1 2)) (B AB))

[4]> 