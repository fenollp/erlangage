%%%----------------------------------------------------------------------
%%% File    : mdb_connection.erl
%%% Author  : Micka�l R�mond <mickael.remond@erlang-fr.org>
%%% Purpose : Connection management library.
%%%           Used by mdb_bot.erl
%%% Created : 16 Sep 2001, Micka�l R�mond <mickael.remond@erlang-fr.org>
%%%----------------------------------------------------------------------
%%%
%%% This program is free software; you can redistribute it and/or modify  
%%% it under the terms of the GNU General Public License as published by 
%%% the Free Software Foundation; either version 2 of the License, or   
%%% (at your option) any later version.                                
%%%
%%%----------------------------------------------------------------------
%%%
%%% See LICENSE for detailled license
%%%
%%% In addition, as a special exception, you have the permission to
%%% link the code of this program with any library released under
%%% the EPL license and distribute linked combinations including
%%% the two. If you modify this file, you may extend this exception
%%% to your version of the file, but you are not obligated to do
%%% so.  If you do not wish to do so, delete this exception
%%% statement from your version.
%%%----------------------------------------------------------------------

-module(mdb_connection).

-author('mickael.remond@erlang-fr.org').
-created('Date: 20010916').
-revision(' $Id$ ').
-vsn(' $Revision$ ').

%% External exports (API)
-export([connect/2, log/4, manage_reconnect/1]).

%% Configure debugging mode:
-include("mdb_macros.hrl").
-include("config.hrl").
-include("mdb.hrl").

%%----------------------------------------------------------------------
%% connect/2
%% Physically connects to the IRC server
%%----------------------------------------------------------------------
connect(Server, Ip_port) ->
    %% TCP connection to the IRC server
    Connect = fun() -> gen_tcp:connect(Server, Ip_port,
				       [binary,
					{packet, 0},
					{nodelay, true},
					{keepalive, true}, 
					{active, true},
					{reuseaddr, true}])
	      end,

    case Connect() of
	{ok, Sock} ->
         mdb_logger:debug("Connected to: ~p~n", [Server]),
	    {ok, Sock};

	{error, Reason} ->
	    %% If there is an error, wait 30 secondes and try to reconnect
	    mdb_logger:warn("Server connection error: ~p~n", [Reason]),
	    timer:sleep(30000),
	    connect(Server, Ip_port)
    end.

%%----------------------------------------------------------------------
%% log/3
%% connect to a given channel
%%----------------------------------------------------------------------
log(Sock, Channel = #channel{}, Passwd, RealName) ->
    %% Logging in
    log_in(Sock, Channel#channel.botname, Passwd, RealName),

    %% Join the given channel
    irc_lib:join(Sock, Channel#channel.name).

%%----------------------------------------------------------------------
%% log_in/3
%% Logging in: Give nick and realname to the server
%%----------------------------------------------------------------------
%%log_in(Sock, Nickname, RealName, Password) ->
log_in(Sock, Nickname, Passwd, RealName) ->
    irc_lib:login(Sock, Nickname, Passwd, RealName).
    %%irc_lib:passwd(Sock, "Password")

%%----------------------------------------------------------------------
%% manage_reconnect/1
%% When something fails, automatically reconnects the bot
%%----------------------------------------------------------------------
manage_reconnect(State) ->
    Host = State#state.host,
    Port = State#state.port,
    Chan = State#state.channel,
    Pass = State#state.passwd,
    Nick = State#state.nickname,
    RealName = State#state.realname,

    {ok, Sock} = connect(Host, Port),
    log(Sock, #channel{name=Chan, botname=Nick}, Pass, RealName),

    {ok, State#state{socket = Sock,
		     date   = calendar:local_time(),
		     buffer   = << >>,
		     joined = false
		    }}.
