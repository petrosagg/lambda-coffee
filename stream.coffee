emptyStream = pair(_true)(_true)
consStream = (head) -> (tailPromise) -> pair(_false)(pair(head)(tailPromise))

isEmptyStream = fst

headStream = compose(fst)(snd)

tailStream = (l) -> snd(snd(l))(_true)

take = Y((take) ->
	(s) -> (n) ->
		_if( isZero n )(
			(z) -> emptyList
		)(
			(z) -> cons(headStream s)(take(tailStream s)(decr n))
		)
)
zipStreams = Y((zipStreams) ->
	(f) -> (s1) -> (s2) ->
		consStream(
			f(headStream s1)(headStream s2)
		)(
			(z) -> zipStreams(f)(tailStream s1)(tailStream s2)
		)
)

addStreams = zipStreams add
