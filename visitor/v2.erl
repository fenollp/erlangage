%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(v2).

%% v: visiorz

-compile(export_all).

%% API

visit (A, T) -> visit (A, T, top_down).

visit (A, T, Way) ->
    F = fun (N) ->
            case catch (A (N)) of
                {'EXIT',{function_clause,_}} -> f("T = ~p\n",[N]), N;
                U -> U
            end
        end,
    W = case Way of
        bottom_up -> fun bottom_up/2
        %;top_down -> fun (G,U) -> v(G,fun top_down/2,G(U)) end
        %;top_down -> fun (U) -> v(G,fun top_down/2,F(U)) end
        ;top_down -> fun top_down/2
    end,
    H = fun (Te) -> W(F,Te) end,
    v (H, H(T)).

top_down  (F,T) -> v(F,F(T)).
bottom_up (F,T) -> F(v(F,T)).

v (H, {'+', L, T, U}) -> {'+', L, H(T), H(U)};
v (H, {'*', L, T, U}) -> {'*', L, H(T), H(U)};
v (H, {int, L, T   }) -> {int, L, H(T)           };
v (H, [He|T]) -> [H(He)|H(T)];
v (_, []) -> [];
v (_, T) -> T.

a ({int,L,"1"}) -> f(1.0), {int, L, 1.0};
a ({int,L,I}) -> f("Integer: ~s\n",[I]), {int, L, list_to_integer(I)}.

test (F) -> test (F,top_down).
test (F,Way) ->
    %% (5 + 4) * 3 + 2
    T = [{'+',1,{'*',1,{'+',1,
                             {int,1,"5"},
                             {int,1,"4"}},
                      {int,1,"3"}},
               {int,1,"2"}},
         {int,2,"1"}],
    visit(F, T, Way).

f(_A,_B) -> io:format(_A,_B).
f(_T) -> io:format("~p\n",[_T]).

pp ({'+', L, T, U}) -> f('+'), {'+', L, pp(T), pp(U)};
pp ({'*', L, T, U}) -> f('*'), {'*', L, pp(T), pp(U)};
pp ({int, L, T}) -> f(int), {int, L, pp(T)}.

%% Internals

%% End of Module.
