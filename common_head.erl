%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(common_head).

%% common_head: hacking module for the shell-expand-0arity-completely branch.

-compile(export_all).
-import(lists, [reverse/1]).

%% API

data () ->
    lists:sort([ {"jeanne", 1}
               , {"jeannine", 2}
               , {"jeann", 0}
               %, {"jeans", 3}
               ]).

longest_common_head ([]) ->
    no;
longest_common_head (LL) ->
    longest_common_head(LL, []).

longest_common_head ([{"",_}|_], L) ->
    {partial, reverse(L)};
longest_common_head (LL, L) ->
    io:format("LL, L\t~p, ~p\n", [LL,L]),
    case same_head(LL) of
        true ->
            [{[H|_],_}|_] = LL,
            LL1 = all_tails(LL),
            case all_nil(LL1) of
                false ->
                    longest_common_head(LL1, [H|L]);
                true ->
                    {complete, reverse([H|L])}
            end;
        false ->
            {partial, reverse(L)}
    end.

same_head([{[H|_],_}|T1]) ->
    same_head(H, T1).
same_head(H, [{[H|_],_}|T]) -> same_head(H, T);
same_head(_, [])            -> true;
same_head(_, _)             -> false.

all_tails(LL) ->
    all_tails(LL, []).
all_tails([{[_|T],A}|T1], L) -> all_tails(T1, [{T,A}|L]);
all_tails([], L)             -> L.

all_nil([]) -> true;
all_nil([[] | Rest]) -> all_nil(Rest);
all_nil(_) -> false.

%% Internals

%% End of Module.
