assertTrue = (cond, msg) ->
	if not cond
		console.log "FAIL: ", msg
	else
		console.log "PASS"

assertFalse = (cond, msg) ->
	if cond
		console.log "FAIL: ", msg
	else
		console.log "PASS"

assertEquals = (a, b, msg) ->
	assertTrue(a == b, msg)

assertTop = (cond, msg) ->
	_if(cond)(
		(z) -> assertTrue(true, msg)
	)(
		(z) -> assertTrue(false, msg)
	)

assertBottom = (cond, msg) ->
	_if(cond)(
		(z) -> assertFalse(true, msg)
	)(
		(z) -> assertFalse(false, msg)
	)
testCases =
	testBoolean: ->
		_if(_true)(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, 'if(true) runs else')
		)
		_if(_false)(
			(z) -> assertTrue(false, 'if(false) runs body')
		)(
			(z) -> assertTrue(true)
		)

		# Testing logical NOT
		_if(_not(_true))(
			(z) -> assertTrue(false, '_not(true) is true')
		)(
			(z) -> assertTrue(true)
		)
		_if(_not(_false))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, '_not(false) is false')
		)

		# Testing logical OR
		_if(_or(_false)(_true))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, '_or(false)(true) is false')
		)
		_if(_or(_true)(_false))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, '_or(true)(false) is false')
		)
		_if(_or(_true)(_true))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, '_or(true)(true) is false')
		)
		_if(_or(_false)(_false))(
			(z) -> assertTrue(false, '_or(false)(false) is true')
		)(
			(z) -> assertTrue(true)
		)

		# Testing logical AND
		_if(_and(_false)(_true))(
			(z) -> assertTrue(false, '_and(false)(true) is true')
		)(
			(z) -> assertTrue(true)
		)
		_if(_and(_true)(_false))(
			(z) -> assertTrue(false, '_and(true)(false) is true')
		)(
			(z) -> assertTrue(true)
		)
		_if(_and(_true)(_true))(
			(z) -> assertTrue(true)
		)(
			(z) -> assertTrue(false, '_and(true)(true) is false')
		)
		_if(_and(_false)(_false))(
			(z) -> assertTrue(false, '_and(false)(false) is true')
		)(
			(z) -> assertTrue(true)
		)
	testArithmetic: ->
		assertEq = (a, b, msg) ->
			assertTop(eq(a)(b), msg)

		# equality
		assertTop(eq(@_0)(@_0), "0 != 0")
		assertBottom(eq(@_0)(@_1), "0 == 1")

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

		# TODO: div, mod

		# comparisons
		assertTop(gt(@_6)(@_5))
		assertBottom(gt(@_5)(@_6))
		assertTop(lt(@_5)(@_6))
		assertBottom(lt(@_6)(@_5))

	testList: ->
		assertTop(isEmpty(emptyList), 'The empty list is not empty')
		assertTop(eq(head cons(_0)(emptyList))(_0), 'head [0] != 0')
		assertTop(isEmpty(tail cons(_0)(emptyList)), 'tail [0] != []')
		assertTop(
			eq(
				head(
					tail(
				 		cons(_0)(
				 			cons(_1)(
				 				emptyList
				 			)
				 		)
				 	 )
				)
			)(
				_1
			)
		)
	testStreams: ->
		allOnes = Y((allOnes) ->
			(z) -> consStream(_1)((z) -> allOnes(_true))
		)()
		l = take(addStreams(allOnes)(allOnes))(@_5)
		printList(l)
		naturals = Y((naturals) ->
			(z) -> consStream(_1)(
				(z) -> addStreams(naturals _true)(allOnes)
			)
		)()
		printList(take(naturals)(@_5))
	testMagic: ->
		fac = Y((fac) ->
			(n) ->
				_if( isZero n )(
					(z) -> _1
				)(
					(z) -> mul(n)(fac(decr(n)))
				)
			)

		assertTop(eq(fac(@_5))(@_120), "3! != 6")


Object.defineProperty(testCases, "_0", {value: _0})
for i in [1..120]
	Object.defineProperty(testCases, "_" + i,
		value: incr(testCases["_" + (i - 1)])
	)

for key of testCases
	console.log "Running test: ", key
	testCases[key]()
