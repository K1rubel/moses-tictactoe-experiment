!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)
!(import! &self ../../representation/ssk)
!(import! &self ../../representation/knob-representation)
!(import! &self ../../representation/sample-strategy-perms)
!(import! &self ../../representation/strategy-probe)
!(import! &self ../../representation/add-strategy-knobs)

; !(set-random-seed 0) ;; for reproducilbility

!(addStrategyKnobs (mkTree (mkNode PRIORITIZED-OR) (Cons (mkTree (mkNode play-block) Nil) Nil)) (mkNodeId (0)) True NilMMap)

; (
;     (mkTree (mkNode PRIORITIZED-OR) (Cons (mkTree (mkNode play-block) Nil) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) Nil))))))) 

;     (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 1) (mkDiscSpec 1) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))
