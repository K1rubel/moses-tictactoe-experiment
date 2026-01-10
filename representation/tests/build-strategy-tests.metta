!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)
!(import! &self ../../representation/ssk)
!(import! &self ../../representation/knob-representation)
!(import! &self ../../representation/sample-strategy-perms)
!(import! &self ../../representation/strategy-probe)
!(import! &self ../../representation/add-strategy-knobs)
!(import! &self ../../representation/build-strategy)

(= (tree1)
    (mkTree (mkNode PRIORITIZED-OR) (Cons (mkTree (mkNode play-win) Nil) Nil)))

!(buildStrategy (tree1) (mkNodeId (1)) NilMMap)

(
    (mkTree (mkNode PRIORITIZED-OR) (Cons (mkTree (mkNode PRIORITIZED-OR) (Cons (mkTree (mkNode play-win) Nil) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) Nil))))))) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) Nil))))))) 
    
    (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1 1))) (mkMultip 2) (mkDiscSpec 1) (mkDiscSpec 1) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1 6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1 5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1 4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1 3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1 2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 1) (mkDiscSpec 1) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))))))))
