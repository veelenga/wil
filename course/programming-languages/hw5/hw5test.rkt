#lang racket
;; Programming Languages Homework5 Simple Test
;; Save this file to the same directory as your homework file
;; These are basic tests. Passing these tests does not guarantee that your code will pass the actual homework grader

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
(require "hw5.rkt")

(require rackunit)

(define tests
  (test-suite
   "Sample tests for Assignment 5"

   ;; check racketlist to mupllist with normal list
   (check-equal? (racketlist->mupllist (list (int 3) (int 4))) (apair (int 3) (apair (int 4) (aunit)))
                 "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist (list (int 3))) (apair (int 3) (aunit))
                 "racketlist->mupllist test")
   (check-equal? (racketlist->mupllist null) (aunit)
                 "racketlist->mupllist test")
   ;; check mupllist to racketlist with normal list
   (check-equal? (mupllist->racketlist (apair (int 3) (apair (int 4) (aunit)))) (list (int 3) (int 4))
                 "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (apair (int 3) (aunit))) (list (int 3))
                 "racketlist->mupllist test")
   (check-equal? (mupllist->racketlist (aunit)) null
                 "racketlist->mupllist test")

   ;; tests if ifgreater returns (int 2)
   (check-equal? (eval-exp (ifgreater (int 3) (int 4) (int 3) (int 2))) (int 2) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (int 6) (int 4) (int 3) (int 2))) (int 3) "ifgreater test")
   (check-equal? (eval-exp (ifgreater (ifgreater (int 1) (int 0) (int 5) (int 3)) (int 4) (int 3) (int 2))) (int 3)
                           "ifgreater test")
   (check-equal? (eval-exp (ifgreater (ifgreater (int 1) (int 0) (int 3) (int 5)) (int 4) (int 3) (int 2))) (int 2)
                           "ifgreater test")

   ;; mlet test
   (check-equal? (eval-exp (mlet "x" (int 1) (add (int 5) (var "x")))) (int 6) "mlet test")
   (check-equal? (eval-exp (mlet "x" (add (int 2) (int 3)) (add (int 5) (var "x")))) (int 10) "mlet test")

   ;; apair test
   (check-equal? (eval-exp (apair (int 1) (int 2))) (apair (int 1) (int 2)) "apair test")
   (check-equal? (eval-exp (apair (add (int 1) (int 2)) (mlet "x" (int 4) (add (int 1) (var "x")))))
                           (apair (int 3) (int 5)) "apair test")

   ;; fst test
   (check-equal? (eval-exp (fst (apair (int 1) (int 2)))) (int 1) "fst test")
   (check-equal? (eval-exp (fst (apair (add (int 2) (int 3)) (int 2)))) (int 5) "fst test")

   ;; snd test
   (check-equal? (eval-exp (snd (apair (int 1) (int 2)))) (int 2) "snd test")
   (check-equal? (eval-exp (snd (apair (int 1) (add (int 1) (int 2))))) (int 3) "snd test")
   (check-equal? (eval-exp (snd (apair (int 1) (int 2)))) (int 2) "snd test")

   ;; isaunit test
   (check-equal? (eval-exp (isaunit (int 10))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (int 1))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (add (int 1) (int 2)))) (int 0) "isaunit test")
   (check-equal? (eval-exp (isaunit (aunit))) (int 1) "isaunit test")
   (check-equal? (eval-exp (isaunit (closure '() (fun #f "x" (aunit))))) (int 0) "isaunit test")

   ;; call test
   (check-equal? (eval-exp (call (closure '() (fun #f "x" (add (var "x") (int 7)))) (int 1))) (int 8) "call test")
   (check-equal? (eval-exp (call (fun "double" "x" (add (var "x") (var "x"))) (int 7))) (int 14) "call test")
   (check-equal? (eval-exp (call (closure (cons (cons "y" (int 1)) null)
                                          (fun #f "x" (add (var "x") (var "y")))) (int 2)))
                 (int 3) "call test")

   ;; ifaunit test
   (check-equal? (eval-exp (ifaunit (int 1) (int 2) (int 3))) (int 3) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (aunit) (int 2) (int 3))) (int 2) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (aunit) (int 2) (int 3))) (int 2) "ifaunit test")
   (check-equal? (eval-exp (ifaunit (add (int 1) (int 2)) (int 2) (int 3))) (int 3) "ifaunit test")


   ;; mlet* test
   (check-equal? (eval-exp (mlet* (list (cons "x" (int 10))) (var "x"))) (int 10) "mlet* test")


   ;; ifeq test
   (check-equal? (eval-exp (ifeq (int 1) (int 2) (int 3) (int 4))) (int 4) "ifeq test")

   ;; mupl-map test
   (check-equal? (eval-exp (call (call mupl-map (fun #f "x" (add (var "x") (int 7)))) (apair (int 1) (aunit))))
                 (apair (int 8) (aunit)) "mupl-map test")

   ;; problems 1, 2, and 4 combined test
   (check-equal? (mupllist->racketlist
   (eval-exp (call (call mupl-mapAddN (int 7))
                   (racketlist->mupllist
                    (list (int 3) (int 4) (int 9)))))) (list (int 10) (int 11) (int 16)) "combined test")
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
