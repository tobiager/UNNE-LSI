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
  (let ((pLista)(pAtomo))
    (print " ingresar una lista" )
    (setq pLista (read))
    (print " ingresar un numero" )
    (setq pAtomo (read))
    (if (and (listp pLista) (numberp pAtomo))
      (progn
        (pprint (cuandoHabloMas pLista))
        (pprint (LLamadaMasLarga pLista))
        (pprint (LlamadaMasCorta pLista))
        )
      (print "ingresar una lista "))))

(defun sumarElementosLista(pLista)
  (cond
    ((endp pLista) 0)
    ((numberp (car pLista)) (+ (car pLista) (sumarElementosLista (cdr pLista))))
    (t (sumarElementosLista (cdr pLista)))))

(defun cuandoHabloMas(pLista)
  (cond
    ((> (sumarElementosLista (car pLista)) (sumarElementosLista (cadr pLista))) (pprint "se habla más en el horario normal"))
    ((< (sumarElementosLista (car pLista)) (sumarElementosLista (cadr pLista))) (pprint "se habla más en el horario reducido"))
    (t (pprint "iguales"))))

(defun mayor (pLista pAtomo)
  (cond
    ((endp pLista) pAtomo)
    ((> (car pLista) pAtomo) (mayor (cdr pLista) (car pLista)))
    (t (mayor (cdr pLista) pAtomo))))

(defun miMayor (pLista)
  (if (endp pLista) NIL
    (mayor (cdr pLista) (car pLista))))

(defun LLamadaMasLarga(pLista)
  (let ((normal (car pLista)) (reducido (cadr pLista)))
    (cond
      ((> (miMayor normal) (miMayor reducido)) (list (miMayor normal) 'NORMAL))
      ((< (miMayor normal) (miMayor reducido)) (list (miMayor reducido) 'REDUCIDO))
      (t (list 'IGUALES)))))

(defun menor (pLista pAtomo)
  (cond
    ((endp pLista) pAtomo)
    ((< (car pLista) pAtomo) (menor (cdr pLista) (car pLista)))
    (t (menor (cdr pLista) pAtomo))))

(defun miMenor (pLista)
  (if (endp pLista) NIL
    (menor (cdr pLista) (car pLista))))

(defun LlamadaMasCorta(pLista)
  (let ((normal (car pLista)) (reducido (cadr pLista)))
    (cond
      ((< (miMenor normal) (miMenor reducido)) (list (miMenor normal) 'NORMAL))
      ((> (miMenor normal) (miMenor reducido)) (list (miMenor reducido) 'REDUCIDO))
      (t (list 'IGUALES)))))


INGRESAR
[2]> 
SUMARELEMENTOSLISTA
[3]> 
CUANDOHABLOMAS
[4]> 
MAYOR
[5]> 
MIMAYOR
[6]> 
LLAMADAMASLARGA
[7]> 
MENOR
[8]> 
MIMENOR
[9]> 
LLAMADAMASCORTA
[10]> (ingresar)

" ingresar una lista" ((1 2 3 4 6 7 8 9 10)( 2 4 6 8 10 12 14 16))

" ingresar un numero" 5

"se habla más en el horario reducido"
NIL
(16 REDUCIDO)
(1 NORMAL)

[11]> 