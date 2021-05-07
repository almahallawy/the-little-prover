
;; -*- mode: scheme; geiser-scheme-implementation: guile -*-
;;;; Recess

(load "./j-bob/j-bob-lang.scm")
(load "./j-bob/j-bob.scm")

(J-Bob/step (prelude)
	    '(car (cons 'ham '(cheese)))
	    '())
;;=> (car (cons (quote ham) (quote (cheese))))

(J-Bob/step (prelude)
	    '(car (cons 'ham '(cheese)))
	    '((() (car/cons 'ham '(cheese)))))
;;=> (quote ham)

(J-Bob/step (prelude)
    '(equal 'flapjack (atom (cons a b)))
    '(((2) (atom/cons a b))
      (() (equal 'flapjack 'nil))))
;;=> (quote nil)

(J-Bob/step (prelude)
	    '(atom (cdr (cons (car (cons p q)) '())))
	    '(((1 1 1) (car/cons p q))
	      ((1) (cdr/cons p '()))
	      (() (atom '()))))
;;=> (quote t)

(J-Bob/step (prelude)
	    '(if a c c)
	    '())
;;=> (if a c c)

(J-Bob/step (prelude)
	    '(if a c c)
	    '((() (if-same a c))))
;;=> c

