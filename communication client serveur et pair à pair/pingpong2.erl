% Pour aider à construire pingpong
% Exemple tiré de la partie 4 du cours Erlang sur le SdZ

-module(pingpong2).

-export([start/1, pingueur/2]).

%% Fonction qui va lancer nos deux processus avec le nombre initial
%start(Serveur, [Clients]) ->
%    register(Serveur, sawn(fun() -> pongueur(0) end)),
%    start([%Serveur | Clients]).

start([]) -> ok;
start([Last | []]) ->
%    register(Last, spawn(fun() -> pingueur([], 0) end)),
    ok;
start([Client | Clients]) ->
    register(Client, spawn(fun() -> pingueur([Clients], 0) end)),
    start(Clients).

pingueur([Ami | Amis] = Input, X) -> 
    Ami ! {ping, self()},
    receive
        {ping, PID} ->   %% Un ping envoyé par PID
            timer:sleep(2000),   %% Sert à attendre deux secondes (pour que les choses n'aillent pas trop vite)
            M = X + 1,   %% Un message de plus
            PID ! {pong, self(), M},
            pingueur(Input, M);  %% On boucle avec le nouveau nombre de messages reçus.

        {pong, Ami, N} ->
            io:format("Reçu ~w~n", [N]),
            pingueur(Amis, N);

        die -> ok;
        _ -> pingueur(Input, X)
    end.

pongueur(N) ->
    timer:sleep(2000),   %% Sert à attendre deux secondes (pour que les choses n'aillent pas trop vite)
    receive
        {ping, PID} ->   %% Un ping envoyé par PID
            M = N + 1,   %% Un message de plus
            PID ! {pong, self(), M},
            pongueur(M)  %% On boucle avec le nouveau nombre de messages reçus.
    after
        5000 -> io:format("Je ne reçois rien, donc je m'arrête.~n")
    end.

% USAGE
%1> c(clientserver).
%{ok,clientserver}
%2> Foo = clientserver:start().
%<0.39.0>
%Reçu 1
%Reçu 2
%3> Foo ! {pong, 42}.    %% On envoie un message au processus pingueur !
%Reçu 42
%{pong,42}
%Reçu 3
%Reçu 4
