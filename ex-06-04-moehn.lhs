alpha' :: (F2 a, F1 a) -> (G2 a, G1 a)
alpha' (a, b) = (a, alpha b)

beta' :: (F2 a, F1 a) -> (G2 a, G1 a)
beta' (a, b) = (beta a, b)

    (cross (id, fmap f) . alpha' . cross (cofmap f, id)) (a, b)
= { composition, def cross }
    (cross (id, fmap f) . alpha') (cofmap f a, b)
= { composition, def alpha' }
    (cross (id, fmap f)) (cofmap f a, alpha b)
= { def cross }
    (cofmap f a, fmap f (alpha b))

    (cross (cofmap f, id) . alpha' . cross (id, fmap f)) (a, b)
= { composition, def cross }
    (cross (cofmap f, id) . alpha') (a, fmap f b)
= { cofmap, def alpha' }
    cross (cofmap f, id) (a, alpha (fmap f b))
= { def cross }
    (cofmap f a, alpha (fmap f b))

By parametricity, the first lines of the two equation paragraphs
must be equal. Therefore the last lines of the two equation
paragraphs must be equal. Thus:

    fmap f (alpha b) = alpha (fmap f b)
<=>
    fmap f . alpha = alpha . fmap f
<=>
    alpha . fmap f = fmap f . alpha
    


    (cross (id, fmap f) . beta' . cross (cofmap f, id)) (a, b)
=
    (cross (id, fmap f) . beta')  (cofmap f a, b)
=
    cross (id, fmap f) (beta' (cofmap f a, b))
=
    cross (id, fmap f) (beta (cofmap f a), b)
= 
    (beta (cofmap f a), fmap f b)

    (cross (cofmap f, id) . beta' . cross (id, fmap f)) (a, b)
=
    (cross (cofmap f, id) . beta') (a, fmap f b)
=
    cross (cofmap f, id) (beta a, fmap f b)
=
    (cofmap f (beta a), fmap f b)

==> beta (cofmap f a) = cofmap f (beta a)
<=> beta . cofmap f = cofmap f . beta
