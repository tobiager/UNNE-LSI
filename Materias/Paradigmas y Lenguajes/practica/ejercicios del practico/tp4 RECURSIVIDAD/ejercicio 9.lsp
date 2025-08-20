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
	(let ((lluvia_junio)(lluvia_abril))
	(print "ingresar la lista con las lluvias de abril")
	(setq lluvia_abril (read))
	(print "ingresar la lista con las lluvias de junio")
	(setq lluvia_junio (read))
	(if(and (listp lluvia_junio)(listp lluvia_abril))
			(progn 
       (pprint (cantidad-junio lluvia_junio))
       (pprint (llovio-ultimo-dia lluvia_abril))
       (pprint (mes-mas-lluvia lluvia_abril lluvia_junio)))
			(pprint "ingresar 2 listas"))))

(defun cantidad-junio (lluvia_junio)
	(cond ((endp lluvia_junio) nil)
				((< (first lluvia_junio) 2) (cons (list 'debil) (cantidad-junio (rest lluvia_junio))))
				((and(> (first lluvia_junio) 2)(< (first lluvia_junio) 15))(cons (list 'moderada) (cantidad-junio (rest lluvia_junio))))
				(t(cons (list 'fuerte) (cantidad-junio (rest lluvia_junio))))))


(defun llovio-ultimo-dia (lluvia_abril)
	(if (> (first (last lluvia_abril)) 0)
		  t 
		  nil))


(defun suma(total)
	(if (endp total)
		0
		(+ (first total) (suma (rest total)))))

(defun mes-mas-lluvia (lluvia_junio lluvia_abril)
	(cond ((or (endp lluvia_junio)(endp lluvia_abril))nil)
				((< (suma lluvia_junio) (suma lluvia_abril)) (print "llovio mas en abril"))
				((> (suma lluvia_junio) (suma lluvia_abril)) (print "llovio mas en junio"))
				(t (print "llovio lo mismo en ambos meses"))))
				

INGRESAR
[2]> 
CANTIDAD-JUNIO
[3]> 
LLOVIO-ULTIMO-DIA
[4]> 
SUMA
[5]> 
MES-MAS-LLUVIA
[6]> 
(ingresar)

"ingresar la lista con las lluvias de abril" (15 2 10 13 0 14 10 15 5 5 11 6 1 1 8 3 5 5 18 2 11 7 15 4 16 12 16 6 3 4)


"ingresar la lista con las lluvias de junio" (16 0 16 9 2 15 5 1 13 17 6 13 5 12 6 1 10 19 14 1 18 1 16 8 4 1 1 8 9 1)


((FUERTE) (DEBIL) (FUERTE) (MODERADA) (FUERTE) (FUERTE) (MODERADA) (DEBIL) (MODERADA) (FUERTE) (MODERADA) (MODERADA)
 (MODERADA) (MODERADA) (MODERADA) (DEBIL) (MODERADA) (FUERTE) (MODERADA) (DEBIL) (FUERTE) (DEBIL) (FUERTE) (MODERADA)
 (MODERADA) (DEBIL) (DEBIL) (MODERADA) (MODERADA) (DEBIL))
T
"llovio mas en abril" 
"llovio mas en abril"

[7]> (ingresar)

"ingresar la lista con las lluvias de abril" (15 2 10 13 0 14 10 15 5 5 11 6 1 1 8 3 5 5 18 2 11 7 15 4 16 12 16 6 3 0)

"ingresar la lista con las lluvias de junio" (15 2 10 13 0 14 10 15 5 5 11 6 1 1 8 3 5 5 18 2 11 7 15 4 16 12 16 6 3 0)

((FUERTE) (FUERTE) (MODERADA) (MODERADA) (DEBIL) (MODERADA) (MODERADA) (FUERTE) (MODERADA) (MODERADA) (MODERADA) (MODERADA)
 (DEBIL) (DEBIL) (MODERADA) (MODERADA) (MODERADA) (MODERADA) (FUERTE) (FUERTE) (MODERADA) (MODERADA) (FUERTE) (MODERADA)
 (FUERTE) (MODERADA) (FUERTE) (MODERADA) (MODERADA) (DEBIL))
NIL
"llovio lo mismo en ambos meses" 
"llovio lo mismo en ambos meses"

[8]> 