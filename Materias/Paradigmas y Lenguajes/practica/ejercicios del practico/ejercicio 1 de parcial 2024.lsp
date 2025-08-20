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
	(print "ingresar a: ")
	(setq a (read))
	(print "ingresar b: ")
	(setq b (read))
	(print "ingresar c: ")
	(setq c (read))
	(pprint (comparar a b c)))

(defun comparar (a b c)
	(and 	(numberp a) (numberp b) (numberp c)(/= a 0)	(= 	(/ (+ a b ) c)	(+ (/ a c) (/ b c)	))))																	

INGRESAR
[2]> 
COMPARAR
[3]> (ingresar)

"ingresar a: " 1

"ingresar b: " 1

"ingresar c: " 1

T

[4]> (ingresar)

"ingresar a: " a 

"ingresar b: " 1

"ingresar c: " 1

NIL

[5]> 