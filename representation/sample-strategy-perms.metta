;; Define your atomic moves
(= (moves) (play-center play-block play-corner play-side play-win play-fork))
(= (getTicTacToeMove $moves)
   (let $index (random-int 0 (- (length $moves) 1)) (index-atom $moves $index)))

;; Generate permutations for a knob --> in this case though there is no need for permutations because we are not looking for combinations of actions to be combined
;; So may be just 
;; $n: Number of permutations to generate
;; Returns: A tuple of single-node Trees, each containing one move.
(: sampleStrategyPerms (-> Expression Number Expression Expression))
(= (sampleStrategyPerms $moves $n $acc)
   (if (== $n 0)
       $acc
       (let* (
           ($move (getTicTacToeMove $moves))
           ($rest (subtraction-atom $moves ($move)))
           ($perm (mkTree (mkNode $move) Nil)) ;; Wrap move in a Tree Node
        ;    ($rest (sampleStrategyPerms $rest (- $n 1)))
           ($picked (append $acc ($perm)))
       )
       (sampleStrategyPerms $rest (- $n 1) $picked))))


; !(set-random-see 42)

; !(getTicTacToeMove)
; !(sampleStrategyPerms 6)

;; this could be just sth like this -- since there is no need to combine moves within another operators as in the logical knob case

; (= (sampleStrategyPerms) 
;     (map-atom (moves) $move (mkTree (mkNode $move) Nil)))

; !(let $a (moves)
;     (sampleStrategyPerms $a 6 ()))
; !(length (moves))
    

