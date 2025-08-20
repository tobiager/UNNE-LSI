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

[1]> 
(defun ingresar ()
  (let ((lista))
    (print "Ingresar una lista:")
    (setq lista (read))
    (if (listp lista)
        (progn (pprint (sublistas lista)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun sublistas (lista)
	(cond ((endp lista)nil)
		    ((listp (first lista)) (cons (list (length (first lista))) (sublistas (rest lista))))
		    (t (sublistas (rest lista)))))

INGRESAR
[2]> 
SUBLISTAS
[3]> (ingresar)

"Ingresar una lista:" (1 2 (3 5 6 7) s (a b s 1 2 3 4 5 6 7))

((4) (10))

[4]> (ingresar)

"Ingresar una lista:" ((((((((()))))))))

((1))

[5]> 