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

[1]> ;3.15
(defun costo_por_persona (cantidad_amigos precio_por_pizza)
  (let* ((porciones_por_pizza 8)
         (porciones_por_persona 3)
         (porciones_totales (* cantidad_amigos porciones_por_persona))
        (pizzas_necesarias (ceiling (/ porciones_totales porciones_por_pizza)))
         (costo_total (* pizzas_necesarias precio_por_pizza)))
    (/ costo_total cantidad_amigos)))

(defun amigos ()
  (let ((cantidad_amigos 0)
        (precio_por_pizza 0))
    (pprint "Ingrese la cantidad de amigos: ")
    (setq cantidad_amigos (read))
    (pprint "Ingrese el precio de una pizza: ")
    (setq precio_por_pizza (read))
    (pprint (format nil "El costo por persona es: $~a" (costo_por_persona cantidad_amigos precio_por_pizza)))))

COSTO_POR_PERSONA
[2]> 
AMIGOS
[3]> (amigos)

"Ingrese la cantidad de amigos: "3

"Ingrese el precio de una pizza: "120

"El costo por persona es: $80"

[4]> 