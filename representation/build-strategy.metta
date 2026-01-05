; (: strategySiblingIt (-> (Tree $a) (List (Tree $a)) NodeId Number (MultiMap ($k $v)) ((Tree $a) (MultiMap ($k $v)))))
(= (strategySiblingIt $tree Nil $parentId $childNum $MMap) ($tree $MMap))
(= (strategySiblingIt $tree (Cons $head $tail) (mkNodeId $parentId) $childNum $MMap)
        (let*
             (
                ;; Calculate Current Child ID
                ($curId (if (== $parentId (0)) ($childNum) (concatT $parentId ($childNum))))
                ((mkTree (mkNode $node) $children) $head)

                ;; Process Child
                (($tNew $mNew) 
                    (if (== $node prioritized_or)
                        ;; Case A: Control Node - Recurse
                        (eval (buildStrategy $tree (mkNodeId $curId) $MMap))
                        
                        ;; Case B: Atomic Move (Terminal)
                        ;; In buildLogical, this inserts a new operator to allow growth.
                        ;; Here, we insert a 'prioritized_or' above the move to allow the chain to expand.
                        ;; Then we add knobs to this new structure.
                        (let $itree (eval (insertNodeAtPosition $tree (mkNodeId $curId) (mkNode prioritized_or))) 
                             (eval (addStrategyKnobs $itree (mkNodeId $curId) True $MMap)))
                    )
                )
     
                ;; Recurse to next sibling
                (($tailT $tailM) (eval (strategySiblingIt $tNew $tail (mkNodeId $parentId) (+ $childNum 1) $mNew)))
             )
             ($tailT $tailM)))

; (: buildStrategy (-> (Tree $a) NodeId (MultiMap ($k $v)) ((Tree $a) (MultiMap ($k $v))))) 
(= (buildStrategy $tree (mkNodeId $nodeId) $MMap)
  (let $subtree (eval (getNodeById $tree (mkNodeId $nodeId)))
    ;; 1. Safety Check (from buildLogical)
    (if (== True (eval (isNullVertex $subtree)))
        ($tree $MMap) 
        (let*
        (
            ;; Deconstruct the current node
            ((mkTree (mkNode $op) $children) $subtree) 
            
            ;; 2. THE MISSING PART: Add knobs to the current node
            ;; This allows the algorithm to swap the current node (e.g., 'prioritized_or' or a Move) 
            ;; with alternatives defined in 'addStrategyKnobs'.
            (($t1 $mp1) (eval (addStrategyKnobs $tree (mkNodeId $nodeId) True $MMap)))
            
            ;; 3. Process Children
            ;; Iterate through children to build knobs recursively
            (($updatedTree $updatedMMap) (eval (strategySiblingIt $t1 $children (mkNodeId $nodeId) 1 $mp1)))
        )
            ($updatedTree $updatedMMap)
        )
    )
  )
)
