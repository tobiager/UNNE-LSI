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
	(let ((max_temp))
		(print "ingresar la lista con las maximas temperaturas")
		(setq max_temp (read))
		(if (listp max_temp)
			(progn
				(pprint (dias-menores-a-38 max_temp))
				(pprint (temperatura-promedio max_temp))
				(pprint (temperatura-ascendente max_temp))
				(pprint (temperaturas-unicas max_temp))))))

(defun dias-menores-a-38 (max_temp)
	(cond
		((endp max_temp) 0)
		((< (first max_temp)38) (+ 1 (dias-menores-a-38 (rest max_temp))))
		(t (dias-menores-a-38 (rest max_temp)))))

(defun suma (total)
	(if (endp total)
		0
		(+ (first total)(suma (rest total)))))	

(defun temperatura-promedio(max_temp)
	(if (endp max_temp)
		0
		(float (/ (suma max_temp)(length max_temp)))))

(defun temperatura-ascendente (max_temp)
	(cond 
		((or (endp max_temp) (endp (rest max_temp)))t)
		((<= (first max_temp)(second max_temp))	(temperatura-ascendente(rest max_temp)))
		(t nil)))

(defun temperaturas-unicas (max_temp)
	(cond 
		((endp max_temp))
		((member (first max_temp)(rest max_temp))(temperaturas-unicas(remove(first max_temp)(rest max_temp))))
		(t (cons (first max_temp)(temperaturas-unicas (rest max_temp))))))

INGRESAR
[2]> 
DIAS-MENORES-A-38
[3]> 
SUMA
[4]> 
TEMPERATURA-PROMEDIO
[5]> 
TEMPERATURA-ASCENDENTE
[6]> 
TEMPERATURAS-UNICAS
[7]> (ingresar)

"ingresar la lista con las maximas temperaturas" ( 38 39 40 41 39 23 21 20)

3
32.625
NIL
(38 40 41 23 21 20 . T)

[8]> 