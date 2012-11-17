# vim: set noexpandtab:

stringBuilder = Y((stringBuilder) ->
	(l) -> (i) ->
		If( isZero i )(
			(z) -> l
		)(
			(z) -> stringBuilder push(l)(i)
		)
)

newString = stringBuilder nil
