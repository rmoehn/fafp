Not sure whether that's optimal, but it works.

> import Exercises4
> import Data.List
> bft :: [STree a] -> [[a]]
> bft = unfoldr f
>       where
>       f :: [STree a] -> Maybe ([a], [STree a])
>       f []    = Nothing
>       f trees = Just (roots trees, rests trees)
>           where
>           roots :: [STree a] -> [a]
>           roots []                  = []
>           roots (Empty:ts)          = roots ts
>           roots ((Node tl a tr):ts) = a:(roots ts)
>           rests :: [STree a] -> [STree a]
>           rests []                  = []
>           rests (Empty:ts)          = rests ts
>           rests ((Node tl a tr):ts) = tl:tr:(rests ts)
