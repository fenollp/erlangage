%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(fun_info).

%% fun_info: how is m:f/n v. f/n different for fun_info/1?
%% a/0: [{module,fun_info},{name,a},{arity,0},{env,[]},{type,external}]
%% b/0: [{pid,<0.62.0>},
%%       {module,fun_info},
%%       {new_index,0},
%%       {new_uniq,<<153,109,228,58,249,254,132,132,243,156,180,208,227,177,153,
%%                   77>>},
%%       {index,0},
%%       {uniq,80441121},
%%       {name,'-main/1-fun-0-'},
%%       {arity,0},
%%       {env,[]},
%%       {type,local}]
%%% module is still the same!

-export([main/1
        ,a/0
        ]).

%% API

main (_) ->
    io:format("a/0: ~p\n", [erlang:fun_info(fun ?MODULE:a/0)]),
    io:format("b/0: ~p\n", [erlang:fun_info(fun b/0)]),
    ok.

%% Internals

a () -> a.
b () -> b.

%% End of Module.
