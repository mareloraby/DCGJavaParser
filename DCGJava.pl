s( s(JC1)) --> java_code(JC1).
s( s(JC1, JC2) ) --> java_code(JC1), java_code(JC2).
s( s(JC1, JC2, JC3)) --> java_code(JC1), java_code(JC2), java_code(JC3).

% ---------------------------------------------------------

java_code(As) --> assignment_statement(As). 
java_code(Ls) --> loop(Ls).
java_code(Cs) --> conditional_statement(Cs).

% ---------------------------------------------------------

assignment_statement(assignStatement(JI,=,AE,';')) --> java_identifier(JI), [=], arithmetic_expression(AE), [';'].

arithmetic_expression( AT ) --> arithmetic_term(AT).
arithmetic_expression( exprs(AT,AER) ) --> arithmetic_term(AT), arithmetic_expression_rest(AER).

arithmetic_expression_rest( exprsRest(+, AT) ) --> [+], arithmetic_term(AT).
arithmetic_expression_rest( exprsRest(+, AT, AER) ) --> [+], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest(-, AT) ) --> [-], arithmetic_term(AT).
arithmetic_expression_rest( exprsRest(-, AT, AER) ) --> [-], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest(*, AT) ) --> [*], arithmetic_term(AT).
arithmetic_expression_rest( exprsRest(*, AT, AER) ) --> [*], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest(/, AT) ) --> [/], arithmetic_term(AT).
arithmetic_expression_rest( exprsRest(/, AT, AER) ) --> [/], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( exprsRest('%', AT) ) --> ['%'], arithmetic_term(AT).
arithmetic_expression_rest( exprsRest('%', AT, AER) ) --> ['%'], arithmetic_term(AT), arithmetic_expression_rest(AER).

arithmetic_term( JI ) --> java_identifier(JI).
arithmetic_term( Uil ) -->unsigned_int_literal(Uil).
arithmetic_term( bracketTrm('(', AE, ')')) --> ['('], arithmetic_expression(AE), [')'].

java_identifier( id(X) ) --> [X], { X \== while, X \== if, X\== else, atom_chars(X,Chars), Chars\=[], Chars = [FirstChar|_], \+code_type(FirstChar, digit), maplist(java_identifier_char,Chars)}.
java_identifier_char(C) :- code_type(C, alpha).
java_identifier_char(C) :- code_type(C, digit).
java_identifier_char('_').

unsigned_int_literal( int(X) ) --> [X], {integer(X)}.

% ---------------------------------------------------------

conditional_statement(ifStatement('if','(', Cn, ')', Ifb)) --> ['if'], ['('], condition(Cn), [')'], if_body(Ifb).
conditional_statement(ifStatement('if','(', Cn, ')', Ifb, Else)) --> ['if'], ['('], condition(Cn), [')'], if_body(Ifb), else_condition(Else).
else_condition(elseBody( 'else', Ifb)) --> ['else'], if_body(Ifb).

if_body( ifbody(AS) ) --> assignment_statement(AS).
if_body( ifbody(CS) ) --> conditional_statement(CS).

% ---------------------------------------------------------

loop( whileLoop(while,'(', Cn,')',Lb) ) --> [while], ['('], condition(Cn), [')'], loop_body(Lb).

loop_body( loopBody(AS)) --> assignment_statement(AS).
loop_body( loopBody(W)) --> loop(W).

% ---------------------------------------------------------

condition( cdn(AE1,'==',AE2) ) --> arithmetic_expression(AE1), ['=='], arithmetic_expression(AE2).
condition( cdn(AE1,'!=',AE2) ) --> arithmetic_expression(AE1), ['!='], arithmetic_expression(AE2).
condition( cdn(AE1,'<=',AE2) ) --> arithmetic_expression(AE1), ['<='], arithmetic_expression(AE2).
condition( cdn(AE1,'>=',AE2) ) --> arithmetic_expression(AE1), ['>='], arithmetic_expression(AE2).
condition( cdn(AE1,'<',AE2) ) -->  arithmetic_expression(AE1), ['<'],  arithmetic_expression(AE2).
condition( cdn(AE1,'>',AE2) ) -->  arithmetic_expression(AE1), ['>'],  arithmetic_expression(AE2).

