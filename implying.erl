%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(implying).

%% implying: see whether ERLC implies is_T to bounded checks.

%% erlc +S implying.erl

-export([p/1, p2/1
        ,q/1, q2/1
        ]).


%% API

p (Arg)
  when is_integer(Arg) andalso Arg >= 200 andalso Arg =< 299 ->
    y;
p (_) ->
    n.

p2 (Arg)
  when is_integer(Arg), Arg >= 200, Arg =< 299 ->
    y;
p2 (_) ->
    n.


q (Arg)
  when Arg >= 200 andalso Arg =< 299 ->
    y;
q (_) ->
    n.

q2 (Arg)
  when Arg >= 200, Arg =< 299 ->
    y;
q2 (_) ->
    n.

%% Internals

%% End of Module.
