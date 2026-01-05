;; Implementation of a random player
;; takes a board state and returns another board state
;; chooses the moves randomly

;; algo
;; take a board state --> sth like (E E E E E E E E E)
;; get index values of Empty cells and choose randomly and return a board with this selected index filled with icon (X or O)

(= (random-player $bs $icon)
    (let* (($empty-indices (get-empty-cells $bs () 0))
            ($count (length $empty-indices))
            ($index-to-play (random-int 0 (- $count 1))))

            (replace-by-index $bs $icon $index-to-play)))


; !(random-player (E E E E X E) X)