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
isZero = (num) -> _1(num(True True))

# Define equality
eq = Y((eq) ->
	(x) -> (y) -> If( isZero x )(
		(z) -> isZero y
	)(
		(z) -> If( isZero y )(
			(z) -> False
		)(
			(z) -> eq(decr x)(decr y)
		)
	)
)

# Define less than
lt = Y((lt) ->
	(x) -> (y) -> If( isZero x )(
		(z) -> Not isZero y
	)(
		(z) -> lt(decr x)(decr y)
	)
)

# Define greater than
gt = (x) -> (y) -> Not Or(eq(x)(y))(lt(x)(y))


# Define addition
add = Y((add) ->
	(x) -> (y) -> If( isZero x )(
		(z) -> y
	)(
		(z) -> add(decr x)(incr y)
	)
)

# Define subtraction
sub = Y((sub) ->
	(x) -> (y) -> If( isZero y )(
		(z) -> x
	)(
		(z) -> sub(decr x)(decr y)
	)
)

# Define multiplication
mul = Y((mul) ->
	(x) -> (y) -> If( isZero x )(
		(z) -> _0
	)(
		(z) ->
			If( eq(x)(_1) )(
				(z) -> y
			)(
				(z) -> add(mul(decr x)(y))(y)
			)
	)
)

# Define modulo
mod = Y((mod) ->
	(x) -> (y) -> If( lt(x)(y) )(
		(z) -> x
	)(
		(z) -> mod(sub(x)(y))(y)
	)
)

# Define division
div = Y((div) ->
	(x) -> (y) -> If( lt(x)(y) )(
		(z) -> _0
	)(
		(z) -> incr(div(sub(x)(y))(y))
	)
)
