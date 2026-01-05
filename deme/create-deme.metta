;; Creates a new deme with an empty instance set
;; Params:
;;   $exemplar: The exemplar tree
;;   $nExpansion: total number of deme expansions (generations) set to 0 -- a constant number or a generation demes
;;   $nDemes: Number of feature sets to select out of feature selection and demes to spawn
;; Return: A new empty deme with the specified representation and ID
; (: createDeme (-> (Tree $a) Number Number Deme)) 
; (= (createDeme $exemplar $nExpansion $nDeme)
;    (let*
;    (
;     ($demeIds (createDemeIds $nExpansion $nDeme))
;     ($representation (representation $exemplar $nDeme))
;     ($demeId (List.getByIdx $demeIds 0))
;     ($score (pow-math -10 3)) ;; I thought (pow-math -10 308) is unecessarily small number
;    )
;    (mkDeme $representation (mkSInstSet $score Nil) $demeId)))

(= (createDeme $nDeme $demeIds $exemplar)
      (let* (($_ (println! (creating representations ....)))
             ($reps (representation $exemplar $nDeme))
             ($_ (println! (done making representations ...)))
            )  
         (loopCreateDeme $demeIds $reps ())
        ))

(= (loopCreateDeme $demeIds $reps $acc)
    (if (== $reps ())
        $acc
        (let* ((($h $t) (decons-atom $reps))
                ($demeId (List.head $demeIds)) 
                ($deme (mkDeme $h (mkSInstSet Nil) $demeId))
                ($new-acc (union-atom $acc ($deme))))
                  
                  (loopCreateDeme (List.tail $demeIds) $t $new-acc))))

;; deme-id creation

; (: createDemeIds (-> Number Number (List DemeId)))
(= (createDemeIds $nExpansion $nDeme)
    (if (> $nDeme 1)
        (demeIdList (+ $nExpansion 1) (- $nDeme 1) Nil)
        (chain (+ $nExpansion 1) $n 
            (chain (py-format "{}" $n) $str
                (chain (mkDemeId $str) $demeId (Cons $demeId Nil))))))

(= (demeIdList $nExpansion $nDeme $list)
    (if (< $nDeme 0)
        $list
        (let* ((($str1 $str2) ((py-format "{}" $nExpansion) (py-format "{}" $nDeme)))
                ($demeId (mkDemeId (py-format "{}.{}" $str1 $str2)))
                ($newList (List.prepend $demeId $list)))

                (demeIdList $nExpansion (- $nDeme 1) $newList))))                