%% Copyright © 2015 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(ofomw).

%% ofomw: 

-export([start_link/0]).
-export([start/0, stop/0]).
-export([children/0]).


%% API

start_link() ->
    ofomw_sup:start_link().

start() ->
    application:start(?MODULE).

stop() ->
    ok.

children() ->
    supervisor:which_children(ofomw_sup).

%% Internals

%% End of Module.
