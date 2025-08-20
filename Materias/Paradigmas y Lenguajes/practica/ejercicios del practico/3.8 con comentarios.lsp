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

[1]> (defun temperatura-primer-dia (max_temp)
  "Devuelve la temperatura registrada en el primer día del mes."
  (first max_temp)) ; Devuelve el primer elemento de la lista de temperaturas.

(defun temperatura-ultimo-dia (max_temp)
  "Devuelve la temperatura registrada en el último día del mes."
  (nth (- (length max_temp) 1) max_temp)) ; Devuelve el último elemento de la lista de temperaturas.

(defun temperatura-tercer-dia (max_temp)
  "Devuelve la temperatura registrada en el tercer día del mes."
  (nth 2 max_temp)) ; Devuelve el tercer elemento de la lista de temperaturas.

(defun temperatura-anteultimo-dia (max_temp)
  "Devuelve la temperatura registrada en el anteúltimo día del mes."
  (nth (- (length max_temp) 2) max_temp)) ; Devuelve el anteúltimo elemento de la lista de temperaturas.

(defun obtener-temperaturas ()
  "Solicita al usuario ingresar la lista de máximas temperaturas de enero y muestra algunas temperaturas específicas."
  (print "Ingrese la lista de máximas temperaturas de enero:") ; Solicita al usuario ingresar la lista de temperaturas.
  (let ((max_temp (read))) ; Lee la entrada del usuario y almacena en max_temp.
    (print "Temperatura del primer día:") ; Imprime un mensaje indicando que se mostrará la temperatura del primer día.
    (print (temperatura-primer-dia max_temp)) ; Llama a la función temperatura-primer-dia para obtener la temperatura del primer día y la muestra.
    (print "Temperatura del último día:") ; Imprime un mensaje indicando que se mostrará la temperatura del último día.
    (print (temperatura-ultimo-dia max_temp)) ; Llama a la función temperatura-ultimo-dia para obtener la temperatura del último día y la muestra.
    (print "Temperatura del tercer día:") ; Imprime un mensaje indicando que se mostrará la temperatura del tercer día.
    (print (temperatura-tercer-dia max_temp)) ; Llama a la función temperatura-tercer-dia para obtener la temperatura del tercer día y la muestra.
    (print "Temperatura del anteúltimo día:") ; Imprime un mensaje indicando que se mostrará la temperatura del anteúltimo día.
    (print (temperatura-anteultimo-dia max_temp))))) ; Llama a la función temperatura-anteultimo-dia para obtener la temperatura del anteúltimo día y la muestra.

;; Ejemplo de uso:
;; (obtener-temperaturas) ; Esta línea llama a la función obtener-temperaturas para probar el código.


TEMPERATURA-PRIMER-DIA
[2]> 
TEMPERATURA-ULTIMO-DIA
[3]> 
TEMPERATURA-TERCER-DIA
[4]> 
TEMPERATURA-ANTEULTIMO-DIA
[5]> 
OBTENER-TEMPERATURAS
[6]> (obtener-temperaturas)

"Ingrese la lista de máximas temperaturas de enero:" (30 43 39 38 36 23 21 38)

"Temperatura del primer día:" 
30 
"Temperatura del último día:" 
38 
"Temperatura del tercer día:" 
39 
"Temperatura del anteúltimo día:" 
21 
21
[7]> 