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

[1]> ;tema1 modelo de 2do parcial
(defun ingresar ()
	(let ((lista))
		(print "ingresar una lista: ")
		(setq lista (read))
		(if (consp lista)
				(progn
					(pprint (filtrarlista lista))
					(pprint (promedio (filtrarlista lista)))
					(pprint (nuevalista (filtrarlista lista)))
					(pprint (sublistas (filtrarlista lista)))
					)
				)))

(defun filtrarlista (lista)
	(cond ((endp lista)nil)
				((and (consp (first lista)) (= (length (first lista)) 2) (numberp (first (rest (first lista))))) (cons (first lista) (filtrarlista (rest lista))))
				(t (filtrarlista (rest lista)))))

(defun precio (lista)
	(if (endp lista)
			0
			(+ (first (rest (first lista))) (precio (rest lista)))))

(defun cantidad (lista)
	(if (endp lista)
			0
			(+ 1 (cantidad (rest lista)))))

;2
	(defun promedio (lista)
		(float (/ (precio lista) (cantidad lista))))


;3 
(defun nuevalista (lista)
	(cond ((endp lista) nil)
				((> (first (rest (first lista))) 3000) (cons (first (first lista)) (nuevalista (rest lista))))
				(t (nuevalista (rest lista)))))

;4
(defun sublistas (lista)
	(mapcar (lambda (x) 
				(cond ((= (first (rest x)) 0) (list "sin-stock" (first (rest x))))
					    ((<= (first (rest x)) 1000) (list "barato" (first (rest x))))
					    ((> (first (rest x)) 1000) (list "caro" (first (rest x))))
		))
	lista))

INGRESAR
[2]> 
FILTRARLISTA
[3]> 
PRECIO
[4]> 
CANTIDAD
[5]> 
PROMEDIO
[6]> 
NUEVALISTA
[7]> 
SUBLISTAS
[8]> (ingresar)

"ingresar una lista: " ((remera 1000) (panti 3000) (adifoam 10000) a (chaqueta 6500) (30000 casa) (media 300))

((REMERA 1000) (PANTI 3000) (ADIFOAM 10000) (CHAQUETA 6500) (MEDIA 300))
4160.0
(ADIFOAM CHAQUETA)
(("barato" 1000) ("caro" 3000) ("caro" 10000) ("caro" 6500) ("barato" 300))

[9]> 