%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(l_vs_b).

%% l_vs_b: compare dot product on list vs. on binary.

-export([ do/1 ]).

%-define(SAMPLE_SIZE, 5).
-define(ll, [1.0,2.0,3.0,4.0,5.0]).
-define(lr, [5.0,4.0,3.0,2.0,1.0]).
-define(bl, <<1.0/float,2.0/float,3.0/float,4.0/float,5.0/float>>).
-define(br, <<5.0/float,4.0/float,3.0/float,2.0/float,1.0/float>>).

%% API

do (Times) ->
    Ls = iter(Times, fun () -> dotl(?ll,?lr) end, 0),
    io:format("Lists: ~p iterations, mean ~p\n", [Times,Ls/Times]),
    Bs = iter(Times, fun () -> dotb(?bl,?br) end, 0),
    io:format("Lists: ~p iterations, mean ~p\n", [Times,Bs/Times]).

%% Internals

iter (0, _, Sum) ->
    Sum;
iter (Times, Fun, Acc) ->
    {D, _} = timer:tc(Fun),
    iter(Times - 1, Fun, Acc + D).

dotl ([N|Ns], [W|Ws]) ->
    N * W + dotl(Ns, Ws);
dotl ([], []) ->
    0.

dotb (<<N/float, Ns/binary>>, <<W/float, Ws/binary>>) ->
    N * W + dotb(Ns, Ws);
dotb (<<>>, <<>>) ->
    0.

%% End of Module.
