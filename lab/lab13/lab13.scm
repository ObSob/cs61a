; (define quine
;     '(+ 1) 1)

(define quine
        ((lambda (x) (list x (list (quote quote) x)))
         (quote (lambda (x) (list x (list (quote quote) x))))))
