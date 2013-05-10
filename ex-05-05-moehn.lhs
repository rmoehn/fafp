Proposition:
------------
Be |P7 t <=> flatten (mapSTree f t) = map f (flatten t)|. |flatten . mapSTree
f = map f . flatten|, i. e. |P7 t| holds for all STrees |t|.

Proof by structural induction on |t|:
-------------------------------------
- Basis:

  flatten (mapSTree f Empty)
= { def mapSTree }
  flatten Empty
= { def flatten }
  []

- Hypothesis: |P7 tl| and |P7 tr| hold.

- Step:

  flatten (mapSTree f (Node tl a tr))
= { def mapSTree }
  flatten (Node (mapSTree f tl) (f a) (mapSTree f tr))
= { def flatten }
  flatten (mapSTree f tl) ++ [f a] ++ flatten (mapSTree f tr)
= { Hypothesis }
  map f (flatten tl) ++ [f a] ++ map f (flatten tr)
= { rev def map, skipping a really obvious step }
  map f (flatten tl) ++ map f [a] ++ map f (flatten tr)
= { Lemma from 05-04, maybe using associativity of ++ }
  map f (flatten tl ++ [a] ++ flatten tr)
= { rev def flatten }
  map f (flatten (Node tl a tr))

=> |P7 (Node tl a tr)| holds. And, by the principle of induction, |P7 t| holds
for all STrees |t|.
