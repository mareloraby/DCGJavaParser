s( s(JC1)) --> java_code(JC1).
s( s(JC1, JC2) ) --> java_code(JC1), java_code(JC2).
s( s(JC1, JC2, JC3)) --> java_code(JC1), java_code(JC2), java_code(JC3).
s( s(JC1, JC2, JC3, JC4)) --> java_code(JC1), java_code(JC2), java_code(JC3), java_code(JC4).

% ---------------------------------------------------------

java_code(Stmt) --> loop(Stmt) | conditional_statement(Stmt) | assignment_statement(Stmt).

% ---------------------------------------------------------

arithmetic_expression( AT ) --> term(AT).
arithmetic_expression( exprs(AT,AER) ) --> term(AT), arithmetic_expr_rest(AER).

arithmetic_expr_rest( exprsRest(OP, AT) ) --> arithmetic_operator(OP), term(AT).
arithmetic_expr_rest( exprsRest(OP, AT, AER) ) --> arithmetic_operator(OP), term(AT), arithmetic_expr_rest(AER).

term( JI ) --> java_identifier(JI).
term( Uil ) --> unsigned_int_literal(Uil).
term( paren('(', AE, ')')) --> ['('], arithmetic_expression(AE), [')'].

java_identifier(id([H|T])) --> [H], { is_alpha(H); H == '_' }, identifier_cont(T).
identifier_cont([H|T]) --> [H], { is_alnum(H) }, identifier_cont(T).
identifier_cont([]) --> [].

is_alpha(H) :- code_type(H, alpha).
is_alnum(H) :- code_type(H, alnum); (integer(H)).

unsigned_int_literal( int(X) ) --> [X], {integer(X)}.

% ---------------------------------------------------------

loop( whileLoop(while,'(', Cn,')',Lb) ) --> [w,h,i,l,e], ['('], condition(Cn), [')'], loop_body(Lb).

conditional_statement(ifStatement(if,'(', Cn, ')', Ifb)) --> [i,f], ['('], condition(Cn), [')'], if_body(Ifb).
conditional_statement(ifStatement(if,'(', Cn, ')', Ifb, Else)) --> [i,f], ['('], condition(Cn), [')'], if_body(Ifb), else_condition(Else).
else_condition(elseBody( else, Ifb)) --> [e,l,s,e], if_body(Ifb).

assignment_statement(assign(JI,=,AE,';')) --> java_identifier(JI), [=], arithmetic_expression(AE), [';'].

loop_body( loopBody(Stmt)) --> assignment_statement(Stmt) | loop(Stmt).

if_body( ifbody(Stmt) ) --> assignment_statement(Stmt) | conditional_statement(Stmt).

condition( cdn(AE1,Op,AE2) ) -->  arithmetic_expression(AE1), cprn_operator(Op), arithmetic_expression(AE2).

cprn_operator('==') --> [=,=].
cprn_operator('!=') --> ['!',=].
cprn_operator('<=') --> [<,=].
cprn_operator('>=') --> [>,=].
cprn_operator('<') --> [<].
cprn_operator('>') --> [>].

arithmetic_operator( + ) --> [+].
arithmetic_operator( - ) --> [-].
arithmetic_operator( / ) --> [/].
arithmetic_operator( * ) --> [*].
arithmetic_operator( '%' ) --> ['%'].
