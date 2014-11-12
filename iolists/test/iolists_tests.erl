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
    , ?_assertException( error, badarg
                       , iolists:to_list([<<1,2,3>>, 4, [5|6], {a}])) ].

to_binary_test_ () ->
    [ ?_assertEqual( <<1,2,3,255>>
                   , iolists:to_binary([1,2,3, <<>>, 255]))
    , ?_assertEqual( <<1,2,3,1,1>>
                   , iolists:to_binary([1,2,3, <<>>, 257])) ].

%% Internals

%% End of Module.
