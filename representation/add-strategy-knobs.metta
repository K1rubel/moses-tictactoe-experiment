;; Adds knobs that allow swapping the current strategy node with other heuristics.
; (: addStrategyKnobs (-> (Tree $a) NodeId Bool (MultiMap ($k $v)) Expression))
(= (addStrategyKnobs $exemplar $nodeId $addIfInExemplar $map) 
   (let (mkTree (mkNode $op) $children) (eval (getNodeById $exemplar $nodeId))
       ;; Generate 6 random alternative moves as options for this knob
        (let $lenOfActions (size-atom (moves)) 
            (let $moves (moves)
                (let $perms (sampleStrategyPerms $moves $lenOfActions ())
                    
                    ;; Reuse logicalProbe to filter existing knobs (checks inExemplar)
                    ;; Note: logicalProbe logic is generic enough to work here 
                    ;; if we accept 'Strategy' as a type of 'Logical' knob for reuse.
                    (let ($knobs $updatedTree) (eval (strategyProbe $exemplar $nodeId $perms $addIfInExemplar ()))
                        (let $pairs (eval (pairKnobWithSpec $knobs))
                            (let $mmp (eval (expToMMap $pairs $map discSpec<=))
                                ($updatedTree $mmp)
                            ))))))))

;; helper function to the addLogicalKnobs
;; takes a tuple of knobs and return a tuple of knob and knobSpec pairs
;; (: pairKnobWithSpec (-> Expression Expression))
(= (pairKnobWithSpec $tuple)   (map-atom $tuple $knob ((eval (getKnobSpec $knob)) $knob) ))
