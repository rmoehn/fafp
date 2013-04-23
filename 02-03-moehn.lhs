> import Lecture1
> import Paras

Want do define |headL| as a paramorphism:

< headL = paraList f e  --  spec

We see: |e = Nothing|

  headL (Cons a as) 
= { spec }a
  paraList f e (Cons a as)
= { def paraList }
  f a (as, paraList f e as)
= { should be }
  Just a

Therefore |f a _ = Just a| and, putting together:

> headL = paraList f Nothing
>         where f a _ = Just a

To define |tailL| as a paramorphism, |f| has to return |Just as| instead
of |Just a| and that is very easy, too:

> tailL = paraList f Nothing
>         where f a (as, _) = Just as
