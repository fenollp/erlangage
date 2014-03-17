%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(tcp_client).

%% tcp_client: 

-export([ main/0
        , send/1 ]).


%% API

send (Message) ->
    {ok, Socket} = gen_tcp:connect("localhost", 1234, [binary, {packet, 4}]),
    ok = gen_tcp:send(Socket, Message),
    gen_tcp:close(Socket).


main () ->
    Message = ["atom" ++ integer_to_list(X) || X <- lists:seq(1, 1000)],
    send(Message).


%% Internals

%% End of Module.
