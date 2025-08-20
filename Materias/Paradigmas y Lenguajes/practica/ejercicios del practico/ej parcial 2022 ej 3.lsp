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

[1]> (defun ingresar-datos()
  ;kg azucar 80$ y kg cafe 1500
  ;1/4 para comprar azucar y el resto para cafe
  (print "Ingresar monto de dinero")
  (setq monto (read))
  (setq monto2 monto) ; Copia el valor de monto en monto2
  (print (cantidad-azucar monto))
  (print (comprar2kgcafe monto2)))

(defun cantidad-azucar (monto)
  (setq totalkg (truncate (/ (/ monto 4) 80)))
  (format t "El total de kg de azucar que se pueden comprar es: ~A~%" totalkg)
  (list monto totalkg))

(defun comprar2kgcafe (monto2)
  (if (< monto2 3750)
      "no Alcanza para los 2 kg de café"
      " alcanza para los 2 kg de café"))

INGRESAR-DATOS
[2]> 
CANTIDAD-AZUCAR
[3]> 
COMPRAR2KGCAFE
[4]> (ingresar-datos)

"Ingresar monto de dinero" 3000
El total de kg de azucar que se pueden comprar es: 9

(3000 9) 
"no Alcanza para los 2 kg de café" 
"no Alcanza para los 2 kg de café"
[5]> (ingresar-datos)

"Ingresar monto de dinero" 3750
El total de kg de azucar que se pueden comprar es: 11

(3750 11) 
" alcanza para los 2 kg de café" 
" alcanza para los 2 kg de café"
[6]> 