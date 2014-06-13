%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(webserver).

%% webserver: simple web server that responds with "Hello World" ∀ request

-export([ start/0 ]).


%% API

start () ->
    spawn(fun () ->
                  {ok, Socket} = gen_tcp:listen(1337, [ {reuseaddr, true}
                                                %, {packet, http}
                                                      , {active, false} ]),
                  serve(Socket)
          end),
    io:format("Server running at http://127.0.0.1:1337/\n").

%% Internals

serve (Socket) ->
    {ok, Conn} = gen_tcp:accept(Socket),
    Handler = spawn(fun () ->
                            Res =  "HTTP/1.0 200 OK\n"
                                ++ "Content-Type: text/plain\n"
                                ++ "Content-Length: 12\n\n"
                                ++ "Hello World\n",
                            gen_tcp:send(Conn, Res),
                            gen_tcp:close(Conn)
                    end),
    gen_tcp:controlling_process(Conn, Handler),
    serve(Socket).

%% End of Module.
