-module(hello).

-export([hello/0,hello/1]).

hello() ->
	hello("world").
hello(Nom) ->
	"Hello " ++ Nom ++ " !".

