!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)
!(import! &self ../../representation/ssk)
!(import! &self ../../representation/knob-representation)
!(import! &self ../../representation/strategy-probe)

!(strategyProbe (mkTree (mkNode prioritized_or) (Cons (mkTree (mkNode play-win)) Nil))
    (mkNodeId (0))
    ((mkTree (mkNode play-block) Nil) (mkTree (mkNode play-win) Nil)) True ())

; !(strategySubtreeKnob  (mkTree (mkNode prioritized_or) Nil) (mkNodeId (0)) (mkTree (mkNode play-block) Nil))