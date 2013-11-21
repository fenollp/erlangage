%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(rmacro).

%% rmacro: 

-export([a/0]).

-define(cl_char(X), ok).
-define(cl_char2(X1,X2), ?cl_char(X1), ?cl_char(X2)).
-define(cl_char4(X1,X2,X3,X4),
        ?cl_char2(X1,X2), ?cl_char2(X3,X4)).
-define(cl_char8(X1,X2,X3,X4,X5,X6,X7,X8),
        ?cl_char4(X1,X2,X3,X4), ?cl_char4(X5,X6,X7,X8)).
-define(cl_char16(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16),
        ?cl_char8(X1,X2, X3, X4, X5, X6, X7, X8),
        ?cl_char8(X9,X10,X11,X12,X13,X14,X15,X16)).
%% API

a () ->
    io:format("~p\n", [[?cl_char16(2,2,2,2,e,e,ko,k,2,2,2,2,e,e,ko,k)]]).

%% Internals

%% End of Module.
