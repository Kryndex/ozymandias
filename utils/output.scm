(define arguments (command-line))
(define pipe (open-output-file (car arguments)))
(define stdio console-i/o-port)
(define delimiter #\newline)
(define *the-environment* (the-environment))
(define silence '*silence*)

(define *id* 0)
(define (get-id)
  (set! *id* (+ 1 *id*))
  *id*)

(define (send . args)
  (assert (> (length args) 1))
  (write-char #\[ pipe)
  (write (car args) pipe)
  (let iter ((arg (cdr args)))
    (write-char #\, pipe)
    (write-string (car arg) pipe)
    (if (pair? (cdr arg)) (iter (cdr arg))))
  (write-char #\] pipe)
  (write-char delimiter pipe)
  (flush-output pipe))
