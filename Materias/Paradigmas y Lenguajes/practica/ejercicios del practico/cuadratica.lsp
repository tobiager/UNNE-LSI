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

[1]> (defun ingresar-valores()
	(print "ingresar a")
	(setq a (read))
	(print "ingresar b")
	(setq b (read))
	(print "ingresar c")
	(setq c (read))
    

    (print (resolver-cuadratica a b c)))



(defun resolver-cuadratica (a b c)

	(setq resultado (/ (+ b (sqrt (- (* b b) (* 4 a c)))) 
	   (* 2 a)))																																																	(format t "el resultado es: ~A" resultado))

INGRESAR-VALORES
[2]> 
RESOLVER-CUADRATICA
[3]> (ingresar-valores)

"ingresar a" 2

"ingresar b" 2

"ingresar c" 2
el resultado es: #C(1/2 0.8660254)
NIL 
NIL
[4]> 