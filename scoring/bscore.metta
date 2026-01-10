; !(import! &self ../helpers)
; !(import! &self ../moves)

;; scoring the strategy evolved by moses is playing it against a palyer
;; random minnge
;; the evolved strategy is going to be sth like (PRIORITIZED-OR play-win play-block (PRIORITIZED-OR play-fork play-side))
;; so we need an interpreter that takes such a strategy and excutes this 
;; the moses evolved strategy is going to be interpreted as follows.
;; ---------------------------------------------------------
;; STRATEGY EXECUTOR
;; ---------------------------------------------------------

;; Main Entry Point:
;; Takes a Strategy Tree, Board State, and Player (X or O)
;; Returns: New Board (with move made) OR False (if no move found)
(= (exec-strategy $expr $bs $player)
   (if (== (get-metatype $expr) Expression)
       ;; It is a complex node (like PRIORITIZED-OR)
       (let ($op $args) (decons-atom $expr)
            (if (== $op PRIORITIZED-OR)
                (exec-prioritized-or $args $bs $player)
                (Error "Unknown Operator" $op)))
       ;; It is an atomic leaf (like play-win)
       (exec-leaf $expr $bs $player)))

;; ---------------------------------------------------------
;; CONTROL FLOW: PRIORITIZED-OR
;; ---------------------------------------------------------
;; Recursively tries each child strategy.
;; Returns the result of the first one that does NOT return False.

(= (exec-prioritized-or $children $bs $player)
   (if (== $children ())
       False ;; No children left, strategy failed
       (let* ((($head-strat $rest) (decons-atom $children))
              ($result (exec-strategy $head-strat $bs $player)))
             
             (if (not (== $result False))
                 $result ;; Success! Return the new board
                 (exec-prioritized-or $rest $bs $player))))) ;; Fail, try next

;; ---------------------------------------------------------
;; ATOMIC MOVES (LEAVES)
;; ---------------------------------------------------------
;; XXX -- checkout the definition of atomic moves such as 
;; Dispatcher for atomic moves

(= (exec-leaf $strategy $bs $player)
   (case $strategy
     (
       (play-win    (play-win $bs $player))
       (play-block  (play-block $bs $player))
       (play-center (play-center $bs $player))
       (play-corner (play-corner $bs $player))
       (play-side   (play-side $bs $player))
       (play-fork   (play-fork $bs $player))
     )))                 

; ;; The next bit of thing to do is use the game engine to play any one strategy against the above and recode the result
; ;; WIN -- 1
; ;; Draw -- 0
; ;; LOOSE -- -1
;; $player 1
;; scoreStrategy calls on the game engine to play the game and assigns returns the score 
;; this is equivalent to the behavioral score for a boolean expression measured agains the input table labels 
;; the game engine uses the above move iterpreter for the "moses-evolved" game strategy
;; to stay consitent with the notion of evaluating the candidate tree over a range of input rows, we play the evolved strategy agains the adversay for a predefined N times
;; and take the sum of all the individual scores
;; for starters lets play the strategy 5 times before we return the behavioral score
;; the best possible score is thus 5 -- wins all 5 games
;; and the worst possible score is -5 -- loses all 5 games
(= (scoreStrategy $bs $player1 $player2 $gameCount) 
    ;; assuming player2 is moses-evolved strategy
    ;; a stupid way to score the strategy using complexity values
    (let $treeComplexity (eval (treeComplexity $player2))
        (if (< $treeComplexity 2)
            (mkBScore (Cons -1 (Cons -1 (Cons -1 (Cons 0 (Cons -1 Nil))))))
            (if (== $treeComplexity 2)
                (mkBScore (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons -1 Nil))))))
                (if (== $treeComplexity 3)
                    (mkBScore (Cons 0 (Cons 0 (Cons 0 (Cons 1 (Cons -1 Nil))))))
                    (if (> $treeComplexity 7)
                        (mkBScore (Cons 1 (Cons 1 (Cons 1 (Cons 0 (Cons 1 Nil))))))
                        (mkBScore (Cons 1 (Cons 1 (Cons 1 (Cons 0 (Cons 0 Nil))))))))))))
                

(= (sumBScore (mkBScore $bs)) (eval (List.sum $bs)))

(= (worstBScore) 
    (let ($_ $round) (getCoef) (mkBScore (List.repeat $round -1))))
; !(exec-strategy 
;     (PRIORITIZED-OR play-win play-block play-center play-corner) 
;     (E E E E E E E E E) 
;     X)     

; !(exec-strategy 
;     (PRIORITIZED-OR play-win play-fork) 
;     (X X E O O E E E E) 
;     X)
; ;; Expected: (X X X O O E E E E)

; !(exec-strategy 
;     (PRIORITIZED-OR play-win play-block play-fork) 
;     (O O E X E E E E E) 
;     X)
; ;; Expected: (O O X X E E E E E)

; 1
; 0
; -1

; ; ()