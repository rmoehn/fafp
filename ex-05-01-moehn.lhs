We have these elements in the declaration:

    List a :: *
    Wrap   :: a -> List a
    Snoc   :: List a -> a -> List a

Search and replace gives:

    x :: *
    g :: a -> x
    f :: x -> a -> x

Now we can define |foldList| in the natural way:

    foldList :: (a -> x) -> (x -> a -> x) -> List a -> x
    foldList (Wrap a)    = g a
    foldList (Snoc as a) = f (foldList g f as) a

In order to find the unfold function, we look at the undecorating
function:

    uncoList :: List a -> (Maybe List a, a)
    uncoList (Wrap a)    = (Nothing, a)
    uncoList (Snoc as a) = (Just as, a)

The interesting thing here is the signature, which is turned into the
signature of |f| of the unfold by search and replace:

    unfoldList :: (x -> (Maybe x, a)) -> x -> List a
    unfoldList f x = case f x of
                         (Nothing, a) -> Wrap a
                         (Just x', a) -> Snoc (unfoldList f x') a

Fold Fusion
-----------

Given |h|, |g| and |f|, we want |g'| and |f'| such that:

    h . (foldList g f) = foldList g' f'

- "Basis":

    (h . (foldList g f)) (Wrap a)
  = { def . }
    h (foldList g f (Wrap a))
  = { def foldList }
    h (g a)

  |foldList g' f' (Wrap a) = g' a|, therefore |g' a = h (g a)|.

- "Hypothesis": (h . foldList g f) as = foldList g' f' as

- "Step":

    LHS = (h . (foldList g f)) (Snoc as a)
  = { def . }
    h (foldList g f (Snoc as a))
  = { def foldList }
    h (f (foldList g f as) a)


    RHS = foldList g' f' (Snoc as a)
  = { def foldList }
    f' (foldList g' f' as) a
  = { version of the Hypothesis }
    f' (h (foldList f g as)) a

    If we find a function |f'| such that |f' (h b) a = h (f b a)|, we have
    |LHS = RHS| and by the principle of induction, |h . (foldList g f) =
    foldList g' f'|.

Fold-Unfold Fusion
------------------

We have:

    h x
  =
    foldList g f (unfoldList f' x)
  = { def unfoldList }
    foldList g f (case f' x of
                      (Nothing, a) -> Wrap a
                      (Just x', a) -> Snoc (unfoldList f' x') a)

Considering the two cases separately:

- Case |f' x of (Nothing, a)|:

      h x
    = { continuing from above }
      foldList g f (Wrap a)
    = { def foldList }
      g a

- Case |f' x of (Just x', a)|:

      h x
    = { continuing from above }
      foldList g f (Snoc (unfoldList f' x') a)
    = { def foldList }
      f (foldList g f (unfoldList f' x')) a
    = { def h }
      f (h x') a

Thus |h| can be defined (with |g|, |f| and |f'| from above) in this way:

    h x = case f' x of
              (Nothing, a) -> g a
              (Just x', a) -> f (h x') a
