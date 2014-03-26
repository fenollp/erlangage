%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(opti_boxing0).

%% opti_boxing0: see if there is a way to not /create a tuple/
%%   when having to export 2+ variables.
%% Conclusion: +to_core
%%   Erlang exporting hides tuple and atom creation. No opti here.

-export([ w/0
        , wo/0 ]).


%% API

w () ->
    {A, B} = case random:uniform() of  %% core: let <A,B> =
                 M when M > 0.5 ->
                     {M, (M + 1) / 2};
                 N ->
                     {N, N -1}
             end,
    io:format("~p ~p\n", [A,B]).

wo () ->
    case random:uniform() of  %% core: let <_cor6,A,B> =
        M when M > 0.5 ->
            A = M,
            B = (M + 1) / 2;
        N ->
            A = N,
            B = N -1
    end,
    io:format("~p ~p\n", [A,B]).

%% End of Module.
