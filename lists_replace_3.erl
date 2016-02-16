%% Copyright © 2016 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% -*- coding: utf-8 -*-
-module(lists_replace_3).

%% lists_replace_3: lists:replace/3

-ifdef(TEST).
- include_lib("eunit/include/eunit.hrl").
-endif.

-export([''/3]).


%% API

%% @doc
%% Replace the first occurence of `Find` with `Replace`.
%% List order is preserved.
%% Elements are *matched* ie. not using '=:='/2.
%% If `Find` is not in the list, the list is returned unaltered.
%%
%% Equivalent to (except the function keeps the original ordering)
%% ```erlang
%% case lists:member(Find, List1) of
%%     false -> List1;
%%     true -> (List1 -- [Find]) ++ Replace
%% end
%% ```
%% @end

-spec ''(Find, Replace, List1) -> List2 when
      Find :: term(),
      Replace :: term(),
      List1 :: list(),
      List2 :: list().

'' (_, _, []) -> [];
'' (Find, Replace, [Find|Rest]) ->
    [Replace | Rest];
'' (Find, Replace, List) ->
    ''(Find, Replace, [], List).

%% Tests

-ifdef(TEST).
lr3_test_ () ->
    [ ?_assertEqual([1,3], ''(2, 3, [1,2]))
    , ?_assertEqual([], ''(blip, blop, []))
    , ?_assertEqual([b], ''(a, b, [a]))
    , ?_assertEqual([1,2,3], ''(a, b, [1,2,3]))
    , ?_assertEqual(lists:seq(1,9)++[{}], ''(10, {}, lists:seq(1,10)))
    ].
-endif.

%% Internals

'' (_, _, Acc, []) ->
    lists:reverse(Acc);
'' (Find, Replace, Acc, [Find|Rest]) ->
    lists:reverse(Acc, [Replace|Rest]);
'' (Find, Replace, Acc, [NotFound|Rest]) ->
    ''(Find, Replace, [NotFound|Acc], Rest).

%% End of Module.
