(define (partial-sums stream)
  'YOUR-CODE-HERE
  (helper 0 stream)
)

(define (helper n stream)
  (cond
    ((null? stream) '())
    (else (cons-stream (+ n (car stream)) (helper (+ n (car stream)) (cdr-stream stream))))
  )
)