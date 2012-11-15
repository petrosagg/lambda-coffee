# Define true
_true = (x) -> (y) -> x
# Define false
_false = (x) -> (y) -> y

# Define if
_if = (cond) -> (truth) -> (fail) -> cond(truth)(fail)()

# Define boolean operators
_not = (cond) -> cond(_false)(_true)
_and = (cond1) -> (cond2) -> cond1(cond2(_true)(_false))(_false)
_or = (cond1) -> (cond2) -> cond1(_true)(cond2(_true)(_false))
