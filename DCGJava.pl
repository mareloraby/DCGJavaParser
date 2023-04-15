

s(s( JC ) ) --> java_code(Jc)

java_code( jc(As)) --> assignment_statement(As).
java_code( jc(Cs) ) --> conditional_statement(Cs).
java_code( jc(Ls) ) --> loop(Ls).

% ---------------------------------------------------------

assignment_statement(as(JI,=,AE,';')) --> java_identifier(JI), [=], arithmetic_expression(AE), [';'].

arithmetic_expression( ae(AT,AER) ) --> arithmetic_term(AT), arithmetic_expression_rest(AER).

arithmetic_expression_rest( aer(+, AT, AER) ) --> [+], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( aer(-, AT, AER) ) --> [-], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( aer(*, AT, AER) ) --> [*], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( aer(/, AT, AER) ) --> [/], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( aer('%', AT, AER) ) --> ['%'], arithmetic_term(AT), arithmetic_expression_rest(AER).
arithmetic_expression_rest( aer() ) --> [].

arithmetic_term( at(T) ) --> term(T).
arithmetic_term( at('(', AE, ')')) --> ['('], arithmetic_expression(AE), [')'].

term( t(JI) ) --> java_identifier(JI).
term( t(Uil) ) --> unsigned_int_literal(Uil).

java_identifier( ji(X) ) --> [X], {atom_chars(X,Chars), Chars\=[], Chars = [FirstChar|_], \+code_type(FirstChar, digit), maplist(java_identifier_char,Chars)}.

java_identifier_char(C) :- code_type(C, alpha).
java_identifier_char(C) :- code_type(C, digit).
java_identifier_char('_').

unsigned_int_literal( uil(X) ) --> [X], {integer(X)}.

% ---------------------------------------------------------

conditional_statement(cs('if','(', Cn, ')', Ifb, Else)) --> ['if'], ['('], condition(Cn), [')'], if_body(Ifb), else_condition(Else).

if_body( ibody(AS) ) --> assignment_statement(AS).
if_body( ibody(CS) ) --> conditional_statement(CS).

else_condition(ec( 'else', Ifb)) --> ['else'], if_body(Ifb).
else_condition(ec()) --> [].

% ---------------------------------------------------------

loop( while('while','(', Cn,')',Lb) ) --> ['while'], ['('], condition(Cn), [')'], loop_body(Lb).

loop_body( lbody(AS)) --> assignment_statement(AS).
loop_body( lbody(W)) --> loop(W).

% ---------------------------------------------------------

condition( cdn(AE,'==',AE) ) --> arithmetic_expression(AE), ['=='], arithmetic_expression(AE).
condition( cdn(AE,'!=',AE) ) --> arithmetic_expression(AE), ['!='], arithmetic_expression(AE).
condition( cdn(AE,'<=',AE) ) --> arithmetic_expression(AE), ['<='], arithmetic_expression(AE).
condition( cdn(AE,'>=',AE) ) --> arithmetic_expression(AE), ['>='], arithmetic_expression(AE).
condition( cdn(AE,'<',AE) ) -->  arithmetic_expression(AE), ['<'],  arithmetic_expression(AE).
condition( cdn(AE,'>',AE) ) -->  arithmetic_expression(AE), ['>'],  arithmetic_expression(AE).

