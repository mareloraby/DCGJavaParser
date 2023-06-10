# DCGJavaParser
Using Prolog, this is a parser for a definite clause grammar of Java-Light.

Java-Light is a fragment of Java consisting of non-empty semi-colon-separated sequences of some
grammatical Java statements. In particular, we restrict ourselves to the following Java statements:

- Assignment statements example: 
```java
_n1 = 13;
_n2 = 21;

fib = _n1 + _n2;

_n1 = _n2;
_n2 = fib;

```
Prolog query:
```Prolog
s(T,[_n1, =, 13,;, _n2, =, 21,;, f,i,b, =, _n1, +, _n2,;, _n1, =, _n2,;, _n2, =, f,i,b,;],[]).
```
Output:

```Prolog
T = s([assign(id([65]), =, int(13), ;), assign(id([65]), =, int(21), ;), assign(id([f, i, b]), =, exprs(id([65]), exprsRest(+, id([65]))), ;), assign(id([65]), =, id([65]), ;), assign(id([65]), =, id([f, i, b]), ;)]),
_n1 = _n2, _n2 = 65 .
```

---

- Java if and if-else statements, nested to any depth, and with bodies which are single statements.
```java

if (n == 0 )
  fib = 0;
if (n == 1 )
  fib = 1;

// another example - nested if (note that we don't handle dangling else problem)
if (n % 2 == 0)
  if( n != 0 )
    x = 1
else
  x = 0
    
```

Prolog query of the second example:

```Prolog
s(T,['if','(',n, ==, 0, ')',  f,i,b, =, 0,;, 'if','(',n, ==, 1,')', f,i,b, =, 1,;],[]).
```

Output:
```Prolog
T = s([ifStatement(if, '(', cdn(id([n]), ==, int(0)), ')', ifbody(assign(id([f, i, b]), =, int(0), ;))), ifStatement(if, '(', cdn(id([n]), ==, int(1)), ')', ifbody(assign(id([f, i|...]), =, int(1), ;)))]) .
```
---

- Java while loops, nested to any depth, and with bodies which are single statements (assignment/while/if).
```java
while(i <= num)
  i = i + _n2;
```

Prolog query:

```Prolog
s(T,[while, '(', i, <=, n,u,m,')',  i, =, i, +, _,n,2,;],[]).
```

Output:

```Prolog
T = s([whileLoop(while, '(', cdn(id([i]), <=, id([n, u, m])), ')', loopBody(assign(id([i]), =, exprs(id([i]), exprsRest(+, id([65, n, 2]))), ;)))])
```
---

## How to run:

[`correctStatements.txt`](/tests/correctStatements.txt) contains prolog queries that should return a parse tree, while [`incorrectStatements.txt`](/tests/incorrectStatements.txt) contains incorrect ones that should return false. 

To test the queries, open the file [`eval.py`](\eval.py) and replace the parameter ```file_name``` with either `correctStatements.txt` or `incorrectStatements.txt`. Next, run the file to test all the queries.

> NB: The code assumes that the queries in the file are correctly formatted and can be evaluated by Prolog.
