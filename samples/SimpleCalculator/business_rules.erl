%%
%% Copyright 2007 Lee S. Barney
		
%% This file is part of QuickConnectYaws.

%% QuickConnectYaws is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Lesser General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.

%% QuickConnectYaws is distributed in the hope that it will be useful,
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Lesser General Public License for more details.

%% You should have received a copy of the GNU Lesser General Public License
%% along with QuickConnectYaws.  If not, see <http://www.gnu.org/licenses/>.
%%
-module(businessrules).


%%
%% Include files
%%
-include_lib("stdlib/include/qlc.hrl").
-record(qc_user, {id, uname, pword}).

%%
%% Exported Functions
%%
-export([get_default_b_rule/1, login_b_rule/1, get_user_count_b_rule/1]).

%%
%% API Functions
%%

%%
%% TODO: Add description of get_default_b_rule/function_arity
%%
get_default_b_rule(_Request) -> 
    ok.%change this so if the request contains the ajax key ajax is returned.

%%
% This function evaluates the user name and password returning true if 
% a match is found and false if it is not.
%%
login_b_rule(_Request) -> 
    %%
    %get the user name and password from the query
    %%
    {value,{_,Uname}} = lists:keysearch("uname",1,yaws_api:parse_post(_Request)),
    {value,{_,Pword}} = lists:keysearch("pword",1,yaws_api:parse_post(_Request)),
    Query = qlc:q([X#qc_user.id || X <- mnesia:table(qc_user)
                     ,X#qc_user.uname == Uname
                     ,X#qc_user.pword == Pword
                     ]),
    Results = mnesia_data_access:get_data(Query),
    
    NumFound = lists:flatlength(Results),
    if
    NumFound == 1 -> [Id|[]] = Results,
                     Found = Id;
    true -> Found = false
    end,
    
    Found.
get_user_count_b_rule(_Request) ->
    Query = qlc:q([X || X <- mnesia:table(qc_user)]),
    Results = mnesia_data_access:get_data(Query),
    lists:flatlength(Results).

%%
%% Local Functions
%%

