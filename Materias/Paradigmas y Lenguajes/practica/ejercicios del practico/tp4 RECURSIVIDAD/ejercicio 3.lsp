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

[1]> (defun procesar-lista-heterogenea ()
	(let ((lista))
	(print "ingresar lista")
	(setq lista (read))
	(if (listp lista)
		(progn 
			(pprint (sublistas-longitud lista))
			(pprint (son-sublistas lista))))))

(defun sublistas-longitud (lista)
	(cond 
		((endp lista)nil)
		((listp (first lista)) (cons (list (first lista)(length (first lista)))	(sublistas-longitud (rest lista))))
		(t (sublistas-longitud (rest lista)))))

(defun son-sublistas (lista)
	(cond
		((endp lista)nil)
		(t(cons (listp (first lista))(son-sublistas (rest lista))))))

PROCESAR-LISTA-HETEROGENEA
[2]> 
SUBLISTAS-LONGITUD
[3]> 
SON-SUBLISTAS
[4]> (procesar-lista-heterogenea)

"ingresar lista" (1 2 3 4 a b () 43 3s (1 2 3 abc))

((NIL 0) ((1 2 3 ABC) 4))
(NIL NIL NIL NIL NIL NIL T NIL NIL T)

[5]> 