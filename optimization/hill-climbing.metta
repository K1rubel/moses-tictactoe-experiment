(= (hillClimbing $POASet $centerInst)
    (let*
        (
        ($disc (getDisk $POASet)) 
        ; ;; complexity is the only parameter that we want for strategy evolution
        (($cpxCoeff $size) (getCoef))
        )
        ;; best score for a game strategy ==> 1 for win
        (hillClimbing (2 3 5) (False False False $centerInst (worstCscore) (* -1 (pow-math 10 3)) 0 0 1)
                    $POASet
                    ($disc $cpxCoeff $size)
                    $centerInst
                    ()
                    estimateNeighborhood crossover
                    sampleNewInstances transform)))


(= (hillClimbing ($maxDist $minXoverNeighbors $bestPossibleScore) ;; Constant parameters
                 ($alreadyXover $lastChance $__ $prevCenter $bestSscore $bestScore $currentNInstances $d $i)
                 $POASet
                 ($neighborhood $rowOCoeff $size)
                 $centerInst
                 $hyperparamsfs
                 $estimateFunction $crossoverFunction $samplingFunction $transformFunction) ;; Helper functions
   (let*
      (
        ($_ (println! (Iteration $i running)))
        ($_ (println! ""))

        ($totalNNeighbors ($estimateFunction $d $neighborhood))

        ($_ (println! (Estimated neighbors: $totalNNeighbors)))
        ($_ (println! ""))

        ($nNewNeighbors (min $totalNNeighbors 2))

        ($largeNbh (>= $totalNNeighbors $minXoverNeighbors))
        ($xOver (and (> $i 2) (and (not $alreadyXover) (or $largeNbh $lastChance)))) ;; INFO: Has to be greater than 2 minimum.
        ($_ (println! (Crossover: $xOver)))
        ($_ (println! (size: $size)))
        ($_ (println! ($totalNNeighbors : $nNewNeighbors : $prevCenter : $POASet : $d)))
        ( 
          ; $newPOA
          ((mkDeme $rep $updatedInstSet $id) $newInstances)
                                                            (case ($xOver $size)
                                                              (
                                                                ((True ()) (let ($updatedInstSet $newInstances) (eval ($crossoverFunction $currentNInstances $nNewNeighbors $prevCenter $POASet))
                                                                              ((mkDeme () $updatedInstSet ()) $newInstances)))
                                                                ((True $notEmpty)  (eval ($crossoverFunction $currentNInstances $nNewNeighbors $prevCenter $POASet)))
                                                                ((False ()) (let ($updatedInstSet $newInstances) (eval ($samplingFunction $totalNNeighbors $nNewNeighbors $prevCenter (mkITable $rowOCoeff $neighborhood) $POASet $d))
                                                                              ((mkDeme () $updatedInstSet ()) $newInstances)))
                                                                ((False $notEmpty) 
                                                                        (let $result (eval ($samplingFunction $totalNNeighbors $nNewNeighbors $prevCenter $POASet $d))
                                                                        (trace! ("Result: " $result) $result)))
                                                              )
                                                          ))
        ; ($_ (println! (New POASet: $newPOA)))
        ; (((mkDeme $rep $upInstSet $id) $newInstances) $newPOA)
        ; ($_ (println! (New rep: $rep)))
        ; ($_ (println! (New Inst: $newInstances)))
        ($_ (println! ""))
        ($_ (println! (Newinstances: $updatedInstSet)))
        ($_ (println! ""))
        ;; deconstruct the hyper params for fs function
;         ; (($miConfi $prePenalty $preMinActivation $preMaxActivation $prePositive $scorerType) (if (== () $hyperparamsfs) (() () () () () ()) $hyperparamsfs))

        ((mkSInstSet $scoredInstances) (eval ($transformFunction $updatedInstSet $rep $rowOCoeff))) 

        ($updatedDeme (if (or (== $rep ()) (== $id ())) 
                          (mkSInstSet $scoredInstances) 
                          (mkDeme $rep (mkSInstSet $scoredInstances) $id)))
        
        ($_ (println! (Scored instances: $scoredInstances)))
        ($_ (println! ""))

        ((mkSInst $newBestInstPair) (eval (List.foldl ((eval (curry2 returnBest)) <) (mkSInst (mkPair $centerInst $bestSscore)) $scoredInstances))) 
        ($newBestScore (if (or (== $rep ()) (== $id ())) 
                          (Pair.second $newBestInstPair)
                          (eval (getPenScore (Pair.second $newBestInstPair))))) ;; This could be the original best candidate or a new one.
        ($hasImproved (> $newBestScore (+ $bestScore 0.5))) ;; Hard coded the score_improved function for now. This is automated in the C++ version.
                                                        
        ($_ (println! (Best instance: $newBestInstPair)))
        ($_ (println! (New best score: $newBestScore)))
        ($_ (println! ""))

        ($nextCenterInst (if $hasImproved (eval (Pair.first $newBestInstPair)) $centerInst)) 
        ($nextDistance (if $hasImproved 1 (if (not $xOver) (+ 1 $d) $d)))
        
        ($_ (println! (NextDistance: $nextDistance)))

        (($newCenter $newDeme ($newXover $newLastChance $newHasImproved $newPrevCenter $newBestSscore $nextNewBestScore $newCurrentNInstance $newDistance $newI))
                              (if (and (== $totalNNeighbors 1) (== $nextDistance 1))
                                  (hillClimbing ($maxDist $minXoverNeighbors $bestPossibleScore)
                                                ((and $xOver (not $hasImproved)) $lastChance $hasImproved $centerInst (eval (Pair.second $newBestInstPair)) $newBestScore (+ $currentNInstances $newInstances) $nextDistance (+ 1 $i)) ;; Updated state
                                                $updatedDeme
                                                ($neighborhood $rowOCoeff $size)
                                                $nextCenterInst
                                                $hyperparamsfs
                                                $estimateFunction $crossoverFunction $samplingFunction $transformFunction)
                                  ($nextCenterInst $updatedDeme ((and $xOver (not $hasImproved)) $lastChance $hasImproved $centerInst (eval (Pair.second $newBestInstPair)) $newBestScore (+ $currentNInstances $newInstances) $nextDistance $i)))) ;; ) (new center new best score $newCenter $newBestSscore)))
        
        ($scoreToCompareBelow (if (or (== $rep ()) (== $id ())) $newBestSscore (eval (getScore $newBestSscore))))
        ($_ (println! (Found newBestSscore After (+ 1 $i) iteration is: $newBestSscore $scoreToCompareBelow)))
        ($_ (println! ""))
        ($_ (println! (cut)))
    )
    (if (<= $bestPossibleScore $scoreToCompareBelow)
          (trace! (Terminating because of best possible score: $bestPossibleScore found $scoreToCompareBelow) ($newCenter $newDeme ($newXover $newLastChance $newHasImproved $newPrevCenter $newBestSscore $nextNewBestScore $newCurrentNInstance $newDistance $newI)))
          (let ($finalCenter $finalDeme ($finalXover $finalLastChance $finalHasImproved $finalPrevCenter $finalBestCscore $finalNewBestScore $finalCurrentNInstance $finalDistance $finalI))
            ;; TODO: The C++ version checks the hyper parameter hc_params.crossover before getting here.
            ;; TODO: The C++ version checks for the hc_params.widen_search too. For now, we're assuming it is always true. 
            ;;       Hence the omission of the distance check from the C++ Hence the omission of the distance check from the C++
            (if (and (and (not $newHasImproved) (not $newLastChance)) (not $newXover))
                ;; If we just did the nearest neighbors and found no improvement,
                ;;  then try again one last time, we may get lucky.
                (hillClimbing ($maxDist $minXoverNeighbors $bestPossibleScore)
                              ($newXover True $newHasImproved $newPrevCenter $newBestSscore $nextNewBestScore $newCurrentNInstance $newDistance (+ 1 $newI)) ;; Updated state
                              $newDeme
                              ($neighborhood $rowOCoeff $size)
                              $newCenter
                              $hyperparamsfs
                              $estimateFunction $crossoverFunction $samplingFunction $transformFunction)
                (trace! (Continue to next iteration because of no more last chance) ($newCenter $newDeme ($newXover $newLastChance $newHasImproved $newPrevCenter $newBestSscore $nextNewBestScore $newCurrentNInstance $newDistance $newI))) )
 
            (if (< $maxDist $finalDistance)
                (trace! (Terminating because of maximum distance reached) ($finalCenter $finalDeme ($finalXover False $hasImproved $finalPrevCenter $finalBestCscore $finalNewBestScore $finalCurrentNInstance $finalDistance $finalI))) ;; I don't know why I didn't do this earlier but incrementing is needed here.
                (hillClimbing ($maxDist $minXoverNeighbors $bestPossibleScore)
                              ($finalXover False $hasImproved $finalPrevCenter $finalBestCscore $finalNewBestScore $finalCurrentNInstance $finalDistance (+ 1 $finalI)) ;; Updated state
                              $finalDeme
                              ($neighborhood $rowOCoeff $size)
                              $finalCenter
                              $hyperparamsfs
                              $estimateFunction $crossoverFunction $samplingFunction $transformFunction))
          )
    ) 
    )          
)

;; Complexity coeficient value of 2
;; And 5 for the size var -- number of games to play

(= (getCoef) (2 5))

(= (getDisk (mkDeme (mkRep (mkKbMap (mkDscKbMp $idxMp) (mkDscMp $disc)) $tree) $instSet $id))
    $disc
)

;; Verbatim port of the Infromation theoretic bits function from c++
;; Params: $knobMap: A map of knobs with their multiplicities
;; Returns: Sum of the multiplicities of the knobs in the map
; (: informationTheoreticBits (-> (MultiMap (DiscSpec $knob)) Number))
(= (informationTheoreticBits $knobMap)
    (chain (eval (MultiMap.values $knobMap)) $knobs
      (chain (eval (List.map getKnobMultip $knobs)) $multips
        (chain (eval (List.foldr add (mkMultip 0) $multips)) $res
          (let (mkMultip $val) $res $val)))))

;; Verbatim port of the Estimate neighborhood function from c++
;; Params: $distance: The hamming distance from the current knob
;;         $knobMap: A map of knobs with their multiplicities
;; Returns: 2 * Sum of the multiplicities of the knobs in the map
; (: estimateNeighborhood (-> Number (MultiMap (DiscSpec $knob)) Number))
(= (estimateNeighborhood $distance $knobMap)
   (if (== $distance 0)
       1
       (let $nnEstimate (informationTheoreticBits $knobMap) (* 2 $nnEstimate)))) ;; INFO: Could use a safe binomial coefficient here if the estiamte starts becoming very large.

(= (crossover $demeSize $nNewInstances $centerInst $deme) (trace! (Running cross over for $centerInst) ((eval (crossTopOne $deme $nNewInstances 0 $demeSize $centerInst)) $nNewInstances))) ;; WARN: The $nNewInstances might not be the actual number of instances created.

(= (returnBest (mkSInst $inst1) (mkSInst $inst2)) (returnBest < (mkSInst $inst1) (mkSInst $inst2)) )


;; (: returnBest (-> (-> $score $score Bool) (ScoredInstance $score) (ScoredInstance $score) (ScoredInstance $score)))
(= (returnBest $lessFn (mkSInst $inst1) (mkSInst $inst2))
   (if (apply $lessFn (eval (Pair.second $inst1)) (eval (Pair.second $inst2)))
       (mkSInst $inst2)
       (mkSInst $inst1)))


(= (countNeighborhoodFromIdx (mkKbMap $dscKbMp (mkDscMp $dscMp)) $inst $dist $startIdx $maxCount)
(if (== $dist 0) 
    1 
    (if (>= $startIdx (eval (MultiMap.length $dscMp))) 
        0
        (let $updatedNumInstances (eval (countNeighborhoodFromIdx (mkKbMap $dscKbMp (mkDscMp $dscMp)) $inst $dist (+ $startIdx 1) $maxCount))
          (if  (> $updatedNumInstances $maxCount) 
               $updatedNumInstances
               (let*
                 (
                    (($kbSpec $knob) (eval (MultiMap.getByIdx $startIdx $dscMp)))
                    ((mkMultip $multip) (eval (getKnobMultip $knob)))
                    ($uUpdatedNumInstances (+ $updatedNumInstances (* (- $multip 1) (eval (countNeighborhoodFromIdx (mkKbMap $dscKbMp (mkDscMp $dscMp)) $inst (- $dist 1) (+ $startIdx 1) $maxCount)))))
                 )
                 $uUpdatedNumInstances))))))

; countNeighborhood
;; (: countNeighborhood (-> KnobMap Instance Number Number Number))
(= (countNeighborhood $kbMap $inst $dist $maxCount)
(eval (countNeighborhoodFromIdx $kbMap $inst $dist 0 $maxCount)))

;; factorial
; (: factorial (-> Number Number))
(= (factorial $n)
   (if (<= $n 1) 1 (* $n (factorial (- $n 1)))))

;; binomial coefficient
; (: binomial (-> Number Number Number))
(= (binomial $n $k)
   (if (or (< $k 0) (> $k $n))
       0
       (/ (factorial $n) (* (factorial $k) (factorial (- $n $k))))))
