!(import! &self ./moves)
!(import! &self ./lib-he)

;; Test 1: Identify Row Win for X
;; Board: X X E | O O E | E E E
;; Move at index 2 completes the top row.
!(assertEqual
    (play-win (X X E O O E E E E) X)
    2)

;; Test 2: Identify Diagonal Win for O
;; Board: X X E | E O E | E E E
;; Move at index 8 completes the diagonal (0, 4, 8) -> Wait, O is at 4.
;; Let's set up a clear O win: (O X X) (E O X) (E E E) -> O needs index 8 to win diagonal.
!(assertEqual
    (play-win (O X X E O X E E E) O)
    8)

;; Test 3: No winning move available
;; Board is empty. No single move wins the game.
!(assertEqual
    (play-win (E E E E E E E E E) X)
    False)

;; Test 4: Block or Win? (This function ONLY looks for wins, not blocks)
;; Board: O O E | X X E | E E E
;; If we are X, we should find index 5 to win.
!(assertEqual
    (play-win (O O E X X E E E E) X)
    5)

!(play-fork (X E E E O E E E X) X)
; !(find-fork-move (X E E E O E E E X) X (1 2 3 5 6 7))

; !(count-winning-moves (X X E E O E E E X) X)


;; 1. Play Corner
;; Board: E X O | X X O | E E E
;; Index 0 is Empty. It should pick 0.
!(assertEqual
    (play-corner (E X O X X O E E E))
    0)

;; Corner Fallback
;; Board: X E E | E E E | E E E
;; Index 0 is taken (X). It should pick the next corner: 2.
!(assertEqual
    (play-corner (X E E E E E E E E))
    2)

;; 2. Play Side
;; Board: X X X | E E E | X X X
;; Indices 1, 3, 5, 7 are the sides.
;; Index 1 is occupied (X).
;; Index 3 is Empty. It should pick 3.
!(assertEqual
    (play-side (X X X E E E X X X))
    3)    

;; 3. No Options Available
;; If all corners are taken, return False
!(assertEqual
    (play-corner (X E X E E E O E O))
    False)    
