!(import! &self ../../utilities/general-helpers)
!(import! &self ../../utilities/node-id)
!(import! &self ../../utilities/tree)
!(import! &self ../../representation/ssk)

!(strategySubtreeKnob (mkTree (mkNode PRIORITIZED-OR) Nil)
    (mkNodeId (0)) (mkTree (mkNode play-fork)))

