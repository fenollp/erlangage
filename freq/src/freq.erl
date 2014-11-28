%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(freq).

%% freq: count same items in [items]

-export([ uency/1 ]).


%% API

uency (Stuff) ->
    F = fun
            Hash (Parent, []) ->
                Parent ! {freq,get()};
            Hash (Parent, [H|T]) ->
                case get(H) of
                    undefined -> put(H, 1);
                    Count     -> put(H, Count + 1)
                end,
                Hash(Parent, T)
        end,
    Parent = self(),
    spawn(fun () -> F(Parent, Stuff) end),
    receive
        {freq, Freq} -> Freq
    end.

%% Internals

%% End of Module.
