!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)
!(import! &self ../../utilities/py-call-helpers)
!(import! &self ../../utilities/lib-he)
!(import! &self ../../utilities/pair)
!(import! &self ../../utilities/lazy-random-selector)

!(import! &self ../../representation/ssk)
!(import! &self ../../representation/knob-representation)
!(import! &self ../../representation/sample-strategy-perms)
!(import! &self ../../representation/strategy-probe)
!(import! &self ../../representation/add-strategy-knobs)
!(import! &self ../../representation/build-strategy)
!(import! &self ../../representation/build-knobs)
!(import! &self ../../representation/knob-mapper)
!(import! &self ../../representation/representation)
!(import! &self ../../representation/instance)


!(import! &self ../../moses/neighborhood-sampling)

!(import! &self ../../optimization/hill-climbing)
!(import! &self ../../optimization/cross-top-one)
!(import! &self ../../optimization/cross-top-one-helpers)

!(import! &self ../../scoring/bscore)
!(import! &self ../../scoring/cscore)
!(import! &self ../../scoring/complexity-based-scorer)

!(import! &self ../../metapopulation/exemplar-selection)
!(import! &self ../../metapopulation/metapopulation)

!(import! &self ../../deme/create-deme)
!(import! &self ../../deme/expand-deme)
!(import! &self ../../deme/score-deme)
!(import! &self ../../deme/merge-demes)

(= (metaPop) (ConsOS (mkExemplar (mkTree (mkNode OR) (Cons (mkTree (mkNode NOT) (Cons (mkTree (mkNode A) Nil) Nil)) (Cons (mkTree (mkNode OR) (Cons (mkTree (mkNode AND) (Cons (mkTree (mkNode B) Nil) Nil)) (Cons (mkTree (mkNode AND) (Cons (mkTree (mkNode C) Nil) Nil)) (Cons (mkTree (mkNode AND) (Cons (mkTree (mkNode D) Nil) Nil)) Nil)))) Nil))) (mkDemeId "1") (mkCscore -0.2 1 0.1 0.1 -0.4) (mkBScore (Cons 0 (Cons 0 Nil))))
                 (ConsOS (mkExemplar (mkTree (mkNode OR) (Cons (mkTree (mkNode OR) (Cons (mkTree (mkNode AND) (Cons (mkTree (mkNode B) Nil) Nil)) (Cons (mkTree (mkNode AND) (Cons (mkTree (mkNode C) Nil) Nil)) (Cons (mkTree (mkNode AND) (Cons (mkTree (mkNode D) Nil) Nil)) Nil)))) Nil)) (mkDemeId "1") (mkCscore -0.1 2 0.2 0.3 -0.6) (mkBScore (Cons 0 (Cons 0 Nil)))) 
                 NilOS)))

(= (metaPop2) 
            (ConsOS (mkExemplar (mkTree (mkNode PRIORITIZED-OR) Nil) (mkDemeId 1) (worstCscore) (worstBScore)) NilOS))                 
            
; !(expandDeme (metaPop2) 0 3 $optimize)        


((
    (mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId 1.0)) 


    (mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId 1.1)) 


    (mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId 1.2))
))


    (
        (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap)))))) 
        
        (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap)))))) 
        
        (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap)))))))

(
    (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap))))))
    
    (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap))))))
    
    (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))

    (
        (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) Nil))))))) 
        
        (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) Nil))))))) 
        
        (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) Nil))))))))

(
    (mkSInstSet Nil) 
    (mkSInstSet Nil) 
    (mkSInstSet Nil)
)        


(
    (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil)))))) 
    (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil)))))) 
    (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil)))))))


(= (deme) 
(mkDeme (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) Nil)))))))) (mkSInstSet Nil) (mkDemeId "1.0")) )

; !(optimizeDemes )
; !(expandDemeHelper (deme) hillClimbing)
; !(optimizeDemes (deme) (mkInst (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) hillClimbing) 

; (
;     (mkInst (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) 
    
;     (mkDeme 
;         (mkRep (mkKbMap (mkDscKbMp (ConsMap ((mkNodeId (1)) 5) (ConsMap ((mkNodeId (2)) 4) (ConsMap ((mkNodeId (3)) 3) (ConsMap ((mkNodeId (4)) 2) (ConsMap ((mkNodeId (5)) 1) (ConsMap ((mkNodeId (6)) 0) NilMap))))))) (mkDscMp (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (6))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (5))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (4))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (3))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (2))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) (ConsMMap ((mkDiscSpec 2) (mkSSK (mkDiscKnob (mkKnob (mkNodeId (1))) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil))) NilMMap)))))))) (mkTree (mkNode PRIORITIZED-OR) (Cons (mkNullVex (Cons (mkTree (mkNode play-center) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-block) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-fork) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-corner) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-side) Nil) Nil)) (Cons (mkNullVex (Cons (mkTree (mkNode play-win) Nil) Nil)) Nil)))))))) 
    
;         (mkSInstSet (Cons (mkSInst (mkPair (mkInst (Cons 0 (Cons 1 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 1 0.5 0.0 -4.5))) (Cons (mkSInst (mkPair (mkInst (Cons 0 (Cons 1 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 1 0.5 0.0 -4.5))) (Cons (mkSInst (mkPair (mkInst (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 0 0.0 0.0 -4.0))) (Cons (mkSInst (mkPair (mkInst (Cons 0 (Cons 1 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 1 0.5 0.0 -4.5))) (Cons (mkSInst (mkPair (mkInst (Cons 1 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 1 0.5 0.0 -4.5))) (Cons (mkSInst (mkPair (mkInst (Cons 1 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 1 Nil))))))) (mkCscore -4 2 1.0 0.0 -5.0))) (Cons (mkSInst (mkPair (mkInst (Cons 1 (Cons 0 (Cons 0 (Cons 0 (Cons 1 (Cons 0 Nil))))))) (mkCscore -4 2 1.0 0.0 -5.0))) Nil)))))))) (mkDemeId 1.0))
;     (true false true (mkInst (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 2 1.0 0.0 -5.0) -5.0 9 3 5))
; !(hillClimbing (deme) (mkInst (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))))

; (is scored instances (Cons (mkSInst (mkPair (mkInst (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 (Cons 0 Nil))))))) (mkCscore -4 0 0.0 0.0 -4.0))) Nil))

!(runMoses 4 (mkCscore 5 0 0 0 5) 2 (metaPop2) 0 2 hillClimbing 3 10 4 6 2 3 3)

; !(if False isless ismore)

