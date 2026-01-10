;; Recursively optimizes each deme in a list using the provided optimizer function.
;; Params:
;;   (List Deme): The list of demes to optimize.
;;   $truthTableBScore: The scoring function or object.
;;   $inst: The initial instance for optimization.
;;   $optimize: The optimizer function to apply to each deme.
;;  Returns: (List Deme): A new list where each deme has been optimized.
; (: optimizeDemes (-> (List Deme) (TruthTableBScore $a) Instance (-> Deme (TruthTableBScore $a) Instance $Scorer (Instance Deme $state)) $Scorer (List (Instance Deme $state))))
(= (optimizeDemes $deme $inst $optimizer)
($optimizer $deme $inst))

;; Runs one deme-creation and optimization step, then merges the optimized deme into the metapopulation.
;; Params:
;;   $metaPop: The current metapopulation.
;;   $nExpansion: Expansion count or deme index.
;;   $nDeme: Number of demes to create.
;;   $truthTableBScore: TruthTableBScore
;;   $optimize: Optimizer function (e.g., hill climbing).
;;   $nEval: Maximum number of evaluations.
;;   $maxCandsPerDeme: Maximum candidates per deme.
;;   $minPoolSize: Minimum deme size to retain.
;;   $complexityTemperature: Parameter for score range in trimming.
;;   $itable: The input table.
;;   $nToKeep: Target size for resized metapopulation.
;;   $capCoef: Capacity coefficient for resizing.
;;   $genCount: Generation count for resizing.
;; Returns:
;;   $updatedMetaPop: Updated metapopulation with the new optimized deme merged in.
; (: expandDeme (-> (OS (Exemplar $a)) Number Number Bool Symbol (TruthTableBScore $a) (-> Deme (TruthTableBScore $a) Instance $Scorer (Instance Deme $state)) $Scorer Number Number Number Number (ITable $a) Number Number Number (OS (Exemplar $a))))
; (: expandDeme (-> (OS (Exemplar $a)) Number Number Bool Symbol (TruthTableBScore $a) (-> Deme (TruthTableBScore $a) Instance $Scorer (Instance Deme $state)) $Scorer Number Number Number Number (ITable $a) Number Number Number (OS (Exemplar $a))))
(= (expandDeme $metaPop $nExpansion $nDeme $optimize)
(let*
   (
    ($exemplar (trace! "Selecting Exemplar" (eval (selectExemplar $metaPop))))
    ($_ (println! $exemplar))
    ($tree (trace! "getting exemplar tree" (eval (getExemplarTree $exemplar)))) 
    ($_ (println! $tree))
    ($demeIds (trace! "creating deme IDs" (eval (createDemeIds $nExpansion $nDeme))))
    ($_ (println! $demeIds))
    ; ($argLabels (getArgLabels $itable))
    ($demes (trace! "Creating Deme" (eval (createDeme $nDeme $demeIds $tree))))
    )
    (map-atom $demes $deme (expandDemeHelper $deme $optimize))
   ))

(= (expandDemeHelper (mkDeme (mkRep (mkKbMap (mkDscKbMp $dscKbMp) (mkDscMp $dscMp)) $updatedTree) $sInstList $demeId) $optimize)
(let*
(
    ($lengthOfDscKbMp (eval (Map.length $dscKbMp)))
    ($generatedList (eval (List.generate $lengthOfDscKbMp 0)))
    ($deme (mkDeme (mkRep (mkKbMap (mkDscKbMp $dscKbMp) (mkDscMp $dscMp)) $updatedTree) $sInstList $demeId))
    (($inst $optimDeme $state) (trace! "Optimizing Deme" (eval (optimizeDemes $deme (mkInst $generatedList) $optimize))))
)
$optimDeme
; (optimizeDemes $deme (mkInst $generatedList) $optimize)
)
)
;; The main loop 
;; Takes 2 termination criterias:
;;     - $maxGen : how many times we want the loop to run
;;     - $maxScore : the maximum score we want the top Examplar to have
;; It also takes:
;;     - $maxCandOutput : The number of candidates to be returned
;;     - other parameters required by the expandDeme method
; (: runMoses (-> Number Cscore Number (OS (Exemplar $a)) Number Number Bool Symbol (TruthTableBScore $a) (-> Deme (TruthTableBScore $a) Instance $Scorer (Instance Deme $state)) $Scorer Number Number Number Number (ITable $a) Number Number Number (OS (Exemplar $a))))
(= (runMoses $maxGen $maxScore $maxCandOutput $metaPop $nExpansion $nDeme $optimize $nEval $maxCandsPerDeme $minPoolSize $complexityTemperature $nToKeep $capCoef $genCount)
(if (== $maxGen 0)
    (if (<= $maxCandOutput (eval (OS.length $metaPop)))
        (let $topCandidates (eval (OS.getTopN $maxCandOutput $metaPop)) $topCandidates)
        $metaPop
    )
    ; (trace! ($maxCandOutput $metaPop) (let $topCandidates (OS.getTopN $maxCandOutput $metaPop) $topCandidates))
    (let* 
     (
       ($optimizedDemes (expandDeme $metaPop $nExpansion $nDeme $optimize))
       ($updatedMetaPop (eval (mergeDemes $optimizedDemes $nEval $maxCandsPerDeme $minPoolSize $complexityTemperature $metaPop $nToKeep $capCoef $genCount)))
       ($_ (println! (generation (- 5 $maxGen) $updatedMetaPop)))
       ($top (OS.getByIdx 0 $metaPop))
       ($_ (println! (top exemplar in generation (- 5 $maxGen) $top)))
       ($topScore (getExemplarCscore $top))
        ($_ (println! (top score  in generation (- 5 $maxGen) $topScore)))
        ($resultCandi (if (<= $maxCandOutput (eval (OS.length $metaPop))) (eval (OS.getTopN $maxCandOutput $metaPop)) $metaPop))
        ($_ (cut)))
    ;    ($resultCandi  (OS.getTopN $maxCandOutput $updatedMetaPop))
        ; ($_ (println! (generation _____________________________________ (- 3 $maxGen) final candidates $finalTopCandidates))))
     (if (eval(cScore>= $topScore $maxScore)) 
         $resultCandi 
         (let $_ (println! (running generation count (- 5 $maxGen))) (runMoses (- $maxGen 1) $maxScore $maxCandOutput $updatedMetaPop $nExpansion $nDeme $optimize $nEval $maxCandsPerDeme $minPoolSize $complexityTemperature $nToKeep $capCoef $genCount))))))
