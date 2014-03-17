%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(tcp_server).

%% tcp_server: 

-export([ start/0 ]).


%% API

start () ->
        {ok, ListenSocket} = gen_tcp:listen(1234, [binary, {packet, 4},
                                                   {active, true}, {reuseaddr, true}]),
    spawn(fun() -> per_connect(ListenSocket) end).


per_connect (ListenSocket) ->
    {ok, Socket} = gen_tcp:accept(ListenSocket),
    spawn(fun() -> per_connect(ListenSocket) end),%%%%%%%%%%%%%%%%%%%%%%%
    loop(Socket).


loop (Socket) ->
    receive
        {tcp, Socket, Data} ->
            io:format("~p~n", [binary_to_list(Data)]),
            loop(Socket);
        {tcp_closed, Socket} ->
            io:format("closed~n"),
            gen_tcp:close(Socket)
    end.

%% Internals

%% End of Module.
