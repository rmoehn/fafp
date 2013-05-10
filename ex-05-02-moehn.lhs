Proposition:
------------
Be |P1 l <=> map id l = id l|. |map id = id|, i. e. |P1| holds for all lists
|l|.

Proof by structural induction on |l|:
-------------------------------------
- Basis:

  map id []
= { def map }
  []
= { rev def id }
  id []

=> |P1 []| holds.

- Hypothesis: |P1 xs| holds.

- Step:

  map id (x:xs)
= { def map }
  (id x) : (map id xs)
= { Hypothesis }
  (id x) : (id xs)
= { def id }
  x:xs
= { rev def id }
  id (x:xs)

=> |P1 (x:xs)| holds. And, by the principle of induction, |P1 l| holds
   for all lists |l|.


Proposition:
------------
Be |P2 l <=> map (g . f) l = map g (map f l)|. |map (g . f) = (map g) .
(map f)|, i. e. |P2| holds for all lists |l|.

Proof by structural induction on |l|:
-------------------------------------
- Basis:

  map (g . f) []
= { def map }
  []
= { rev def map }
  map g []
= { rev def map }
  map g (map f [])

=> |P2 []| holds.

- Hypothesis: |P2 xs| holds.

- Step:

  map (g . f) (x:xs)
= { def map }
  ((g . f) x) : (map (g . f) xs)
= { def . }
  (g (f x)) : (map (g . f) xs)
= { Hypothesis }
  (g (f x)) : (map g (map f xs))
= { rev def map }
  map g ((f x) : (map f xs))
= { rev def map }
  map g (map f (x:xs))

=> |P (x:xs)| holds. And, by the principle of induction, |P l| holds for all
   lists |l|.
