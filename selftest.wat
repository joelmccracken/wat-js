(assert (wat-num= ((lambda (x) x) 3) 3))
(assert (wat-num= ((lambda (x) x) (wat-+ 3 4)) 7))
(assert (wat-num= ((lambda (x y) y) 1 (wat-+ 4 5)) 9))
(assert (wat-num= ((lambda (x y) 1 2 3 y) 1 (wat-+ 4 5)) 9))
