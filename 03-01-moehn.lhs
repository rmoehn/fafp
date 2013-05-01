Implementation of |reverse| with |foldr|:

> rrev :: [a] -> [a]
> rrev = foldr f []
>        where f :: a -> [a] -> [a]
>              f a as = as ++ [a]

A trace:

< rrev [1,2,3]
<
< =         foldr f [] [1,2,3]
< =    f 1 (foldr f []   [2,3])
< =        (foldr f []   [2,3])                 ++ [1]
< =   (f 2 (foldr f []     [3])               ) ++ [1]
< =   (    (foldr f []     [3])         ++ [2]) ++ [1]
< =  ((f 3 (foldr f []      [])       ) ++ [2]) ++ [1]
< =  ((    (foldr f []      []) ++ [3]) ++ [2]) ++ [1]
< =  ((                     []  ++ [3]) ++ [2]) ++ [1]
< =  (                      [3]         ++ [2]) ++ [1]
< =                         [3,2]               ++ [1]
<
< =                         [3,2,1]

Implementation of |reverse| with |foldl|:

> lrev :: [a] -> [a]
> lrev = foldl f []
>        where f :: [a] -> a -> [a]
>              f as a = [a] ++ as

A trace:

<   lrev [1,2,3]
<
< = foldl f           []           [1,2,3]
< = foldl f  (f       [] 1)          [2,3]
< = foldl f  (f (f    [] 1) 2)         [3]
< = foldl f  (f (f (f [] 1) 2) 3)       []
<
< =          (f (f (f [] 1) 2) 3)
< = [3] ++      (f (f [] 1) 2)
< = [3] ++ ([2] ++ (f [] 1))
<
< = [3] ++ ([2] ++ (1 ++ []))
< = [3] ++ ([2] ++ [1])
< = [3] ++  [2,1]
<
< = [3,2,1]

Both implementations run in linear time. In fact, they appear to take the same
number of steps. Due to the associativity of |++|, even an outermost-reduction
machine could reduce the concatenations after each reduction of |f| in |rrev|.
This would yield constant space complexity. However, I doubt that Haskell is
able to move parentheses around. So space complexity is linear in both |rrev|
and |lrev|.

In a strict language on the other hand, the applications of |f| in |lrev|
could be reduced immediately, leading to constant space complexity.
