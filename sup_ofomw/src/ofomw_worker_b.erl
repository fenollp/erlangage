%% Copyright © 2015 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(ofomw_worker_b).
-behaviour(gen_server).

%% ofomw_worker_b: 

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {arg}).

%% API

start_link(Args) ->
    io:format("~s:start_link Args = ~p\n", [?MODULE,Args]),
    gen_server:start_link({local,?MODULE}, ?MODULE, Args, []).

init(Args) ->
    io:format("~s:init Args = ~p\n", [?MODULE,Args]),
    {the_arg, Arg} = Args,
    State = #state{arg = Arg},
    {ok, State}.

handle_call(_Request, _From, State) ->
    io:format("unhandled call ~p ~p\n", [_Request,_From]),
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    io:format("unhandled cast ~p\n", [_Msg]),
    {noreply, State}.

handle_info(_Info, State) ->
    io:format("unhandled info ~p\n", [_Info]),
    {noreply, State}.

terminate(_Reason, _State) ->
    io:format("~s terminating with reason ~p state ~p\n", [?MODULE,_Reason,_State]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% Internals

%% End of Module.
