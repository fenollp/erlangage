%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(api_sugar).

%% we: 

-export([pp/0]).


%% API

pp () ->
    %% fun '++'/2.
    fun erlang:'++'/2.

%% Internals

%% End of Module.
