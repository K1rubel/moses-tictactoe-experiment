!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/lib-he)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)

!(import! &self ../bscore)
!(import! &self ../cscore)

(= (tree1) 
    (mkTree (mkNode PRIORITIZED-OR) (Cons (mkTree (mkNode play-win) Nil) (Cons (mkTree (mkNode play-fork) Nil) Nil))))


; !(treeComplexity (tree1))    
!(getCscore (tree1) 2)
!(scoreStrategy $f $b $c $d)