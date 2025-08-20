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

[1]> (defun ingresar ()
  (let ((arch_graficos) (arch_texto) (valor))
    (print "Ingresar la lista con la lista de archivos gráficos")
    (setq arch_graficos (read))
    (print "Ingresar la lista con la lista de archivos de texto")
    (setq arch_texto (read))
    (print "Ingresar valor atómico")
    (setq valor (read))
    (if (and (listp arch_graficos) (listp arch_texto))
        (progn
          (pprint (igualdadArchivos arch_graficos))
          (pprint (mas-espacio arch_graficos arch_texto))
          (pprint (nuevalista valor arch_graficos arch_texto)))
      (print "Las entradas no son listas válidas."))))

(defun igualdadArchivos (arch_graficos)
  (cond 
    ((endp arch_graficos) nil)
    ((= (first arch_graficos) (first (last arch_graficos))) t)
    (t nil)))

(defun suma (total)
  (if (endp total)
      0
      (+ (first total) (suma (rest total)))))

(defun mas-espacio (arch_graficos arch_texto)
  (cond ((and (endp arch_graficos) (endp arch_texto)) nil)
        ((> (suma arch_graficos) (suma arch_texto)) "Los archivos gráficos son mayores")
        ((< (suma arch_graficos) (suma arch_texto)) "Los archivos de texto son mayores")
        (t "Usan el mismo espacio")))

(defun nuevalista (valor arch_graficos arch_texto)
  (cond ((or (endp arch_graficos) (endp arch_texto)) nil)
        ((< valor (+ (first arch_texto) (first arch_graficos))) (cons (+ (first arch_texto) (first arch_graficos)) (nuevalista valor (rest arch_graficos) (rest arch_texto))))
        (t (nuevalista valor (rest arch_graficos) (rest arch_texto)))))


INGRESAR
[2]> 
IGUALDADARCHIVOS
[3]> 
SUMA
[4]> 
MAS-ESPACIO
[5]> 
NUEVALISTA
[6]> (ingresar)

"Ingresar la lista con la lista de archivos gráficos" (1 2 3 4 5)

"Ingresar la lista con la lista de archivos de texto" (1 2 3 4)

"Ingresar valor atómico" 3

NIL
"Los archivos gráficos son mayores"
(4 6 8)

[7]> (ingresar)

"Ingresar la lista con la lista de archivos gráficos" (1 2 3 4 5 1)

"Ingresar la lista con la lista de archivos de texto" (1 2 3 4 5)

"Ingresar valor atómico" 3

T
"Los archivos gráficos son mayores"
(4 6 8 10)

[8]> 