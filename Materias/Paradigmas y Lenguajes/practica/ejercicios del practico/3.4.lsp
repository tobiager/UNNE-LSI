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

[1]> (defun mi_segundo()
  "Devuelve una lista que consiste en el segundo elemento seguido por el primer elemento."
  (let ((lista) (atomo)) ; Define las variables locales lista y atomo.
    (pprint "Ingrese atomo:") ; Solicita al usuario ingresar un átomo.
    (setq atomo (read)) ; Lee la entrada del usuario y almacena en la variable atomo.
    (pprint "Ingrese lista:") ; Solicita al usuario ingresar una lista.
    (setq lista (read)) ; Lee la entrada del usuario y almacena en la variable lista.

    (if (and (atom atomo) (consp lista)) ; Comprueba si atomo es un átomo y lista es una lista.
        (cons atomo lista) ; Si ambas condiciones son verdaderas, devuelve una lista que consiste en el segundo elemento seguido por el primer elemento.
        (pprint "Valores erróneos")))) ; Si las condiciones no se cumplen, imprime un mensaje de error.



MI_SEGUNDO
[2]> (mi_segundo)

"Ingrese atomo:"10

"Ingrese lista:"( 1 2 3 4 5)

(10 1 2 3 4 5)
[3]> 