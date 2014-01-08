%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(ifdef_in_fun).

%% 12:40 <      stobix>| Grr... It would seem that I can't use ifdef directives inside function bodies. Any reason why, or is it just a design flaw?

%% 1> c(ifdef_in_fun).
%% ifdef_in_fun.erl:16: syntax error before: '-'
%% ifdef_in_fun.erl:18: syntax error before: '-'
%% ifdef_in_fun.erl:19: syntax error before: ','
%% ifdef_in_fun.erl:14: variable 'TEST' is unbound
%% ifdef_in_fun.erl:14: function ifdef/1 undefined
%% ifdef_in_fun.erl:13: Warning: variable 'A' is unused
%% error

-export([ f/0 ]).

%% API

f () ->
    A =
-ifdef(TEST).
        test
-else.
        notest
-endif.
    , A.

%% Internals

%% End of Module.
