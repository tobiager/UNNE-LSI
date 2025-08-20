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
  (if (or (member atomico maxEn) (member atomico maxFeb))
      'T
      nil))

(defun temperatura()
  (let ((temp) (enero) (febrero))
    (princ "Ingrese la temperatura de ayer: ")
    (setq temp (read))
    (princ "Ingrese las temperaturas de enero: ")
    (setq enero (read))
    (princ "Ingrese las temperaturas de febrero: ")
    (setq febrero (read))

    (if (and (atom temp) (listp enero) (listp febrero))
        (buscarTemp temp enero febrero)
        (print "Valor invalido"))))



BUSCARTEMP
[2]> 
TEMPERATURA
[3]> (temperatura)
Ingrese la temperatura de ayer: 30
Ingrese las temperaturas de enero: (30 31 32 33)
Ingrese las temperaturas de febrero: (29 28 27 23)

T
[4]> 