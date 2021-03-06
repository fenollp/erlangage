%%%----------------------------------------------------------------------
%%% File    : multiple_states.erl
%%% Author  : Pierre Fenoll ‹pierrefenoll@gmail.com›
%%% Purpose : See multiple states of a looping function
%%%           Is the function able to compute sth out of a receive case 
%%%             while computing sth therein?
%%% Date    : 17 Dec 2011
%%%----------------------------------------------------------------------

-module(multiple_states).
-author('pierrefenoll@gmail.com').

-export([main/0]).

main() -> main(0).
main(42) -> theAnswer;
main(N) ->
  Pid = spawn(fun() -> loop(N) end),
  Pid ! N,
  io:format("Sent ~p~n", [N]),
  Pid ! M = N +1,
  io:format("Sent ~p~n", [M]).


loop(N) ->
  io:format("Haz ~p~n", [N]),
  receive
  M when M rem 2 =:= 0 ->
    io:format("Received ~p~n", [M]),
    timer:sleep(5000),
    io:format("Outta da state~n"),
    loop(N +1);
  _M ->
    io:format("Nonobstant ~p~n", [_M]),
    loop(N +3)
  end.

%%% Conclusion: Unhappily you get stuck inside a state when receiving messages,
%%%               meaning you don't process waiting messages in parallel : as 
%%%               if there were multiple instances of the function
