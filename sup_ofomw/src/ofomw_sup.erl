-module(ofomw_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([start_child/2]).

%% Supervisor callbacks
-export([init/1]).

%% Helpers
-define(WORKER(I), {I, {I, 'start_link', []}, 'permanent', 5000, 'worker', [I]}).
-define(WORKER_ARGS(I, Args), {I, {I, 'start_link', Args}, 'permanent', 5000, 'worker', [I]}).
-define(WORKER_TYPE(I, Type), {I, {I, 'start_link', []}, Type, 5000, 'worker', [I]}).
-define(WORKER_ARGS_TYPE(I, Args, Type), {I, {I, 'start_link', Args}, Type, 5000, 'worker', [I]}).
-define(WORKER_NAME_ARGS(I, N, Args), {N, {I, 'start_link', Args}, 'permanent', 5000, 'worker', [I]}).
-define(WORKER_NAME_ARGS_TYPE(N, I, Args, Type), {N, {I, 'start_link', Args}, Type, 5000, 'worker', [I]}).

-define(SUPER(I), {I, {I, 'start_link', []}, 'permanent', 'infinity', 'supervisor', [I]}).
-define(SUPER_TYPE(I, Type), {I, {I, 'start_link', []}, Type, 'infinity', 'supervisor', [I]}).
-define(SUPER_ARGS(I, Args), {I, {I, 'start_link', Args}, 'permanent', 'infinity', 'supervisor', [I]}).
-define(SUPER_ARGS_TYPE(I, Args, Type), {I, {I, 'start_link', Args}, Type, 'infinity', 'supervisor', [I]}).
-define(SUPER_NAME_ARGS_TYPE(N, I, Args, Type), {N, {I, 'start_link', Args}, Type, 'infinity', 'supervisor', [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 5,
    MaxSecondsBetweenRestarts = 10,
    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},
    {ok, {SupFlags, []}}.

start_child(Module, Args) ->
    {the_arg, Arg} = lists:keyfind(the_arg, 1, Args),
    ChildSpec = ?WORKER_NAME_ARGS(Module, Arg, Args),
    supervisor:start_child(?MODULE, ChildSpec).
