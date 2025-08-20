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
;2do parcial tema 2

(defun ingresar ()
	(let ((lista)(atomo))
	(print "ingresar lista: ")
	(setq lista (read))
	(print "ingresar peso: ")
	(setq atomo (read))
	(if (and (consp lista)(numberp atomo))
		(progn 
			;(pprint (listafiltrada lista))
			(pprint (masde50cajas (listafiltrada lista)))
      (pprint (ultimaCaja (listafiltrada lista) atomo))
      (pprint (cajavacia (listafiltrada lista)))
      (pprint (nuevalista (listafiltrada lista) atomo))
      (pprint (llenoOvacio (listafiltrada lista)))
      (pprint (listafiltrada lista))
			)
			"error")))

;lista filtrada
(defun listafiltrada (lista)
(cond ((endp lista) nil)
			((and (consp (first lista))
				    (numberp (first (rest (first lista))))
				    (= (length (first lista)) 2)) 
			  (cons (first lista) (listafiltrada (rest lista))))
			(t (listafiltrada (rest lista)))))


;2)
(defun masde50cajas (lista)
  (> (length lista) 3))
      

;3)
(defun ultimacaja (lista atomo)
	(if (<= (first (rest (first (last lista)))) atomo) 
		(first (rest (first (last lista))))
		"nil"))


;4)
(defun cajavacia (lista)
	(cond ((endp lista) nil)
				((= (first (rest (first lista))) 0) t)
				(t(cajavacia (rest lista)))))


;5)
(defun nuevalista (lista atomo)
	(cond ((endp lista) nil)
				((< (first (rest (first lista))) atomo) (cons (first lista) (nuevalista (rest lista) atomo)))
				(t (nuevalista (rest lista) atomo))))


;6)

(defun llenoOvacio (lista)
	(mapcar (lambda (x)
				(if (> (first (rest x)) 0)
					"lleno"
					"vacio")
		)
	lista))

INGRESAR
[2]> 
LISTAFILTRADA
[3]> 
MASDE50CAJAS
[4]> 
ULTIMACAJA
[5]> 
CAJAVACIA
[6]> 
NUEVALISTA
[7]> 
LLENOOVACIO
[8]> (ingresar)

"ingresar lista: "  ((caja1 10) (caja2 54) a (caja3 0) (1 caja9) (caja4 10))

"ingresar peso: " 11

T
10
T
((CAJA1 10) (CAJA3 0) (CAJA4 10))
("lleno" "lleno" "vacio" "lleno")
((CAJA1 10) (CAJA2 54) (CAJA3 0) (CAJA4 10))

[9]> (ingresar)

"ingresar lista: "  ((caja1 10) (caja2 54) a (caja3 0) (1 caja9) (caja4 10) (caja5 -1) (caja6 0) (caja4 9320))

"ingresar peso: " 11

T
"nil"
T
((CAJA1 10) (CAJA3 0) (CAJA4 10) (CAJA5 -1) (CAJA6 0))
("lleno" "lleno" "vacio" "lleno" "vacio" "vacio" "lleno")
((CAJA1 10) (CAJA2 54) (CAJA3 0) (CAJA4 10) (CAJA5 -1) (CAJA6 0) (CAJA4 9320))

[10]> 