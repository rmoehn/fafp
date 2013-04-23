Definitions:
------------

foldNat f e O     = e
foldNat f e (S n) = f (foldNat f e n)

foldNat' f e O     = e
foldNat' f e (S n) = foldNat' f (f e) n

P k <=> foldNat f e k = foldNat' f e k

Proposition:
------------

P k holds for all natural numbers k.

Proof by induction over k:
--------------------------

- Basis 1: k = O

    foldNat f e O 
  = {def foldNat}
    e 
  = {def foldNat'}
    foldNat' f e O

  => P O holds.

- Basis 2: k = S O

    foldNat f e (S O)
  = {def foldNat}
    f (foldNat e O)
  = {def foldNat}
    f e
  = {def foldNat'}
    foldNat f (f e) O
  = {def foldNat'}
    foldNat f e (S O)

  => P (S O) holds.

- Hypothesis: P n and P (S n) hold.

- Step: k = S (S n)

    foldNat f e (S (S n))
  = {def foldNat}
    f (foldNat f e (S n))
  = {Hypothesis}
    f (foldNat' f e (S n))
  = {def foldNat'}
    f (foldNat' f (f e) n)
  = {Hypothesis}
    f (foldNat f (f e) n)
  = {def foldNat in reverse}
    foldNat f (f e) (S n)
  = {Hypothesis}
    foldNat' f (f e) (S n)
  = {def foldNat' in reverse}
    foldNat' f e (S (S n))

  We see that P n and P (S n) imply P (S (S n)). Therefore, by the
  principle of induction, P holds for all natural numbers k.
