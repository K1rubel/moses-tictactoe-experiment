; (: buildKnobs (-> (Tree $a) (MultiMap ($k $v)) Expression ((Tree $a) (MultiMap ($k $v)))))
(= (buildKnobs $exemplar $mmp)
   ;; 1. Canonize: Ensure the root is PRIORITIZED-OR
   (let (mkTree (mkNode $rootOp) $ch) $exemplar
       (let $canonTree (if (== $rootOp PRIORITIZED-OR)
                           $exemplar
                           (mkTree (mkNode PRIORITIZED-OR) (Cons $exemplar Nil)))
           
           ;; 2. Build Strategy Knobs
           (eval (buildStrategy $canonTree (mkNodeId (0)) $mmp))
       )
   )
)