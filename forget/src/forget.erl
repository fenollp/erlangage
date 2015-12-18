%% Copyright © 2015 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(forget).

%% forget: 

-export([start/0]).

-define(ONE_S, 1000).
-define(FIVE_S, 5 * ?ONE_S).

%% api

start () ->
    spawn(fun loop/0).

%% Internals

loop () ->
    erlang:send_after(?ONE_S, self(), dump),
    loop(#{ i => 0
          , c => 0
          , f => 0
          }).

loop (S) ->
    receive
        {put, Ty, TS}
          when Ty == i; Ty == c; Ty == f ->
            #{Ty := Val} = S,
            NewVal = Val + 1 * 3,
            erlang:send_after(1*?FIVE_S, self(), {del, Ty}),
            erlang:send_after(2*?FIVE_S, self(), {del, Ty}),
            erlang:send_after(3*?FIVE_S, self(), {del, Ty}),
            loop(S#{Ty => NewVal});
        {get, Ty} ->
            #{Ty := Val} = S,
            io:format("count(~s) = ~p\n", [Ty, Val]),
            loop(S);
        {del, Ty} ->
            #{Ty := Val} = S,
            NewVal = Val - 1,
            loop(S#{Ty => NewVal});

        dump ->
            io:format("GOT: ~p\n", [S]),
            erlang:send_after(?ONE_S, self(), dump),
            loop(S);

        stop ->
            ok;
        M ->
            io:format("M = ~p\n", [M]),
            loop(S)
    end.

%% End of Module.
