!(import! &self ./minimax)
!(import! &self ./lib-he)

!(assertEqual (get-nth (A B C) 0) A)
!(assertEqual (get-nth (A B C) 1) B)
!(assertEqual (get-nth (A B C) 2) C)


;; Test check-line
;; Board for testing: (X O X X X X O O O)
;; Indices:            0 1 2 3 4 5 6 7 8
;; Row 2 (indices 3, 4, 5) is X X X.
!(assertEqual 
    (check-line (X O X X X X O O O) 3 4 5) 
    X)

;; Test a line that is mixed (X O X) -> Should return E
!(assertEqual 
    (check-line (X O X X X X O O O) 0 1 2) 
    E)

;; Test a line that matches but is Empty (E E E) -> Should return E
!(assertEqual 
    (check-line (E E E E E E E E E) 0 1 2) 
    E)

;; Row 0 Win (X)
;; X X X
;; O E O
;; E E E
!(assertEqual 
    (get-winner (X X X O E O E E E)) 
    X)

;; Row 1 Win (O)
;; X X E
;; O O O
;; X E E
!(assertEqual 
    (get-winner (X X E O O O X E E)) 
    O)    

;; Col 0 Win (X)
;; X O E
;; X O E
;; X E E
!(assertEqual 
    (get-winner (X O E X O E X E E)) 
    X)

;; Col 2 Win (O)
;; X X O
;; E E O
;; X E O
!(assertEqual 
    (get-winner (X X O E E O X E O)) 
    O)    

;; Main Diagonal Win (X)
;; X O E
;; O X E
;; E E X
!(assertEqual 
    (get-winner (X O E O X E E E X)) 
    X)

;; Anti-Diagonal Win (O)
;; X X O
;; E O E
;; O X E
!(assertEqual 
    (get-winner (X X O E O E O X E)) 
    O)    

;; Empty Board
;; E E E
;; E E E
;; E E E
!(assertEqual 
    (get-winner (E E E E E E E E E)) 
    E)

;; Draw (Full board, no lines)
;; X O X
;; X O O
;; O X X
!(assertEqual 
    (get-winner (X O X X O O O X X)) 
    E)

;; Game in progress (No win yet)
;; X O E
;; E X E
;; O E E
!(assertEqual 
    (get-winner (X O E E X E O E E)) 
    E)    