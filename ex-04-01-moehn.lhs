> import Exercises4

> count     ::  Int -> Int -- only defined for values >= 1
> count      =  unfoldn f
>               where
>               f 1 = Nothing
>               f n = Just (col n)
