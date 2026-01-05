; (: strategyProbe (-> (Tree $a) NodeId Expression Bool Expression Expression))
(= (strategyProbe $exemplar (mkNodeId $targetId) () $addIfInExemplar $knobs) ($knobs $exemplar))
(= (strategyProbe $exemplar (mkNodeId $targetId) $perms $addIfInExemplar $knobs)
   (let*
   (
       (($headPerms $tailPerms) (decons-atom $perms))
       ;; CHANGE: Call strategySubtreeKnob instead of logicalSubtreeKnob
       (($updatedTree $ssk) (eval (strategySubtreeKnob $exemplar (mkNodeId $targetId) $headPerms)))
       ($discKnob (eval (getDiscKnob $ssk)))
   )

   (if (or $addIfInExemplar (not (eval (inExemplar $discKnob)) )) 
       (let* (
           ($updatedKnobs (eval (concatT $knobs ($ssk))))
       )
       (eval (strategyProbe $updatedTree (mkNodeId $targetId) $tailPerms $addIfInExemplar $updatedKnobs))
       )
       (eval (strategyProbe $exemplar (mkNodeId $targetId) $tailPerms $addIfInExemplar $knobs)))))