# Meta-stuff
metaEval = (n) ->
	stateEval = (n, i) ->
		_if( isZero n )(
			(z) -> i
		)(
			(z) -> stateEval(decr(n), i + 1)
		)
	stateEval(n, 0)

metaUneval = (n) ->
	stateUneval = (n, i) ->
		if n == 0
			i
		else
			stateUneval(n - 1, incr i)

	stateUneval(n, _0)

print = (n) ->
	console.log(metaEval n)

printList = map print

buildList = (els) ->
	if els.length is 0
		console.log("Returning emptyList")
		emptyList
	else
		h = els.shift()
		console.log("Running cons(#{metaEval(h)})(buildList(", els.map(metaEval), "))")
		cons(h)(buildList(els))
