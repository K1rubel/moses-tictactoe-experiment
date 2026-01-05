; (: buildKnobs (-> (Tree $a) (MultiMap ($k $v)) Expression ((Tree $a) (MultiMap ($k $v)))))
(= (buildKnobs $exemplar $mmp)
   ;; 1. Canonize: Ensure the root is prioritized_or
   (let (mkTree (mkNode $rootOp) $ch) $exemplar
       (let $canonTree (if (== $rootOp prioritized_or)
                           $exemplar
                           (mkTree (mkNode prioritized_or) (Cons $exemplar Nil)))
           
           ;; 2. Build Strategy Knobs
           (eval (buildStrategy $canonTree (mkNodeId (0)) $mmp))
       )
   )
)