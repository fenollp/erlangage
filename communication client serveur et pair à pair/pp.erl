% pp : pair <-> pair
% Pas de serveur. Que des clients qui connaissent d'autres clients et qui peuvent exécuter des ordres.

% Le client qui donne des ordres (des trucs à faire) à un semblable est momentanéement un serveur, si on veut...
%  En utilisant les mêmes "mots", le même langage/protocole, n'importe quel process peut faire partie du "cercle";
% même de plus grosses fonctions, qui elles même peuvent utiliser d'autres mots pour se parler, ou tout simplement les mêmes
% mots, envoyés à une liste différente de pairs.

% L'idée principale de cet essai est que les pairs maintiennent une liste de leurs semblables.
-author("pierrefenoll@gmail.com").

-module(pp).
-export([start/1, pair/2]).

start(X) -> start(X, []).

start(0, _) -> ok;
%start(Y, []) ->
%	PID = spawn(fun() -> pair([], 0) end),
%	start(Y - 1, [PID]);
start(Z, PIDs) ->
	PID = spawn(fun() -> pair(PIDs, 0) end),
    start(Z - 1, [PID | PIDs]).


% loop(Liste) ->
%     receive
%         {add, X} -> loop([X|Liste]);
%         {del, X} -> loop([Y || Y <- Liste, Y =/= X]);
%         {From, show} -> From ! Liste,
%                         loop(Liste);
%         close -> io:format("Fin de la connexion~n")
%     end.

pair([Mate | Mates], N) ->
    timer:sleep(1000),  %% En millisecondes. (pour que les choses n'aillent pas trop vite)
    serveur ! {ping, self()},   % ⒈ ping
    receive
        pang ->
            M = N + 1,
            serveur ! {pong, M},    % ⒊ pong
            pair([Mate | Mates], M);    %% On boucle avec le nouveau nombre de messages reçus.

        die -> ok
    after
        5000 -> io:format("Le serveur ne répond plus !~n")
    end.

serveur() ->
    process_flag(trap_exit, true),
    receive
        {ping, PID} ->
            PID ! pang, % ⒉ pang
            serveur();

        {pong, N} ->
            io:format("Reçu ~w~n", [N]),
            serveur();

        {'EXIT', Pid, Raison} -> io:format("Le serveur s'arrête !~n");

        die -> ok   % + Clients ! die
%    after
%        5000 -> io:format("Je ne reçois rien, donc je m'arrête.~n")
    end.
