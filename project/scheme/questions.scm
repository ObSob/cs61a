(define (caar x) (car (car x)))

(define (cadr x) (car (cdr x)))

(define (cdar x) (cdr (car x)))

(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement
(define (zip-all pairs)
  (if (or (eq? pairs nil) (eq? (car pairs) nil))
      nil
      (begin (define (zip-who fn pairs)
               (let ((ls (car pairs))
                     (rs (cdr pairs)))
                 (cons (fn ls)
                       (if (eq? rs nil)
                           nil
                           (zip-who fn rs)))))
             (cons (zip-who car pairs)
                   (zip-all (zip-who cdr pairs))))))

; zip two pairs
(define (zip s)
  (if (eq? s nil)
      '(() ())
      (cons (cons (caar s) (car (zip (cdr s))))
            (cons (cons (car (cdar s)) (cadr (zip (cdr s))))
                  nil))))

; ; Problem 15
; ; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (begin (define (build s num)
           (if (null? s)
               nil
               (cons (cons num (cons (car s) nil))
                     (build (cdr s) (+ num 1)))))
         (build s 0)))

; END PROBLEM 15
; ; Problem 16
; ; Merge two lists LIST1 and LIST2 according to COMP and return
; ; the merged lists.
(define (merge comp list1 list2)
  ; BEGIN PROBLEM 16
  (cond 
    ((and (null? list1) (null? list2))
     nil)
    ((null? list2)
     list1)
    ((null? list1)
     list2)
    ((comp (car list1) (car list2))
     (cons (car list1) (merge comp (cdr list1) list2)))
    (else
     (cons (car list2) (merge comp list1 (cdr list2))))))

; END PROBLEM 16
(merge < '(1 5 7 9) '(4 8 10))

; expect (1 4 5 7 8 9 10)
(merge > '(9 7 5 1) '(10 8 4 3))

; expect (10 9 8 7 5 4 3 1)
; ; Problem 17
(define (nondecreaselist s)
  ; BEGIN PROBLEM 17
  (begin (define (len-inc s)
           (cond 
             ((eq? s nil)
              0)
             ((or (eq? (cdr s) nil) (> (car s) (cadr s)))
              1)
             (else
              (+ 1 (len-inc (cdr s))))))
         (define (cut-pre s num)
           (cond 
             ((= num 0)
              nil)
             ((eq? s nil)
              nil)
             (else
              (cons (car s) (cut-pre (cdr s) (- num 1))))))
         (define (cut-suf s num)
           (cond 
             ((= num 0)   s)
             ((eq? s nil) s)
             (else        (cut-suf (cdr s) (- num 1)))))
         (if (eq? s nil)
             nil
             (let ((len (len-inc s)))
               (cons (cut-pre s len)
                     (nondecreaselist (cut-suf s len)))))))

; END PROBLEM 17
; ; Problem EC
; ; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))

(define define? (check-special 'define))

(define quoted? (check-special 'quote))

(define let? (check-special 'let))

; ; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond 
    ((atom? expr)
     ; BEGIN PROBLEM EC
     expr
     ; END PROBLEM EC
    )
    ((quoted? expr)
     ; BEGIN PROBLEM EC
     expr
     ; END PROBLEM EC
    )
    ((or (lambda? expr) (define? expr))
     (let ((form (car expr))
           (params (cadr expr))
           (body (cddr expr)))
       ; BEGIN PROBLEM EC
       (cons form (cons params (let-to-lambda body)))
       ; END PROBLEM EC
     ))
    ((let? expr)
     (let ((values (cadr expr))
           (body (cddr expr)))
       ; BEGIN PROBLEM EC
       (let ((params (zip values)))
            (cons (cons 'lambda (cons (car params) (cons (let-to-lambda (car body)) nil))) (let-to-lambda (car (cdr params)))))
       ; END PROBLEM EC
     ))
    (else
     ; BEGIN PROBLEM EC
     (map let-to-lambda expr)
     ; END PROBLEM EC
    )))
