%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(iolists).

%% iolists: functions handling iolists

-export([ to_list/1
        , to_binary/1
        ]).


%% API

to_list ([]) -> [];
to_list (IoList)
  when is_list(IoList) ->
    [H|T] = IoList,
    to_list(H) ++ to_list(T);
to_list (<<>>) -> [];
to_list (IoList)
  when is_binary(IoList) ->
    <<E0:1/binary, Rest/binary>> = IoList,
    <<E>> = E0,
    [E | to_list(Rest)];
to_list (IoList)
  when is_tuple(IoList); is_atom(IoList) ->
    erlang:error(badarg, IoList);
to_list (IoList) ->
    [IoList].

to_binary ([]) -> <<>>;
to_binary (IoList)
  when is_list(IoList) ->
    [H|T] = IoList,
    <<(to_binary(H))/binary, (to_binary(T))/binary>>;
to_binary (IoList)
  when is_binary(IoList) ->
    IoList;
to_binary (IoList)
  when is_number(IoList) ->
    int_to_binary(IoList).

%% Internals

%% //github.com/uwiger/sext/blob/e04c3dd07e903172ff215ad9ba08e6afbad717b2/src/sext.erl#L509-L520
int_to_binary(I) when I =< 16#ff -> <<I:8>>;
int_to_binary(I) when I =< 16#ffff -> <<I:16>>;
int_to_binary(I) when I =< 16#ffffff -> <<I:24>>;
int_to_binary(I) when I =< 16#ffffffff -> <<I:32>>;
int_to_binary(I) when I =< 16#ffffffffff -> <<I:40>>;
int_to_binary(I) when I =< 16#ffffffffffff -> <<I:48>>;
int_to_binary(I) when I =< 16#ffffffffffffff -> <<I:56>>;
int_to_binary(I) when I =< 16#ffffffffffffffff -> <<I:64>>;
int_to_binary(I) ->
    %% Realm of the ridiculous
    list_to_binary(
      lists:dropwhile(fun(X) -> X==0 end, binary_to_list(<<I:256>>))).

%% End of Module.
