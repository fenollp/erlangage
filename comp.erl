%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(comp).

%% comp: 

%-export([match/1]).
-export([filter/1]).

%% API

%match (Patt) ->
%    [X || Patt <- data()].

filter (Filter) ->
    [X || X <- data(), Filter(X)].

%% Internals

data () ->
    lists:seq(1,10).

%% End of Module.
