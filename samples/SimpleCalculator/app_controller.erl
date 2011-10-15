%% Copyright (c) 2008, 2009 Lee Barney
%% Permission is hereby granted, free of charge, to any person obtaining a 
%% copy of this software and associated documentation files (the "Software"), 
%% to deal in the Software without restriction, including without limitation the 
%% rights to use, copy, modify, merge, publish, distribute, sublicense, 
%% and/or sell copies of the Software, and to permit persons to whom the Software 
%% is furnished to do so, subject to the following conditions:
%% 
%% The above copyright notice and this permission notice shall be 
%% included in all copies or substantial portions of the Software.
%% 
%% The end-user documentation included with the redistribution, if any, must 
%% include the following acknowledgment: 
%% "This product was created using the QuickConnect framework.  http://quickconnect.sourceforge.net/", 
%% in the same place and form as other third-party acknowledgments.   Alternately, this acknowledgment 
%% may appear in the software itself, in the same form and location as other 
%% such third-party acknowledgments.
%% 
%% 
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
%% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
%% PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
%% HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
%% CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
%% OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


-module(app_controller).


%%
%% Exported Functions
%%
-export([dispatch_to_ValCF/2, dispatch_to_BCF/2, dispatch_to_VCF/3, dispatch_to_ECF/2, dispatch_to_SCF/2]).

%%
%% API Functions
%%


dispatch_to_ValCF(_Cmd, _Parameters) -> 
	%io:format("dispatching Validation with parameters ~p~n",[_Parameters]),
	dispatch_to_CF(_Cmd, _Parameters, get(validation),none).

%%
%% TODO: Add description of dispatch_to_b_rule/function_arity
%%
dispatch_to_BCF(_Cmd, _Parameters) -> 
	%io:format("dispatching Business~n"),
	dispatch_to_CF(_Cmd, _Parameters, get(business), none).

%%
%% TODO: Add description of dispatch_to_view/function_arity
%%
dispatch_to_VCF(_Cmd, _Parameters, _Accumulated_data) -> 
	%io:format("dispatching View~n"),
	dispatch_to_CF(_Cmd, _Parameters, get(view), _Accumulated_data).



dispatch_to_ECF(_Cmd, _Parameters) -> 
	dispatch_to_CF(_Cmd, _Parameters, get(error), none).


dispatch_to_CF(_Cmd, _Parameters, _Map, _Accumulated_data) ->
	case dict:is_key(_Cmd, _Map) of
		false ->
			 {ok,true}; 
		 true -> 
			%io:format("map is: ~p~n",[_Map]),
			case dict:is_key(default, _Map) of
				true ->
					_Default_function_list = dict:fetch(default, _Map); 
				 false -> 
					 _Default_function_list = [] 
			end,

			%io:format("default list: ~p~n",[_Default_function_list]), 
			_Command_function_list = dict:fetch(_Cmd, _Map),
			%io:format("commandList list: ~p~n",[_Command_function_list]),
			if 
				_Accumulated_data =/= none -> % this is true only for view control functions
					execute_control_functions(_Default_function_list, _Parameters, _Accumulated_data),
					execute_control_functions(_Command_function_list, _Parameters, _Accumulated_data); 
				 true -> 
					case execute_control_functions(_Default_function_list, _Parameters, []) of
						{ok, true} ->
							 execute_control_functions(_Command_function_list, _Parameters, []); 
						{ok, false} ->
							false;
						 _Otherwise -> 
							execute_control_functions(_Command_function_list, _Parameters, _Otherwise) 
					end %end of case stmt 
			end %end of if accumulated data
	end. %end of map has key

execute_control_functions([_Afunc|_Remaining_funcs], _Parameters, _Result_list) ->
	case functions:_Afunc(_Parameters, _Result_list) of
		% ok true and ok false are returned from all non-business control functions
		% and ok false is returned if a business function has failed to execute successfully.
		{ok, true} -> 
			execute_control_functions(_Remaining_funcs, _Parameters, _Result_list); 
		{ok, false} ->
			{ok,false};
		% ok and a list is returned if all business functions execute successfully
		{ok, _Aresult} -> 
			_Updated_list = [_Aresult |_Result_list],
			execute_control_functions(_Remaining_funcs, _Parameters, _Updated_list)
	end;

execute_control_functions([], _Parameters, _Result_list) ->
	if 
		_Result_list == [] ->
			 {ok, true}; 
		 true -> 
			 lists:reverse(_Result_list) 
	end.
	

%%
%% TODO: Add description of dispatch_to_view/function_arity
%%
dispatch_to_SCF(_Cmd, _Parameters) -> 
	dispatch_to_CF(_Cmd, _Parameters, get(security), none).
%%
%% Local Functions
%%
