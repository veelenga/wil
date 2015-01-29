
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

; problem 1
(define (sequence low high stride)
  (if (< high low)
      null
      (cons low (sequence (+ low stride) high stride))))

; problem 2
(define (string-append-map xs suffix)
  (map (lambda (i) (string-append i suffix)) xs))

; problem 3
(define (list-nth-mod xs n)
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

; problem 4
(define (stream-for-n-steps s n)
  (let ([pr (s)])
  (cond [(< n 1) null]
        [(= n 1) (list (car pr))]
        [#t (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1)))])))

; problem 5
(define (funny-number-stream)
  (define (th x)
    (cons (if (= (remainder x 5) 0) (- x) x)
          (lambda() (th (+ x 1)))))
  (th 1))

; problem 6
(define (dan-then-dog)
  (define (th x)
    (cons (if (even? x) "dog.jpg" "dan.jpg")
          (lambda () (th (+ x 1)))))
  (th 1))

; problem 7
(define (stream-add-zero s)
  (define (th x)
    (cons (cons 0 (car (x)))
          (lambda () (th (cdr (x))))))
  (lambda () (th s)))

; problem 8
(define (cycle-lists xs ys)
  (define (th n)
    (cons (cons (list-nth-mod xs n)
                (list-nth-mod ys n))
          (lambda () (th (+ n 1)))))
  (lambda () (th 0)))

; problem 9
(define (vector-assoc v vec)
  (define (f p)
    (if (>= p (vector-length vec))
      #f
      (let ([val (vector-ref vec p)])
          (cond [(not (pair? val)) (f (add1 p))]
                [(equal? v (car val)) val]
                [#t (f (add1 p))]))))
  (f 0))

; problem 10
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [slot 0]
           [fun (lambda (x)
                  (let ([ans (vector-assoc x memo)])
                    (if ans
                      ans
                      (let ([new-ans (assoc x xs)])
                        (begin
                          (vector-set! memo slot new-ans)
                          (if (< slot (- n 1))
                            (set! slot (add1 slot))
                            (set! slot 0))
                          new-ans)))))])
  fun))
