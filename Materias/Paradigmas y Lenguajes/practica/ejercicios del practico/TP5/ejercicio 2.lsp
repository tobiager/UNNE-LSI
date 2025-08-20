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

[1]> ((lambda (X) (if (> (car X) 0) 'POSITIVO)) '(5 6 7))

POSITIVO
[2]> ((lambda (X) (if (> (car X) 0) 'POSITIVO)) '(-5 6 7))

NIL
[3]> ((lambda (A) (reverse (cdr A))) '((2 3 4) a b c))


(C B A)
[4]> ((lambda (X) (if (numberp (car X)) (* 2 (car X)))) '(5 6 7))

10
[5]> ((lambda (X) (if (and (numberp (car X)) (evenp (car X))) (+ 10 (car X)))) '(4 6 7))

14
[6]> ((lambda (X) (if (and (numberp (car X)) (evenp (car X))) (+ 10 (car X)) 0 )) '(7 6 7))

0
[7]> 