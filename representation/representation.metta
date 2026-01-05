(= (getCandidate $repObj $inst)
   (let*
      (
         ($parentid (mkNodeId (0)))
         ($srcid (mkNodeId (0)))
         ;; Recursively build the tree starting from root
         ($candidate (getCandidateRec $repObj $inst $parentid $srcid (mkNullVex Nil)))
         ;; Clean up the result (remove empty placeholders)
         ($cleanedTree (eval (cleanTree $candidate)))
      )
      $cleanedTree
   )
)

(= (getCandidateRec (mkRep $knobMapObj $tree) (mkInst $inst) $parentId $srcId $candidate)
   ;; 1. Check if the current Node ($srcId) has a Knob associated with it
   (let $knobIdxPair (eval (findDiscKnob $knobMapObj $srcId)) 
      (if (not (== (eval (second-from-pair $knobIdxPair)) -1))
         ;; CASE A: Knob Found
         (let*
            (          
               ;; Retrieve the setting (0 or 1) from the Instance list using the knob's index
               ($d (eval (List.getByIdx $inst (eval (second-from-pair $knobIdxPair)))))
               ;; Call appendTo (or strategyAppendTo) to insert the chosen strategy component
               ($updatedCnd (eval (appendTo $tree (eval (first-from-pair $knobIdxPair)) $candidate $parentId $d)))
            )
            $updatedCnd
         )
         ;; CASE B: No Knob Found (Structure is fixed)
         (let*
            (
               ;; Get the node value (e.g., prioritized_or)
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

;; representation constructor
;; Params: Tree (Exemplar)
;; Returns: Representation
; (: representation (-> (Tree $a) Representation))
(= (representation $exemplar $nDeme)
   (let $demeCount (range $nDeme)
      (collapse (let $x (superpose $demeCount) ;; to create multiple representations and hence demes
         (let*
            (
               (($updatedTree $dscMp) (buildKnobs $exemplar NilMMap))
               ($dscKbMp (crtDiscKnobMap (mkDscMp $dscMp) (mkDscKbMp NilMap) 0))
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
    ($updatedDkm (eval (Map.insert ($loc $index) $dkm == nodeId<)))
   ) 
   (eval (crtDiscKnobMap (mkDscMp $tail) (mkDscKbMp $updatedDkm) (+ $index 1)))
  ))


  