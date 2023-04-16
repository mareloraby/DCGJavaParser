# DCGJavaParser
Using Prolog, this is a parser for a definite clause grammar of Java-Light.

Java-Light is a fragment of Java consisting of non-empty semi-colon-separated sequences of some
grammatical Java statements. In particular, we restrict ourselves to the following Java statements:
- Assignment Statements
- Java if and if-else statements, nested to any depth, and with bodies which are single statements.
- Java while loops, nested to any depth, and with bodies which are single statements.
