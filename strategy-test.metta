; !(import! &self utilities)
!(import! &self sequential-moves-game-strategy)
!(import! &self random-player)
!(import! &self moves)

; !(play-center (X E X E E E O E O))
!(run-policy (X E X X X E E E O) X)