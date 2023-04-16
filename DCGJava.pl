s( s(JC1)) --> java_code(JC1).
s( s(JC1, JC2) ) --> java_code(JC1), java_code(JC2).
s( s(JC1, JC2, JC3)) --> java_code(JC1), java_code(JC2), java_code(JC3).
s( s(JC1, JC2, JC3, JC4)) --> java_code(JC1), java_code(JC2), java_code(JC3), java_code(JC4).

% ---------------------------------------------------------

java_code(As) --> assignment_statement(As). 
java_code(Ls) --> loop(Ls).
java_code(Cs) --> conditional_statement(Cs).

% ---------------------------------------------------------

arithmetic_expression( AT ) --> arithmetic_term(AT).
arithmetic_expression( exprs(AT,AER) ) --> arithmetic_term(AT), arithmetic_expr_rest(AER).

arithmetic_expr_rest( exprsRest(OP, AT) ) --> arithmetic_operator(OP), arithmetic_term(AT).
arithmetic_expr_rest( exprsRest(OP, AT, AER) ) --> arithmetic_operator(OP), arithmetic_term(AT), arithmetic_expr_rest(AER).

arithmetic_term( JI ) --> java_identifier(JI).
arithmetic_term( Uil ) -->unsigned_int_literal(Uil).
arithmetic_term( paren('(', AE, ')')) --> ['('], arithmetic_expression(AE), [')'].

java_identifier( id(X) ) --> [X], {atom_chars(X,Chars), Chars\=[], Chars = [FirstChar|_], \+code_type(FirstChar, digit), maplist(java_identifier_char,Chars)}.
java_identifier_char(C) :- code_type(C, alpha).
java_identifier_char(C) :- code_type(C, digit).
java_identifier_char('_').

% java_identifier(id([H|T])) --> [H], { is_alpha(H); H == '_' }, identifier_cont(T).
% identifier_cont([H|T]) --> [H], { is_alnum(H) }, identifier_cont(T).
% identifier_cont([]) --> [].

% is_alpha(H) :- code_type(H, alpha).
% is_alnum(H) :- code_type(H, alnum); (integer(H)).

unsigned_int_literal( int(X) ) --> [X], {integer(X)}.

% ---------------------------------------------------------
loop( whileLoop(while,'(', Cn,')',Lb) ) --> [while], ['('], condition(Cn), [')'], loop_body(Lb).

conditional_statement(ifStatement('if','(', Cn, ')', Ifb)) --> ['if'], ['('], condition(Cn), [')'], if_body(Ifb).
conditional_statement(ifStatement('if','(', Cn, ')', Ifb, Else)) --> ['if'], ['('], condition(Cn), [')'], if_body(Ifb), else_condition(Else).
else_condition(elseBody( 'else', Ifb)) --> ['else'], if_body(Ifb).

assignment_statement(assignStatement(JI,=,AE,';')) --> java_identifier(JI), [=], arithmetic_expression(AE), [';'].

loop_body( loopBody(AS)) --> assignment_statement(AS).
loop_body( loopBody(AS)) --> conditional_statement(AS).
loop_body( loopBody(W)) --> loop(W).

if_body( ifbody(AS) ) --> assignment_statement(AS).
if_body( ifbody(CS) ) --> conditional_statement(CS).

condition( cdn(AE1,Op,AE2) ) -->  arithmetic_expression(AE1), cprn_operator(Op), arithmetic_expression(AE2).

cprn_operator('==') --> ['=='].
cprn_operator('!=') --> ['!='].
cprn_operator('<=') --> ['<='].
cprn_operator('>=') --> ['>='].
cprn_operator('<') --> ['<'].
cprn_operator('>') --> ['>'].

arithmetic_operator( + ) --> [+].
arithmetic_operator( - ) --> [-].
arithmetic_operator( / ) --> [/].
arithmetic_operator( * ) --> [*].
arithmetic_operator( '%' ) --> ['%'].

% ---------------------------------------------------------

