Paramorphisms: folds with parameters
------------------------------------

The solution we have for writing |pred| as a fold, namely

> pred               =  foldNat f Nothing
>                       where
>                       f Nothing = Just O
>                       f (Just n) = Just (S n)

is somewhat unsatisfactory: we are still doing pattern-matching, 
and the helper function |f| doesn't appear any simpler than |pred| 
itself.

We can get away without any pattern-matching in the definition of the
helper function if we allow ourselves to compute a bit more in the fold.
Namely, we will let the helper function compute pairs, and |pred| is
going to be one of the elements of the pair, say the right-hand one:

< pred'              =  snd . foldNat f e

What could |f| and |e| be?  We can compute:

    pred' O
=  {-  definition of |pred'| -}
    snd (foldNat f e O)
=  {- definition of |foldNat| -}
    snd e
=  {- |pred'| should be |pred| -}
    Nothing

    pred' (S O)
=  {-  definition of |pred'| -}
    snd (foldNat f e (S O))
=  {- definition of |foldNat| -}
    snd (f (foldNat f e O))
=  {- putting |(l, Nothing) = foldNat f e O| -}
    snd (f (l, Nothing))
=  {- |pred'| should be |pred| -}
    Just O

At this point, we can see we can make this work by taking |e = (O,
Nothing)| and |f (l, m) = (S l, Just l)|.

> pred'              =  snd . foldNat f (O, Nothing)
>                       where
>                       f (l, m) = (S l, Just l)

But there is something very unsatisfactory about this definition: it
takes |S n| steps to compute |pred n|, whereas the definition by direct
patter-matching

< pred  O          =  Nothing
< pred  (S n)      =  Just n

only takes one.  A solution to his problem is to implement the
combinator suggested by the above definition, the fold with a parameter,
directly:

> paraNat f e O      =  e
> paraNat f e (S n)  =  f (n, paraNat f e n)

Now we have

> pred'' = paraNat (Just . fst) Nothing

To discover the ingredients of a \emph{paramorphism}, we apply a similar
procedure to that for folds: the difference is that this time we replace
the occurences of the defined datatype as \emph{arguments} to the
constructors by tuples of the defined datatype and the target datatype.

For |Nat| this gives us:

   |Nil  ::  Nat| gets turned into |e :: a|, as before (|Nat| is here
   the target of the constructor |Nil|, which takes no arguments at all)

   |S  ::  Nat -> Nat| gets translated to |f  ::  (Nat, a) -> a| (the
   first  occurence of |Nat| is as an argument, the second as target).

For |List|, we have

<  Nil    :: List a                  -->  e  :: b
<  Cons   :: a -> List a -> List a   -->  f  ::  a -> (List a, b) -> b

> paraList f e Nil             =  e
> paraList f e (Cons a as)     =  f a (as, paraList f e as)

For |STree|, we have

< Empty   ::  STree a          gets turned into    e :: b
< Node    ::  STree a -> a -> STree a -> STree a          becomes 
< f       ::  (STree a, b) -> a -> (STree a, b) -> b

> paraSTree f e Empty           =  e
> paraSTree f e (Node tl a tr)  =  
>           f (tl, paraSTree f e tl) a (tr, paraSTree f e tr)

For non-recursive datatypes, the notion of paramorphism doesn't really
make sense: by definition, their constructors don't take arguments of
the defined datatype.

