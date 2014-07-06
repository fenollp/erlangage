#!/usr/bin/env escript
%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(int_returns).

%% int_returns: 

-export([ main/1 ]).


%% API

main (_) ->
    spawn(timer, sleep, [100000]).

%% Internals

%% End of Module.
