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

[1]> (defun procesar-lista-pares-impares ()
  (let ((lista))                           ; Declara una variable para almacenar la lista.
    (print "Ingresar lista:")              ; Solicita al usuario que ingrese una lista.
    (setq lista (read))                    ; Lee la lista ingresada por el usuario.
    (if (listp lista)                      ; Verifica si la entrada es una lista.
        (progn
          (let ((resultado (dividir-pares-e-impares lista)))  ; Llama a dividir-pares-e-impares y almacena el resultado.
            (print "Sublistas de pares e impares:")           ; Imprime un mensaje antes del resultado.
            (pprint resultado)))           ; Imprime el resultado en un formato legible.
        (print "El input debe ser una lista"))))  ; Si la entrada no es una lista, muestra un mensaje de error.

(defun dividir-pares-e-impares (lista)
  "Divide una lista en dos sublistas: una de pares y otra de impares."
  (cond
    ((endp lista) (list '() '()))  ; Retorna dos listas vacías cuando la lista está vacía.
    (t
     (let ((resto (dividir-pares-e-impares (rest lista))))  ; Llama recursivamente con el resto de la lista.
       (if (evenp (first lista))   ; Verifica si el primer elemento de la lista es par.
           (list (cons (first lista) (first resto)) (second resto))  ; Si es par, lo agrega a la primera sublista.
           (list (first resto) (cons (first lista) (second resto))))))))  ; Si es impar, lo agrega a la segunda sublista.


PROCESAR-LISTA-PARES-IMPARES
[2]> 
DIVIDIR-PARES-E-IMPARES
[3]> (procesar-lista-pares-impares)

"Ingresar lista:" (1 2 3 4 5 13 27 81 93 66 69)

"Sublistas de pares e impares:" 
((2 4 66) (1 3 5 13 27 81 93 69))

[4]> 