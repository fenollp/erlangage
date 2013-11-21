%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(empty_fun_name).

%% empty_fun_name: 

-export([''/0, p/0]).

%% API

'' () ->
    yay.

p () ->
    ''().

%% Internals

%% End of Module.
