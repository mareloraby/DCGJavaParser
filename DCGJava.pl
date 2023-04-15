
java_code --> assignment_statement.
java_code --> conditional_statement.
java_code --> loop.

% ---------------------------------------------------------

assignment_statement --> java_identifier, [=], arithmetic_expression, [';'].

arithmetic_expression --> arithmetic_term, arithmetic_expression_rest.

arithmetic_expression_rest --> [+], arithmetic_term, arithmetic_expression_rest.
arithmetic_expression_rest --> [-], arithmetic_term, arithmetic_expression_rest.
arithmetic_expression_rest --> [*], arithmetic_term, arithmetic_expression_rest.
arithmetic_expression_rest --> [/], arithmetic_term, arithmetic_expression_rest.
arithmetic_expression_rest --> ['%'], arithmetic_term, arithmetic_expression_rest.
arithmetic_expression_rest --> [].

arithmetic_term --> term.
arithmetic_term --> ['('], arithmetic_expression, [')'].

term --> java_identifier.
term --> unsigned_int_literal.

% java_identifier --> [X], { atom(X), atom_chars(X, [XCode]), code_type(XCode, alpha) }.
java_identifier --> [X], {atom_chars(X,Chars), Chars\=[], Chars = [FirstChar|_], \+code_type(FirstChar, digit), maplist(java_identifier_char,Chars)}.

java_identifier_char(C) :- code_type(C, alpha).
java_identifier_char(C) :- code_type(C, digit).
java_identifier_char('_').

unsigned_int_literal --> [X], { integer(X)}.

% ---------------------------------------------------------

conditional_statement --> ['if'], ['('], condition, [')'], if_body, else_condition.

if_body --> assignment_statement.
if_body --> conditional_statement.

else_condition --> ['else'], if_body.
else_condition --> [].

% ---------------------------------------------------------

loop --> ['while'], ['('], condition, [')'], loop_body.

loop_body --> assignment_statement.
loop_body --> loop.

% ---------------------------------------------------------

condition --> arithmetic_expression, ['=='], arithmetic_expression.
condition --> arithmetic_expression, ['!='], arithmetic_expression.
condition --> arithmetic_expression, ['<='], arithmetic_expression.
condition --> arithmetic_expression, ['>='], arithmetic_expression.
condition --> arithmetic_expression, ['<'], arithmetic_expression.
condition --> arithmetic_expression, ['>'], arithmetic_expression.

