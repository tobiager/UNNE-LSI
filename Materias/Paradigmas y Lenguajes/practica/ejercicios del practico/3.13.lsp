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

[1]> ;3.13
	(defun nivelRio()
(let ((alto) (bajo))
(pprint "ingrese el valor mas alto de dispersión: ")
(setq alto(read))
(pprint "ingrese el valor mas bajo de dispersión: ")
(setq bajo(read))

(cond
	((not (numberp (and alto bajo))) 'error)
	((< (- alto bajo) 30 )	(pprint "dias parejos"))
	((> (- alto bajo) 100 )	(pprint "dias locos"))
	(t (pprint "dias ni parejos, ni locos"))
)
)
)
(nivelRio)



NIVELRIO
[2]> 
"ingrese el valor mas alto de dispersión: "10

"ingrese el valor mas bajo de dispersión: "3

"dias parejos"

[3]> (nivelRio)

"ingrese el valor mas alto de dispersión: "100

"ingrese el valor mas bajo de dispersión: "30

"dias ni parejos, ni locos"

[4]> (nivelRio)

"ingrese el valor mas alto de dispersión: "200

"ingrese el valor mas bajo de dispersión: "100

"dias ni parejos, ni locos"

[5]> (nivelRio)

"ingrese el valor mas alto de dispersión: "100

"ingrese el valor mas bajo de dispersión: "100

"dias parejos"

[6]> (nivelRio)

"ingrese el valor mas alto de dispersión: "1000

"ingrese el valor mas bajo de dispersión: "100

"dias locos"

[7]> 