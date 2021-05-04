;; -*- mode: scheme; geiser-scheme-implementation: guile -*-
;;;; 1. Old Games, New Rules

(load "./j-bob/j-bob-lang.scm")
(load "./j-bob/j-bob.scm")


(car (cons 'ham '(eggs)))
;; 'ham

(car (cons 'ham '(cheese)))
;; hame

(car (cdr (cons 'eggs '(ham))))
;; ham

(car (cons (car '(ham)) '(eggs)))
;; ham

(atom '())
;; 't

(cons a b)
;; Dont know the value

(atom (cons 'ham '(eggs)))
;; nil

(atom (cons a b))
;; we still don't know what a and b are.
;; Nevertheless, we can figure out what value it has because
;; no matter what value the variables a and b have, cons cannot
;; produce an atom


(equal 'flapjack (atom (cons a b)))
;; =>
(equal 'flapjack 'nil)
;; => 'nil

(atom (cdr (cons (car (cons p q)) '())))
;; =>
(atom (cdr (cons p) '()))
;; =>
(atom '())


(atom (cdr (cons (car (cons p q)) '())))
;; =>
(atom '())
;; => t

;;; The Axioms of Cons (initial);;;;;;;;;;;
(dethm atom/cons (x y)
       (equal (atom (cons x y)) 'nil))

(dethm car/cons (x Y)
       (equal (car (cons x y)) x))

(dethm cdr/cons (x y)
       (equal (cdr (cons x y)) y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(car
 (cons (equal (cons x y) (cons x y))
       '(and crumpets)))
;;=>
(car
 (cons 't
       '(and crumpets)))
;;=>
(car '(t and crumpets))
;;=>
't

;;; The Axioms of Equal (initial);;;;;;;;
(dethm equal-same (x)
       (equal (equal x x) 't))

(dethm equal-swap (x y)
       (equal (equal x y) (equal y x)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cons y
      (equal (car (cons (cdr x) (car y)))
	     (equal (atom x) 'nil)))
;; car/cons on (car (cons (cdr x) (car y)))=>
(cons y
      (equal (cdr x)
	     (equal (atom x) 'nil)))
;;------------------
(cons y
      (equal (car (cons (cdr x) (car y)))
	     (equal (atom x) 'nil)))
;; equal to =>
(cons y
      (equal (car (cons
		   (car (cons (cdr x) (car y)))
		   '(oats)))
	     (equal (atom x) 'nil)))
;;-----------------
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    'nil)))
;; use atom/cons to replace 'nil =>
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom (cdr (cons a b)))
			   (equal (cons a b) c))))))
;;----------------------
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom (cdr (cons a b)))
			   (equal (cons a b) c))))))
;; cdr/cons on (cdr (cons a b)) =>
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom b)
			   (equal (cons a b) c))))))

;;------------------
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom b)
			   (equal(cons a b) c))))))
;; equal-swap (equal (cons a b) c)=>
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom b)
			   (equal c (cons a b)))))))


;;;; Using The Law of Dethm

     
;; Frame 62 - car/cons
;; expression
(atom (car (cons (car a) (cdr b))))
;;focus 
(car (cons (car a) (cdr b)))

e1 = (car a)
e2 = (cdr b)
bodye = (equal (car (cons (car a) (cdr b))) (car a))
p = (car (cons (car a) (cdr b)))
q = (car a)
;;replace p by q yields
(atom (car a))


;;Frame 54 - car/cons
;; expression:
(cons y
      (equal (car (cons (cdr x) (car y)))
	     (eqaul (atom x) 'nil)))
;; focus:
(car (cons (cdr x) (car y)))

e1 = (cdr x)
e2 = (car y)
bodye = (equal (car (cons (cdr x) (car y))) (cdr x))
p = (car (cons (cdr x) (car y)))
q = (cdr x)
;; replace p by q yields
(cons y
      (equal (cdr x)
	     (equal (atom x) 'nil)))

;; Frame 55 - car/cons
;; expression:
(cons y
      (equal (car (cons
		   (car (cons (cdr x) (car y)))
		   '(oats)))
	     (equal (atom x) 'nil)))
;; focus:
(car (cons
      (car (cons (cdr x) (car y)))
      '(oats)))

e1 = (car (cons (cdr x) (car y)))
e2 = '(oats)
bodye = (equal (car (cons
		     (car (cons (cdr x) (car y))) '(oats)))
	       (car (cons (cdr x) (car y))))
p = (car (cons
      (car (cons (cdr x) (car y))) '(oats)))
q = (car (cons (cdr x) (car y)))
;; replace p by q yields
(cons y
      (equal (car (cons (cdr x) (car y)))
	     (eqaul (atom x) 'nil)))

;; Frame 66 - atom/cons
;; expression:
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom (cdr (cons a b)))
			   (equal (cons a b) c))))))
;; focus
(atom
 (cons (atom (cdr (cons a b)))
       (equal (cons a b) c)))

e1 = (atom (cdr (cons a b)))
e2 = (equal (cons a b) c)
bodye = (equal (atom (cons
		      (atom (cdr (cons a b)))
		      (equal (cons a b) c)))
	       'nil)
p = (atom (cons
	   (atom (cdr (cons a b)))
	   (equal (cons a b) c)))
q = 'nil

;; replace p by q yields
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    'nil)))

;; Frame 57 - cdr/cons
;; expression
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom (cdr (cons a b)))
			   (equal (cons a b) c))))))
;; focus
(cdr (cons a b))

e1 = a
e2 = b
bodye = (equal (cdr (cons a b)) b)
p = (cdr (cons a b))
q = b

;;replace p by q
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom b)
			   (equal (cons a b) c))))))

;; Fram 59 - equal-swap
;; expression
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom b)
			   (equal(cons a b) c))))))
;; focus
(equal (cons a b) c)

e1 = (cons a b)
e2 = c
bodye = (equal (equal (cons a b) c)
	       (equal c (cons a b)))
p = (equal (cons a b) c)
q = (equal c (cons a b))
;; replace p by q
(cons y
      (equal (car (cons (car (cons (cdr x) (car y)))
			'(oats)))
	     (equal (atom x)
		    (atom
		     (cons (atom b)
			   (equal c (cons a b)))))))

