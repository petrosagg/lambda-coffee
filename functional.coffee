# composition
O = (f) -> (g) -> (x) -> f(g(x))

# recursion
Y = (f) -> (
	(x) -> f((v) -> x(x)(v))
)(
	(x) -> f((v) -> x(x)(v))
)
