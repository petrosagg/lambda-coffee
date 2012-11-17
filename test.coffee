# vim: set noexpandtab:

numAsserts = 0

assertTrue = (cond, msg) ->
	if not cond
		throw msg
	++numAsserts

assertFalse = (cond, msg) ->
	assertTrue not cond, msg

assertEquals = (a, b, msg) ->
	assertTrue(a == b, msg)

assertTop = (cond, msg) ->
	If(cond)(
		(z) -> assertTrue(true, msg)
	)(
		(z) -> assertTrue(false, msg)
	)

assertBottom = (cond, msg) ->
	If(cond)(
		(z) -> assertFalse(true, msg)
	)(
		(z) -> assertFalse(false, msg)
	)

testCases =
	testBoolean: ->
		If(True)(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'if(true) runs else')
		)
		If(False)(
			(z) -> assertTrue(false, 'if(false) runs body')
		)(
			(z) -> assertTrue(true)
		)

		# Testing logical NOT
		If(Not(True))(
			(z) -> assertTrue(false, 'Not(true) is true')
		)(
			(z) -> assertTrue(true)
		)
		If(Not(False))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'Not(false) is false')
		)

		# Testing logical OR
		If(Or(False)(True))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'Or(false)(true) is false')
		)
		If(Or(True)(False))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'Or(true)(false) is false')
		)
		If(Or(True)(True))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'Or(true)(true) is false')
		)
		If(Or(False)(False))(
			(z) -> assertTrue(false, 'Or(false)(false) is true')
		)(
			(z) -> assertTrue(true)
		)

		# Testing logical AND
		If(And(False)(True))(
			(z) -> assertTrue(false, 'And(false)(true) is true')
		)(
			(z) -> assertTrue(true)
		)
		If(And(True)(False))(
			(z) -> assertTrue(false, 'And(true)(false) is true')
		)(
			(z) -> assertTrue(true)
		)
		If(And(True)(True))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'And(true)(true) is false')
		)
		If(And(False)(False))(
			(z) -> assertTrue(false, 'And(false)(false) is true')
		)(
			(z) -> assertTrue(true)
		)
	testY: ->
		fac = Y((fac) ->
			(n) ->
				If( isZero n )(
					(z) -> _1
				)(
					(z) -> mul(n)(fac(decr(n)))
				)
			)
		assertTop(eq(fac(@_5))(@_120), "3! != 6")
	testArithmetic: ->
		# equality
		assertTop(eq(@_0)(@_0), "0 != 0")
		assertBottom(eq(@_0)(@_1), "0 == 1")
		assertTop(eq(@_42)(@_42))
		assertBottom(eq(@_42)(@_17))

		# add
		assertTop(eq(add(@_0)(@_0))(@_0))
		assertTop(eq(add(@_11)(@_31))(@_42))

		# sub
		assertTop(eq(sub(@_0)(@_0))(@_0))
		assertTop(eq(sub(@_52)(@_10))(@_42))

		# mul
		assertTop(eq(mul(@_0)(@_42))(@_0))
		assertTop(eq(mul(@_42)(@_1))(@_42))
		assertTop(eq(mul(@_3)(@_5))(@_15))

		# div
		assertTop(eq(div(@_15)(@_5))(@_3))
		assertTop(eq(div(@_16)(@_5))(@_3))
		assertTop(eq(div(@_14)(@_5))(@_2))

		# mod
		assertTop(eq(mod(@_15)(@_5))(_0))
		assertTop(eq(mod(@_16)(@_5))(_1))
		assertTop(eq(mod(@_14)(@_3))(@_2))

		# comparisons
		assertTop(gt(@_6)(@_5))
		assertBottom(gt(@_5)(@_6))
		assertTop(lt(@_5)(@_6))
		assertBottom(lt(@_6)(@_5))
	testList: ->
		assertTop(isEmpty(nil), 'The empty list is not empty')
		assertTop(eq(head consLazy(_0)((z) -> True))(_0), 'head [0] != 0 (or tail promise called unnecessarily)')
		assertTop(eq(head cons(_0)(nil))(_0), 'head [0] != 0')
		assertTop(isEmpty(tail cons(_0)(nil)), 'tail [0] != []')
		assertTop(eq(length(nil))(_0))
		oneTwoThree = cons(_1)(cons(@_2)(cons(@_3)(nil)))
		assertTop(eq(length(oneTwoThree))(@_3))
		assertTop(eq(head(tail oneTwoThree))(@_2), 'head tail [1, 2, 3] != 2')
		assertTop(eq(listItem(oneTwoThree)(@_0))(@_1), 'item 0 of [1, 2, 3] is not 1')
		assertTop(eq(listItem(oneTwoThree)(@_1))(@_2), 'item 1 of [1, 2, 3] is not 2')
		assertTop(eq(listItem(oneTwoThree)(@_2))(@_3), 'item 2 of [1, 2, 3] is not 3')
		assertTop(listEq(nil)(nil))
		twoThreeFour = map((x) -> incr(x))(oneTwoThree)
		assertTop(eq(length twoThreeFour)(@_3))
		assertTop(eq(head twoThreeFour)(@_2))
		assertTop(eq(head(tail twoThreeFour))(@_3))
		assertTop(eq(head(tail(tail twoThreeFour)))(@_4))
		twoFourSix = map((x) => mul(@_2)(x))(oneTwoThree)
		assertTop(eq(length twoFourSix)(@_3))
		assertTop(eq(head twoFourSix)(@_2))
		assertTop(eq(head(tail twoFourSix))(@_4))
		assertTop(eq(head(tail(tail twoFourSix)))(@_6))
		twoFour = filter((x) => isZero mod(x)(@_2))(twoThreeFour)
		assertTop(eq(length twoFour)(@_2))
		assertTop(eq(head twoFour)(@_2))
		assertTop(eq(head(tail twoFour))(@_4))
	testInfiniteList: ->
		assertTop(listEq(nil)(nil))
		assertTop(eq(reduce(add)(oneTwoThree)(@_0))(@_6), '[1, 2, 3].reduce(add, 0) is not 6')
		allOnes = Y((allOnes) ->
			(z) -> consLazy(_1)((z) -> allOnes(True))
		)()
		l = take(allOnes)(@_5)
		assertTop(eq(head(tail(tail(tail(tail l)))))(_1))

		naturals = Y((naturals) ->
			(z) -> consLazy(_1)(
				(z) -> addLists(naturals True)(allOnes)
			)
		)()
		oneToFive = take(naturals)(@_5)
		assertTop(eq(head(tail(tail(tail(tail oneToFive)))))(@_5))
		assertTop(eq(length(oneToFive))(@_5))
		# printList l

		# two = consStream(@_2)(
		# 	(z) -> emptyStream
		# )
		# oneTwo = consStream(@_1)(
		# 	(z) -> two
		# )

		# printList take(oneTwo)(@_2)

		# even = filterStream((x) -> True)(
		# printList take(oneTwo)(@_2)

		# sieve = (s) -> consStream(headStream s)(
		#   	(z) ->
		#  		filterStream(
		#  			(x) -> not(isZero mod(x)(headStream s))
		#  		)(sieve(tail s))
		# )
		# printList take(sieve(tail naturals))(@_1)

	# testStrings: ->
	#	 printString newString(@_H)(@_E)(@_L)(@_L)(@_O)(_0)

# define numerals
Object.defineProperty(testCases, "_0", {value: _0})
for i in [1..120]
	Object.defineProperty(testCases, "_" + i,
		value: incr(testCases["_" + (i - 1)])
	)

# define chars
for i in [65..90]
	Object.defineProperty(testCases, "_" + String.fromCharCode(i),
		value: testCases['_' + i]
	)
Object.defineProperty(testCases, "_SPACE", testCases._32)

red = '\x1b[31m'
green = '\x1b[32m'
reset = '\x1b[0m'

for key of testCases
	console.log "Running test: ", key
	numAsserts = 0
	try
		testCases[key]()
		console.log green + "PASS " + numAsserts + " assertions" + reset
	catch error
		if numAsserts is not 0
			console.log "PASS " + numAsserts + " assertions"
		console.log red + "FAIL: " + error + reset
