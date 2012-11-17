# vim: set noexpandtab:
emptyStream = pair(_true)(_true)
consStream = (head) -> (tailPromise) -> pair(_false)(pair(head)(tailPromise))

isEmptyStream = fst

headStream = O(fst)(snd)

tailStream = (s) -> snd(snd(s))(_true)

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
filterStream = Y((filterStream) ->
	(f) -> (s) ->
		_if( isEmptyStream s )(
			(z) -> emptyStream
		)(
			(z) ->
                _if(f (headStream s))(
                    (z) ->
                        consStream(headStream s)(
                            (z) -> filterStream(f)(tailStream s)
                        )
                )(
                    (z) ->
                        filterStream(f)(tailStream s)
                )
		)
)


addStreams = zipStreams add
