%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(badarg_bug_tests).

%% badarg_bug: 

-export([  normal/0
        , normal2/0
        ,     bad/0
        ,    bad2/0 ]).

-include_lib("eunit/include/eunit.hrl").

-define(F, fun (K) ->
                   case K of
                       key -> value;
                       _K  -> no
                   end
           end).

-define(G, fun (Kk) ->
                   case Kk of
                       key2 -> value2;
                       _Kk  -> (?F)(_Kk)
                   end
           end).

%% API

normal () ->
    F = ?F,
    value = F(key),
    no    = F(garbage),
    Ff = binary_to_term(term_to_binary(F)),
    value = Ff(key),
    no    = Ff(garbage),
    Ff.

normal2 () ->
    F = binary_to_term(term_to_binary(?F)),
    value = F(key),
    no    = F(garbage),
    F.

bad () ->
    F = ?F,
    value = F(key),
    no    = F(garbage),
    F = binary_to_term(binary_to_term(F)).

bad2 () ->
    G = ?G,
    value  = G(key),
    value2 = G(key2),
    no     = G(garbage),
    G = binary_to_term(binary_to_term(G)).

%% Internals

normal_test_ () ->
    F = ?F,
    [ ?_assertEqual(normal(), F)
    , ?_assertEqual(normal2(), F)
    , ?_assertEqual(bad(), F) ].

bad_test () ->
    ?assertEqual(bad2(), ?G).

%% End of Module.
