(define (split-at lst n)
  (begin (define (front lst n)
           (if (or (eq? n 0) (null? lst))
               nil
               (cons (car lst) (front (cdr lst) (- n 1)))))
         (define (back lst n)
           (cond 
             ((null? lst) nil)
             ((eq? n 0)   lst)
             (else        (back (cdr lst) (- n 1)))))
         (cons (front lst n) (back lst n))))
     
(define (square x) (* x x))

(define (add-one x) (+ x 1))

(define (double x) (* x 2))

(define (compose-all funcs)
  (begin (define (helper funcs x)
           (if (null? funcs)
               x
               (helper (cdr funcs) ((car funcs) x))))
         (lambda (x) (helper funcs x))))
