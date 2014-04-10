%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(table).

%% table: store atoms and that's an hash table!

-export([ new/0
        , add/3
      %%, remove/2
        , fetch/3 ]).

-define(zilch, empty_table).

%% API

new () ->
    ?zilch.

add (Key, Value, ?zilch) ->
    fun (K) ->
            case K of
                Key -> Value
            end
    end;
add (Key, Value, Table) ->
    fun (K) ->
            case K of
                Key -> Value;
                _K  -> Table(_K)
            end
    end.

fetch (_, Default, ?zilch) ->
    Default;
fetch (Key, Default, Table) ->
    try Table(Key) of
        Value -> Value
    catch
        error:function_clause -> Default;
        error:{case_clause,Key} -> Default
    end.

%% Internals.

%% 16> io:format("~w\n", [erlang:term_to_binary(Table0)]).
%% <<131,100,0,11,101,109,112,116,121,95,116,97,98,108,101>>
%% ok
%% 17> io:format("~w\n", [erlang:term_to_binary(Table)]).
%% <<131,112,0,0,0,84,1,238,220,166,159,209,129,239,127,103,181,160,145,127,196,211,163,0,0,0,0,0,0,0,2,100,0,5,116,97,98,108,101,97,0,98,7,118,229,52,103,100,0,13,110,111,110,111,100,101,64,110,111,104,111,115,116,0,0,0,37,0,0,0,0,0,100,0,5,118,97,108,117,101,100,0,3,107,101,121>>
%% ok
%% 18> io:format("~w\n", [erlang:term_to_binary(Table2)]).
%% <<131,112,0,0,0,171,1,238,220,166,159,209,129,239,127,103,181,160,145,127,196,211,163,0,0,0,1,0,0,0,3,100,0,5,116,97,98,108,101,97,1,98,7,118,229,52,103,100,0,13,110,111,110,111,100,101,64,110,111,104,111,115,116,0,0,0,43,0,0,0,0,0,112,0,0,0,84,1,238,220,166,159,209,129,239,127,103,181,160,145,127,196,211,163,0,0,0,0,0,0,0,2,100,0,5,116,97,98,108,101,97,0,98,7,118,229,52,103,100,0,13,110,111,110,111,100,101,64,110,111,104,111,115,116,0,0,0,37,0,0,0,0,0,100,0,5,118,97,108,117,101,100,0,3,107,101,121,100,0,6,118,97,108,117,101,50,100,0,4,107,101,121,50>>

%% End of Module.
