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

[1]> (defun buscarTemp (atomico maxEn maxFeb)
  "Busca la temperatura dada en las listas de temperaturas de enero y febrero."
  (if (or (member atomico maxEn) (member atomico maxFeb)) ; Comprueba si la temperatura dada está presente en alguna de las listas.
      'T  ; Devuelve 'T si la temperatura está presente en alguna de las listas.
      nil)) ; Devuelve nil si la temperatura no está presente en ninguna de las listas.

(defun temperatura()
  "Solicita al usuario ingresar la temperatura de ayer y las temperaturas de enero y febrero."
  (let ((temp) (enero) (febrero)) ; Define las variables locales temp, enero y febrero.
    (princ "Ingrese la temperatura de ayer: ") ; Solicita al usuario ingresar la temperatura de ayer.
    (setq temp (read)) ; Lee la entrada del usuario y la asigna a la variable temp.
    (princ "Ingrese las temperaturas de enero: ") ; Solicita al usuario ingresar las temperaturas de enero.
    (setq enero (read)) ; Lee la entrada del usuario y la asigna a la variable enero.
    (princ "Ingrese las temperaturas de febrero: ") ; Solicita al usuario ingresar las temperaturas de febrero.
    (setq febrero (read)) ; Lee la entrada del usuario y la asigna a la variable febrero.

    (if (and (atom temp) (listp enero) (listp febrero)) ; Comprueba si la temperatura es un átomo y las temperaturas de enero y febrero son listas.
        (buscarTemp temp enero febrero) ; Llama a la función buscarTemp para buscar la temperatura dada en las listas de enero y febrero.
        (print "Valor invalido")))) ; Imprime un mensaje de error si los datos ingresados no son válidos.

;; Ejemplo de uso:
;; (temperatura) ; Esta línea llama a la función temperatura para solicitar al usuario ingresar las temperaturas.


BUSCARTEMP
[2]> 
TEMPERATURA
[3]> (temperatura)
Ingrese la temperatura de ayer: 30
Ingrese las temperaturas de enero:  (30 31 32 33)
Ingrese las temperaturas de febrero: (29 28 27 23)

T
[4]> 