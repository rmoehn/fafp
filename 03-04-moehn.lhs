Fold fusion for |foldNat|
-------------------------

Given |h|, |f| and |e|, we want |f'| and |e'| such that:

    h . (foldNat f e) = foldNat f' e'

- "Basis":

    (h . (foldNat f e)) O
  = { def . }
    h (foldNat f e O)
  = { def foldNat }
    h e

  Because of |foldNat f' e' O = e'|, |e' = h e|.

- "Hypothesis": (h . foldNat f e) n = foldNat f' e' n

- "Step":

    LHS = (h . (foldNat f e)) (S n)
  = { def . }
    h (foldNat f e (S n))
  = { def foldNat }
    h (f (foldNat f e n))

    RHS = foldNat f' e' (S n)
  = { def foldNat }
    f' (foldNat f' e' n)
  = { Hypothesis }
    f' (h (foldNat f e n))

  If there is a function |f'| such that |h . f = f' . h|, we have |RHS = LHS|
  and, by the principle of induction, |h . (foldNat f e) = foldNat f' e'|.


Fold fusion for |foldSTree|
---------------------------

Given |h|, |f| and |e|, we want |f'| and |e'| such that:

    h . (foldSTree f e) = foldSTree f' e'

- "Basis":

    (h . (foldSTree f e)) Empty
  = { def . }
    h (foldSTree f e Empty)
  = { def foldSTree }
    h Empty

  Because of |foldSTree f' e' Empty = e'|, |e' = h e|.

- "Hypothesis":

    (h . (foldSTree f e)) tl = foldSTree f' e' tl    and
    (h . (foldSTree f e)) tr = foldSTree f' e' tr

- "Step":

    LHS = (h . (foldSTree f e)) (Branch tl a tr)
  = { def . }
    h (foldSTree f e (Branch tl a tr))
  = { def foldSTree }
    h (f (foldSTree f e tl) a (foldSTree f e tr))

    RHS = foldSTree f' e' (Branch tl a tr)
  = { def foldSTree }
    f' (foldSTree f' e' tl) a (foldSTree f' e' tr)
  = { Hypothesis }
    f' (h (foldSTree f e tl)) a (h (foldSTree f e tr))

  If there is a function |f'| such that |h (f x y z) = f' (h x) y (h z)|, we
  have |RHS = LHS| and, by the principle of induction, |h . (foldSTree f e) =
  foldSTree f' e'|.


Fold fusion for |foldPair|
--------------------------

Given |h| and |f|, we want |f'| such that:

    h . (foldPair f) = foldPair f'

We have:

    (h . (foldPair f)) (a, b)
  = { def . }
    h (foldPair f (a, b))
  = { def foldPair }
    h (f a b)

And:

    foldPair f' (a, b)
  = { def foldPair }
    f' a b

Therefore |f' = h . f|.
