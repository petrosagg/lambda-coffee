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

print = (x) ->
	log(metaEval(x))

printList = (l) ->
	If( isEmpty l )(
		(z) -> id
	)(
		(z) ->
			print (head l)
			printList (tail l)
	)

buildList = (els) ->
	if els.length is 0
		nil
	else
		h = els.shift()
		cons(h)(buildList(els))

printChar = (x) ->
	log(String.fromCharCode(metaEval(x)))
	id

printString = map printChar
