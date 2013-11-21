-module(lc_map).

-export([run/0]).

run() ->
    Seq = lists:seq(1,1000000),
    comp(10, Seq),
    mapper(10, Seq).
mapper(0, _Seq) ->
    ok;
mapper(Iter, Seq) ->
    Now1 = now(),
    lists:map(fun(N) -> N + 1 end, Seq),
    Now2 = now(),
    io:format("Map time: ~p~n", [timer:now_diff(Now2, Now1)]),
    mapper(Iter - 1, Seq).
comp(0, _Seq) ->
    ok;
comp(Iter, Seq) ->
    Now1 = now(),
    _ = [N + 1 || N <- Seq],
    Now2 = now(),
    io:format("Comprehension time: ~p~n", [timer:now_diff(Now2, Now1)]),
    comp(Iter - 1, Seq).
