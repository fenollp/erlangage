%%%----------------------------------------------------------------------
%%% File    : multiple_states.erl
%%% Author  : Pierre Fenoll ‹pierrefenoll@gmail.com›
%%% Purpose : See multiple states of a looping function
%%% Date    : 17 Dec 2011
%%%----------------------------------------------------------------------

-module(multiple_states).
-author('pierrefenoll@gmail.com').

-export([main/0]).

main() -> main(0).
main(11) -> ok;
main(N) ->
  self() ! N,
  receive
  M ->
    io:format("Received ~p~n", [M]),
    main(N +1)
  end.
