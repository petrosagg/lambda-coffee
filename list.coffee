emptyList = _true _true
cons = (x) -> (y) -> (emptyCheck) -> emptyCheck(_false)((cond) -> cond(x)(y))
head = (l) -> l(_false)(_true)
tail = (l) -> l(_false)(_false)
isEmpty = (l) -> l _true

filter = (f) -> (l) ->
	_if( isEmpty l )(
		(z) -> emptyList
	)(
		(z) -> _if(f (head l))(
			cons(head l)(filter(f)(tail l))
		)(
			filter(f)(tail l)
		)
	)

length = (l) ->
	_if( isEmpty l )(
		(z) -> _0
	)(
		(z) -> incr(length(tail l))
	)

map = (f) -> (l) ->
	_if( isEmpty l )(
		(z) -> emptyList
	)(
		(z) -> cons(f(head l))(map(f)(tail l))
	)
