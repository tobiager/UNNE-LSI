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
  (let ((lista) (valor))
    (print "Ingresar la lista")
    (setq lista (read))
    (print "Ingresar valor atómico")
    (setq valor (read))
    (if (and (listp lista) (numberp valor))
        (progn
          (pprint (valores-atomicos lista))
          (pprint (cantidadvalores valor lista))
          (pprint (nuevalista valor lista)))
      (print "Las entradas no son válidas."))))

(defun valores-atomicos (lista)
  (cond ((null lista) t)
        ((numberp (first lista)) (valores-atomicos (rest lista)))
        (t nil)))

(defun cantidadvalores (valor lista)
  (cond ((endp lista) 0)
        ((and (numberp (first lista))(>= valor (first lista))) (+ 1 (cantidadvalores valor (rest lista))))
        (t (cantidadvalores valor (rest lista)))))

(defun nuevalista (valor lista)
  (cond ((endp lista) nil)
        ((and (numberp (first lista))(> (first lista) 0)) (cons (list (first lista) (/ (first lista) valor)) (nuevalista valor (rest lista))))
        (t (nuevalista valor (rest lista)))))

INGRESAR
[2]> 
VALORES-ATOMICOS
[3]> 
CANTIDADVALORES
[4]> 
NUEVALISTA
[5]> (ingresar)

"Ingresar la lista" (2 4 6 8 10 32 34)

"Ingresar valor atómico" 2

T
1
((2 1) (4 2) (6 3) (8 4) (10 5) (32 16) (34 17))

[6]> (ingresar)

"Ingresar la lista" ( 16 ( 2 3) -2 40 S (D F))

"Ingresar valor atómico" 2

NIL
1
((16 8) (40 20))

[7]> 