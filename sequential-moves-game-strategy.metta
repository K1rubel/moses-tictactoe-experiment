; 1. Define a helper function to run a list of strategies sequentially.
;    It takes a list of functions, the board, and the player.
(= (try-strategies () $board $player) None) ; If list is empty, return None

(= (try-strategies $action-list $board $player)
   ; Execute the current action
   (let* ((($action $rest) (decons-atom $action-list))
            ($result ($action $board $player)))
        ; Check if the result is Failure
         (if (== $result False)
               ; If it failed, recurse with the rest of the list
               (try-strategies $rest $board $player)
               ; If it succeeded, return the new board
               $result
         )
      )
   )

; 2. Define your main policy function
;    We pass the list of strategies in the EXACT order you specified in Python.
(= (run-policy $board $player)
   (try-strategies 
      ; (play-block play-corners play-sides play-block play-corners) 
      (play-center play-corner play-side) 
      $board 
      $player
   )
)
