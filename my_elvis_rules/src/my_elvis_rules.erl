-module(my_elvis_rules).

%% API exports
-export([use_MODULE/3]).

-type empty_rule_config() :: #{}.

-define(MSG__use_MODULE, "~p:~p: use ?MODULE instead of ~s").

-define(P(Fmt, Args),
        Path == "core/whistle_transactions/src/wh_transaction.erl"
        andalso io:format(Fmt++ "\n", Args)).
%% API

-spec use_MODULE(elvis_config:config(), elvis_file:file(), empty_rule_config()) ->
                        [elvis_result:item()].
use_MODULE( _Config = #{}
          , Target = #{ path := Path
                      , parse_tree := #{ attrs := #{tokens := Tokens}
                                       , content := Content
                                       } = Tree
                      , content := _BinSrc
                      }
          , _RuleConfig = #{}) ->
    Module = list_to_atom(filename:basename(Path, ".erl")),

    %% maps:map(fun (K, V) -> ?P("\n\n~p --> ~p\n", [K, V]) end, Tree),
    %% [].



    %% Found =
    %%     lists:foldl(
    %%       fun (#{ value := ModuleValue
    %%             , type := atom
    %%             , attrs := #{ location := Loc = {Line,Col} }
    %%             }
    %%           , Acc
    %%           ) ->
    %%       end
    %%       ,[]
    %%       ,Tokens
    %%      )
    %% case
    %%     [ elvis_result:new(item, ?MSG__use_MODULE, [Line, Col, Module], Loc)
    %%       ||
    %%              <- Tokens
    %%              , Module == ModuleValue
    %%     ]
    %% of
    %%     [] -> [];
    %%     [_ModuleAttr | RelevantFinds] ->
    %%         RelevantFinds
    %% end.


    %% [case Ty of
    %%      function -> ?P("\t~p", [Branch]);
    %%      _ -> ?P("~p ~p --> ~p",[Loc,Ty,Txt])
    %%  end
    %%  || Branch = #{attrs := #{location := Loc, text := Txt},type := Ty}
    %%         <- Content],


    lists:map(fun (Token) -> ?P("~p", [Token]) end, Tokens),

    case
        [ begin
              %% maps:map(fun (K, V) -> ?P("\n~p --> ~p", [K,V]) end, Token),
              elvis_result:new(item, ?MSG__use_MODULE, [Line, Col, Module], Loc)
          end
          || #{ value := ModuleValue
              , type := atom
              , attrs := #{ location := Loc = {Line,Col} }
              }=Token
                 <- Tokens
                 , Module == ModuleValue
        ]
    of
        [] -> [];
        [_ModuleAttr | RelevantFinds] -> RelevantFinds
    end.

%% Internals

find(Module, Contents) ->
    [find(Module, Content) || Content <- Contents];
find(Module, M = #{ value := Module
                  , content := Content
                  }) ->
    [warn(M) | find(Module, Content)];
find(Module, #{content := Content}) ->
    find(Module, Content).


warn(#{ value := Module
       , attrs := #{ location := Loc = {Line,Col} }
       }) ->
    elvis_result:new(item, ?MSG__use_MODULE, [Line, Col, Module], Loc).

%% End of Module
