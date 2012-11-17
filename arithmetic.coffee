# vim: set noexpandtab:
#

# Identity function
id = (x) -> x

# Define zero
_0 = id

# Define increment-decrement
incr = (x) -> (y) -> y x
decr = (x) -> x _0

# Define one
_1 = incr _0

# Define isZero condition (black magic)
isZero = (num) -> _1(num(_true _true))

# Define equality
eq = Y((eq) ->
	(x) -> (y) -> _if( isZero x )(
		(z) -> isZero y
	)(
		(z) -> _if( isZero y )(
			(z) -> _false
		)(
			(z) -> eq(decr x)(decr y)
		)
	)
)

# Define less than
lt = Y((lt) ->
	(x) -> (y) -> _if( isZero x )(
		(z) -> _not isZero y
	)(
		(z) -> lt(decr x)(decr y)
	)
)

# Define greater than
gt = (x) -> (y) -> _not _or(eq(x)(y))(lt(x)(y))


# Define addition
add = Y((add) ->
	(x) -> (y) -> _if( isZero x )(
		(z) -> y
	)(
		(z) -> add(decr x)(incr y)
	)
)

# Define subtraction
sub = Y((sub) ->
	(x) -> (y) -> _if( isZero y )(
		(z) -> x
	)(
		(z) -> sub(decr x)(decr y)
	)
)

# Define multiplication
mul = Y((mul) ->
	(x) -> (y) -> _if( isZero x )(
		(z) -> _0
	)(
		(z) ->
			_if( eq(x)(_1) )(
				(z) -> y
			)(
				(z) -> add(mul(decr x)(y))(y)
			)
	)
)

# Define modulo
mod = Y((mod) ->
	(x) -> (y) -> _if( lt(x)(y) )(
		(z) -> x
	)(
		(z) -> mod(sub(x)(y))(y)
	)
)

# Define division
div = Y((div) ->
	(x) -> (y) -> _if( lt(x)(y) )(
		(z) -> _0
	)(
		(z) -> incr(div(sub(x)(y))(y))
	)
)
