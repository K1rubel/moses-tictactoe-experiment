(= (curry2 $f $x $y $z)($f $x $y $z))

(= (compose $g $f $x)($g ($f $x)))

(= (isUnit $expr) (== $expr ()))

(= (concatTuple $x $y) (union-atom $x $y))

(= (exprToList $expr)
    (if (== $expr ())
        Nil
        (let ($head $tail) (decons-atom $expr)  (Cons $head (exprToList $tail)))
    )
)

(= (range $n)
    (if (== $n 0)
        ()
        (let $rest (range (- $n 1)) (append $rest ($n)))))
; !(range 1)

(= (if-decons-expr-custom $list $h $t $then $else)
      (if (or (== $list ()) (not (== (get-metatype $list) Expression)))
            $else
            (let* (
                  ($h (car-atom $list))
                  ($t (cdr-atom $list))
                  )
                (eval $then)
            )
            ))

(= (expToMMap () $map $compFunc) NilMMap)
(= (expToMMap $tuple $map $compFunc)
    (let*
    (
        (($head $tail) (decons-atom $tuple))
        ($updatedMap (eval (MultiMap.insert $head $map $compFunc)))

    )
(if (== $tail ()) $updatedMap (eval (expToMMap $tail $updatedMap $compFunc)))))

;; I think this thing has the same purpose as built in append
(= (concatT $expr1 $expr2)
    (if (== $expr1 ())
        $expr2
        (let*
            (
            ($head (car-atom $expr1))
            ($tail (concatT (cdr-atom $expr1) $expr2))
            )
            (cons-atom $head $tail)
        )))

(= (biasedRandomInt)
   (if (== (random-int 0 2) 0)  ; 50% chance
       0
       (random-int 1 3)))         
       
(= (updateID (mkNodeId $id)) 
    (if (== (car-atom $id) 0)
        (mkNodeId (cdr-atom $id))
        (mkNodeId $id)

    ))

(= (map $f $xs)
   (if (== $xs ())
       ()
       (let* (($h (car-atom $xs))
              ($t (cdr-atom $xs))
              ($fh ($f $h))
              ($ft (map $f $t)))
         (cons-atom $fh $ft))))    

(= (add ($ctor $a) ($ctor $b))
     (if (== (get-type $a) Number)
            ($ctor (+ $a $b))
            (Error ($a or $b) "One of the argument is not a number")))

(= (genList $u) (genList 0 $u))
;;
; (: genList (-> Number Number Expression))
(= (genList $l $u)
    (if (< $u $l)
        ()
        (let $res (genList $l (- $u 1))
            (cons-atom $u $res) )))

(= (selectionSort $list $n) (selectionSort $list $n <))
; (: selectionSort (-> Expression Number (-> $a $a Bool) Expression))
(= (selectionSort $list $n $op)
    (if (or (== $n 0) (== $list ()))
        $list
     (let* (
        ($initial (car-atom $list))
        ($cur (selector $list $initial $op))
        ($newList (subtraction-atom $list ($cur))) ;since the subtractionAtom (the custom one) isn't working now but this subtraction-atom does same thing.
        ($rest (selectionSort $newList (- $n 1) $op))
    )
    (cons-atom $cur $rest)
    )))  
    
(= (selector $expr $op) (selector $expr (car-atom $expr) $op) )
; (: selector (-> Expression $a (-> $a $a Bool) $a))
;;for the petta foldl-atom doesn't works for nested list(lists or expression inside list) a custom method re-implemented for the selector helper.
(= (selector $expr $i $op)
(if (== $expr ())
     $i
     (let*  (
             ($head (car-atom $expr))
             ($tail (cdr-atom $expr))
              ($result (comparator $head $i $op))
            )
          (selector $tail $result $op))
)
)

(= (comparator $x $y $op) (if ($op $x $y) $x $y))


;; Compare in apply by shape; no collection support here

;; ============================================================
;; No collection operations via apply — use coll.* instead

;; ============================================================
;; Basic Type Operations (Direct Application)
;; ============================================================

;; Generic comparison via key-projection and comparators
(= (apply >= $x $y)
   (case ((key-of $x) (key-of $y))
     (
       (((KPair $a1 $b1) (KPair $a2 $b2)) (or (> $a1 $a2) (and (== $a1 $a2) (>= $b1 $b2))))
       (((KScalar $kx) (KScalar $ky)) (>= $kx $ky))
     )))

(= (apply < $x $y)
   (case ((key-of $x) (key-of $y))
     (
       (((KPair $a1 $b1) (KPair $a2 $b2)) (or (< $a1 $a2) (and (== $a1 $a2) (< $b1 $b2))))
       (((KScalar $kx) (KScalar $ky)) (< $kx $ky))
     )))

(= (apply == $x $y)
   (case ((key-of $x) (key-of $y))
     (
       (((KPair $a1 $b1) (KPair $a2 $b2)) (and (isApproxEq $a1 $a2) (isApproxEq $b1 $b2)))
       (((KScalar $kx) (KScalar $ky)) (== $kx $ky))
     )))

(= (key-of $x)
   (case $x
     (
       ;; 5-field Cscore (scoring/cscore.metta)
       ((mkCscore $scor $cpxy $cpxyPen $uniPen $penScore)
        (let $p (if (isnan-math $penScore) (* -1 (pow-math 10 3)) $penScore)
             (KPair $p (* -1 $cpxy))))
       ((mkSInst (mkPair $inst $score))
         (key-of $score))
       ((mkExemplar $tree $demeId $cscore $bscr)
         (key-of $cscore))
       ($else (KScalar $x))
     )))

!(bind! EPSILON (new-state (pow-math 10 -6))) ;in petta to bind some constant like this we need to do it by new-state function and  to retrieve get-state function
; (: isApproxEq (-> Number Number Bool))
(= (isApproxEq $x $y)
    (let $diff (abs-math (- $x $y))
        (if (< $diff (get-state EPSILON))
            True
            (let $amp (abs-math (+ $x $y))
                (<= $diff (* (get-state EPSILON) $amp))))))     
;; List methods

(= (List.map $f Nil) Nil)
(= (List.map $f (Cons $x $xs)) (Cons ($f $x) (List.map $f $xs)))

(= (List.filter $p Nil) Nil)
(= (List.filter $p (Cons $x $xs)) (if ($p $x) (Cons $x (List.filter $p $xs)) (List.filter $p $xs)))


(= (List.listToExpr Nil) ())
(= (List.listToExpr (Cons $x $xs)) (let $t (List.listToExpr $xs) (cons-atom $x $t)))

(= (List.foldl $f $i Nil) $i)
(= (List.foldl $f $i (Cons $h $t)) (chain ($f $h $i) $i' (List.foldl $f $i' $t)))

(= (List.contains $a Nil) False)
(= (List.contains $a (Cons $head $tail)) (if (== $a $head) True (List.contains $a $tail)))
(= (List.append $val Nil) (Cons $val Nil))
(= (List.append $val (Cons $head $tail)) (Cons $head (List.append $val $tail)))

(= (List.length Nil) 0)
(= (List.length (Cons $head $tail)) (+ 1 (List.length $tail)))

(= (List.getByIdx Nil $idx) (Error Nil (Index out of range)))
(= (List.getByIdx (Cons $head $tail) $idx) (if (== $idx 0 ) $head (List.getByIdx $tail (- $idx 1))) )

(= (List.replaceAt Nil $n $elem) Nil)
(= (List.replaceAt (Cons $head $tail) $n $elem) 
   (if (== $n 0) (Cons $elem $tail) (Cons $head (List.replaceAt $tail (- $n 1) $elem))))  

(= (List.prepend $a $list) (Cons $a $list))

(= (List.max $comparator Nil) Nil)
(= (List.max $comparator (Cons $x $xs))
    (if (== $xs Nil)
        $x
         (let (Cons $t $u) $xs
            (if ($comparator $x $t)
                (List.max $comparator (Cons $x $u))
                (List.max $comparator $xs)))))

(= (List.max (Cons $x $xs)) (List.max >= (Cons $x $xs)))

(= (List.sum $xs) (eval (List.foldr + 0 $xs)))

(= (List.foldr $f $i Nil) $i)
(= (List.foldr $f $i (Cons $h $t)) ($f $h (List.foldr $f $i $t)))

(= (List.generate $length $element) 
(if (> $length 0) 
    (Cons $element (List.generate (- $length 1) $element)) Nil))
    
(= (List.tail Nil) Nil)
(= (List.tail (Cons $x $xs)) $xs)

(= (List.head Nil) (Error Nil EmptyList))
(= (List.head (Cons $x $xs)) $x)

(= (List.removeAtIdx Nil $idx) Nil)
(= (List.removeAtIdx (Cons $head $tail) $idx)
   (if (< $idx 0) (Cons $head $tail)
       (if (== $idx 0) $tail
           (Cons $head (List.removeAtIdx $tail (- $idx 1))))))

(= (List.repeat $n $a)
   (if (== $n 0)
       Nil
       (Cons $a (List.repeat (- $n 1) $a))))

(= (List.partialSort $comparator (Cons $x $xs) $n $acc)
    (let* (($max (List.max $comparator (Cons $x $xs)))
            ($unsortedList (List.delete $max (Cons $x $xs)))
            ($sortedList (List.append $max $acc)))
                
                (if (== (- $n 1) 0)
                    (List.appendList $unsortedList $sortedList)
                    (List.partialSort $comparator $unsortedList (- $n 1) $sortedList))))
                    
(= (List.delete $a Nil) (Error Nil "empty list"))
(= (List.delete $a (Cons $x $xs))
    (if (== $x $a)
        $xs
        (Cons $x (List.delete $a $xs))))  

(= (List.takeN $n Nil) Nil)
(= (List.takeN $n (Cons $x $xs)) 
    (if (== $n 0)
        Nil
        (let $t (List.takeN (- $n 1) $xs) (Cons $x $t))))        

(= (List.concat Nil $list2) $list2)
(= (List.concat (Cons $head $tail) $list2)
   (Cons $head (List.concat $tail $list2)))        

(= (List.appendList $a (Cons $x $xs))
    (if (== $xs Nil)
        (Cons $x $a)
        (Cons $x (List.appendList $a $xs))))   

(= (MultiMap.insert ($key $value) NilMMap $fn) (ConsMMap ($key $value) NilMMap))
(= (MultiMap.insert ($key $value) (ConsMMap ($curKey $curVal) $tail) $fn)
        (if ($fn $key $curKey)
            (ConsMMap ($key $value) (ConsMMap ($curKey $curVal) $tail))
            (ConsMMap ($curKey $curVal) (MultiMap.insert ($key $value) $tail $fn))))

;; default insert function that insert an element to the Ordered MultiMap using <=.
; (: MultiMap.insert (-> ($k $v) (MultiMap ($k $v)) (MultiMap ($k $v))))
(= (MultiMap.insert $newValue $mMap) (MultiMap.insert $newValue $mMap <=))

;; insert an element to a Map using custom comparison functions (equality $ lessthan)
; (: Map.insert (-> ($k $v) (Map ($k $v)) (-> $k $k Bool) (-> $k $k Bool) (Map ($k $v))))
(= (Map.insert ($key $value) NilMap $fEq $fLt) (ConsMap ($key $value) NilMap))
(= (Map.insert ($key $value) (ConsMap ($curKey $curVal) $tail) $fEq $fLt)
    (if ($fEq $key $curKey)  (ConsMap ($key $value) $tail)
        (if ($fLt $key $curKey)
            (ConsMap ($key $value) (ConsMap ($curKey $curVal) $tail))
            (ConsMap ($curKey $curVal) (Map.insert ($key $value) $tail $fEq $fLt)))))

;; insert an element to a Map
; (: Map.insert (-> ($k $v) (Map ($k $v)) (Map ($k $v))))
(= (Map.insert ($key $value) NilMap) (ConsMap ($key $value) NilMap))
(= (Map.insert ($key $value) (ConsMap ($curKey $curVal) $tail))
    (if (== $key $curKey)  (ConsMap ($key $value) $tail)
        (if (< $key $curKey)
            (ConsMap ($key $value) (ConsMap ($curKey $curVal) $tail))
            (ConsMap ($curKey $curVal) (Map.insert ($key $value) $tail)))))

(= (Map.length NilMap) 0)
(= (Map.length (ConsMap ($curKey $curVal) $tail)) (+ 1 (Map.length $tail)))

(= (Map.contains $key NilMap) False)
(= (Map.contains $key (ConsMap ($curKey $curVal) $tail))
    (if (== $key $curKey) True (Map.contains $key $tail)))

(= (Map.getByKey $key NilMap) (Error $key "not found"))
(= (Map.getByKey $key (ConsMap ($curKey $curVal) $tail))
    (if (== $key $curKey) $curVal (Map.getByKey $key $tail) ))

(= (MultiMap.length NilMMap) 0)
(= (MultiMap.length (ConsMMap ($curKey $curVal) $tail)) (+ 1 (MultiMap.length $tail)))

(= (MultiMap.getByIdx $idx NilMMap ) (Error NilMMap (Can't find $idx)))
(= (MultiMap.getByIdx $idx (ConsMMap $x $xs)) (if (== $idx 0) $x (MultiMap.getByIdx (- $idx 1) $xs)))

(= (MultiMap.values NilMMap) Nil)
(= (MultiMap.values (ConsMMap ($key $value) $tail))
    (Cons $value (MultiMap.values $tail)))

(= (OS.getByIdx $idx NilOS) (Error $idx "empty set/index out of range"))
(= (OS.getByIdx $idx (ConsOS $x $xs)) 
    (if (== $idx 0)
        $x
        (OS.getByIdx (- $idx 1) $xs)))            

(= (OS.getTopN $n NilOS) (Error NilOS "empty ordered set/ fewer items than required")) 
(= (OS.getTopN $n (ConsOS $x $xs))
    (if (== $n 1)
        (ConsOS $x NilOS)
        (chain (OS.getTopN (- $n 1) $xs) $res 
            (eval (if-error $res $res (ConsOS $x $res))))))        

(= (OS.length NilOS) 0)
(= (OS.length (ConsOS $x $xs)) (+ 1 (OS.length $xs)))    

(= (OS.isMember $exemplar NilOS) False)
(= (OS.isMember $exemplar (ConsOS $x $xs))
   (if (== $exemplar $x)
       True
       (OS.isMember $exemplar $xs)))

(= (OS.insert $comparator $x NilOS) (ConsOS $x NilOS))
(= (OS.insert $comparator $new (ConsOS $x $xs))
    
    (case ($comparator $new $x)
        ((G (ConsOS $new (ConsOS $x $xs)))
         (E (ConsOS $x $xs))
         (L (ConsOS $x (OS.insert $comparator $new $xs))))))       