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

[1]>  (defun ingresar ()
  (let ((lista1)(lista2))
    (print "Ingresar una lista:")
    (setq lista1 (read))
    (print "Ingresar una lista:")
    (setq lista2 (read))
    (if (and (listp lista1)(listp lista2))
        (progn (pprint (sublistas lista1 lista2)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun sublistas (lista1 lista2)
	(cond ((or (endp lista1)(endp lista2))nil)
				((not (numberp (first lista1))) (cons (list (first lista1) (first (last lista2)))(sublistas (rest lista1)(reverse (rest (reverse lista2))))))
				(t (sublistas (rest lista1) lista2))))

INGRESAR
[2]> 
SUBLISTAS
[3]> (ingresar)

"Ingresar una lista:" (a 1 b c 23 1 ())

"Ingresar una lista:" (1 2 3 4 5 6 7 8  9 10)

((A 10) (B 9) (C 8) (NIL 7))

[4]> 