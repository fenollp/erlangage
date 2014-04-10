Nonterminals E AddOp MulOp.
Terminals '+' '-' '*' '/' '(' ')' number.
Rootsymbol E.

Left 100 AddOp.
Left 200 MulOp.

E -> E AddOp E : {'$2', '$1', '$3'}.
E -> E MulOp E : {'$2', '$1', '$3'}.
E -> '(' E ')' : '$2'.
Unary 300 '-'.
E -> '-' E : {neg, '$2'}.
E -> number : '$1'.

AddOp -> '+' : '$1'.
AddOp -> '-' : '$1'.
MulOp -> '*' : '$1'.
MulOp -> '/' : '$1'.
