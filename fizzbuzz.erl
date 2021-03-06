-module(fizzbuzz).
-export([do/1]).

do (N) ->
    [case {X rem 3, X rem 5} of {0, 0} -> fizzbuzz
                              ; {0, _} -> fizz
                              ; {_, 0} -> buzz
                              ; {_, _} -> X
     end || X <- lists:seq(1, N)].
