!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)
!(import! &self ../../utilities/py-call-helpers)
!(import! &self ../../utilities/lib-he)
!(import! &self ../../representation/ssk)
!(import! &self ../../representation/knob-representation)
!(import! &self ../../representation/sample-strategy-perms)
!(import! &self ../../representation/strategy-probe)
!(import! &self ../../representation/add-strategy-knobs)
!(import! &self ../../representation/build-strategy)
!(import! &self ../../representation/build-knobs)
!(import! &self ../../representation/representation)
!(import! &self ../../deme/create-deme)

; !(createDeme)
; !(createDemeIds 0 2)
; !(assertEqual (createDemeIds 0 1) (Cons (mkDemeId "1") Nil))
; !(createDemeIds 0 1)

!(let $demeIds (createDemeIds 0 3)
    (createDeme 3 $demeIds (mkTree (mkNode prioritized_or) Nil)))

; !(createDeme (mkTree (mkNode prioritized_or) Nil) 0 0)

(
    (mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode prioritized_or) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId 1.0)) 
    
    (mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode prioritized_or) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId 1.1)) 
    
    
    (mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode prioritized_or) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId 1.2)))