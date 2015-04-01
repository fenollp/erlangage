%% Copyright © 2015 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(runtime_binary_match).

%% runtime_binary_match: m/2 is bad \\ n/2 !
%% src/hangups_util.erl:60: a binary field without size is only allowed at the end of a binary pattern
%% src/hangups_util.erl:60: a binary field without size is only allowed at the end of a binary pattern
%% Erlang R15B03 (erts-5.9.3.1) [source] [64-bit] [async-threads:0] [hipe] [kernel-poll:false]
%% Linux wef.2600hz.com 2.6.32-431.el6.x86_64 #1 SMP Fri Nov 22 03:15:09 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

-export([ m/2
        , n/2 ]).


%% API

m (M, Bin) when is_binary(Bin) ->
    case M of
        <<"bla", ".", Bin/binary, ".", _/binary>> -> true;
        _ -> false
    end.

n (M, Bin) when is_binary(Bin) ->
    Size = byte_size(Bin),
    case M of
        <<"bla", ".", Bin:Size/binary, ".", _/binary>> -> true;
        _ -> false
    end.

%% Internals

%% End of Module.
