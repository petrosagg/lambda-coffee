# vim: set noexpandtab:
#
consLazy = (head) -> (tailPromise) -> (emptyCheck) ->
	If( emptyCheck )(
		(z) -> False
	)(
		(z) -> (headOrTail) ->
			If( headOrTail )(
				(z) -> head
			)(
				(z) -> (tailPromise z)
			)
	)
cons = (x) -> (y) -> consLazy(x)((z) -> y)

head = (l) -> l(False)(True)
tail = (l) -> l(False)(False)

nil = True True
$nil = (z) -> nil
isEmpty = (l) -> l True

pair = (a) -> (b) -> cons(a)(cons(b)(nil))
fst = head
snd = O(head)(tail)

length = Y((length) ->
	(l) ->
		If( isEmpty l )(
			(z) -> _0
		)(
			(z) -> incr(length(tail l))
		)
)
take = Y((take) ->
	(l) -> (n) ->
		If( isZero n )(
			(z) -> nil
		)(
			(z) -> cons(head l)(take(tail l)(decr n))
		)
)
zip = Y((zip) ->
	(f) -> (l1) -> (l2) ->
		If( Or(isEmpty l1)(isEmpty l2) )(
			(z) -> nil
		)(
			(z) ->
				consLazy(
					f(head l1)(head l2)
				)(
					(z) -> zip(f)(tail l1)(tail l2)
				)
		)
)
filter = Y((filter) ->
	(f) -> (l) ->
		If( isEmpty l )(
			(z) -> nil
		)(
			(z) ->
                If(f (head l))(
                    (z) ->
                        consLazy(head l)(
                            (z) -> filter(f)(tail l)
                        )
                )(
                    (z) ->
                        filter(f)(tail l)
                )
		)
)
map = Y((map) ->
	(f) -> (l) ->
		If( isEmpty l )(
			(z) -> nil
		)(
			(z) -> consLazy(f(head l))((z) -> map(f)(tail l))
		)
)
listEq = Y((listEq) ->
    (comp) -> (l1) -> (l2) ->
        If( isEmpty l1 )(
            (z) -> isEmpty l2
        )(
            (z) ->
                If( isEmpty l2 )(
                    (z) -> False
                )(
                    (z) -> And(comp(head l1)(head l2))(listEq(comp)(tail l1)(tail l2))
                )
        )
)
addLists = zip add
item = Y((item) ->
	(l) -> (i) ->
		If( Or(eq(length(l))(_1))(isZero i) )(
			(z) -> head l
		)(
			(z) -> item(tail l)(decr(i))
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
	(f) -> (v) -> (l) ->
		If( isEmpty l )(
			(z) -> v
		)(
			(z) -> reduce(f)(f(v)(head l))(tail l)
		)
)
sum = reduce(add)(_0)
product = reduce(mul)(_1)

reverse = Y((reverse) ->
	(l) ->
		If( isEmpty l )(
			(z) -> l
		)(
			(z) -> push(reverse(tail l))(head l)
		)
)

merge = Y((merge) ->
	(pred) -> (l1) -> (l2) ->
		If( isEmpty l1 )(
			(z) -> l2
		)(
			(z) ->
				If( isEmpty l2 )(
					(z) -> l1
				)(
					(z) ->
						If( pred(head l1)(head l2) )(
							(z) -> cons(head l1)(merge(pred)(tail l1)(l2))
						)(
							(z) -> cons(head l2)(merge(pred)(l1)(tail l2))
						)
				)
		)
)

leftHalf = (l) -> take(l)(div(length(l))(incr(_1)))
rightHalf = (l) -> reverse(take(reverse(l))(sub(length(l))(div(length(l))(incr(_1)))))

mergesort = Y((mergesort) ->
	(pred) -> (l) ->
		If( Or(isEmpty l)(eq(_1)(length(l))) )(
			(z) -> l
		)(
			(z) ->
				merge(pred)(mergesort(pred)(leftHalf l))(mergesort(pred)(rightHalf l))
		)
)
