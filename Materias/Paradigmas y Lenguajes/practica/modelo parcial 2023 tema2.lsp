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

[1]> ;MODELO PARCIAL 2023 TEMA 2

 (defun ingresar ()
	(let ((lista)(peso))
		(print " ingresar una lista" )
		(setq lista (read))
		(print " ingresar un peso en kg" )
		(setq peso (read))
		(if (and (listp lista)(numberp peso))
			(progn
				(pprint ( evalua-pesos lista peso))
				(pprint (nuevaLista lista))
				(pprint (peso-menor lista peso))
				(pprint (peso-mayor lista peso))
				(pprint (listas-con-sublistas lista peso))
				)
			(print "ingresar una lista "))))
;1)
(defun evalua-pesos (lista peso)
	(cond ((endp lista) t)
		  ((> (first lista) peso) (evalua-pesos (rest lista) peso))
		  (t nil)))


;2)
(defun lista-kg (lista)
	(cond ((endp lista) nil)
		  ((> (first lista) 30) (cons (first lista) (lista-kg (rest lista))))
		  (t (lista-kg (rest lista)))))

(defun lista-gramos (lista)
	(cond ((endp lista) nil)
		  ((<= (first lista) 30) (cons  (* (first lista) 1000) (lista-gramos (rest lista))))
		  (t (lista-gramos (rest lista)))))

(defun nuevaLista (lista)
	(list (lista-kg lista) (lista-gramos lista)))  

;3)
(defun peso-menor (lista peso)
  (cond ((endp lista) 0)
        ((<= (first lista) peso) (+ 1 (peso-menor (rest lista) peso)))
        (t (peso-menor (rest lista) peso))))


;4)
(defun peso-mayor (lista peso)
  (remove nil (mapcar (lambda (x)
                        (if (> x peso)
                            x
                            nil))
                      lista)))

;5)
(defun listas-con-sublistas (lista peso)
	(remove nil (mapcar (lambda (x)
                        (cond ((<= x 20) (list x "liviano"))
                        	    ((and (>= x 20)(<= x 60)) (list x "pesado"))
                              ((> x 60) (list x "muy pesado"))
                            ))
                      lista)))

INGRESAR
[2]> 
EVALUA-PESOS
[3]> 
LISTA-KG
[4]> 
LISTA-GRAMOS
[5]> 
NUEVALISTA
[6]> 
PESO-MENOR
[7]> 
PESO-MAYOR
[8]> 
LISTAS-CON-SUBLISTAS
[9]> (ingresar)

" ingresar una lista" (1 5 15 17 18 19 20 30 31 39 50 39 50 1002)

" ingresar un peso en kg" 15

NIL
((31 39 50 39 50 1002) (1000 5000 15000 17000 18000 19000 20000 30000))
3
(17 18 19 20 30 31 39 50 39 50 1002)
((1 "liviano") (5 "liviano") (15 "liviano") (17 "liviano") (18 "liviano") (19 "liviano") (20 "liviano") (30 "pesado")
 (31 "pesado") (39 "pesado") (50 "pesado") (39 "pesado") (50 "pesado") (1002 "muy pesado"))

[10]> 