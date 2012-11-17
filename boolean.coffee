# Define true
True = (x) -> (y) -> x
# Define false
False = (x) -> (y) -> y

# Define if
If = (cond) -> (truth) -> (fail) -> cond(truth)(fail)()

# Define boolean operators
Not = (cond) -> cond(False)(True)
And = (cond1) -> (cond2) -> cond1(cond2(True)(False))(False)
Or = (cond1) -> (cond2) -> cond1(True)(cond2(True)(False))
