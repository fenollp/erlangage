#!/usr/bin/env escript
%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(bench_calls).
-mode(compile).
-compile({inline, ['among?'/2]}).

%% bench_calls: benchmarks the speed of different func call ways.

%%   Unexpected results:
%% 0 ~ λ ./bench_calls.erl 10
%% foreign module call: 1150.7µs
%% local call:          2038.8µs
%% inlined call:        1833.7µs
%% 0 ~ λ ./bench_calls.erl 100
%% foreign module call: 210.31µs
%% local call:          1585.98µs
%% inlined call:        1307.36µs
%% 0 ~ λ ./bench_calls.erl 1000
%% foreign module call: 153.574µs
%% local call:          1511.764µs
%% inlined call:        1216.446µs

-export([ main/1 ]).


%% API

main ([N_]) ->
    ok = io:setopts([{encoding, unicode}]),
    N = list_to_integer(N_),
    Set = lists:seq(1, 100000),
    t(N,Set, "foreign module call: ~pµs\n", fun () -> lists:member(N,Set) end),
    t(N,Set, "local call:          ~pµs\n", fun () ->       member(N,Set) end),
    t(N,Set, "inlined call:        ~pµs\n", fun () ->     'among?'(N,Set) end),
    ok;

main (_) ->
    ok = io:setopts([{encoding, unicode}]),
    Arg0 = filename:basename(escript:script_name()),
    io:format("Usage: ~s  ‹integer N›\n", [Arg0]),
    halt(1).

%% Internals

t (N,Times, Descr, Fun) ->
    T = lists:foldl(
          fun (_X, Acc) ->
                  {Tx,_R} = timer:tc(Fun),
                  Tx + Acc
          end, 0, Times),
    io:format(Descr, [T/N]).


member (_, []) -> false;
member (X, [X|_]) -> true;
member (X, [_|T]) -> member(X, T).

'among?' (_, []) -> false;
'among?' (X, [X|_]) -> true;
'among?' (X, [_|T]) -> 'among?'(X, T).

%% End of Module.
