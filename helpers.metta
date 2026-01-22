!(import! &self ./lib-he)
(= (get-empty-cells $bs $acc $counter)
    (if (== $bs ())
        $acc
        (let ($h $t) (decons-atom $bs)
            (if (== $h E)
                (let $carry (union-atom $acc ($counter))
                    (get-empty-cells $t $carry (+ $counter 1)))
                (get-empty-cells $t $acc (+ $counter 1))))))

(=  (replace-by-index $bs $icon $index)
    (let ($h $t) (decons-atom $bs)
        (if (== $index 0)
            (cons-atom $icon $t)
            (let $rest (replace-by-index $t $icon (- $index 1))
                (cons-atom $h $rest)))))

;; ---------------------------------------------------------
;; WIN CHECKER
;; ---------------------------------------------------------
;; no need to get the winner -- who ever's turn it was when the winning state is obtained will be the winner -- going extra mile to get the identity of the winner is not necessary

;; Main function: Returns X, O, or E (if no winner yet)
; (= (get-winner $bs)
;     ;; Check Rows
;     (let $rows ((check-line $bs 0 1 2) (check-line $bs 3 4 5) (check-line $bs 6 7 8))
;         (if (== $rows (E E E))
;             (let $columns ((check-line $bs 0 3 6) (check-line $bs 1 4 7) (check-line $bs 2 5 8)) 
;                 (if (== $columns (E E E))
;                     (let $diagonals ((check-line $bs 0 4 8) (check-line $bs 2 4 6))
;                         (if (== $diagonals (E E))
;                             E
;                             (if (is-member X $diagonals)
;                                 X
;                                 O)))
;                     (if (is-member X $columns)
;                         X
;                         O)))
;             (if (is-member X $rows)
;                 X
;                 O))))

;; ---------------------------------------------------------
;; DETERMINISTIC WIN CHECKER
;; ---------------------------------------------------------

(= (get-winner $bs)
   ;; 1. Check Rows
   (let $r1 (check-line $bs 0 1 2) 
     (if (not (== $r1 E)) $r1
     (let $r2 (check-line $bs 3 4 5)
       (if (not (== $r2 E)) $r2
       (let $r3 (check-line $bs 6 7 8)
         (if (not (== $r3 E)) $r3

   ;; 2. Check Columns
   (let $c1 (check-line $bs 0 3 6)
     (if (not (== $c1 E)) $c1
     (let $c2 (check-line $bs 1 4 7)
       (if (not (== $c2 E)) $c2
       (let $c3 (check-line $bs 2 5 8)
         (if (not (== $c3 E)) $c3

   ;; 3. Check Diagonals
   (let $d1 (check-line $bs 0 4 8)
     (if (not (== $d1 E)) $d1
     (let $d2 (check-line $bs 2 4 6)
       (if (not (== $d2 E)) $d2
       
   ;; 4. No Winner
       E)))))))))))))))))

;; Helper: Checks if indices A, B, and C are identical and not Empty
(= (check-line $bs $a $b $c)
    (let* (($v1 (index-atom $bs $a))
           ($v2 (index-atom $bs $b))
           ($v3 (index-atom $bs $c)))
        
        ;; Logic: If v1 != E, AND v1 == v2, AND v2 == v3, then return v1. Else return E.
        (if (== $v1 E) 
            E
            (if (== $v1 $v2)
                (if (== $v2 $v3)
                    $v1
                    E)
                E))))

;; Helper: recursive function to get the Nth element of a list
; (= (index-atom $bs $index)
;     (let ($h $t) (decons-atom $bs)
;         (if (== $index 0)
;             $h
;             (index-atom $t (- $index 1)))))

;; Returns 10 if player wins, -10 if opponent wins, 0 otherwise
(= (evaluate-board $bs $player $opponent)
   (let $w (get-winner $bs) 
      (if (== $w $player) 10
      (if (== $w $opponent) -10
      0))))

;; Switcher
(= (get-opponent $icon)
   (if (== $icon X) O X))            

;; These are simple positional strategies. Unlike winning or blocking, they don't depend on the opponent's moves, but simply look for advantageous spots on the board.   
;; Since all 3 strategies essentially do the same thing (look for an empty spot from a specific list of preferred indices), we can create a single helper function to handle the checking.

;; Helper: Returns the first index from $indices that is Empty (E) in $board
(= (find-first-empty $board $indices)
   (if (== $indices ())
       False
       (let ($idx $rest) (decons-atom $indices)
            (if (== (index-atom $board $idx) E)
                $idx
                (find-first-empty $board $rest)))))


;; checking for winning player identification logic
;; mock winning states
; (= (winning-states) ((($x $x $y) $x) (($y $x $x) $x)))
(= (winning-states) ((($x $x $x $a $b $c $d $e $f) $x) 
                    (($a $b $c $x $x $x $d $e $f) $x)
                    (($a $b $c $d $e $f $x $x $x) $x) 
                    (($x $a $b $x $c $d $x $e $f) $x)
                    (($a $x $b $c $x $d $e $x $f) $x)
                    (($a $b $x $c $d $x $e $f $x) $x)
                    (($x $a $b $c $x $d $e $f $x) $x)
                ))

; !(is-member (X X E) (winning-states))                
; !(is-member (X O E) (winning-states))                

; !(let $state (superpose ((($x $x $y) $x) (($y $x $x) $x)))
;     (unify (X X E) $state $x false))

; !(let $state (superpose (winning-states))
;     (unify (X X E) $state $x false))
; !(unify ((X X E) X) ())

; !(let $state (superpose (let $x (winning-states))) (unify $state ((X X E) $x) $x $state))
; !(let $states (winning-states) (collapse (let $state (superpose $states) (unify $state ((O X E) $x) $x (empty)))))
(= (get-winner2 $board) 
    (let $states (winning-states) 
        (let $result (collapse (let $state (superpose $states) (unify $state ($board $x) (if (= $x E) (empty) $x) (empty))))
            (if (= $result ())
                E
                (car-atom $result)))))

; !(get-winner2 (E E E X X X E O E))        
; !(get-winner (E E E X X X E O E))        
; !(get-winner2 (E E E O X X E E E))        

;; Test cases for get-winner2
; !(assertEqual
;   (get-winner2 (E E E
;                  E E E
;                  E E E))
;   E)

; !(assertEqual
;   (get-winner2 (X X X
;                  E O E
;                  O E E))
;   X)

; !(assertEqual
;   (get-winner2 (O X E
;                  X O E
;                  E E O))
;   O)

; !(assertEqual
;   (get-winner2 (X O X
;                  X O O
;                  O X X))
;   E)
