# vim: set noexpandtab:
#
emptyList = _true _true
cons = (x) -> (y) -> (emptyCheck) -> emptyCheck(_false)((cond) -> cond(x)(y))
pair = (a) -> (b) -> cons(a)(cons(b)(emptyList))
head = (l) -> l(_false)(_true)
fst = head
tail = (l) -> l(_false)(_false)
snd = O(head)(tail)
isEmpty = (l) -> l _true

filter = Y((filter) ->
	(f) -> (l) ->
		_if( isEmpty l )(
			(z) -> emptyList
		)(
			(z) -> _if(f (head l))(
				cons(head l)(filter(f)(tail l))
			)(
				filter(f)(tail l)
			)
		)
)

length = Y((length) ->
	(l) ->
		_if( isEmpty l )(
			(z) -> _0
		)(
			(z) -> incr(length(tail l))
		)
)

map = Y((map) ->
	(f) -> (l) ->
		_if( isEmpty l )(
			(z) -> emptyList
		)(
			(z) -> cons(f(head l))(map(f)(tail l))
		)
)

listEq = Y((listEq) ->
    (l1) -> (l2) ->
        _if( isEmpty l1 )(
            (z) -> isEmpty l2
        )(
            (z) ->
                _if( isEmpty l2 )(
                    (z) -> _false
                )(
                    (z) -> _and(eq(head l1)(head l2))(listEq(tail l1)(tail l2))
                )
        )
)

listItem = Y((listItem) ->
	(l) -> (i) ->
		_if( _or(eq(length(l))(_1))(eq(i)(_0)) )(
			(z) -> head l
		)(
			(z) -> listItem(tail l)(decr(i))
		)
)

push = Y((push) ->
	(l) -> (i) ->
		_if( isEmpty l )(
			(z) -> cons(i)(l)
		)(
			(z) -> cons(head l)(push(tail l)(i))
		)
)
