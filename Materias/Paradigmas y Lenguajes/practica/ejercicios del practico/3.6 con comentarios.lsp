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

[1]> (defun mediano()
  "Encuentra el número mediano de tres números dados."
  (let ((a) (b) (c)) ; Define variables locales a, b y c.
    (princ "Escribir un numero:") ; Solicita al usuario escribir un número.
    (setq a (read)) ; Lee la entrada del usuario y almacena en la variable a.
    (princ "Escribir otro numero:") ; Solicita al usuario escribir otro número.
    (setq b (read)) ; Lee la entrada del usuario y almacena en la variable b.
    (princ "Escribir un numero mas:") ; Solicita al usuario escribir un número más.
    (setq c (read)) ; Lee la entrada del usuario y almacena en la variable c.

    (cond
         ((<(MIN a b c) c (MAX a b c)) c) ; Comprueba si c está entre los extremos (MIN y MAX) y lo devuelve si es así.
         ((<(MIN a b c) b (MAX a b c)) b) ; Comprueba si b está entre los extremos (MIN y MAX) y lo devuelve si es así.
         ((<(MIN a b c) a (MAX a b c)) a)))) ; Comprueba si a está entre los extremos (MIN y MAX) y lo devuelve si es así.


MEDIANO
[2]> (mediano)
Escribir un numero:1
Escribir otro numero:5
Escribir un numero mas:10

5
[3]> 