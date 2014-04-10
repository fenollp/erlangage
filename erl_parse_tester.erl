%% Copyright © 2014 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(erl_parse_tester).

%% erl_parse_tester: 

-export([ ast/1 ]).


%% API

ast (File) ->
    %% code:unstick_mod(erl_parse)
    %% yecc:file("src/parser.yrl", [])
    case epp_dodger:parse_file(File) of
	{ok,Forms} ->
	    [print_error_markers(F, File) || F <- Forms],
	    ok;
	{error,Reason} ->
	    io:format("~s: ~p\n", [File,Reason]),
	    error
    end.
    %%{ok, Tokens, _NLines} = erl_scan:

%% Internals

print_error_markers(F, File) ->
    case erl_syntax:type(F) of
	error_marker ->
	    {L,M,Info} = erl_syntax:error_marker_info(F),
	    io:format("~s:~p: ~s\n", [File,L,M:format_error(Info)]);
	_ ->
	    ok
    end.

%% End of Module.

%% Finally:
t () ->
    true = code:unstick_mod(erl_parse),
    cd("lib/stdlib/src"),
    yecc:file("erl_parse.yrl"),
    c(erl_parse),
    %%Note: code:clash()
    {ok, F, _} = erl_scan:string("f() -> bla"),
    erl_parse:parse_form(F).
%%{ok,{function,1,f,0,[{clause,1,[],[],[{atom,1,bla}]}]}}
