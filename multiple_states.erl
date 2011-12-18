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
main(42) -> ok;
main(N) ->
  self() ! N,
  io:format("Sent ~p~n", [N]),
  timer:sleep(1),
  receive
  M when M rem 2 =:= 0 ->
    io:format("Received ~p~n", [M]),
    main(N +1);
  _ -> main(N +3)
  end.
