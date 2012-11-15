assertTrue = (cond, msg) ->
	if not cond
		console.log "FAIL: ", msg
	else
		console.log "PASS"
#
#
# Define some numbers to play with
global._0 = _0
for i in [1..30]
	global["_" + i] = incr(global["_" + (i - 1)])

# Greater than test case
_if( gt(_6)(_5) )(
	(z) -> console.log("Good")
)(
	(z) -> console.log("Bad")
)

# Div operation test case
print(div(_21)(_3))

l = buildList([_0, _1, _2, _3])
printList(l)

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

testCases.testBoolean()
