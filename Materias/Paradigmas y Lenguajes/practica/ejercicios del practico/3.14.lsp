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

[1]> (defun sirvePino()
  ;; Definición de la función sirvePino, la cual solicita la altura del pino al usuario
  (let ((altura 0)) ;; Definición de la variable local altura inicializada en 0
    (princ "Ingresar la altura del pino: ") ;; Imprimir mensaje solicitando la altura del pino
    (setq altura (read)) ;; Leer la entrada del usuario y asignarla a la variable altura
    (if (numberp altura) ;; Verificar si la entrada es un número
        (let ((peso (pesoPino altura))) ;; Calcular el peso del pino usando la función pesoPino
          (if (esPesoUtil peso) ;; Verificar si el peso del pino es útil usando la función esPesoUtil
              (progn ;; Si el peso es útil, mostrar mensajes de felicitación
                (format t "El peso del pino es de ~a kg. ¡Es útil!~%" peso)
                (format t "¡Felicitaciones, tienes un pino útil!~%"))
              ;; Si el peso no es útil, mostrar un mensaje indicándolo
              (format t "El peso del pino es de ~a kg. No es útil.~%" peso)))
        ;; Si la entrada no es un número, mostrar un mensaje de error
        (format t "Debe ingresar un número válido para la altura.~%"))))

(defun pesoPino (altura)
  ;; Definición de la función pesoPino, la cual calcula el peso del pino basado en su altura
  (let ((peso 0)) ;; Definición de la variable local peso inicializada en 0
    (if (<= altura 3) ;; Verificar si la altura del pino es menor o igual a 3 metros
        (setq peso (* altura 300)) ;; Calcular el peso usando 3 kg por cada centímetro hasta 3 metros
        ;; Si la altura es mayor a 3 metros, calcular el peso usando una combinación de 3 kg y 2 kg por centímetro
        (setq peso (+ (* 300 3) (* 200 (- altura 3)))))
    peso)) ;; Devolver el peso calculado del pino

(defun esPesoUtil(peso)
  ;; Definición de la función esPesoUtil, la cual verifica si el peso del pino es útil
  (and (<= 400 peso) (<= peso 1000)))) ;; Devolver true si el peso está entre 400 y 1000 kg, de lo contrario, devolver false


SIRVEPINO
[2]> 
PESOPINO
[3]> 
ESPESOUTIL
[4]> (sirvePino)
Ingresar la altura del pino: 4
El peso del pino es de 1100 kg. No es útil.
NIL
[5]> (sirvePino)
Ingresar la altura del pino: 1
El peso del pino es de 300 kg. No es útil.
NIL
[6]> (sirvePino)
Ingresar la altura del pino: 3
El peso del pino es de 900 kg. ¡Es útil!
¡Felicitaciones, tienes un pino útil!
NIL
[7]> 