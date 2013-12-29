%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(iodata_to_string).

%% iodata_to_string: the slowest (and only?) way to iodata() -> string().

-export([ main/1 ]).


%% API

-spec main (iodata()) -> string().

main (IOdata) ->
    {ok, Fd} = file:open("bla", [ram,write,read,binary]),
    ok = file:write(Fd, IOdata),
    {ok, Str} = file:pread(Fd, 0, 8192),
    ok = file:close(Fd),
    Str.

%% End of Module.
