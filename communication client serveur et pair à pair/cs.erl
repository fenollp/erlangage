% Pour aider à construire pingpong; voici pingpangpong.
% Le serveur, unique, répartie du travail (ici une addition) sur ses clients, infinis.

% Maintenant, comment faire que le serveur soit un client d'un plus gros serveur et lui passer des ordres ?
% Ou pour suivre une idée de décentralisation, comment transforler serveur/0 en client/1 ?

-module(cs).
-export([start/0, start_client/1, client/1, serveur/0]).
-author("pierrefenoll@gmail.com").

%% Fonction qui va lancer nos deux processus avec le nombre initial
start() ->
    register(serveur, spawn(fun() -> serveur() end)),
    %spawn(?MODULE, client, [0]),
    spawn(fun() -> start_client(1) end).    % start 1 client/1

start_client(0) -> ok;
start_client(X) ->
    link(whereis(serveur)),
    client(0),
    start_client(X - 1).

client(N) ->
    timer:sleep(1000),  %% En secondes. (pour que les choses n'aillent pas trop vite)
    serveur ! {ping, self()},   % ⒈ ping
    receive
        pang ->
            M = N + 1,
            serveur ! {pong, M},    % ⒊ pong
            client(M);    %% On boucle avec le nouveau nombre de messages reçus.

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
