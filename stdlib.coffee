###
# Church-like arithmetic in Coffeescript using only λ-calculus
# Authors:  Dionysis "dionyziz" Zindros <dionyziz@gmail.com>
# 			Petros "petrosagg" Aggelatos <petrosagg@gmail.com>
###

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

# Define some numbers to play with
global._0 = _0
for i in [1..30]
	global["_" + i] = incr(global["_" + (i - 1)])

# Greater than test case
#_if( gt(_6)(_5) )(
#	(z) -> console.log("Good")
#)(
#	(z) -> console.log("Bad")
#)

# Div operation test case
#print(div(_21)(_3))

l = buildList([_0, _1, _2, _3])
printList(l)
#
