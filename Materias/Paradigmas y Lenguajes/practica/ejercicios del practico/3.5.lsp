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

[1]> (defun triangulos ()
  "Determina el tipo de triángulo basado en los lados ingresados por el usuario."
  (let ((lado1) (lado2) (lado3)) ; Define las variables locales lado1, lado2 y lado3.
    (print "Ingrese el 1er lado") ; Solicita al usuario ingresar el primer lado del triángulo.
    (setq lado1 (read)) ; Lee la entrada del usuario y almacena en la variable lado1.
    (print "Ingrese el 2do lado") ; Solicita al usuario ingresar el segundo lado del triángulo.
    (setq lado2 (read)) ; Lee la entrada del usuario y almacena en la variable lado2.
    (print "Ingrese el 3er lado") ; Solicita al usuario ingresar el tercer lado del triángulo.
    (setq lado3 (read)) ; Lee la entrada del usuario y almacena en la variable lado3.

    (cond
      ((and (= lado1 lado2) (= lado2 lado3)) "equilatero") ; Comprueba si los tres lados son iguales, en cuyo caso devuelve "equilátero".
      ((or (= lado1 lado2) (= lado1 lado3) (= lado2 lado3)) "isosceles") ; Comprueba si al menos dos lados son iguales, en cuyo caso devuelve "isósceles".
      (t "escaleno")))) ; Si ninguna de las condiciones anteriores se cumple, devuelve "escaleno", ya que todos los lados son diferentes.



TRIANGULOS
[2]> (triangulos)

"Ingrese el 1er lado" 5

"Ingrese el 2do lado" 5

"Ingrese el 3er lado" 5

"equilatero"
[3]> (triangulos)

"Ingrese el 1er lado" 5

"Ingrese el 2do lado" 5

"Ingrese el 3er lado" 10

"isosceles"
[4]> (triangulos)

"Ingrese el 1er lado" 3

"Ingrese el 2do lado" 6

"Ingrese el 3er lado" 9

"escaleno"
[5]> 