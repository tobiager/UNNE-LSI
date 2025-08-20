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
	(let ((lista1)(lista2))
		(print "ingresar lista1")
		(setq lista1 (read))
		(print "ingresar lista2")
		(setq lista2 (read))
		(if (and (listp lista1) (listp lista2))
			(progn (pprint (ambos-enteros lista1 lista2)))
			(print "ingresar 2 listas"))))

(defun ambos-enteros (lista1 lista2)
	(cond ((or (endp lista1) (endp lista2))nil)
				((and (integerp (first lista1))(integerp (first lista2))) (cons (+ (first lista1) (first lista2)) (ambos-enteros (rest lista1)(rest lista2))))
				(t (ambos-enteros (rest lista1)(rest lista2)))))


INGRESAR
[2]> 
AMBOS-ENTEROS
[3]> (ingresar)

"ingresar lista1" (1 5 10 32 15 20 100)

"ingresar lista2" (-1/2 1 32 0 3/9 3)

(6 42 32 23)

[4]> 