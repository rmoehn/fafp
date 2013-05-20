Be |alpha :: (a, a) -> (a, a)| our polymorphic function. There is only
one possible |alpha| for the singleton type:

    alpha ((), ()) = ((), ())

As |F a = (a, a)|, we have that |alpha :: F a -> F a|. |fmap| on |F| is
probably defined like this:

    fmap f (x, y)
=
    (f x, f y)

So we have because of parametricity and |F|'s covariance:

    (alpha . fmap f) (x, y) = (fmap f . alpha) (x, y)
<=> { composition }
    alpha (fmap f (x, y))   = fmap f (alpha (x, y))
<=> { def fmap }
    alpha (f x, f y)        = fmap f (alpha (x, y))

Let |X| be an arbitrary type and |z| an arbitrary element of that type
and assume:
    
    f () = z

Then assume for the above equation that |a| is the singleton type:

    alpha (f (), f ()) = fmap f (alpha ((), ()))
<=> { def f and def alpha for the singleton type }
    alpha (z, z) = fmap f ((), ())
<=> { def fmap }
    alpha (z, z) = (f (), f ())
<=> { def f }
    alpha (z, z) = (z, z)

Therefore these are the possible functions |alpha| of type |(a, a) ->
(a, a)|:

    alpha (x, y) = (x, x)

    alpha (x, y) = (x, y)

    alpha (x, y) = (y, x)

    alpha (x, y) = (y, y)

(It remains to be shown that |alpha| cannot apply any other
transformations to its arguments than those shown, I think.)
