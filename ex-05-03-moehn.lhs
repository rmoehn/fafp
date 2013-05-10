> mapSTree f Empty          = Empty
> mapSTree f (Node tl a tr) = Node (mapSTree f tl) (f a) (mapSTree f tr)

Alternatively one could define it as a fold:

< mapSTree f = foldSTree g Empty
<              where
<              g :: STree b -> a -> STree b -> STree b
<              g tl' a tr' = Node tl' (f a) tr'

However, the proofs on the fold version are a more verbose than those for the
version with pattern matching (unless I've overlooked something). Therefore
I'll prove the propositions using the latter one.


Proposition:
------------
Be |P3 t <=> mapSTree id t = id t|. |mapSTree id = id|, i. e. |P3| holds for
all STrees t.

Proof by structural induction on t:
-----------------------------------
- Basis:

  mapSTree id Empty
= { def mapSTree }
  Empty
= { rev def id }
  id Empty

=> |P3 Empty| holds.

- Hypothesis: |P3 tl| and |P3 tr| hold.

- Step:

  mapSTree id (Node tl a tr)
= { def mapSTree }
  Node (mapSTree id tl) (id a) (mapSTree id tr)
= { Hypothesis }
  Node (id tl) (id a) (id tr)
= { def id }
  Node tl a tr
= { rev def id }
  id (Node tl a tr)

=> |P3 (Node tl a tr)| holds. And, by the principle of induction, |P3| holds
   for all STrees |t|.


Proposition:
------------
Be |P4 t <=> mapSTree (g . f) t = mapSTree g (mapSTree f t)|. |mapSTree (g .
f) = (mapSTree g) . (mapSTree f)|, i. e. |P4| holds for all STrees |t|.

Proof by structural induction on t:
-----------------------------------
- Basis:

  mapSTree (g . f) Empty
= { def mapSTree }
  Empty
= { rev def id }
  id Empty

=> |P4 Empty| holds.

- Hypothesis: |P4 tl| and |P4 tr| hold.

- Step:

  mapSTree (g . f) (Node tl a tr)
= { def mapSTree }
  Node (mapSTree (g . f) tl) (g (f a)) (mapSTree (g . f) tr)
= { Hypothesis }
  Node (mapSTree g (mapSTree f tl)) (g (f a)) (mapSTree g (mapSTree f tr))
= { rev def mapSTree }
  mapSTree g (Node (mapSTree f tl) (f a) (mapSTree f tr))
= { rev def mapSTree }
  mapSTree g (mapSTree f (Node tl a tr))

=> |P4 (Node tl a tr)| holds. And, by the principle of induction, |P4| holds
   for all STrees |t|.
