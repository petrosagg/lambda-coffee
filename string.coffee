# vim: set noexpandtab:

stringBuilder = Y((stringBuilder) ->
	(l) -> (i) ->
		_if( isZero i )(
			(z) -> l
		)(
			(z) -> stringBuilder push(l)(i)
		)
)

newString = stringBuilder emptyList
