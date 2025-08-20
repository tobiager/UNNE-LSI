;;;ROOT: (load "C://Users/Usuario/Desktop/lisp/modelos segundo parcial/tema1.lisp")

(defun ingresoDatos()
    (let ((lista))
        (format t "Ingrese la lista de prendas: ")
        (setq lista (read))

        (if (consp lista)
            (progn
                (princ (promedioPreciosStock lista))
                (terpri)
                (princ (precioMayorA3000 lista))
                (terpri)
                (princ (preciosPrendas lista))
                (terpri)
                (princ (stockDisponible lista))
            )
        )
    )
)

(defun sumaPrecios (l)
    (if (endp l)
        0
        (+ (cadar l) (sumaprecios (cdr l)))
    )
)

(defun contadorDe0 (l)
    (cond
        ((endp l) 0)
        ((= (cadar l) 0)
            (+ 1 (contadorDe0 (cdr l)))
        )
        (t (contadorDe0 (cdr l)))
    )
)

(defun promedioPreciosStock (pLista)
    (cond
        ((> (contadorDe0 pLista) 0)
            (float (/ (sumaprecios plista) (- (length plista) (contadorDe0 pLista))))
        )
        (t (float (/ (sumaprecios plista) (length plista))))
    )
)

;(float (/ (sumaprecios plista) (length plista)))

(defun precioMayorA3000 (pLista)
    (cond
        ((endp plista) nil)
        ((> (cadar plista) 3000)
            (cons (caar pLista) (precioMayorA3000 (cdr pLista)))
        )
        (t (precioMayorA3000 (cdr plista)))
    )
)

(defun preciosPrendas (pLista)
    (mapcar (lambda (l)
            (cond
                ((= (cadr l) 0) (list 0 'SIN-STOCK))
                ((and (> (cadr l) 0) (<= (cadr l) 1000))
                    (list (cadr l) 'BARATO)
                )
                ((> (cadr l) 1000) (list (cadr l) 'CARO))
            )
        ) plista
    )
)

(defun stockDisponible (pLista)
    (mapcar (lambda (l)
            (if (> (cadr l) 0)
                T
                NIL
            )
        ) plista
    )
)

(ingresoDatos)