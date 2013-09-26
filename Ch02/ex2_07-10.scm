;; ex2_07-10.scm
;; Kevin C. Baird
;; SICP
;; Exercise 2.7  - Interval Arithmetic
;; Exercise 2.8  - add sub-interval
;; Exercise 2.9  - add width
;; Exercise 2.10 - add spans-zero? error handling

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mult-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (define (spans-zero? r)
    (define x (lower-bound r))
    (define y (upper-bound r))
    (or
      (and (>= x 0) (<= y 0))
      (and (<= x 0) (>= y 0))))
  (if (spans-zero? x y)
    (raise "Can't divide when spanning zero.")
    (mult-interval x
                   (make-interval (/ 1.0 (upper-bound y))
                                  (/ 1.0 (lower-bound y))))))

(define (make-interval a b) (cons a b))
(define upper-bound cdr)
(define lower-bound car)

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

(define (width x)
  (/ (- (upper-bound x) (lower-bound x)) 2))