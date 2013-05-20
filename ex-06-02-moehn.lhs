|beta| takes a predicate |a -> Bool| and is supposed to deliver another
predicate |a -> Bool|. There are three possibilities for |beta| to
transform its predicate |p|: it may put a function in front of it, it
may put a function after it or it may do both.

If it puts a function in front of it, this function has to be of type |a
-> a| since the predicate produced by |beta| must still be of type |a ->
Bool|. There is only one function of this type (unrestricted
polymorphism), as we know, |id|, and |p . id = id|.

If it puts a function after it, this function must be of type |Bool ->
Bool| for a similar reason as above. There are only two functions of
this type, namely |id| and |not|.

Therefore we have only two possible predicate transformers of type |(a
-> Bool) -> (a -> Bool)|:

    beta p = p

    beta p = not p

(Of course, I haven't used the fact that |F a = a -> Bool| is a
contravariant functor, now.)
