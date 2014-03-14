%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(matching_order).

%% matching_order: 

-export([ do1/1
        , do2/1 ]).


%% API

do1 (T={'=', _, _}) when is_tuple(T) ->
    ok.

do2 ({_, '=', _}) ->
    k.

%% Internals

%% End of Module.
