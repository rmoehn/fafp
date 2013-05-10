Lemma:
------
Fix an arbitrary |l2|. Be |P5 l1 <=> map f l1 ++ map f l2 = map f (l1 ++ l2)|.
|P5 l1| holds for all lists |l1|.

Proof by induction on |l1|:
---------------------------
- Basis:

  map f [] ++ map f l2
= { def map }
  [] ++ map f l2
= { def ++ }
  map f l2
= { rev def ++ }
  map f ([] ++ l2)

=> |P5 []| holds.

- Hypothesis: |P5 xs| holds.

- Step:

  map f (x:xs) ++ map f l2
= { def map }
  ((f x) : (map f xs)) ++ map f l2
= { def ++ }
  (f x) : (map f xs ++ map f l2)
= { Hypothesis }
  (f x) : (map f (xs ++ l2)
= { rev def map }
  map f (x : (xs ++ l2))
= { rev def ++ }
  map f ((x:xs) ++ l2)

=> |P5 (x:xs)| holds. And, by the principle of induction, |P5 l1| holds for
   all lists |l1|.


Proposition:
------------
Be |P6 l <=> concat (map (map f) l) = map f (concat
l)|. |concat . map (map f) = map f . concat|, i. e. |P6 l| holds for all lists
of lists |l|.

Proof by induction on |l1|:
---------------------------
- Basis:

  concat (map (map f) [])
= { def map }
  concat []
= { def concat }
  []
= { rev def map }
  map f []
= { rev def concat }
  map f (concat [])

- Hypothesis: |P6 xs| holds.

- Step:

  concat (map (map f) (x:xs))
= { def map }
  concat ((map f x) : (map (map f) xs))
= { def concat }
  (map f x) ++ (concat (map (map f) xs))
= { Hypothesis }
  (map f x) ++ (map f (concat xs))
= { Lemma from above }
  map f (x ++ concat xs)
= { rev def concat }
  map f (concat (x:xs))

=> |P6 (x:xs) holds. And, by the principle of induction, |P6 l| holds for all
   lists of lists |l|.
