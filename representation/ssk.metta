;; (: strategySubtreeKnob (-> (Tree $a) NodeId (Tree $a) (Tree $a StrategySubtreeKnob)))
(= (strategySubtreeKnob $tree (mkNodeId $target) $subtree)
   (let $childrenOfTarget (eval (getChildrenById $tree (mkNodeId $target)))
       
       ;; Case 1: Subtree already exists in children
       (if (== True (eval (List.contains $subtree $childrenOfTarget)))
           (let $idOfSubtree (eval (getSubtreeId $tree (mkNodeId $target) $subtree 0))
               ;; Create Knob: Multiplicity 2 (0=Absent, 1=Present). Default=1 (Present)
               ($tree (mkSSK (mkDiscKnob (mkKnob (updateID $idOfSubtree)) (mkMultip 2) (mkDiscSpec 1) (mkDiscSpec 1) Nil)))
           )
           ;; Case 2: New Subtree (Insert placeholder)
           (let*
               (
                   ;; Insert NullVertex placeholder
                   (($nullVexAppendedTree $nullVexId) (eval (appendChild $tree (mkNodeId $target) (mkNullVex Nil))))
                   ;; Attach the actual subtree to the placeholder (conceptually)
                   (($subtreeAppendedTree $subtreeId) (eval (appendChild $nullVexAppendedTree $nullVexId $subtree)))
               )
               ;; Create Knob: Multiplicity 2. Default=0 (Absent/NullVertex)
               ($subtreeAppendedTree (mkSSK (mkDiscKnob (mkKnob (updateID $nullVexId)) (mkMultip 2) (mkDiscSpec 0) (mkDiscSpec 0) Nil)))
           )
       )
   )
)