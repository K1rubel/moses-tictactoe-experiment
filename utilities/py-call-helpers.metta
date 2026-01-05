;; generic str method 
; Helper to get the Python 'str' class
(= (get-str-class)
   (let $builtins (py-call (importlib.import_module builtins))
         (py-call (getattr $builtins str))))

;; accessing python's format string 
(= (py-format $template $arg1)
   (let $str (get-str-class)
         (py-call (.format $str $template $arg1))))

(= (py-format $template $arg1 $arg2)
   (let $str (get-str-class)
         (py-call (.format $str $template $arg1 $arg2))))
         
(= (printf $template $arg1) 
   (println! (py-format $template $arg1)))

(= (printf $template $arg1 $arg2) 
   (println! (py-format $template $arg1 $arg2)))
   
(= (numStr $num) (py-call (str $num)))   
; !(py-format "{} ..." 12345321541)
; !(get-metatype (numStr 3))
