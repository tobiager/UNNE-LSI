(defun palindromo (lista)
(equal lista (reverse lista))

(let ((ejemplo '(i t a t i))
(forma t "la lista ~a es un palindromo? ~a~%"ejemplo (palindromo ejemplo))