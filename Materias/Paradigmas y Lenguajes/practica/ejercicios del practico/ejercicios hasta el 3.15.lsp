
(defun prueba ()
	(let ((x 0))
		(pprint "Escribi algo")
		(setq x (read))
		(pprint "escribiste:")
		(pprint x)
	)
)
;--------------------------------------------------------
;3.1

(defun precioDolar()
    (let((x))
    	(pprint "ingrese la cantidad de pesos: ")
    	(setq x (read))
    	(if (numberp x) (float (/ x 1000)))
	)
)


;------------------------------------------------------

(defun calculovolumen(r h)
	(* (* pi (expt r 2)) h)
)


(defun volumenCilindro()
	(let ((y)(x))
		(print "ingrese radio y un valor")
		(setq y (read))
		(print "ingrese un valor")
		(setq x (read))
		( if(and(numberp y) (numberp x)) (calculovolumen y x))
	)
)     

;--------------------------------------------
;3.2

(defun palindromo()
	(let ((palabra))
		(pprint "ingrese una palabra: ")
		(setq palabra (read))
		(if (and (listp palabra) (equal (reverse palabra) palabra)) 'T) 
	)
)
;-------------------------------------------------
;3.3
(defun clima()
	(let ((x))
		(pprint "ingresa temperatura:")
		(setq x(read))
		(cond
			((not (numberp x)) "no es un numero")
			((< x 0)"helado")
			((< x 10)"frio")
			((< x 20) "templado")
			((< x 30) "calido")
			(t "abrasador")
		)
	)
)

;(clima)----------------------------------------------------
  ; ejercicio 3.4 
(defun mi_segundo()
      (let ((lista)(atomo))
      (pprint "ingrese atomo:")
        (setq atomo(read)) 
      	(pprint "ingrese lista:")
      	(setq lista(read));read sirve para esperar que el usuario ingrese
        (if (and(atom atomo) (consp lista)) (cons atomo lista)
        	(pprint "valores erroneos")
        )
    )
)

;-----------------------------------------
;3.5
(defun ingreso()
	(let ((a)(b)(c))
		(print "ingrese lado a")
		(setq a (read))
		(print "ingrese lado b")
		(setq b (read))
		(print "ingrese lado c")
		(setq c (read))
		   (if (and (< a (+ b c)) (> a (- b c)) (numberp a) (numberp b) (numberp c))
		   	(clasificacion a b c) 
	    ) 
	)
)		   
;x a
;y b
;c z
(defun clasificacion(x y z)
	(cond 
		((and (= x y) (= y z)) (pprint "triangulo equilatero"))
		((or (= x y) (= x z) (= z y)) (pprint "triangulo isoceles"))
        (t (pprint "triangulo escaleno")) 
	)
)

;------------------------------------------------------------------------------------
;3.6
(defun mediano()
     (let ((a) (b) (c))
     (princ "Escribir un numero:")
     (setq a (read))
     (princ "Escribir otro numero:")
     (setq b (read))
     (princ "Escribir un numero mas:")
     (setq c (read))

    (cond
         ((<(MIN a b c) c (MAX a b c)) c)
         ((<(MIN a b c) b (MAX a b c)) b) ; recordar que "<" devuelve true o nil, compara los valores de manera sucesiva
         ((<(MIN a b c) a (MAX a b c)) a))))


;-----------------------------------------------------------------------------

;La máxima temperatura de ayer y las máximas temperaturas de enero y febrero se registran en dos listas
;,max_enero: que contendrá las máximas temperaturas registradas para cada uno de los días de enero
; max_febrero: que contendrá las máximas temperaturas registradas para cada uno de los días de febrero
;definir una función predicado que permita determinar si la temperatura máxima de ayer se registró 
;también en enero o en febrero. (el valor atómico y las dos listas deben ser ingresadas por el 
;operador)

;-------------------------------------------------------------------------
;3.7
;la funcion member busca en el nivel superior de la lista y devuelve la lista, siendo el car ele elemto buscado y el cdr el rest de la lista

(defun buscarTemp (atomico maxEn maxFeb)

    (if (or (member atomico maxEn) (member atomo maxFeb))'T
    )
) 

(defun temperatura()
	(let ((temp) (enero) (febrero))
		(princ "ingrese la temperatura de ayer: ")
		(setq temp(read))
		(princ "ingrese las temperaturas de enero")
		(setq enero(read))
		(princ "ingrese las temperaturas de febrero")
		(setq febrero(read))

		(if (AND (atom temp) (consp enero) (consp febrero))
			(buscarTemp temp enero febrero)
			(pprint "valor invalido")
		)	
	)		
)			


;--------------------------------------------------------------------------
;3.8 yo crei que era asi el 3.8
;desarrollo actividad 2.2
;(setq max_temp '(17 20 30 34 40))
; ¿que temperatura se registra el primer dia del mes?
;(setq tempPdia(car max_temp))
;¿que temperatura registra el ultimo dia del mes?
;(setq ultDiames(last max_temp))
;¿que temperatura se registra el tercer dia del mes?
;(setq tercerdia(nth 2 max_temp))
;¿que temperatura se rgistra el anteultimo dia del mes?
;(setq antultdia(nth 3 max_temp))
;verifica si alguno de los dias del mes su maxi a fue de 40
;(setq buscamaximo(member '40 '(max_temp)))


(defun nuevatemperatura()
	(let((max_temp) (temPdia) (ultDiames) (tercerdia) (antultdia) (buscamaximo))
	(princ "ingrese temperaturas del mes: ")
	(setq max_temp(read))  ; recuerda que se ingresa como lista las temperaturas (7 8 9 10)
    ; ¿que temperatura se registra el primer dia del mes?
    (setq tempPdia(car max_temp))
    ;¿que temperatura registra el ultimo dia del mes?
    (setq ultDiames(car (last max_temp)))
    ;¿que temperatura se registra el tercer dia del mes?
    (setq tercerdia(nth 2 max_temp))
    ;¿que temperatura se rgistra el anteultimo dia del mes?
    (setq antultdia(nth 3 max_temp))
    ;verifica si alguno de los dias del mes su maxi a fue de 40
    (setq buscamaximo(member '40 '(max_temp)))

	  (if (consp max_temp)
		(mostraritems max_temp temPdia ultDiames tercerdia antultdia buscamaximo)
	   )
    )
)

(defun mostraritems(x a b c e g)

  (Format t "la temperatura del primer dia fue de:~A" a)
  (terpri)
  (Format t"temperatura del ultimo dia del mes:~A" b)
  (terpri)
  (Format t"temperatura del tercer dia del mes:~A" c)
  (terpri)
  (Format t"temperatura que se registra el anteultimo dia del mes:~A" e)
  (terpri)
  (Format t"lista desde el dia en que se encontro la temperatura igual a 40:~A" g)
)

  


;3.8 la profe dice que es asi el 3.8


(defun ingresarlista()
	(let ((lista))
		(pprint "ingrese las temperaturas de enero") ;se ingresa asi= (20 10 8 15 17 40 30) porque es lista
		(setq lista(read))
		(if(listp lista)
			(progn
	         (primerTemp lista)
	 	     (ultimaTemp lista)
		     (tercerTemp lista)
		     (anteultimaTemp lista)
		     (maximade40 lista))
	    )
	)   
)


(defun primerTemp(prilista)
	(pprint "¿que temperatura se registra el primer dia del mes?")
	(princ (car prilista))
	(terpri); sirve para salto de linea como el /n
)

(defun ultimaTemp(ultlista)
	(pprint "¿que temperatura se registra el ultimo dia del mes?")
	(princ (car(last ultlista)))
	(terpri)
)

(defun tercerTemp(terlista)
	(pprint "¿que temperatura se registra el tercer dia del mes?")
	(princ (nth 2 terlista))
	(terpri)
)

(defun anteultimaTemp(antlista)
	(pprint "¿que temperatura se registra el anteultimo dia del mes?")
	(princ (nth 5 antlista))
	(terpri)
)

(defun maximade40(maxlista)
	(pprint "lista desde la maxima de 40")
	(princ (member '40 '(maxlista)))
	(terpri)
)

;--------------------------------------------------------------------------------------------------------
;3.9 aun no esta terminado porque no se bien como se hace 

(defun ingresarTemp ()
	(let ((maxTemp))
		(print "Ingrese las temperaturas de Enero (... ...)")
		(setq maxTemp (read))
		(if (listp maxTemp) 
			(funcionesTemp maxTemp)
			(pprint "Error")
		)
	)
)

(defun funcionesTemp (lista)
	(cond
	 ((< 40 (car lista) 45)(pprint "La temperatura del primer dia esta entre 40 y 45 grados")) ;(pprint "La temperatura del primer dia NO esta entre 40 y 45 grados")
     ((not (member '40 lista :TEST-NOT #'>))(pprint "En Enero no hubo dia con máxima de 40 grados")) ;(pprint "En Enero hubo dia con máxima de 40 grados")
	 ((= (car lista) (car (last lista))) (pprint "Las temperaturas del primer y ultimo son iguales")) ;(pprint "Las temperaturas del primer y ultimo NO son iguales")
	)
)
	
   



;----------------------------------------------------------------
;3.10 registro nota alumnos

(defun libreta()

 (let ((a))

   (princ "ingrese numero de libreta y notas de alumnos") ; se ingresa asi:((1 10) (2 8)) etc
   (setq a(read))
   (if (consp a)
  	(informe a)	
 	)
  )
)

(defun informe(x)
	(setq cantidadAlum(length x))
	(Format t "la cantidad de alumnos que hay es de:~A" cantidadAlum)
	(terpri)
	(setq nrolibreta(caar x))
	(Format t "numero de libreta del primer alumno:~A" nrolibreta)
	(terpri)
	(setq notUlt(cadar(last x)))
	(Format t "nota del ultimo alumno de la lista:~A" notUlt)
	(terpri)
    (princ "el primer alumno de la lista regularizo la mteria?")
    (setq regular(cadar x))
    (if(>= regular 6) "si regularizo la materia" "no regularizo la materia")
)
;otra forma para hacer el punto 10:

(defun cant_alumnos(lista)
		(princ "¿Qué cantidad de alumnos hay?: ")
		(princ (length lista))
		(terpri))

	(defun primer_alumno(lista)
		(princ "¿Cuál es el número de libreta del primer alumno de la lista?: ")
		(princ (caar lista))
		(terpri))

	(defun ultimo_alumno(lista)
		(princ "¿Qué nota sacó el último alumno de la lista?: ")
		(princ (cadar (last lista)))
		(terpri))

	(defun estado_regulizacion_primer_alumno(lista)
		(princ "¿Ha regularizado la materia el primer alumno de la lista?: ")
		(if (>= (cadar lista) 6)
			(princ "Regularizó")
			(princ "No regularizó"))
		(terpri))

	(defun notas_alumnos ()
		(let ((lista '()))
			(princ "Ingresar numero de libreta y nota del alumno ((LU NOTA)):")
			(setq lista (read))
			(if(listp lista)
				(progn
					(cant_alumnos lista)
					(primer_alumno lista)
					(ultimo_alumno lista)
					(estado_regulizacion_primer_alumno lista))
				(princ "No es una lista"))))

;----------------------------------------------------------------

	;3.11
(defun lista()
(let ((lista '()))
				(princ "Ingresar elementos en lista: ")
				(setq lista (read))
				(if(listp lista)
					(progn
						(rotar_derecha lista)
						(rotar_izquierda lista)
						)
					(pprint "No es lista"))))


(defun rotar_derecha(lista)
			(terpri)
			(pprint "Rotacion a la derecha: ")
			(pprint (append (cdr lista) (list (car lista))))
            )

		(defun rotar_izquierda(lista)
			(terpri)
			(pprint "Rotacion a la izquierda: ")
			(pprint (append (last lista) (butlast lista)))
            )

		(lista)



;----------------------------------------------------------------

;3.12
;Definir una función llamada posición, que reciba como argumentos un elemento y una lista e 
;indique la posición que ocupa el elemento en la lista

(defun posicion()
	(let ((atomo) (lista '()))
	(pprint "ingrese un elemento: ")
	(setq atomo(read))
	(pprint "ingrese lista: ")
	(setq lista(read))

	(if (and (listp lista)(atom atomo))
	(pprint (position atomo lista))
	(pprint "no es un elemento de la lista")
	)
	)
	)
	
(posicion)

	
;----------------------------------------------------------------

;3.13
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

;----------------------------------------------------------------

;3.14
(defun sirvePino()
(let ((altura 0))
		(princ "Ingresar la altura del pino: ")
		(setq altura (read))
		(if(numberp altura)
			(esPesoUtil (pesoPino altura)))


(defun pesoPino (altura)
  (let ((peso 0))
     (if (<= altura 3)
       (setq peso (* altura 300)) ; 3 kg por cada centímetro hasta 3 metros
        (setq peso (+ (* 300 3) (* 200 (- altura 3))))) ; 3 kg por cada centímetro hasta 3 metros y 2 kg por cada centímetro arriba de los 3 metros
    peso))

(defun esPesoUtil(peso)
	(and (<= 400 peso) (<= peso 1000)))
		

;----------------------------------------------------------------

;3.15
(defun costo_por_persona (cantidad_amigos precio_por_pizza)
  (let* ((porciones_por_pizza 8)
         (porciones_por_persona 3)
         (porciones_totales (* cantidad_amigos porciones_por_persona))
        (pizzas_necesarias (ceiling (/ porciones_totales porciones_por_pizza)))
         (costo_total (* pizzas_necesarias precio_por_pizza)))
    (/ costo_total cantidad_amigos)))

(defun amigos ()
  (let ((cantidad_amigos 0)
        (precio_por_pizza 0))
    (pprint "Ingrese la cantidad de amigos: ")
    (setq cantidad_amigos (read))
    (pprint "Ingrese el precio de una pizza: ")
    (setq precio_por_pizza (read))
    (pprint (format nil "El costo por persona es: $~a" (costo_por_persona cantidad_amigos precio_por_pizza)))))

;---------------------------------------------------------------------------------------------------------------
;; EJEMPLO PARCIAL EJERCICIO N2
(defun total-personas-invitadas	
	(print "ingresar donde se sentaran las personas: ")
	(setq lugar (read))
	(print "ingresar cantidad de personas: ")
	(setq personas (read))
	(print "ingresar cantidad de personas mayores: ")
	(setq mayores (read))
	(print "ingresar cantidad de personas menores: ")
	(setq menores (read))
	(list lugar personas)




(defun calcular-personas (personas)
	(if ((<= personas (* personas 4)
		(print "se pueden acomodar sin agregar sillones"))

		(print "faltan lugares")))





(defun calcular-descuentos(mayores menores)
	(let* ((importeMayor 2500)(importeMenor 1500)
		  (totalMayor (* mayores importeMayor))
		  (totalMenor (* menores importeMenor))
		  (totalsindescuento (+ totalMayor totalMenor))))

	(cond
		((<= mayores 150)(totalsindescuento))
		((and (> mayores 150)(<= mayores 200))(- totalsindescuento (* 0.8 totalsindescuento)))
		((t (- totalsindescuento (* 0.12 totalsindescuento))))

	  )
	)
  )
)
;----------------------------------------------------------------------------------------------------
(defun ingresar-valores()
	(print "ingresar a")
	(setq a (read))
	(print "ingresar b")
	(setq b (read))
	(print "ingresar c")
	(setq c (read))
    

    (print (resolver-cuadratica a b c)))



(defun resolver-cuadratica (a b c)

	(/ (+ b (sqrt (- (* b b) (* 4 a c)))) 
	   (* 2 a))

;-----------------------------------------------------------------------------------------------------------

(defun igresar-datos()
	;kg azucar 80$ y kg cafe 1500
	;1/4 para comprar azucar y el resto para cafe
	(print "ingresar monto de dinero")
	(setq monto (read))
	(print (cantidad-azucar monto))
	(print (comprar2kgcafe monto))


	(defun cantidad-azucar (monto)
		(setq totalkg (/ (/ monto 0.25) 80))
		(format t "el total de kg de azucar que se pueden comprar es:~A"totalkg)
		(list monto totalkg))

	(defun comprar2kgcafe(monto)
		(if ((< monto 3750))
			(t ))
;-----------------------------------------------------------------------------------------
(defun armo (A B)
	(cond 
		((and (consp A) (consp B)) (append A B))
		((and (consp A) (not(consp B))) (list A B))
		((and (not(consp A)) (consp B)) (cons A B))
		(t (list A B))))
		
;------------------------------------------------------------------------------------------
;MODELO DE PARCIAL 2024
;1)
(defun ingresar-datos()
  (print "ingresar a")
  (let ((a (read)))
    (print "ingresar b")
    (let ((b (read)))
      (print "ingresar c")
      (let ((c (read)))
        (if (and (= (+ (* a b) (* a c)) (+ b c)) (/= a 0))
            t
            nil)))))
;-------------------------------------------------------------------------------------------
;; Haga una fución que permita ingresar los datos por un operador acerca del consumo energético de los 3 meses anteriores (cada uno en una variable). Además, tambien debe realizar las siguientes funciones
; 1- Una función que calcule a partir de los parámetros el consumo promedio de energía
; 2- Una función predicado que compruebe si todos los consumos  iguales
; 3- Devolver una lista en la que se indique si el promedio es (menor a 80) bajo, si (mayor a 81 y menor a 120) es medio, o (mayor a 121) alto.        Ejemplo (Bajo 72)

;.....................................................................................................................................................

;punto 1: Realice una función predicado que compuebe si (a + b)/c es igual a/c + b/c, con la condicición de que los elementos sean distintos de cero.				  
(defun ingresar ()
	(print "ingresar a: ")
	(setq a (read))
	(print "ingresar b: ")
	(setq b (read))
	(print "ingresar c: ")
	(setq c (read))
	(pprint (comparar a b c)))

(defun comparar (a b c)
	(and 	(/= a 0)(/= b 0)(/= c 0) 	(= 	(/ (+ a b ) c)	(+ (/ a c) (/ b c)	))));; Haga una fución que permita ingresar los datos por un operador acerca del consumo energético de los 3 meses anteriores (cada uno en una variable). Además, tambien debe realizar las siguientes funciones

;----------------------------------------------------------------------------------------------------------------------------------------------------
;EJERCICIO Nº 3: a) 1,5 pto, al) 2 ptos, a2) 2,5 ptos, a3) 1pto
;Una empresa comercializa diferentes tipos de bidones de agua. El precio del bidón depende de la cantidad de agua que contenga. 
;El bidón de 10 litros cuesta $15.000, El bidón de 20 litros, cuesta el $28.000 y el bidón de 50 litros cuesta $70000, El monto total de la compra será ingresado por el operador.

;a) Definir una función, que permita ingresar el monto total de la compra por parte del operador y llame a
;cada una de las funciones que se solicitan a continuación:

;1. Definir una función, la que a partir del monto ingresado como parámetro, devuelva una lista formada por sublistas. 
;* Cada sublista tendrá como primer elemento un texto que indique el tipo de bidón y como segundo elemento, la cantidad de bidones que se podrían comprar con el monto ingresado para ese tipo de bidón.


;2. El monto total de la compra puede sufrir un descuento que dependerá del siguiente detalle:
;* Si el monto a abonar es menor o igual a $75.000, no sufre descuento
;* Si el monto a abonar varía entre $75.000 y $200.000, sufre un descuento de $30.000
;* Si el monto a abonar es mayor a $200.000, sufre un descuento de $50.000
;Definir una función, la que a partir del monto ingresado como parámetro, devuelva el nuevo monto a abonar.


;3. Definir una función predicado, la que a partir del monto ingresado como parámetro, evalúe si con ese monto se pueden comprar 2 bidones de 10 Its y 4 bidones de 50 litros.

;10L=15k		20L=28k			50L=70k

(defun ingresar ()
  (print "Ingresar monto: ")
  (setq monto (read))

  (if (and (numberp monto) (> monto 0))
		(progn
    		(pprint(lista monto))
			(pprint (descuento monto))
			(pprint (comprar-bidones monto)))))	

	(defun lista (monto)
  	(list (list '10L (truncate (/ monto 15000)))
          (list '20L (truncate (/ monto 28000)))				
          (list '30L (truncate (/ monto 70000)))))

(defun descuento (monto)
  (cond ((< monto 75000) monto)
        ((and (>= monto 75000) (<= monto 200000)) (- monto 30000))
        ((> monto 200000) (- monto 50000))))

(defun comprar-bidones(monto)
	(<= 310000 monto))

;=============================================================================================================
;; Haga una fución que permita ingresar los datos por un operador acerca del consumo energético de los 3 meses anteriores (cada uno en una variable). Además, tambien debe realizar las siguientes funciones
; 1- Una función que calcule a partir de los parámetros el consumo promedio de energía
; 2- Una función predicado que compruebe si todos los consumos  iguales
; 3- Devolver una lista en la que se indique si el promedio es (menor a 80) bajo, si (mayor a 81 y menor a 120) es medio, o (mayor a 121) alto.        Ejemplo (Bajo 72)

(defun ingresar ()
  (let ((mes1) (mes2) (mes3))
    (print "Ingresar el consumo del mes 1: ")
    (setq mes1 (read))
    (print "Ingresar el consumo del mes 2: ")
    (setq mes2 (read))
    (print "Ingresar el consumo del mes 3: ")
    (setq mes3 (read))
    (if (and (numberp mes1) (numberp mes2) (numberp mes3))
        (progn
          (pprint (promedio mes1 mes2 mes3))
          (pprint (iguales mes1 mes2 mes3))
          (pprint (lista (promedio mes1 mes2 mes3))))
        (princ "Alguno de los valores ingresados no es un número"))))

(defun promedio (mes1 mes2 mes3)
  (/ (+ mes1 mes2 mes3) 3))

(defun iguales (mes1 mes2 mes3)
  (= mes1 mes2 mes3))

(defun lista (promedio)
  (cond
    ((< promedio 80) (list 'bajo promedio))
    ((and (>= promedio 80) (< promedio 120)) (list 'medio promedio))
    ((>= promedio 120) (list 'alto promedio))))

--------------------------------------------------------------


(defun procesar-lista-heterogenea ()
	(let ((lista))
	(print "ingresar lista")
	(setq lista (read))
	(if (listp lista)
		(progn 
			(pprint (sublistas-longitud lista))
			(pprint (son-sublistas lista))))))

(defun sublistas-longitud (lista)
	(cond 
		((endp lista)nil)
		((listp (first lista)) (cons (list (first lista)(length (first lista)))	(sublistas-longitud (rest lista))))
		(t (sublistas-longitud (rest lista)))))

(defun son-sublistas (lista)
	(cond
		((endp lista)nil)
		(t(cons (listp (first lista))(son-sublistas (rest lista))))

---------------------------------------------------------------------------

(defun procesar-lista-pares-impares ()
  (let ((lista))
    (print "Ingresar lista:")
    (setq lista (read))
    (if (listp lista)
        (progn
          (let ((resultado (dividir-pares-e-impares lista)))
            (print "Sublistas de pares e impares:")
            (pprint resultado)))
        (print "El input debe ser una lista"))))

(defun dividir-pares-e-impares (lista)
  "Divide una lista en dos sublistas: una de pares y otra de impares."
  (cond
    ((endp lista) (list '() '()))  ; Retorna dos listas vacías cuando la lista está vacía.
    (t
     (let ((resto (dividir-pares-e-impares (rest lista))))
       (if (evenp (first lista))
           (list (cons (first lista) (first resto)) (second resto))
           (list (first resto) (cons (first lista) (second resto))))))))
---------------------------------------------------------------------------

(defun aprobado (notas)
	(cond ((endp notas)t)
		  ((>= (first notas)4)(aprobado (rest notas)))
		  (t nil)
------------------------------------------------------------------------

(defun ingresar()
	(let ((lista))
		(print "ingresar lista")
		(setq lista (read))
		(if (listp lista)
			(progn
				(pprint (unir-listas lista))))))

(defun unir-listas (lista)
	(list (pares lista)(impares lista)))

(defun pares (lista)
	(cond
		((endp lista) nil)
		((and (numberp (first lista))(evenp (first lista)))	(cons (first lista)(pares (rest lista))))
		(t (pares (rest lista)))))

(defun impares (lista)
	(cond
		((endp lista) nil)
		((and (numberp (first lista))(oddp (first lista))) (cons (first lista)(impares (rest lista))))
		(t(impares (rest lista)))))
----------------------------------------------------------------------------------------------------------

(defun ingresar ()
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
		(/ (suma max_temp)(length max_temp))))

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
------------------------------------------------------------------------------------------------------------------

;Actividad Nº 6:
;En la compañía telefónica FunTel modelan la historia de llamadas del usuario mediante una
;lista conteniendo dos sublistas.
;* la primer sublista corresponde al tiempo de duraciones de llamadas (en minutos) en el
;horario normal
;* la segunda sublista corresponde al tiempo de duraciones de llamadas (en minutos) en
;el horario reducido
;Se necesita que desarrollen las siguientes funciones:
;1. cuandoHabloMas, que determine en que horario hablo mas. Si en los dos hablo la
;misma cantidad, responder IGUAL; en q horario hablo mas en el normal o el redu? comparar y si es igual print "igual"
;2. LLamadaMasLarga: que determine cuál fue la llamada más larga y en que horario
;3. LLamadaMasCorta: que determine cuál fue la llamada más corta y en que horario

;RESOLUTION
;1. cuandoHabloMas, que determine en que horario hablo mas. Si en los dos hablo la
;misma cantidad, responder IGUAL; en q horario hablo mas en el normal o el redu? comparar y si es igual print "igual"
(DEFUN SUMA(L)
	(COND
		((END duraciones) 0)
		((NUMBERP (CAR duraciones)) (+(CAR duraciones) (SUMA (CDR duraciones))))
		(T (SUMA (CDR duraciones)))
	)
)

(DEFUN cuandoHabloMas (duraciones)
	(COND 
		((NULL duraciones) NIL)
		((= (SUMA (car duraciones)) (SUMA (cadr duraciones))) 'SON IGUALES)
		((> (SUMA (car duraciones)) (SUMA (cadr duraciones))) 'NORMAL)
		((< (SUMA (car duraciones)) (SUMA (cadr duraciones))) 'REDUCIDO)
		)
	)

;2. LLamadaMasLarga: que determine cuál fue la llamada más larga y en que horario

(DEFUN LLamadaMasLarga (duraciones)
	(COND 
		((NULL duraciones) NIL)
		((not (NUMBERP (car duraciones) (cddr duraciones))) (LLamadaMasLarga (car duraciones) (cddr duraciones)))
		(( > (MAX (car duraciones)) (MAX (cddr duraciones))) 'NORMAL)
		(( > (MAX (cddr duraciones)) (MAX (caar duraciones))) 'REDUCIDO); creo q por descarte ya podemos devolver (T 'REDUCIDO)
		(T (NIL ))	
		)
	);suponiendo que todos son numeros entonces no habria problema ahora si son heterogoneos posiblemente si

;3. LLamadaMasCorta: que determine cuál fue la llamada más corta y en que horario
(DEFUN LLamadaMasLarga (duraciones)
	(COND 
		((NULL duraciones) NIL)
		((not (NUMBERP (car duraciones) (cddr duraciones))) (LLamadaMasLarga (car duraciones) (cddr duraciones)))
		(( < (MIN (car duraciones)) (MIN (cddr duraciones))) 'NORMAL)
		(( < (MIN (cddr duraciones)) (MIN (caar duraciones))) 'REDUCIDO); creo q por descarte ya podemos devolver (T 'REDUCIDO)
		(T (NIL ))	
		)
	);suponiendo que todos son numeros entonces no habria problema ahora si son heterogoneos posiblemente si

------------------------------------------------------------------------------------------------------------------
;ejercicio 6 resulto por mi(no terminado)
(defun ingresar ()
	(let ((normal)(reducido)(lista))
		(print "ingresar la lista con los horarios normal")
		(setq lista read)
		(if (listp lista)
			(progn
				(pprint (cuandoHabloMas normal reducido))
				(pprint (llamadaMasLarga normal reducido))
				
				))))

(defun suma (total)
	(if (endp total)
		0
		(+ (first total)(suma (rest total)))))	


(defun cuandoHabloMas (normal reducido)
	(cond ((or (endp normal)(endp reducido)) nil)
		  ((< (suma reducido) (suma normal)) "hablo mas el horario normal")
		  ((> (suma reducido) (suma normal)) "hablo mas el horario reducido")
		  ((= (suma reducido) (suma normal)) "IGUAL")))


(defun mayor (L A)
	(cond ((endp L)A)
		((> (first L)A) (mayor (rest L)(first L)))
		(t (mayor (rest L)A))))


(defun minimayor (L) (mayor (rest L) (first L)))
;LISTA = ((1 2 3 4 5) (3 1 6 9))

(defun llamadaMasLarga (reducido normal)
	(cond ((< llamadaMasLargareducido llamadaMasLargaNormal) llamadaMasLargaNormal)
		  ((< llamadaMasLargaNormal llamadaMasLargareducido) llamadaMasLargareducido)
		  (t (print "son iguales"))))
;----------------------------------------------------------------------------------------------
;ejercicio 7

(defun ingresar ()
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

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;EJERCICIO 8

(defun valotes-atomicos (lista)
	(cond ((null lista)t)
				((atom (first lista)) (valores-atomicos (rest lista)))
				(t nil)))

(defun cantidadvalores (valor lista)
	(cond ((endp lista)nil)
		    ((>= valor (first lista)) (+ 1 (cantidadvalores (rest lista))))
		    (t (cantidadvalores (rest lista )))

(defun nuevalista (valor lista)
	(cond ((endp lista)nil)
				((< 0 (first lista)) (list (cons (first lista)(/ (first lista) valor ))) (nuevalista valor (rest lista)))
				(t (nuevalista (rest lista)))))
;,..........................................,.................................................................................
;ejercicio 9

(defun ingresar ()
	(let ((lluvia_junio)(lluvia_abril))
	(print "ingresar la lista con las lluvias de abril")
	(setq lluvia_abril (read))
	(print "ingresar la lista con las lluvias de junio")
	(setq lluvia_junio (read))
	(if(and (listp lluvia_junio)(listp lluvia_abril))
			(progn 
       (pprint (cantidad-junio lluvia_junio))
       (pprint (llovio-ultimo-dia lluvia_abril))
       (pprint (mes-mas-lluvia lluvia_abril lluvia_junio)))
			(pprint "ingresar 2 listas"))))

(defun cantidad-junio (lluvia_junio)
	(cond ((endp lluvia_junio) nil)
				((< (first lluvia_junio) 2) (cons (list 'debil) (cantidad-junio (rest lluvia_junio))))
				((and(> (first lluvia_junio) 2)(< (first lluvia_junio) 15))(cons (list 'moderada) (cantidad-junio (rest lluvia_junio))))
				(t(cons (list 'fuerte) (cantidad-junio (rest lluvia_junio))))))


(defun llovio-ultimo-dia (lluvia_abril)
	(if (> (first (last lluvia_abril)) 0)
		  t 
		  nil))


(defun suma(total)
	(if (endp total)
		0
		(+ (first total) (suma (rest total)))))

(defun mes-mas-lluvia (lluvia_junio lluvia_abril)
	(cond (or (endp lluvia_junio)(endp lluvia_abril))
				((< (suma lluvia_junio) (suma lluvia_abril)) (print "llovio mas en abril"))
				((> (suma lluvia_junio) (suma lluvia_abril)) (print "llovio mas en junio"))
				(t (print "llovio lo mismo en ambos meses"))))
				
				





;,..........................................,.................................................................................
;TP5
;ejercicio3

(defun ingresar ()
	(let ((lista))
		(print "ingresar una lista")
		(setq lista (read))
		(if (listp lista)
			(progn (pprint (numerico lista)))
			(print "ingresar una lista"))))


(defun numerico (lista)
	(mapcar 'numberp lista))
;,..........................................,.................................................................................
;TP5
;ejercicio 4
(defun ingresar ()
  (let ((lista))
    (print "Ingresar una lista:")
    (setq lista (read))
    (if (listp lista)
        (progn (pprint (numerico lista)))
        (print "Por favor, ingresar una lista."))))

(defun numerico (lista)
  (mapcar (lambda (x) (if (numberp x) "SI" "NO")) lista))
;
;,..........................................,.................................................................................
;TP5
;ejercicio 5
(defun ingresar ()
  (let ((lista)(numero))
    (print "Ingresar una lista:")
    (setq lista (read))
    (print "Ingrese un numero:")
    (setq numero (read))
    (if (and (listp lista) (not (endp lista)) (numberp numero))
        (progn (pprint (potencia numero lista)))
        (print "Por favor, ingresar una lista."))))

(defun potencia (lista numero)
  (cond ((endp lista) nil)
  			(t (list (cons (first lista) (expt (first lista) numero))) (potencia (rest lista) numero))))

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;ejercicio 5
(defun ingresar ()
  (let ((lista) (numero))
    (print "Ingresar una lista:")
    (setq lista (read))
    (print "Ingrese un numero:")
    (setq numero (read))
    (if (and (listp lista) (not (endp lista)) (numberp numero))
        (progn (pprint (potencia lista numero)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun potencia (lista numero)
  (if (endp lista)
      nil
      (cons (list (first lista) (expt (first lista) numero))(potencia (rest lista) numero))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ejercicio de cuestionario
(defun ingresar ()
  (let ((lista1) (lista2))
    (print "Ingresar una lista:")
    (setq lista1 (read))
    (print "Ingrese una lista:")
    (setq lista2 (read))
    (if (and (listp lista1) (listp lista2))
        (progn (pprint (sublistas-no-sumables lista1 lista2))
        (print "Por favor, ingresar una lista correcta y un número correcto.")))))

(defun sublistas-no-sumables (lista1 lista2)
      (cond 
               ((or (endp lista1) (endp lista2))nil)
               ((or(not(numberp (first lista1)))(not(numberp (first lista2))))
                                           (cons (list (first lista1)(first lista2)))(sublistas-no-sumables (rest lista1)(rest lista2))
                (t (sublistas-no-sumables (rest lista1)(rest lista2))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;tp5
;ejercicio 6 con recursividad

(defun ingresar ()
  (let ((lista))
    (print "Ingresar una lista:")
    (setq lista (read))
    (if (listp lista)
        (progn (pprint (sublistas lista)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun sublistas (lista)
	(cond ((endp lista)nil)
				((< (first lista) 0) (list (cons (first lista)" < 0")) (sublistas (rest lista)))
				((> (first lista) 0) (list (cons (first lista) " > 0")) (sublistas (rest lista)))
				((= (first lista) 0) (list (cons (first lista) " = 0")) (sublistas (rest lista)))
				(t (sublistas (rest lista)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;tp5 ejercicio 6 con mapcar
 
(defun ingreso()
  (let ( (lista) )
    (setq lista (list (read) (read) (read) (read) (read)))
    (nuevaLista lista)
  )
)
 
(defun nuevaLista(lista)
  (mapcar (lambda(x)
      (cond
        ( (not(numberp x)) nil)
        ( (< x 0) (list x '< 0) )
        ( (> x 0) (list x '> 0) )
        ( t (list x '= 0) )
      )
    ) lista
  )
)




;--------------------------------------------------------------------------------------------------------------------------------------------
;tp5
;ejercicio 7

(defun ingresar ()
  (let ((lista))
    (print "Ingresar una lista:")
    (setq lista (read))
    (if (listp lista)
        (progn (pprint (sublistas lista)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun sublistas (lista)
	(cond ((endp lista)nil)
		    ((listp (first lista)) (cons (list (length (first lista))) (sublistas (rest lista))))
		    (t (sublistas (rest lista)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;tp5
;ejercicio 8
(defun ingresar ()
  (let ((lista1)(lista2))
    (print "Ingresar una lista:")
    (setq lista1 (read))
    (print "Ingresar una lista:")
    (setq lista2 (read))
    (if (and (listp lista1)(listp lista2))
        (progn (pprint (sublistas lista1 lista2)))
        (print "Por favor, ingresar una lista correcta y un número correcto."))))

(defun sublistas (lista1 lista2)
	(cond ((or (endp lista1)(endp lista2))nil)
				((not (numberp (first lista1))) (cons (list (first lista1) (last lista2))(sublistas (rest lista1)(reverse (rest (reverse lista2))))))
				(t (sublistas (rest lista1)(reverse (rest (reverse lista2)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;tp5 ejercicio 9
(defun ingresar ()
	(let ((lista1)(lista2))
		(print "ingresar lista1")
		(setq lista1 (read))
		(print "ingresar lista2")
		(setq lista2 (read))
		(if (and (listp lista1) (listp lista2))
			(progn (pprint (suma-ambos lista1 lista2)))
			(print "ingresar 2 listas"))))

(defun suma-ambos (lista1 lista2)
	(cond ((or (endp lista1) (endp lista2))nil)
				((and (numberp (first lista1))(numberp (first lista2))) (cons (+ (first lista1) (first lista2)) (suma-ambos (rest lista1)(rest lista2))))
				(t (suma-ambos (rest lista1)(rest lista2)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
;tp5 ejercicio 10
(defun ingresar ()
	(let ((lista1)(lista2))
		(print "ingresar lista1")
		(setq lista1 (read))
		(print "ingresar lista2")
		(setq lista2 (read))
		(if (and (listp lista1) (listp lista2))
			(progn (pprint (ambos-enteros lista1 lista2)))
			(print "ingresar 2 listas"))))

(defun ambos-enteros (lista1 lista2)
	(cond ((or (endp lista1) (endp lista2))nil)
				((and (integerp (first lista1))(integerp (first lista2))) (cons (+ (first lista1) (first lista2)) (ambos-enteros (rest lista1)(rest lista2))))
				(t (ambos-enteros (rest lista1)(rest lista2)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MODELO DE PARCIAL 2023 TEMA 1

;1)
(defun ingresar ()
	(let ((lista))
		(print " ingresar una lista con sublistas" )
		(setq lista (read))
		(if (listp lista)
			(progn
				(pprint (promedio lista))
				(pprint (nuevalista lista))
				(pprint (lista-con-sublistas lista))
				(pprint (posee-stock lista))
				)
			(print "ingresar una lista con sublistas"))))

;2)
(defun precios (lista)
	(cond ((endp lista) 0)
				((and (listp (first lista)) (numberp (first(rest (first lista))))) (+ (first(rest (first lista))) (precios (rest lista))))
				(t (precios (rest lista)))))

(defun cantidad (lista)
	(cond ((endp lista) 0)
				((and (listp (first lista)) (numberp (first(rest (first lista))))) (+ 1 (cantidad (rest lista))))
				(t (cantidad (rest lista)))))

(defun promedio (lista)
	(float (/ (precios lista) (cantidad lista))))

;3)
(defun nuevalista (lista)
	(cond ((endp lista) nil)
				((and (listp (first lista))( > (first(rest (first lista))) 3000 ))	(cons (list ( first (first lista))) (nuevalista (rest lista))))
				(t (nuevalista (rest lista)))))

;4)		
(defun lista-con-sublistas (lista)
  "Función para etiquetar los precios de los productos."
  (mapcar (lambda (x)
            (cond ((= (second x) 0) (list (first x) 'sin-stock))
                  ((<= (second x) 1000) (list (first x) 'barato))
                  ((> (second x) 1000) (list (first x) 'caro))))
          lista))

;5)
(defun posee-stock (lista)
  "Función para etiquetar los precios de los productos."
  (mapcar (lambda (x)
            (if (= (second x) 0)
            	(list 'sin-stock)
              (list 'con-stock)))
          lista))


;ejemplo:  ((remera 1000) (campera 3000) (pantalon 750) (camperon 5000) (zapato 0) (traje 4100)  (short 1200) (bufanda 0) (sombrero 2000) (guantes 0))
;
;resolucion
;; Ejercicio N° 1:
(defun ingresar-lista()
  (let (l)
    (setq l '(("Pantalon" 3500) ("Pantalon Vaquero" 16000) ("Remera Deportiva" 990) ("Short Deportivo" 500) ("Zapatilla" 15000) ("Ojota" 0)))
    ; (print "Ingrese una lista de sublistas donde nombre de prenda y precio")
    ; (print "Ejemplo ((Nombre1 Precio1) (Nombre2 Precio2)...)")
    ; (setq l (read))
    (print (promedio_precios l))
    (print (lista_prendas l))
    (print (ejer4_mapcar l))
    (print (ejer5_mapcar l))
  )
)

;; Ejercicio N° 2:
(defun suma_precios(l)
  (cond 
    ((endp l) 0)
    ((and (consp (first l)) (numberp (cadar l))) (+ (cadar l) (suma_precios (rest l))))
    (T (suma_precios (rest l)))
  )
)
(defun cantidad_stock(l)
  (cond 
    ((endp l) 0)
    ((and (consp (first l)) (numberp (cadar l)) (> (cadar l) 0)) (+ 1 (cantidad_stock (rest l))))
    (T (cantidad_stock (rest l)))
  )
)
(defun promedio_precios(l)
  (/ (suma_precios l) (cantidad_stock l))
)

;; Ejercicio N° 3:
(defun lista_prendas(l)
  (cond 
    ((endp l) NIL)
    ((and (consp (first l)) (stringp (caar l)) (numberp (cadar l)) (> (cadar l) 3000)) (cons (caar l) (lista_prendas (rest l))))
    (T (lista_prendas (rest l)))
  )
)

;; Ejercicio N° 4:
(defun ejer4_mapcar(l)
  (mapcar (lambda (e)
    (cond
      ((not (numberp (cadr e))) NIL)
      ((= (cadr e) 0) (list (cadr e) "Sin-stock"))
      ((<= (cadr e) 1000) (list (cadr e) "Barato"))
      ((> (cadr e) 1000) (list (cadr e) "Caro"))
    )
  ) l)
)

;; Ejercicio N° 5:
(defun ejer5_mapcar(l)
  (mapcar (lambda (e)
    (and (consp e) (stringp (car e)) (numberp (cadr e)) (= (cadr e) 0))
  ) l)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;MODELO PARCIAL 2023 TEMA 2

 (defun ingresar ()
	(let ((lista)(peso))
		(print " ingresar una lista" )
		(setq lista (read))
		(print " ingresar un peso en kg" )
		(setq peso (read))
		(if (and (listp lista)(numberp peso))
			(progn
				(pprint ( evalua-pesos lista peso))
				(pprint (nuevaLista lista))
				(pprint (peso-menor lista peso))
				(pprint (peso-mayor lista peso))
				(pprint (listas-con-sublistas lista peso))
				)
			(print "ingresar una lista "))))
;1)
(defun evalua-pesos (lista peso)
	(cond ((endp lista) t)
		  ((> (first lista) peso) (evalua-pesos (rest lista) peso))
		  (t nil)))


;2)
(defun lista-kg (lista)
	(cond ((endp lista) nil)
		  ((> (first lista) 30) (cons (first lista) (lista-kg (rest lista))))
		  (t (lista-kg (rest lista)))))

(defun lista-gramos (lista)
	(cond ((endp lista) nil)
		  ((<= (first lista) 30) (cons  (* (first lista) 1000) (lista-gramos (rest lista))))
		  (t (lista-gramos (rest lista)))))

(defun nuevaLista (lista)
	(list (lista-kg lista) (lista-gramos lista)))  

;3)
(defun peso-menor (lista peso)
  (cond ((endp lista) 0)
        ((<= (first lista) peso) (+ 1 (peso-menor (rest lista) peso)))
        (t (peso-menor (rest lista) peso))))


;4)
(defun peso-mayor (lista peso)
  (remove nil (mapcar (lambda (x)
                        (if (> x peso)
                            x
                            nil))
                      lista)))

;5)
(defun listas-con-sublistas (lista peso)
	(remove nil (mapcar (lambda (x)
                        (cond ((<= x 20) (list x "liviano"))
                        	    ((and (>= x 20)(<= x 60)) (list x "pesado"))
                              ((> x 60) (list x "muy pesado"))
                            ))
                      lista)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,
; ejercicio 6 recursividad
 (defun ingresar ()
	(let ((pLista)(pAtomo))
		(print " ingresar una lista" )
		(setq pLista (read))
		(print " ingresar un numero" )
		(setq pAtomo (read))
		(if (and (listp pLista) (numberp pAtomo))
			(progn
				(pprint (cuandoHabloMas pLista))
				(pprint (llamadaMasLarga pLista))
				(pprint (LlamadaMasCorta pLista))
				)
			(print "ingresar una lista "))))


(defun sumarElementosLista(pLista)
			(cond
			((endp pLista) 0)
			((numberp (car pLista))(+ (car pLista)(sumarElementosLista(cdr pLista))))
			(t (sumarElementosLista (cdr pLista)))))
			
			
(defun cuandoHabloMas(pLista)
			(cond
			((> (sumarElementosLista (car pLista)) (sumarElementosLista (cadr pLista))) (pprint "se habla más en el horario normal"))
			((< (sumarElementosLista (car pLista)) (sumarElementosLista (cadr pLista))) (pprint "se habla más en el horario reducido"))
			(t (pprint "iguales"))))
			
			
(defun mayor (pLista pAtomo)
		(cond
		((endp pLista) pAtomo) ;Caso base: si la lista está vacía, devuelve pAtomo
		((> (car pLista) pAtomo) (mayor (cdr pLista) (car pLista))) ;Si el primer elemento de la lista es mayor que pAtomo, llama recursivamente con el resto de la lista y el primer elemento como nuevo pAtomo
		(t (mayor (cdr pLista) pAtomo)))) ;En caso contrario, llama recursivamente con el resto de la lista y pAtomo sin cambios
	
(defun miMayor (pLista)
	(if (endp pLista) NIL
  (mayor (cdr pLista) (car pLista)))) ; Llama a mayor con el resto de la lista y el primer elemento de la lista como pAtomo inicial	

(defun LLamadaMasLarga(pLista)
				(let((normal (car pLista)) (reducido (cadr pLista)))
				(cond
				((> (miMayor normal) (miMayor reducido)) (list (miMayor normal) 'NORMAL))
				((< (miMayor normal) (miMayor reducido)) (list (miMayor reducido) 'REDUCIDO))
				(t (list 'IGUALES)))))
				
(defun miMenor (pLista)
	(if (endp pLista) NIL
  (menor (cdr pLista) (car pLista)))) ; Llama a mayor con el resto de la lista y el primer elemento de la lista como pAtomo inicial	


(defun LlamadaMasCorta(pLista)
				(let ((normal (car pLista)) (reducido (cadr pLista)))
				(cond
				((> (miMenor normal) (miMenor reducido)) (list (miMenor reducido) 'REDUCIDO))
				((< (miMenor normal) (miMenor reducido)) (list (miMenor normal) 'NORMAL))
				(t (list 'IGUALES)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,

;tema1 modelo de 2do parcial
(defun ingresar ()
	(let ((lista))
		(print "ingresar una lista: ")
		(setq lista (read))
		(if (consp lista)
				(progn
					(pprint (filtrarlista lista))
					(pprint (promedio (filtrarlista lista)))
					(pprint (nuevalista (filtrarlista lista)))
					(pprint (sublistas (filtrarlista lista)))
					)
				)))

(defun filtrarlista (lista)
	(cond ((endp lista)nil)
				((and (consp (first lista)) (= (length (first lista)) 2) (numberp (first (rest (first lista))))) (cons (first lista) (filtrarlista (rest lista))))
				(t (filtrarlista (rest lista)))))

(defun precio (lista)
	(if (endp lista)
			0
			(+ (first (rest (first lista))) (precio (rest lista)))))

(defun cantidad (lista)
	(if (endp lista)
			0
			(+ 1 (cantidad (rest lista)))))

;2
	(defun promedio (lista)
		(float (/ (precio lista) (cantidad lista))))


;3 
(defun nuevalista (lista)
	(cond ((endp lista) nil)
				((> (first (rest (first lista))) 3000) (cons (first (first lista)) (nuevalista (rest lista))))
				(t (nuevalista (rest lista)))))

;4
(defun sublistas (lista)
	(mapcar (lambda (x) 
				(cond ((= (first (rest x)) 0) (list "sin-stock" (first (rest x))))
					    ((<= (first (rest x)) 1000) (list "barato" (first (rest x))))
					    ((> (first (rest x)) 1000) (list "caro" (first (rest x))))
		))
	lista))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,
;2do parcial tema 2

(defun ingresar ()
	(let ((lista)(atomo))
	(print "ingresar lista: ")
	(setq lista (read))
	(print "ingresar peso: ")
	(setq atomo (read))
	(if (and (consp lista)(numberp atomo))
		(progn 
			;(pprint (listafiltrada lista))
			(pprint (masde50cajas (listafiltrada lista)))
      (pprint (ultimaCaja (listafiltrada lista) atomo))
      (pprint (cajavacia (listafiltrada lista)))
      (pprint (nuevalista (listafiltrada lista) atomo))
      (pprint (llenoOvacio (listafiltrada lista)))
      (pprint (listafiltrada lista))
      (pprint (maximo(listafiltrada lista)))
      (pprint (minimo(listafiltrada lista)))
			)
			"error")))

;lista filtrada
(defun listafiltrada (lista)
(cond ((endp lista) nil)
			((and (consp (first lista))
				    (numberp (first (rest (first lista))))
				    (= (length (first lista)) 2)) 
			  (cons (first lista) (listafiltrada (rest lista))))
			(t (listafiltrada (rest lista)))))


;2)
(defun masde50cajas (lista)
  (> (length lista) 3))
      

;3)
(defun ultimacaja (lista atomo)
	(if (<= (first (rest (first (last lista)))) atomo) 
		(first (rest (first (last lista))))
		"nil"))


;4)
(defun cajavacia (lista)
	(cond ((endp lista) nil)
				((= (first (rest (first lista))) 0) t)
				(t(cajavacia (rest lista)))))


;5)
(defun nuevalista (lista atomo)
	(cond ((endp lista) nil)
				((< (first (rest (first lista))) atomo) (cons (first lista) (nuevalista (rest lista) atomo)))
				(t (nuevalista (rest lista) atomo))))


;6)

(defun llenoOvacio (lista)
	(mapcar (lambda (x)
				(if (> (first (rest x)) 0)
					"lleno"
					"vacio")
		)
	lista))

;7)maximo
(defun maximo (lista)
	(cond ((endp lista) 0)
				((> (first (rest (first lista))) 0) ( max (first (rest (first lista))) (maximo (rest lista))))
				(t (maximo (rest lista)))))

;8)minimo
(defun minimo (lista)
	(cond ((endp lista) 10000)
				((> (first (rest (first lista))) 0) ( min (first (rest (first lista))) (minimo (rest lista))))
				(t (minimo (rest lista)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun ingresar ()
	(let ((lista1) (lista2) (numero))
		(print "ingresar lista1: ")
		(setq lista1 (read))
		(print "ingresar lista2: ")
		(setq lista2 (read))
		(print "ingresar numero: ")
		(setq numero (read))
		(if (and (consp lista1) (consp lista2) (numberp numero))
				(progn
					(pprint (filtrarlista lista1))
					(pprint (filtrarlista lista2))
					(pprint (mayortotal (filtrarlista lista1) (filtrarlista lista2)))
					(pprint (menortotal (filtrarlista lista1) (filtrarlista lista2)))
					(pprint (nuevalista (filtrarlista lista1) (filtrarlista lista2) numero))
					)
				"error")))


	(defun filtrarlista (lista)
		(cond ((endp lista) nil)
					((numberp (first lista)) (cons (first lista) (filtrarlista (rest lista))))
					(t (filtrarlista (rest lista)))))

	;1)
	   (defun mayor (lista)
	   	(if (endp lista)
	   			0
	   			(max (first lista) (mayor (rest lista)))))

	   (defun mayortotal (lista1 lista2)
	   	(if (> (mayor lista1) (mayor lista2))
	   			(mayor lista1)
	   			(mayor lista2)))


	;2)
	   (defun menor (lista)
	   	(if (endp lista)
	   			10000000
	   			(min (first lista) (menor (rest lista)))))

	   (defun menortotal (lista1 lista2)
	   	(if (< (menor lista1) (menor lista2))
	   			(menor lista1)
	   			(menor lista2)))

	;3
	(defun nuevalista (lista1 lista2 numero)
		(cond ((or (endp lista1) (endp lista2)) 'termino)
					((and (numberp (first lista1))(numberp (first lista2))(> (first lista1) (first lista2) (> (first lista1) numero))) (cons (first lista1) (nuevalista (rest lista1) (rest lista2) numero)))
					((and (numberp (first lista1))(numberp (first lista2))(> (first lista2) (first lista1) (> (first lista2) numero))) (cons (first lista2) (nuevalista (rest lista1) (rest lista2) numero)))
					(t (nuevalista (rest lista1) (rest lista2) numero))))









	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,

