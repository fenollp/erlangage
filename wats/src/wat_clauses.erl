%% -*- coding: utf-8 -*-
-module(wat_clauses).

%% wat_clauses:
%%  a warning should be emitted as 2nd clause will never match (given 1st clause)

-export([authenticate_nouns/1]).

%% API

authenticate_nouns([{<<"user_auth">>, _}]) -> 'true';
authenticate_nouns([{<<"user_auth">>, [<<"recovery">>]}]) -> hi;
authenticate_nouns(_Nouns) -> 'false'.

%% End of Module.
