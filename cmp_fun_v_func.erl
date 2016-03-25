%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(cmp_fun_v_func).

%% cmp_fun_v_func: compare calling a function vs calling a function applying a fun.

%% 44> G = fun (Fun, Times) -> lists:sum([T || _ <- lists:seq(1,Times), {T,_Ret} <- [timer:tc(cmp_fun_v_func, Fun, [Times])]]) / Times end.
%% #Fun<erl_eval.12.50752066>
%% 45> G(fn, 1000000). G(fnc, 1000000).
%% 1.044192
%% 46> G(fnc, 1000000).
%% 1.081405

-export([ fn/1
        , fnc/1
        ]).


%% API

fn(A) ->
    3 * A.

fnc(A) ->
    F = fun fn/1,
    fnc(F, A).

%% Internals

fnc(F, A) ->
    F(A).

%% End of Module.
