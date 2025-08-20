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

[1]> (defun ingresar ()																																												  (let (monto))
  (print "Ingresar monto: ")
  (setq monto (read))

  (if (and (numberp monto) (> monto 0))
		(progn
    		(pprint(lista monto))
			(pprint (descuento monto))																																													                                                                                                  
      (pprint (comprar-bidones monto)))))	

	(defun lista (monto)
  	(list (list '10L (truncate (/ monto 15000)))
          (list '20L (truncate (/ monto 28000)))				
          (list '30L (truncate (/ monto 70000)))))

(defun descuento (monto)
  (cond ((< monto 75000) monto)
        ((and (>= monto 75000) (<= monto 200000)) (- monto 30000))
        ((> monto 200000) (- monto 50000))))

(defun comprar-bidones(monto)
	(<= 310000 monto))

INGRESAR
[2]> 
LISTA
[3]> 
DESCUENTO
[4]> 
COMPRAR-BIDONES
[5]> (ingresar)

"Ingresar monto: " 700000

((|10L| 46) (|20L| 25) (|30L| 10))
650000
T

[6]> 