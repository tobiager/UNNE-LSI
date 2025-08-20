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
			(progn (pprint (suma-ambos lista1 lista2)))
			(print "ingresar 2 listas"))))

(defun suma-ambos (lista1 lista2)
	(cond ((or (endp lista1) (endp lista2))nil)
				((and (numberp (first lista1))(numberp (first lista2))) (cons (+ (first lista1) (first lista2)) (suma-ambos (rest lista1)(rest lista2))))
				(t (suma-ambos (rest lista1)(rest lista2)))))


INGRESAR
[2]> 
SUMA-AMBOS
[3]> (ingresar)

"ingresar lista1" (84 932 31 32 0 4 -1 )

"ingresar lista2" (-1 a and 32 (1 23 4 5) 4 10)


(83 64 8 9)

[4]> (ingresar)

"ingresar lista1" (4 9 10 32 43 54 82 10000)

"ingresar lista2" (1 -1 -1000 0 32 and)

(5 8 -990 32 75)

[5]> 