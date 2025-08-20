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

[1]> ;2do parcial tema2

(defun ingresar ()
	(let ((lista) (atomo))
		(print " ingresar una lista" )
		(setq lista (read))
		(print " ingresar un numero" )
		(setq atomo (read))
		(if (and (listp lista) (numberp atomo))
			(progn
				(pprint (masDe50Cajas lista))
				(pprint (ultimaCaja lista atomo))
				(pprint (cajaVacia lista))
				(pprint (listaCajasMenoresAlPeso lista atomo))
				(pprint (ListaCajasLlenasoVacias lista))
				)
			(print "ingresar una lista válida"))))

(defun masDe50Cajas (lista)
    (> (length lista) 50)
)

(defun ultimaCaja (lista atomo)
    (if (<= (first (rest (first (last lista)))) atomo)
        (first (rest (first (last lista))))
    )
)

(defun cajaVacia (lista)
    (cond
        ((endp lista) nil)
        ((= (first (rest (first lista))) 0) t)
        (t (cajaVacia (cdr lista)))))

(defun listaCajasMenoresAlPeso (lista atomo)
    (cond
        ((endp lista) nil)
        ((< (first (rest (first lista))) atomo)
            (cons (first (first lista)) (listaCajasMenoresAlPeso (rest lista) atomo)))
        (t (listaCajasMenoresAlPeso (rest lista) atomo))))

(defun ListaCajasLlenasoVacias (lista)
    (mapcar (lambda (x)
            (if (> (first (rest x)) 0)
                'LLENO
                'VACIO))
        lista))


INGRESAR
[2]> 
MASDE50CAJAS
[3]> 
ULTIMACAJA
[4]> 
CAJAVACIA
[5]> 
LISTACAJASMENORESALPESO
[6]> 
LISTACAJASLLENASOVACIAS
[7]> (ingresar)

" ingresar una lista" ((caja1 1000) (caja2 0) (caja3 10) (caja4 10000))

" ingresar un numero" 11000

NIL
10000
T
(CAJA1 CAJA2 CAJA3 CAJA4)
(LLENO VACIO LLENO LLENO)

[8]> (ingresar)

" ingresar una lista" ((caja1 1000) (caja2 0) (caja3 10) (caja4 10000) (caja5 500) (caja6 5) (caja7 100) (caja8 15000) (caja9 50) (caja10 2000) (caja11 20) (caja12 750) (caja13 3000) (caja14 400) (caja15 8000)  (caja16 250)       (caja17 100) (caja18 50) (caja19 1250) (caja20 0) (caja21 600) (caja22 10) (caja23 9000) (caja24 150) (caja25 5000)  (caja26 300) (caja27 30) (caja28 200) (caja29 12000) (caja30 70) (caja31 2500) (caja32 10000)         (caja33 80) (caja34 100) (caja35 900) (caja36 4500) (caja37 3000) (caja38 600) (caja39 0) (caja40 50000) (caja41 11000) (caja42 90) (caja43 6000) (caja44 100) (caja45 2000) (caja46 500) (caja47 120) (caja48 0)       (caja49 7000) (caja50 300) (caja51 1))

" ingresar un numero" 2

T
1
T
(CAJA2 CAJA20 CAJA39 CAJA48 CAJA51)
(LLENO VACIO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO VACIO
 LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO LLENO VACIO LLENO
 LLENO LLENO LLENO LLENO LLENO LLENO LLENO VACIO LLENO LLENO LLENO)

[9]> 