    (cross (cofmap f, id) . filter' . cross (id, fmap f)) (pb, as)
= { composition }
    (cross (cofmap f, id) . filter') (cross (id, fmap f) (pb, as))
= { def cross, def fmap }
    (cross (cofmap f, id) . filter') (pb, map f as)
= { composition }
    (cross (cofmap f, id)) (filter' (pb, map f as))
= { def filter' }
    cross (cofmap f, id) ((), filter (pb, map f as))
= { def cross }
    (cofmap f (), filter (pb, map f as))
= { def cofmap }
    ((), filter (pb, map f as))

And, by parametricity, we have obtained:

    ((), map f (filter (pb . f, as)))
=
    ((), filter (pb, map f as))
