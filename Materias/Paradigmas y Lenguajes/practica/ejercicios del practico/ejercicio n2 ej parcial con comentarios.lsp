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

[1]> (defun total-personas-invitadas ()
  ;; Solicitar al usuario ingresar el lugar donde se sentarán las personas
  (print "Ingresar donde se sentaran las personas: ")
  ;; Leer la entrada del usuario y asignarla a la variable lugar
  (setq lugar (read))
  ;; Solicitar al usuario ingresar la cantidad de personas en el lugar
  (print "Ingresar cantidad donde se sentaran las personas: ")
  ;; Leer la entrada del usuario y asignarla a la variable lugar-cantidad
  (setq lugar-cantidad (read))	
  ;; Solicitar al usuario ingresar la cantidad de personas
  (print "Ingresar cantidad de personas: ")
  ;; Leer la entrada del usuario y asignarla a la variable personas
  (setq personas (read))
  ;; Solicitar al usuario ingresar la cantidad de personas mayores
  (print "Ingresar cantidad de personas mayores: ")
  ;; Leer la entrada del usuario y asignarla a la variable mayores
  (setq mayores (read))
  ;; Solicitar al usuario ingresar la cantidad de personas menores
  (print "Ingresar cantidad de personas menores: ")
  ;; Leer la entrada del usuario y asignarla a la variable menores
  (setq menores (read))
  ;; Imprimir una lista con el lugar y la cantidad de personas ingresadas
  (print (list lugar lugar-cantidad))
  ;; Imprimir el resultado de la función calcular-personas con el número de personas y lugar-cantidad como argumentos
  (print (calcular-personas personas lugar-cantidad))
  ;; Imprimir el resultado de la función calcular-descuentos con la cantidad de personas mayores y menores como argumentos
  (print (calcular-descuentos mayores menores)))

(defun calcular-personas (personas lugar-cantidad)
  ;; Si la cantidad de personas es menor o igual a 4 veces la cantidad en el lugar,
  ;; devolver "Se pueden acomodar sin agregar sillones", de lo contrario, devolver "Faltan lugares"
  (if (<= personas (* lugar-cantidad 4))
      (format t "Se pueden acomodar sin agregar ~A " lugar)
      (format t "Faltan ~A" lugar)))

(defun calcular-descuentos (mayores menores)
  ;; Definir las variables de importe para personas mayores y menores
  (let* ((importeMayor 2500)
         (importeMenor 1500)
         ;; Calcular el total para personas mayores y menores
         (totalMayor (* mayores importeMayor))
         (totalMenor (* menores importeMenor))
         ;; Calcular el total sin descuento sumando los totales de personas mayores y menores
         (totalSinDescuento (+ totalMayor totalMenor)))
    ;; Aplicar descuentos según la cantidad de personas mayores
    (cond
      ;; Si la cantidad de personas mayores es menor o igual a 150, no hay descuento
      ((<= mayores 150) totalSinDescuento)
      ;; Si la cantidad de personas mayores es mayor a 150 y menor o igual a 200, aplicar un descuento del 8%
      ((and (> mayores 150) (<= mayores 200)) (- totalSinDescuento (* 0.08 totalSinDescuento))(format t "Se descuenta el 8%:~A "totalSinDescuento ))
      ;; Para cualquier otro caso, aplicar un descuento del 12%
      (t (- totalSinDescuento (* 0.12 totalSinDescuento))(format t "Se descuenta el 12%:~A "totalSinDescuento )))))

(total-personas-invitadas) ;; Llamar a la función total-personas-invitadas para comenzar el programa

TOTAL-PERSONAS-INVITADAS
[2]> 
CALCULAR-PERSONAS
[3]> 
CALCULAR-DESCUENTOS
[4]> 
"Ingresar donde se sentaran las personas: " sillas

"Ingresar cantidad donde se sentaran las personas: " 20

"Ingresar cantidad de personas: " 150

"Ingresar cantidad de personas mayores: " 100

"Ingresar cantidad de personas menores: " 50

(SILLAS 20) Faltan SILLAS
NIL 
325000 
325000
[5]> (total-personas-invitadas)

"Ingresar donde se sentaran las personas: " sofas

"Ingresar cantidad donde se sentaran las personas: " 60

"Ingresar cantidad de personas: " 200

"Ingresar cantidad de personas mayores: " 200

"Ingresar cantidad de personas menores: " 0

(SOFAS 60) Se pueden acomodar sin agregar SOFAS 
NIL Se descuenta el 8%:500000 
NIL 
NIL
[6]> (total-personas-invitadas)

"Ingresar donde se sentaran las personas: " bancos

"Ingresar cantidad donde se sentaran las personas: " 100

"Ingresar cantidad de personas: " 400

"Ingresar cantidad de personas mayores: " 250

"Ingresar cantidad de personas menores: " 150

(BANCOS 100) Se pueden acomodar sin agregar BANCOS 
NIL Se descuenta el 12%:850000 
NIL 
NIL
[7]> 