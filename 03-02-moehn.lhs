Due to the associativity of |++|, the fold functions look the same. Only the
traces are different.

> rconcat :: [[a]] -> [a]
> rconcat = foldr (++) []

<   rconcat [[1],[2,3],[4,5]]
<
< =                             foldr (++) [] [[1],[2,3],[4,5]]
< = [1] ++                     (foldr (++) [] [    [2,3],[4,5]])
< = [1] ++ ([2,3] ++           (foldr (++) [] [          [4,5]]))
< = [1] ++ ([2,3] ++ ([4,5] ++ (foldr (++) [] [               ])))
< = [1] ++ ([2,3] ++ ([4,5] ++  []))
< = [1] ++ ([2,3] ++         [4,5])
< = [1] ++               [2,3,4,5]
<
< =                    [1,2,3,4,5]

> lconcat :: [[a]] -> [a]
> lconcat = foldl (++) []

< lconcat [[1],[2,3],[4,5]]
<
< = foldl (++)    []               [[1],[2,3],[4,5]]
< = foldl (++)   ([] ++ [1])           [[2,3],[4,5]]
< = foldl (++)  (([] ++ [1])  ++ [2,3])      [[4,5]]
< = foldl (++) ((([] ++ [1])  ++ [2,3]) ++ [4,5]) []
<
< =             (([] ++ [1])  ++ [2,3]) ++ [4,5]
< =              ([1]         ++ [2,3]) ++ [4,5]
< =               [1,2,3]               ++ [4,5]
<
< =               [1,2,3,4,5]

Both versions have linear time complexity. The second one would have constant
space complexity under strict evaluation. The first one would have constant
space complexity if Haskell would treat the parentheses intelligently and use
|++|'s associativity.
