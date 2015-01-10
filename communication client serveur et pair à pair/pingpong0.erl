-module(pingpong).

-export([start/0, pingueur/0, pongueur/1]).

%% ?MODULE est une macro qui renvoie le module courant
%% spawn cree des processus avec un Pid

%% Fonction qui va lancer nos deux processus avec le nombre initial
start() ->
	PID = spawn(?MODULE, pongueur, [0]),
	register(serveur, PID),	% l'atome serveur est global
	spawn(?MODULE, pingueur, []).

pingueur() ->
	serveur ! {ping, self()},	% Envoi {ping, Pid} au pongueur
	receive
		{pong, N} ->
			io:format("Recu ~w~n", [N])
	end,
	pingueur().	%% On boucle

pongueur(N) ->	% serveur
	timer:sleep(2000),	%% Sert a attendre deux secondes (pour que les choses n'aillent pas trop vite)
	receive
		{ping, PID} ->	%% Un ping envoye par PID
			M = N + 1,	%% Un message de plus
			PID ! {pong, M},
			pongueur(M)	%% On boucle avec le nouveau nombre de messages recus.
	after	% Permet un timeout (ou pleins d'autres trucs interessants
		5000 -> io:format("Je ne recois rien, donc je m'arrete.~n")
	end.
