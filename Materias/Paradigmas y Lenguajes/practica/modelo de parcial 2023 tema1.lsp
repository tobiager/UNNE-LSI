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

[1]> ;MODELO DE PARCIAL 2023 TEMA 1

;1)
(defun ingresar ()
	(let ((lista))
		(print " ingresar una lista con sublistas" )
		(setq lista (read))
		(if (listp lista)
			(progn
				(pprint (promedio lista))
				(pprint (nuevalista lista))
				(pprint (lista-con-sublistas lista))
				(pprint (posee-stock lista))
				)
			(print "ingresar una lista con sublistas"))))

;2)
(defun precios (lista)
	(cond ((endp lista) 0)
				((and (listp (first lista)) (numberp (first(rest (first lista))))) (+ (first(rest (first lista))) (precios (rest lista))))
				(t (precios (rest lista)))))

(defun cantidad (lista)
	(cond ((endp lista) 0)
				((and (listp (first lista)) (numberp (first(rest (first lista))))) (+ 1 (cantidad (rest lista))))
				(t (cantidad (rest lista)))))

(defun promedio (lista)
	(float (/ (precios lista) (cantidad lista))))

;3)
(defun nuevalista (lista)
	(cond ((endp lista) nil)
				((and (listp (first lista))( > (first(rest (first lista))) 3000 ))	(cons (list ( first (first lista))) (nuevalista (rest lista))))
				(t (nuevalista (rest lista)))))

;4)		
(defun lista-con-sublistas (lista)
  "Función para etiquetar los precios de los productos."
  (mapcar (lambda (x)
            (cond ((= (second x) 0) (list (first x) 'sin-stock))
                  ((<= (second x) 1000) (list (first x) 'barato))
                  ((> (second x) 1000) (list (first x) 'caro))))
          lista))

;5)
(defun posee-stock (lista)
  "Función para etiquetar los precios de los productos."
  (mapcar (lambda (x)
            (if (= (second x) 0)
            	(list 'sin-stock)
              (list 'con-stock)))
          lista))


INGRESAR
[2]> 
PRECIOS
[3]> 
CANTIDAD
[4]> 
PROMEDIO
[5]> 
NUEVALISTA
[6]> 
LISTA-CON-SUBLISTAS
[7]> 
POSEE-STOCK
[8]> (ingresar)

" ingresar una lista con sublistas" ((remera 1000) (campera 3000) (pantalon 750) (camperon 5000) (zapato 0) (traje 4100)  (short 1200) (bufanda 0) (sombrero 2000) (guantes 0))

1705.0
((CAMPERON) (TRAJE))
((REMERA BARATO) (CAMPERA CARO) (PANTALON BARATO) (CAMPERON CARO) (ZAPATO SIN-STOCK) (TRAJE CARO) (SHORT CARO)
 (BUFANDA SIN-STOCK) (SOMBRERO CARO) (GUANTES SIN-STOCK))
((CON-STOCK) (CON-STOCK) (CON-STOCK) (CON-STOCK) (SIN-STOCK) (CON-STOCK) (CON-STOCK) (SIN-STOCK) (CON-STOCK) (SIN-STOCK))

[9]> 