-module(tictactoe).
-behavior(gen_server).

%% tictactoe: a game of tictactoe.

-export([new/0]).
-export([move/3]).
-export([check/0]).

-export([code_change/3]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([init/1]).
-export([terminate/2]).
-record(s, {board}).

%% API

new() ->
    start_link(),
    display_board().

move(Who, X, Y) ->
    gen_server:call(?MODULE, {play, Who, X, Y}).

display_board() ->
    gen_server:call(?MODULE, display_board).

check() ->
    gen_server:call(?MODULE, check).

%% Internals

start_link() ->
    gen_server:start_link(?MODULE, [], []).

init(_) ->
    State = #s{board={undefined, undefined, undefined,
                      undefined, undefined, undifined,
                      undefined, undefined, undefined}},
    {ok, State}.

handle_call(display_board, _From, S) ->
    io:format("Board: ~p\n", [S#s.board]),
    {reply, ok, S};

handle_call({play, Who, X, Y}, _From, #s{board=Board}=S) ->
    Pos = 3 * (Y - 1) + X,
    case element(Pos, Board) of
        undefined ->
            NBoard = setelement(Pos, Board, Who),
            {reply, ok, S#s{board=NBoard}}
        ; _______ ->
            {reply, occupied, S}
    end;

handle_call(check, _From, #s{board=Board}=S) ->
    R = case Board of
            {X, X, X,
             _, _, _,
             _, _, _} when X =/= undefined -> {X, won};
            {_, _, _,
             X, X, X,
             _, _, _} when X =/= undefined -> {X, won};
            {_, _, _,
             _, _, _,
             X, X, X} when X =/= undefined -> {X, won};
            {X, _, _,
             _, X, _,
             _, _, X} when X =/= undefined -> {X, won};
            {_, _, X,
             _, X, _,
             X, _, _} when X =/= undefined -> {X, won};
            {A, B, C,
             D, E, F,
             G, H, I} when A =/= undefined, B =/= undefined, C =/= undefined,
                           D =/= undefined, E =/= undefined, F =/= undefined,
                           G =/= undefined, H =/= undefined, I =/= undefined -> itsadraw
            ; _______ ->
                ok
        end,
    {reply, R, S};

handle_call(_Msg, _From, S) ->
    {stop, normal, ok, S}.

handle_cast(_Msg, S) ->
    {stop, ok, S}.
handle_info(Msg, S) ->
    io:format("Unexpected message '~p'\n", [Msg]),
    {noreply, S}.
code_change(_OldVsn, S, _Extra) ->
    {ok, S}.
terminate(_Reason, _S) ->
    ok.

%% End of Module.
