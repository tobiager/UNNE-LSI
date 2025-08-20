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

[1]> (mapcar 'atom '(a (b) () (()) “AA” 3))

*** - READ-LINE: Invalid byte #x9D in CHARSET:CP1252 conversion
Es posible continuar en los siguientes puntos:
ABORT          :R1      Abort main loop
Break 1 [2]> Abort

[3]> (mapcar 'listp '(a (b) () (()) "AA" 3))

(NIL T T T NIL NIL)
[4]> (mapcar '> '(5 8 3) '(4 9 2))


(T NIL T)
[5]> (mapcar '< '(2 8 3) '(4 9 2) '(5 1 7))

(T NIL NIL)
[6]> (mapcar '> '(5 8 3) '(4 9) '(3 8 1))

(T NIL)
[7]> (mapcar '+ '(1 2) '(3 4) '(2 2))


(6 8)
[8]> (mapcar '- '(1 8) '(3 4) '(2 2 9))

(-4 2)
[9]> (mapcar 'cons '(1 2) '((a b) (3 4) ((7 8))))

((1 A B) (2 3 4))
[10]> (mapcar 'abs '(0 -8 10 3 -2.5 -1/4 ))


(0 8 10 3 2.5 1/4)
[11]> (mapcar 'length '((1 1 1) () ((8)) (a b)))

(3 0 1 2)
[12]> (mapcar 'list '(a b c d))


((A) (B) (C) (D))
[13]> (mapcar 'car '((2 3 4) (a b) ((c)) ) )

(2 A (C))
[14]> 