% Mon premier test en Erlang
% La fonction factorielle

-module(fac).
-export([fac/1]).

-author(pierrefenoll@gmail.com).

fac(0) -> 1;
fac(N) -> N * fac(N -1).
