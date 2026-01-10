(= (transform (mkSInstSet $scoredInstList) $rep $complexityRatio)
(let*
    (
        ($instList (eval (List.map removeInstScore $scoredInstList)))
        ($_ (println! (scored instance list $instList)))
        ($cbsInstList (eval (applyComplexityBasedScore $rep $instList $complexityRatio Nil)))
    )
(mkSInstSet $cbsInstList)))  

(= (applyComplexityBasedScore $rep Nil $complexityRatio $listOfScoredInst) $listOfScoredInst)
(= (applyComplexityBasedScore $rep (Cons $i $is) $complexityRatio $listOfScoredInst)
(let*
    (
        ($score (eval (complexityBasedScorer $rep $i $complexityRatio)))
        ($scoredInst (mkSInst (mkPair $i $score)))
        ($uListofScoredInst (Cons $scoredInst $listOfScoredInst))
    )
(applyComplexityBasedScore $rep $is $complexityRatio $uListofScoredInst)))
