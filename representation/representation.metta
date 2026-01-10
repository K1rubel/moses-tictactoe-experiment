(= (getCandidate $repObj $inst)
   (let*
      (
         ($parentid (mkNodeId (0)))
         ($srcid (mkNodeId (0)))
         ; ($_ (println! (parent and source Ids $parentid $srcid)))
         ;; Recursively build the tree starting from root
         ($candidate (getCandidateRec $repObj $inst $parentid $srcid (mkNullVex Nil)))
         ($_ (println! (candidate tree?? $candidate)))
         ;; Clean up the result (remove empty placeholders)
         ($cleanedTree (eval (cleanTree $candidate)))
         ($_ (println! (cleaned tree $cleanedTree)))
      )
      $cleanedTree
   )
)

(= (getCandidateRec (mkRep $knobMapObj $tree) (mkInst $inst) $parentId $srcId $candidate)
   ;; 1. Check if the current Node ($srcId) has a Knob associated with it
   (let* (($knobIdxPair (eval (findDiscKnob $knobMapObj $srcId)))
         ; ($_ (println! (knob id pair $knobIdxPair)))
      ) 
      (if (not (== (eval (second-from-pair $knobIdxPair)) -1))
         ;; CASE A: Knob Found
         (let*
            (          
               ;; Retrieve the setting (0 or 1) from the Instance list using the knob's index
               ($d (eval (List.getByIdx $inst (eval (second-from-pair $knobIdxPair)))))
               ; ($_ (println! (value of inst ad index value (second-from-pair $knobIdxPair $d))))
               ;; Call appendTo (or strategyAppendTo) to insert the chosen strategy component
               ($updatedCnd (eval (appendTo $tree (eval (first-from-pair $knobIdxPair)) $candidate $parentId $d)))
               ; ($_ (println! (updatead candidate is $updatedCnd)))
            )
            $updatedCnd
         )
         ;; CASE B: No Knob Found (Structure is fixed)
         (let*
            (
               ;; Get the node value (e.g., PRIORITIZED-OR)
               ($src (eval (getNodeById $tree $srcId)))
               ;; Copy it to the candidate tree
               ($cndchidpair (eval (appendChild $candidate $parentId (mkTree (eval (getNodeValue $src)) Nil))))       
               ;; Recurse on all children
               ($srcchildren (eval (getChildren $src)))
               ($state (eval (List.foldl applyGetCandidateRec ((mkRep $knobMapObj $tree) (mkInst $inst) (eval (second-from-pair $cndchidpair)) (eval (first-from-pair $cndchidpair)) 1) $srcchildren)))
               (((mkRep $knobmapobj $tree) (mkInst $inst) $newparentid $finalcnd $d) $state)
            )
              $finalcnd
          )
   )
)
)

(= (applyGetCandidateRec $tr ($repObj $inst (mkNodeId $parentId) $candidate $chIdx))
   (let*
      (
         ($_ (println! ("applyGetCandidateRec called with parentId:" $parentId , chIdx: $chIdx)))
         ($srcId (if (== $parentId (0)) (mkNodeId ($chIdx)) (mkNodeId (eval (concatT $parentId ($chIdx))))))
         ($_ (println! (srcId: $srcId)))
         ($updatedCnd (eval (getCandidateRec $repObj $inst (mkNodeId $parentId) $srcId $candidate)))
         ($_ (println! (updatedCnd: $updatedCnd)))
         ($finalResult ($repObj $inst (mkNodeId $parentId) $updatedCnd (+ 1 $chIdx)))
         ($_ (println! ("applyGetCandidateRec returning finalResult:" $finalResult)))
      )
      $finalResult
   )
)

;; representation constructor
;; Params: Tree (Exemplar)
;; Returns: Representation
; (: representation (-> (Tree $a) Representation))
(= (representation $exemplar $nDeme)
   (let $demeCount (eval (range $nDeme))
      (collapse (let $x (superpose $demeCount) ;; to create multiple representations and hence demes
         (let*
            (
               (($updatedTree $dscMp) (eval (buildKnobs $exemplar NilMMap)))
               ($_ (println! (knobs built .....)))
               ($dscKbMp (eval (crtDiscKnobMap (mkDscMp $dscMp) (mkDscKbMp NilMap) 0)))
            )   
               (mkRep (mkKbMap $dscKbMp (mkDscMp $dscMp)) $updatedTree))))))

;; helper function to representation
;; Converts DiscMap (multimap of knobSpec & knob) to DiscKnobMap (map of location & index)
;; Params: DiscMap
;; Returns: DiscKnobMap
;; (: crtDiscKnobMap (-> DiscMap DiscKnobMap Number DiscKnobMap))
(= (crtDiscKnobMap (mkDscMp NilMMap) (mkDscKbMp $dkm) $index) (mkDscKbMp $dkm))
(= (crtDiscKnobMap (mkDscMp (ConsMMap ($kbSpec $kb) $tail)) (mkDscKbMp $dkm) $index)
   (let*
   (
    ($loc (eval (getKnobLoc $kb)))
   ;  ($_ (println! (location of the knob ...)))
    ($updatedDkm (eval (Map.insert ($loc $index) $dkm == nodeId<)))
   ) 
   (eval (crtDiscKnobMap (mkDscMp $tail) (mkDscKbMp $updatedDkm) (+ $index 1)))
  ))


  