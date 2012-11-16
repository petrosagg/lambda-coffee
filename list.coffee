emptyList = _true _true
cons = (x) -> (y) -> (emptyCheck) -> emptyCheck(_false)((cond) -> cond(x)(y))
pair = (a) -> (b) -> cons(a)(cons(b)(emptyList))
head = (l) -> l(_false)(_true)
fst = head
tail = (l) -> l(_false)(_false)
snd = compose(head)(tail)
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
