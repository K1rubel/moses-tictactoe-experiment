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

(= (updateID (mkNodeId $id)) 
    (if (== (car-atom $id) 0)
        (mkNodeId (cdr-atom $id))
        (mkNodeId $id)

    ))

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


(= (OS.getByIdx $idx NilOS) (Error $idx "empty set/index out of range"))
(= (OS.getByIdx $idx (ConsOS $x $xs)) 
    (if (== $idx 0)
        $x
        (OS.getByIdx (- $idx 1) $xs)))            