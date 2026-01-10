(= (worstCscore)
    (mkCscore (* -1 (pow-math 10 3)) 0 0.0 0.0 (* -1 (pow-math 10 3))))

(= (getPenScore (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)) $penalizedScore)
 
(= (getScore (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)) $scor)

(= (getComp (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)) $cpxy)

(= (getCompPen (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)) $complexityPenalty)

(= (getUniPen (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)) $uniformityPenalty)

;; I dont see the advantage of caching the results as there is non-deterministic behaviour
(= (getCscore $tree $complexityRatio)
    (let* (($bs (scoreStrategy $board $player1 $tree 5))
            ($_ (println! (behavioral score for the tree $bs))))
    ; (chain (eval (scoreStrategy $board $player1 $tree 5)) $bs ;; this runs the tree strategy for 5 iterations and record the bscore as a list (Cons .. (Cons ..))
        (if-error $bs ;; return worst possible composite score
            (eval (worstCscore))
            (let* (($bsum (eval (sumBScore $bs)))
                    ($_ (println! (sum of behavioral score $bsum)))
                    ($cpxy (treeComplexity $tree))
                    ($cCoef (getComplexityCoef $complexityRatio))
                    ($res (updatePenalizedScore (mkCscore $bsum $cpxy (* $cpxy $cCoef) 0.0 (* -1 (pow-math 10 3)))  False)))

                    $res ))))
                ; )

(= (getComplexityCoef $complexityRatio)
    (if (> $complexityRatio 0)
        (/ 1.0 $complexityRatio)
        0.0))                       

(= (updatePenalizedScore (mkCscore $scor $cpxy $cpxyPenalty $uniformityPenalty $penalizedScore) $multiplyDiversity)
    (let* (($temp (- $scor $cpxyPenalty))
           ($updatedPScore (eval (if $multiplyDiversity (* $temp $uniformityPenalty) (- $temp $uniformityPenalty))))
           ($_ (println! (PenalizedScore: $updatedPScore))))
        
            (mkCscore $scor $cpxy $cpxyPenalty $uniformityPenalty $updatedPScore)))        

(= (cScoreExpr< (($scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)) 
                    (($scor2 $cpxy2 $complexityPenalty2 $uniformityPenalty2 $penalizedScore2)))
    
        (if (isnan-math $penalizedScore)
            (not (isnan-math $penalizedScore2))
            (or (< $penalizedScore $penalizedScore2) (and (== $penalizedScore $penalizedScore2) (> $cpxy $cpxy2)))))
            
;; Check for equality, to within floating-point error, EPSILON
; (: cScore== (-> Cscore Cscore Bool))
(= (cScore== $cs1 $cs2)
    (let ($sL $cL $cpL $upL $pL $sR $cR $cpR $upR $pR) 
            ((getScore $cs1) (getComp $cs1) (getCompPen $cs1) (getUniPen $cs1) (getPenScore $cs1)
            (getScore $cs2) (getComp $cs2) (getCompPen $cs2) (getUniPen $cs2) (getPenScore $cs2)) 
        
            (and (isApproxEq $sL $sR) 
                (and (isApproxEq $cL $cR) 
                    (and (isApproxEq $cpL $cpR) 
                        (and (isApproxEq $upL $upR) (isApproxEq $pL $pR)))))))

; (: cScore>= (-> Cscore Cscore Bool)) 
(= (cScore>= $cs1 $cs2)
    (let ($pl $pr $cl $cr) ((getPenScore $cs1) (getPenScore $cs2) (getComp $cs1) (getComp $cs2))
        (if (isnan-math $pl)
            False
            (or (> $pl $pr) (and (== $pl $pr) (< $cl $cr))))))

(= (setUniPen (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore) $newUniPen)
    (mkCscore $scor $cpxy $complexityPenalty $newUniPen $penalizedScore))

(= (cScoreToExpr (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore))
    (let* (
        ($e1 (cons-atom $penalizedScore ()))
        ($e2 (cons-atom $uniformityPenalty $e1))
        ($e3 (cons-atom $complexityPenalty $e2))
        ($e4 (cons-atom $cpxy $e3))
        ($e5 (cons-atom $scor $e4))
    )
        ($e5)
    )
)

;; (:exprToCScore (-> Expression Cscore))
(= (exprToCScore $exp)
    (let* (
        ($expr (car-atom $exp))
        (($scor $rest1) (decons-atom $expr))
        (($cpxy $rest2) (decons-atom $rest1))
        (($complexityPenalty $rest3) (decons-atom $rest2))
        (($uniformityPenalty $rest4) (decons-atom $rest3))
        (($penalizedScore $_) (decons-atom $rest4))
    )
        (mkCscore $scor $cpxy $complexityPenalty $uniformityPenalty $penalizedScore)
    )
)
