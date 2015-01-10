%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(iolists_tests).

%% iolists_tests: tests for module iolists.

-include_lib("eunit/include/eunit.hrl").


%% API tests.

to_list_test_ () ->
    [ ?_assertEqual( [1,2,3]
                   , iolists:to_list([1,2,3]))
    , ?_assertEqual( [1,2,3]
                   , iolists:to_list(<<1,2,3>>))
    , ?_assertEqual( [1,2,3,4,5,6,7,8]
                   , iolists:to_list([<<1,2,3>>, 4, [5,6|7], [[[8]]]]))
    , ?_assertException( error, function_clause
                       , iolists:to_list([<<1,2,3>>, 4, [5|6], {a}])) ].

to_binary_test_ () ->
    [ ?_assertEqual( <<1,2,3,255>>
                   , iolists:to_binary([1,2,3, <<>>, 255]))
    , ?_assertEqual( <<1,2,3,1,1>>
                   , iolists:to_binary([1,2,3, <<>>, 257])) ].

size_test_ () ->
    [ ?_assertEqual( 6
                   , iolists:size([1,2|<<1,2,257:16>>]))
    , ?_assertEqual( 1
                   , iolists:size(1)) ].

map_test () ->
    Id = fun (X) -> X end,
    ?_assertEqual( lists:seq(1,10)
                 , iolists:mapfilter(Id, [1,2,3, <<4,5,6>>,7,[[[8,9],10]]])).

foldr_test_ () ->
    LCons = fun (E,Acc) ->  [E|Acc]         end,
    BCons = fun (E,Acc) -> <<E,Acc/binary>> end,
    [ ?_assertEqual( <<1,2,3>>
                   , iolists:foldr(BCons, <<>>, [1,2,3]))
    , ?_assertEqual( [1,2,3]
                   , iolists:foldr(LCons, [], [1,[2,<<3>>]])) ].

filtermap_test_ () ->
    LETwo = fun (X) -> X =< 2 end,
    Intricate = fun
                    (X) when X < 5 -> false;
                    (X) when X > 5 -> true;
                    (_) -> {true,cinq}
                end,
    Even = fun (X) -> X rem 2 == 0 end,
    [ ?_assertEqual( [1,2]
                   , iolists:filtermap(LETwo, [1,2,3,4]))
    , ?_assertEqual( [cinq,6,7,8,9,10]
                   , iolists:filtermap(Intricate, lists:seq(1,10)))
    , ?_assertEqual( [2,4,6,8]
                   , iolists:filtermap(Even, lists:seq(1,4)++[{5,6},{8},{}])) ].

%% Internals

%% End of Module.
