%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(blowup).

%% blowup: 

-export([s/0]).

%% API

s () ->
    {ok, A} = oka(),
    {ok, B} = okb().

oka () ->
    {ok, a}.
okb () ->
    io:format("").

%% Internals

%% End of Module.
