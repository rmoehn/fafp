> import Lecture1

In lecture 1 we saw that functions on |Nat| can be expressed as folds if
they fit a certain pattern. As we have to find folds for three functions
on lists, a pattern would be helpful, again. -- We have a function |h ::
List a -> a| and need an |e :: a| and an |f :: a -> List a -> a| such
that:

< h Nil         = e
< h (Cons a as) = f a (h as)

The length of a list defined by pattern matching:

< lengthL Nil          =  O
< lengthL (Cons a as)  =  S (lengthL as)

This fits the pattern with |h = foldL|, |e = O| and |f _ n = S n|.
Together:

> lengthL = foldList f O
>           where f _ n = S n

For the sum of the elements of a list

< sumL Nil             =  O
< sumL (Cons n ns)     =  n `plus` (sumL ns)

we have |h = sumL|, |e = O|, |f = plus|:

> sumL = foldList plus O

For the product of the elements of a list

< prodL Nil            =  S O
< prodL (Cons n ns)    =  n `times` (prodL ns)

we have |h = prodL|, |e = S O|, |f = times|:

> prodL = foldList times (S O)
