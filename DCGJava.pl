s( s(As)) --> assignment_statement(As).
s( s(Cs) ) --> conditional_statement(Cs).
s( s(Ls) ) --> loop(Ls).

% ---------------------------------------------------------

assignment_statement(assignStatement(JI,=,AE,';')) --> java_identifier(JI), [=], arithmetic_expression(AE), [';'].

arithmetic_expression( exprs(AT,AER) ) --> arithmetic_term(AT), arithmetic_expression_rest(AER).

arithmetic_expression_rest( exprsRest(+, AT, AER) ) --> [+], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest(-, AT, AER) ) --> [-], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest(*, AT, AER) ) --> [*], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest(/, AT, AER) ) --> [/], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest('%', AT, AER) ) --> ['%'], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest() ) --> [].

arithmetic_term( arithTrm(T) ) --> term(T).
arithmetic_term( bracketTrm('(', AE, ')')) --> ['('], arithmetic_expression(AE), [')'].

term( trm(JI) ) --> java_identifier(JI).
term( trm(Uil) ) --> unsigned_int_literal(Uil).

java_identifier( id(X) ) --> [X], {atom_chars(X,Chars), Chars\=[], Chars = [FirstChar|_], \+code_type(FirstChar, digit), maplist(java_identifier_char,Chars)}.
java_identifier_char(C) :- code_type(C, alpha).
java_identifier_char(C) :- code_type(C, digit).
java_identifier_char('_').

unsigned_int_literal( int(X) ) --> [X], {integer(X)}.

% ---------------------------------------------------------

conditional_statement(ifStatement('if','(', Cn, ')', Ifb, Else)) --> ['if'], ['('], condition(Cn), [')'], if_body(Ifb), else_condition(Else).

if_body( ifbody(AS) ) --> assignment_statement(AS).
if_body( ifbody(CS) ) --> conditional_statement(CS).

else_condition(elseBody( 'else', Ifb)) --> ['else'], if_body(Ifb).
else_condition(elseBody()) --> [].

% ---------------------------------------------------------

loop( while('while','(', Cn,')',Lb) ) --> ['while'], ['('], condition(Cn), [')'], loop_body(Lb).

loop_body( loopBody(AS)) --> assignment_statement(AS).
loop_body( loopBody(W)) --> loop(W).

% ---------------------------------------------------------

condition( cdn(AE,'==',AE) ) --> arithmetic_expression(AE), ['=='], arithmetic_expression(AE).
condition( cdn(AE,'!=',AE) ) --> arithmetic_expression(AE), ['!='], arithmetic_expression(AE).
condition( cdn(AE,'<=',AE) ) --> arithmetic_expression(AE), ['<='], arithmetic_expression(AE).
condition( cdn(AE,'>=',AE) ) --> arithmetic_expression(AE), ['>='], arithmetic_expression(AE).
condition( cdn(AE,'<',AE) ) -->  arithmetic_expression(AE), ['<'],  arithmetic_expression(AE).
condition( cdn(AE,'>',AE) ) -->  arithmetic_expression(AE), ['>'],  arithmetic_expression(AE).

