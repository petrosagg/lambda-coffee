compose = (f) -> (g) -> (x) -> f(g(x))

Y = (f) -> (
	(x) -> f((v) -> x(x)(v))
)(
	(x) -> f((v) -> x(x)(v))
)
