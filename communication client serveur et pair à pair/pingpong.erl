% Mon deuxième erlang-test !
% On va faire ping pong...
% L'idée c'est de faire plusieurs entitées indépendantes, toutes capables de ping/ponger n'importe qui.
% <> Un ping décentralisé. Il faut pouvoir le lancer infiniement: une fonction spawnable, indépendante.
% On en lance deux/trois et elles doivent pouvoir se reconnaitre, tisser des liens...

-module(pingpong).
-export([play_the_game/0, take_my_hand/1, ping/1]).

-author("pierrefenoll@gmail.com").

%start(First, Second) -> % Pour commencer quelque chose, il faut être deux... ?
%    register(First, spawn(fun() -> play_the_game(Second) end))
%.

% Friends play games, nonregarding whom self it is about : Me isn't specially part of Friends.
%start([Friend|Friends]) ->
    

play_the_game([]) ->
    play_the_game();

%play_the_game([self()|[]]) ->   % Pas vraiment sûr que le cas existe
%    play_the_game();

play_the_game([Friend|Friends]) ->  % Le problème ici c'est que c'est bien joli mais self() n'envoie pas
    %[First|Friends] = Input,       %  de ping à _chacun_ de ses copaings
    register(Friend,
        spawn(fun() -> play_the_game([self()|Friends]) end)  % self() du père de Friend
    ),
    %Friend ! {ping, self()},
    play_the_game(Friends).

play_the_game() ->
    receive
        {ping, Friend} ->
            Friend ! {pong, self()},
            io:format("~p said ping!~n", [Friend]),
            play_the_game();
        {pong, Friend} ->
            io:format("~p answered my ping!~n", [Friend]),
            play_the_game();
        {meet, []} ->
            play_the_game();
        {meet, Friends} ->
            io:format("~p met ~p~n", [self(), Friends]),
            take_my_hand(Friends),
            play_the_game();
        die -> ok
    after   % si on ne reçoit rien
        %2000 -> 
        5000 -> self() ! die
    end.

take_my_hand([]) -> ok;
take_my_hand([Mate | Mates]) ->
    Mate ! {meet, [Mates]},
    take_my_hand(Mates).

ping([]) -> ok;
ping([Friend | Friends]) ->
    Friend ! {ping, self()},
    io:format("ping send to ~p~n", [Friend]),
    ping(Friends).


