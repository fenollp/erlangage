-module(preluded).

%% preluded: preluded library's entry point.

-export([ number/0
        , number/1
        , number/2
        , number/3
        , number/4
        , number/5
        ]).


%% API

number () -> ok.
number (_1) -> number(ok).
number (_1, _2) -> number(ok, ok).
number (_1, _2, _3) -> number(ok, ok, ok).
number (_1, _2, _3, _4) -> number(ok, ok, ok, ok).
number (_1, _2, _3, _4, _5) -> number(ok, ok, ok, ok, ok).

%% Internals

%% End of Module.
