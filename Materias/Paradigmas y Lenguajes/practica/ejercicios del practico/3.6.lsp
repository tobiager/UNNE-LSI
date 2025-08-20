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

[1]> (defun mediano ()
  (print "Ingrese el primer número:")
  (let ((num1 (read)))
    (print "Ingrese el segundo número:")
    (let ((num2 (read)))
      (print "Ingrese el tercer número:")
      (let ((num3 (read)))
        (cond
          ((and (<= num1 num2) (<= num2 num3)) num2)
          ((and (<= num2 num1) (<= num1 num3)) num1)
          (t num3))))))


MEDIANO
[2]> (mediano)

"Ingrese el primer número:" 12

"Ingrese el segundo número:" 42

"Ingrese el tercer número:" 30

30
[3]> 