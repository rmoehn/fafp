Lemma:
--------

Be |Q l' <=> reverse (l' ++ [a]) = a : (reverse l')|. |Q l'| holds for all
lists |l'|.

Proof by structural induction on |l'|:
--------------------------------------

- Basis: l' = []

    reverse ([] ++ [a])
  = { def ++ }
    reverse [a]
  = { def reverse }
    [] ++ [a]
  = { def ++ }
    [a]
  = { Haskell's syntactic sugar }
    a : []
  = { reverse def of reverse }
    a : (reverse [])

  ==> |Q []| holds.

- Hypothesis: |Q bs| holds.

- Step: l' = b:bs

    reverse ((b:bs) ++ [a])
  = { def ++ }
    reverse (b : (bs ++ [a])
  = { def reverse }
    (reverse (bs ++ [a])) ++ [b]
  = { Hypothesis }
    (a : (reverse bs)) ++ [b]
  = { def ++ }
    a : ((reverse bs) ++ [b])
  = { reverse def of reverse }
    a : (reverse (b:bs))

  ==> |Q (b:bs)| holds. Therefore, by the principle of induction, |Q l'| holds
  for all lists |l'|.


Proposition:
------------

Be |P l <=> (reverse . reverse) l = l|. |P l| holds for all lists |l| and
therefore |(reverse . reverse) = id| for lists.

Proof by structural induction on |l|:
-------------------------------------

- Basis: l = []

    (reverse . reverse) []
  = { def . }
    reverse (reverse [])
  = { def reverse }
    reverse []
  = { def reverse }
    []

  ==> P [] holds.

- Hypothesis: |P as| holds.

- Step: l = a:as

    (reverse . reverse) (a:as)
  = { def . }
    reverse (reverse (a:as))
  = { def reverse }
    reverse ((reverse as) ++ [a])
  = { Lemma, |l' = (reverse as)| }
    a : (reverse (reverse as))
  = { reverse def . }
    a : ((reverse . reverse) as)
  = { Hypothesis }
    a : as

  ==> |P (a:as)| holds. Therefore, by the principle of induction, |P l| holds
  for all lists |l|.
