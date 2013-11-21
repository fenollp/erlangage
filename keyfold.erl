%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(keyfold).

%% keyfold: extension to stdlib's lists module.
%%          Intersection of lists:fold{l,r}/3 and lists:keymap/3.

-include_lib("eunit/include/eunit.hrl").

-export([keyfoldl/4]).
-export([keyfoldr/4]).

%% API

keyfoldl (F, A, K, T) ->
    keyfold(F, A, fun lists:foldl/3, K, T).

keyfoldr (F, A, K, T) ->
    keyfold(F, A, fun lists:foldr/3, K, T).

%% Tests

keyfoldl_test_ () ->
    Tuples = [{1,5}, {2,4}, {3,3}, {4,2}, {5,1}],
    [ ?assertEqual(keyfoldl(fun (X, Acc) -> X + Acc end, 0, 2, Tuples), 15)
    , ?assertEqual(keyfoldl(fun (X, Acc) -> [X|Acc] end, [], 1, Tuples),
                   [5,4,3,2,1]) ].

keyfoldr_test_ () ->
    Tuples = [{1,5}, {2,4}, {3,3}, {4,2}, {5,1}],
    [ ?assertEqual(keyfoldr(fun (X, Acc) -> X * Acc end, 1, 2, Tuples), 120)
    , ?assertEqual(keyfoldr(fun (X, Acc) -> [X|Acc] end, [], 1, Tuples),
                   [1,2,3,4,5]) ].

%% Internals

keyfold (Fun, AccIn, Fold, Key, Tuples) ->
    Fold(fun (Tuple, Acc) ->
                 Elem = element(Key, Tuple),
                 Fun(Elem, Acc)
         end, AccIn, Tuples).

%% End of Module.
