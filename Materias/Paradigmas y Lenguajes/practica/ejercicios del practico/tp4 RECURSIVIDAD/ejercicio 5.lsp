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

[1]> (defun ingresar()
	(let ((lista))
		(print "ingresar lista")
		(setq lista (read))
		(if (listp lista)
			(progn
				(pprint (unir-listas lista))))))

(defun unir-listas (lista)
	(list (pares lista)(impares lista)))

(defun pares (lista)
	(cond
		((endp lista) nil)
		((and (numberp (first lista))(evenp (first lista)))	(cons (first lista)(pares (rest lista))))
		(t (pares (rest lista)))))

(defun impares (lista)
	(cond
		((endp lista) nil)
		((and (numberp (first lista))(oddp (first lista))) (cons (first lista)(impares (rest lista))))
		(t(impares (rest lista)))))


INGRESAR
[2]> 
UNIR-LISTAS
[3]> 
PARES
[4]> 
IMPARES
[5]> (ingresar)

"ingresar lista" (1 2 3 4 5 6 7 8 9 10)

((2 4 6 8 10) (1 3 5 7 9))

[6]> 