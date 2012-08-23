;; -*- mode: scheme -*-

;; WAT ON THE WWW

(provide (read display)

(define *window* (js-global "window"))
(define *document* (js-global "document"))
(define *body* (js-prop *document* "body"))

(define getElementById 
  (let ((m (js-method "getElementById")))
    (lambda (str) (m *document* (to-js str)))))

(define createElement
  (let ((m (js-method "createElement")))
    (lambda (name) (m *document* (to-js name)))))

(define createTextNode
  (let ((m (js-method "createTextNode")))
    (lambda (s) (m *document* (to-js s)))))

(define appendChild
  (let ((m (js-method "appendChild")))
    (lambda (e child) (m e child))))

(define scrollTo
  (let ((m (js-method "scrollTo")))
    (lambda (x y) (m *window* x y))))

(define (read-input)
  (let ((res (list* 'begin (read-from-string (from-js (js-prop (getElementById "input") "value"))))))
    (display (strcat "USER> " (from-js (js-prop (getElementById "input") "value"))))
    (js-set-prop! (getElementById "input") "value" (to-js ""))
    res))

(provide (read input-callback)
  (define *env* (current-environment))
  (define *read-k* #f)
  (define (read)
    (take-subcont *top-level* k (set! *env* *read-k* k)))
  (define (input-callback evt)
    (if (num= (from-js (js-prop evt "keyCode")) 13)
        (push-prompt *top-level* (push-subcont *read-k* (read-input)))
        #void)))

(js-set-prop! (getElementById "input") "onkeypress" (js-callback input-callback))

(define (display msg)
  (let ((div (createElement "div")))
    (appendChild div (createTextNode (to-js msg)))
    (appendChild (getElementById "output") div)
    (scrollTo (to-js 0) (js-prop *body* "scrollHeight"))
    msg))

((js-method "focus") (getElementById "input"))

) ; edivorp
