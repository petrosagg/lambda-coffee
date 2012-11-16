**λ-coffee** is a λ-calculus implementation in CoffeeScript.

Authors
=======

 * Petros Aggelatos <petrosagg@gmail.com>
 * Dionysis Zindros <dionyziz@gmail.com>

[Petros](http://twitter.com/petrosagg) and [Dionysis](http://twitter.com/dionyziz) are
[Electrical and Computer Engineering](http://ece.ntua.gr/) students at the [National Technical
University of Athens](http://www.ntua.gr/). They built this code to improve their knowledge in
λ-calculus.

Implementation
==============

It uses only single function definitions to define a whole Turing-complete language
which can support anything from integer operations to arrays. It does **not** utilize
any of the following:
 
 * Any functions with more than one argument
 * Variables
 * Arithmetic operators +, -, \*, /, % etc.
 * Boolean operators ||, && etc.
 * Comparison operators ==, <, <=, >, >= etc.
 * Named recursion
 * Loops of any kind (for, while, do)
 * If statements or the branching operator ?:
 * Constants of any kind such as numerals (0, 1, ...), booleans (true, false), null etc.

It only uses two language features:

 * Calling an anonymous (lambda) function with one argument
 * Defining an anonymous (lambda) function with one argument

For integers, we use a similar encoding to [Church-encoding](http://en.wikipedia.org/wiki/Church_encoding)
which is more convenient for defining arithmetical operations. In particular:

<code>
0 = λx.x
</code>

<code>
n = λy.y (decr n)
</code>

where (<code>decr n</code>) denotes the predecessor of <code>n</code>.

Boolean values and boolean operators are defined using the usual Church encoding.

Lists and streams are as in Scheme, with basic operators cons, head, tail etc.

Evaluation is eager as in CoffeeScript, but lazy evaluation is emulated using lambdas, which
enable infinite streams among others.

Named recursion is emulated using only anonymous lambdas by utilizing the
[Y combinator](http://en.wikipedia.org/wiki/Fixed-point_combinator#Y_combinator).

Some definitions using assignments are used only for convenience, but there is no mutual or
named recursion of any kind: Everything done can be done without those assignments by
straightforward rewriting.

Scope
=====

This is an educational and experimental piece of code. Please do **not**, for the love of God, ever
use this code in a production environment or for anything else other than a playground. Its performance
is terrible, it is error-prone and it was never meant to be used.

License
=======
Copyright (C) 2012 Petros Aggelatos <petrosagg@gmail.com>, Dionysis "dionyziz" Zindros <dionyziz@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
