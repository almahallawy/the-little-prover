;; -*- mode: scheme; geiser-scheme-implementation: guile -*-
;;;; 1. Even Older Games

(load "./j-bob/j-bob-lang.scm")
(load "./j-bob/j-bob.scm")

(if (car (cons a b))
    c
    c)
;; obviously c, by if-same (check below for the axiom)

;;===========The Axioms of If (initial)===============
(dethm if-true (x y)
	(equal (if 't x y) x))

(dethm if-false (x y)
       (equal (if 'nil x y) y))

(dethm if-same (x y)
       (equal (if x y y) y))
;;=====================================================

;; if-same can start with an if-expression and end with variable
;; then it must alos be able to start with a variable and end with if-expression
(if (if (equal a 't)
	(if (equal 'nil 'nil)
	    a
	    b)
	(equal 'or (cons 'black '(coffee))))
    c
    c)
;;=> c

(if (if (equal a 't)
	(if (equal 'nil 'nil)
	    a
	    b)
	(equal 'or (cons 'black '(coffee))))
    c
    c)

;;focus
(cons 'black '(coffee))
;;=> (black coffee)

;;replace (cons 'black '(coffe)) by (black coffee)
(if (if (equal a 't)
	(if (equal 'nil 'nil)
	    a
	    b)
	(equal 'or '(black coffee)))
    c
    c)

;; simplify (equal 'nil 'nil) => 't
(if (if (equal a 't)
	(if 't
	    a
	    b)
	(equal 'or '(black coffee)))
    c
    c)

;; simplify (if 't a b) => a
(if (if (equal a 't)
	a
	(equal 'or '(black coffee)))
    c
    c)
