!(import! &self ./random-player)
; !(import! &self ./minimax)
!(import! &self ./utilities)

;; Main Strategy: Returns index of a winning move, or False if none exists
;; XXX -- add a procedure that makes the move using the index returned
(: play-win Expression Symbol Bool)
(: play-win Expression Symbol Number)
(= (play-win $board $player)
   (let $candidates (get-empty-cells $board () 0)
        (find-winning-move $board $player $candidates)))

;; Recursive Helper: Checks each candidate index
(= (find-winning-move $board $player $indices)
   (if (== $indices ())
       False ;; No winning moves found in the list
       (let* ((($idx $rest) (decons-atom $indices))
                ;; 1. Create a hypothetical board with the move made
                ($new-board (replace-by-index $board $player $idx))
                ;; 2. Check if this new board makes the player a winner
                ($winner (get-winner $new-board)))
                (if (==  $player $winner)
                    $idx ;; Found it! Return the index
                    ;; 3. Otherwise, check the rest of the indices
                    (find-winning-move $board $player $rest)))))

; We reuse the play-win function. If play-win returns an index for the opponent, that is the index we must block.

(= (play-block $board $player)
   (let $opponent (get-opponent $player)
        (play-win $board $opponent)))                    

        
;; To implement play-fork, we need to find a move that creates two or more winning opportunities (threats) simultaneously.
;; This requires "looking ahead" twice:
;; Hypothetical Move: We place our mark in an empty spot.
;; Count Threats: On this new board, we count how many winning moves are now available to us. If the count is 2 or more, we found a fork.        

;; 1. Helper: count-winning-moves
;; This function counts how many immediate winning moves exist for a player on a given board. It is similar to play-win, but instead of returning the index, it returns the total count.

;; Helper: Counts how many winning moves exist for $player on $board
(= (count-winning-moves $board $player)
   (let $empty-cells (get-empty-cells $board () 0)
      (count-wins-recursive $board $player $empty-cells)))
   

;; Recursive counter
(= (count-wins-recursive $board $player $indices)
   (if (== $indices ())
       0
       (let* ((($idx $rest) (decons-atom $indices))
               ;; Try the move
               ($temp-board (replace-by-index $board $player $idx))
               ;; Check if it wins
               ($is-win (== (get-winner $temp-board) $player)))
               ;; Add 1 if win, 0 if not, and recurse
               (+ (if $is-win 1 0) 
                  (count-wins-recursive $board $player $rest)))))

;; Main function: Returns index of a fork move, or False
(= (play-fork $board $player)
   (let $empty-cells (get-empty-cells $board () 0)
      (find-fork-move $board $player $empty-cells)))

;; Checks candidates recursively
(= (find-fork-move $board $player $indices)
   (if (== $indices ())
       False
       (let* ((($idx $rest) (decons-atom $indices))
               ;; 1. Create hypothetical board with this move
               ($temp-board (replace-by-index $board $player $idx)))
               ;; 2. Count how many winning threats this move creates
               ;; Note: We check if threats >= 2
               (if (>= (count-winning-moves $temp-board $player) 2)
                   $idx
                   (find-fork-move $board $player $rest)))))                         


;; Play Side, Corner and Center
; Play Corner: Corners are generally the strongest opening moves. The indices are 0, 2, 6, and 8.                

(= (play-corner $board $player)
   (find-first-empty $board (0 2 6 8)))

; Play Side: Sides (middles of the outer edges) are indices 1, 3, 5, and 7. These are usually played last as they offer fewer winning lines.   

(= (play-side $board $player)
   (find-first-empty $board (1 3 5 7)))

; Play Center: 4   
(= (play-center $board $player)
   (find-first-empty $board (4)))

