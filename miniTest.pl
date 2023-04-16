% Define the grammar rules for Java-Light

s(s(Assignments)) --> assignments(Assignments).

assignments(Assignment) --> assignment(Assignment), [';'].

assignment(assign(Id, '=',Expr)) --> identifier(Id), ['='], expression(Expr).

expression(Expr) --> term(Term), expression(Term, Expr).
expression(Accumulator, Expr) --> ['+'], term(Term), { Accumulator1 = (Accumulator, +, Term) }, expression(Accumulator1, Expr).
expression(Accumulator, Expr) --> ['-'], term(Term), { Accumulator1 = (Accumulator, -, Term) }, expression(Accumulator1, Expr).
expression(Accumulator, Accumulator) --> [].

term(Term) --> factor(Factor), term(Factor, Term).

term(Accumulator, Term) --> arithmetic_operator(OP), factor(Factor), { Accumulator1 = (Accumulator, OP, Factor) }, term(Accumulator1, Term).
term(Accumulator, Accumulator) --> [].

factor(int(Num)) --> [Num], { integer(Num) }.
factor(id(Id)) --> identifier(Id).
factor(paren(Expr)) --> ['('], expression(Expr), [')'].

identifier([H|T]) --> [H], { is_alpha(H); H == '_' }, identifier_cont(T).
identifier_cont([H|T]) --> [H], { is_alnum(H) }, identifier_cont(T).
identifier_cont([]) --> [].

is_alpha(H) :- code_type(H, alpha).
is_alnum(H) :- code_type(H, alnum); (integer(H)).


% arithmetic_operator( + ) --> [+].
% arithmetic_operator( - ) --> [-].
arithmetic_operator( / ) --> [/].
arithmetic_operator( * ) --> [*].
arithmetic_operator( '%' ) --> ['%'].