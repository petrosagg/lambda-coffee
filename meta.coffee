# vim: set noexpandtab:
#
# Meta-stuff
metaEval = (n) ->
	stateEval = (n, i) ->
		If( isZero n )(
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

log = console.log.bind console
print = O(log)(metaEval)
printList = O(length)(map print)

buildList = (els) ->
	if els.length is 0
		nil
	else
		h = els.shift()
		cons(h)(buildList(els))

printChar = O(O(log)(String.fromCharCode))(metaEval)

printString = map printChar
