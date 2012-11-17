# vim: set noexpandtab:
#
emptyList = True True
cons = (x) -> (y) -> (emptyCheck) -> emptyCheck(False)((cond) -> cond(x)(y))
pair = (a) -> (b) -> cons(a)(cons(b)(emptyList))
head = (l) -> l(False)(True)
fst = head
tail = (l) -> l(False)(False)
snd = O(head)(tail)
isEmpty = (l) -> l True

filter = Y((filter) ->
	(f) -> (l) ->
		If( isEmpty l )(
			(z) -> emptyList
		)(
			(z) -> If(f (head l))(
				cons(head l)(filter(f)(tail l))
			)(
				filter(f)(tail l)
			)
		)
)

length = Y((length) ->
	(l) ->
		If( isEmpty l )(
			(z) -> _0
		)(
			(z) -> incr(length(tail l))
		)
)

map = Y((map) ->
	(f) -> (l) ->
		If( isEmpty l )(
			(z) -> emptyList
		)(
			(z) -> cons(f(head l))(map(f)(tail l))
		)
)

listEq = Y((listEq) ->
    (l1) -> (l2) ->
        If( isEmpty l1 )(
            (z) -> isEmpty l2
        )(
            (z) ->
                If( isEmpty l2 )(
                    (z) -> False
                )(
                    (z) -> And(eq(head l1)(head l2))(listEq(tail l1)(tail l2))
                )
        )
)

listItem = Y((listItem) ->
	(l) -> (i) ->
		If( Or(eq(length(l))(_1))(eq(i)(_0)) )(
			(z) -> head l
		)(
			(z) -> listItem(tail l)(decr(i))
		)
)

push = Y((push) ->
	(l) -> (i) ->
		If( isEmpty l )(
			(z) -> cons(i)(l)
		)(
			(z) -> cons(head l)(push(tail l)(i))
		)
)

reduce = Y((reduce) ->
	(f) -> (l) -> (v) ->
		If( isEmpty l )(
			(z) -> v
		)(
			(z) -> reduce(f)(tail l)(f(v)(head l))
		)
)
