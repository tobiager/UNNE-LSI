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

[1]> (defun procesar-listas ()
  (let ((lista1) (lista2))
    (print "Ingresar lista 1:")
    (setq lista1 (read))
    (print "Ingresar lista 2:")
    (setq lista2 (read))
    
    (if (and (listp lista1) (listp lista2))
        (progn
          (pprint (diferencias-listas lista1 lista2))))))

(defun diferencias-listas (lista1 lista2)
  (if (or (endp lista1) (endp lista2))
      nil
      (cons (- (first lista1) (first lista2))(diferencias-listas (rest lista1) (rest lista2)))))



PROCESAR-LISTAS
[2]> 
DIFERENCIAS-LISTAS
[3]> (procesar-listas)

"Ingresar lista 1:" (3 6 9 12 15)

"Ingresar lista 2:" (1 2 3 4 5)

(2 4 6 8 10)

[4]> 