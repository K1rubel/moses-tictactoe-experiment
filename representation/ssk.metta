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

(= (appendTo $updatedTree $lsk $tree $parentId $d)
    (let*
       (
        ; ($_ (println! (lsk: $lsk)))
        ($targetId (eval (getNodeId $lsk)))
        ($_ (println! (node id $targetId)))
        ($targetTree (eval (getNodeById  $updatedTree $targetId)))
        ($subtree (if (== True (eval (isNullVertex $targetTree) ))
                        (let (mkNullVex (Cons $child Nil)) $targetTree $child)
                        $targetTree
                    ))        
        ($_ (println! ("subtree ": $subtree $targetTree)))
      )
      (if (> $d 2)
          (Error $d "Invalid disc specification:- cannot exceed 2.")
          (if (== True (isEmpty $tree))
              $subtree

              ;; The c++ version takes the child of the null vertex from the 
              ;;   location of the tree but we don't have access to the knob 
              ;;   decorated tree in this function. It is possible to pass 
              ;;   that tree as well but instead of increasing the function 
              ;;   parameter size, why not simply use the $subtree we already 
              ;;   have stored in the lsk? It seems to be doing the exact same thing.
              (let $treeToAppend
                   (case $d
                       (
                         (2 (eval (insertAbove $subtree (mkNode NOT)))) ;; If negated
                         (1  $subtree) ;; If present
                         (0  (mkNullVex (Cons $subtree Nil))))) ;; If absent

                   (chain (eval (appendChild $tree $parentId $treeToAppend)) $treeChIdPair
                      (eval (first-from-pair $treeChIdPair)))))))) ;; INFO: Just incase if the append fails and stores the result somewhere else, we need to add a test case here to cmpare between targetNode and appendChild node.

(= (getNodeId (mkLSK (mkDiscKnob (mkKnob $nodeId) $multi $default $current $discSpecList)))
   $nodeId)                      
(= (getNodeId (mkSSK (mkDiscKnob (mkKnob $nodeId) $multi $default $current $discSpecList)))
   $nodeId)                      