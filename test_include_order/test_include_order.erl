%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(test_include_order).
-export([e/0]).
%% test_include_tests: tests for module test_include.

-include_lib("eunit/include/eunit.hrl").
-include("head.hrl").

%% API tests.

e()->
    ?A.

%% Internals

%% End of Module.
