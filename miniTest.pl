% Define the grammar rules for Java-Light

s(s(Assignments)) --> assignments(Assignments).

% assignments([Assignment|Assignments]) --> assignment(Assignment), [';'], assignments(Assignments).
assignments(Assignment) --> assignment(Assignment), [';'].

assignment(assign(Id, '=',Expr)) --> identifier(Id), ['='], expression(Expr).

expression(Expr) --> term(Term), expression(Term, Expr).
expression(Accumulator, Expr) --> ['+'], term(Term), { Accumulator1 = add(Accumulator, Term) }, expression(Accumulator1, Expr).
expression(Accumulator, Expr) --> ['-'], term(Term), { Accumulator1 = subtract(Accumulator, Term) }, expression(Accumulator1, Expr).
expression(Accumulator, Accumulator) --> [].

term(Term) --> factor(Factor), term(Factor, Term).

term(Accumulator, Term) --> ['*'], factor(Factor), { Accumulator1 = multiply(Accumulator, Factor) }, term(Accumulator1, Term).
term(Accumulator, Term) --> ['/'], factor(Factor), { Accumulator1 = divide(Accumulator, Factor) }, term(Accumulator1, Term).
term(Accumulator, Term) --> ['%'], factor(Factor), { Accumulator1 = mod(Accumulator, Factor) }, term(Accumulator1, Term).
term(Accumulator, Accumulator) --> [].

factor(int(Num)) --> [Num], { integer(Num) }.
factor(id(Id)) --> identifier(Id).
factor(paren(Expr)) --> ['('], expression(Expr), [')'].

identifier(id([H|T])) --> [H], { is_alpha(H); H == '_' }, identifier_cont(T).
identifier_cont([H|T]) --> [H], { is_alnum(H) }, identifier_cont(T).
identifier_cont([]) --> [].

is_alpha(H) :- code_type(H, alpha).
is_alnum(H) :- code_type(H, alnum); (integer(H)).

add(X, Y, add(X, Y)).
subtract(X, Y, subtract(X, Y)).
multiply(X, Y, multiply(X, Y)).
divide(X, Y, divide(X, Y)).
mod(X, Y, mod(X, Y)).