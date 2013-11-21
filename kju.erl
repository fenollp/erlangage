%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(kju).

%% kju: 

-compile(export_all).

%% API

%% v :: ‹string› -> ‹natural›
-spec v(string()) -> pos_integer().
v (Str) ->
    case is_list(Str) of
        true ->
            length(Str)
    end.

f () ->
    D = case er of
            r ->
                ok
        end,
    D.

%% Internals

%% End of Module.
