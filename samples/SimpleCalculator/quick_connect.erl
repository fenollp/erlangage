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

-module(quick_connect).
-export([start/0]).
-import(app_controller,[dispatch_to_ValCF/2, dispatch_to_BCF/2, dispatch_to_VCF/3, dispatch_to_ECF/2, dispatch_to_SCF/2]).
-import(command_mappings,[map_commands/0]).
start() ->
	register(handleRequest,spawn(fun() -> setup() end)).

setup() ->
	
    Validation_command_map = dict:new(),
    Business_command_map = dict:new(),
    View_command_map = dict:new(),
    Error_command_map = dict:new(),
    Security_command_map = dict:new(),
	put(validation, Validation_command_map),
	put(business, Business_command_map),
	put(view, View_command_map),
	put(error, Error_command_map),
	put(security, Security_command_map),
	map_commands(),
	handleRequests()
.

handleRequests() ->
	receive
		{From, Acmd, Parameters} ->
			Data = handleRequest(Acmd, Parameters),
			From ! {ok,Data},
			handleRequests();
		die ->
			ok
	end.

handleRequest(_Acmd, _Parameters)->
	{ok,Passed} = dispatch_to_ValCF(_Acmd, _Parameters),
	if 
		Passed == true ->
			 case dispatch_to_BCF(_Acmd, _Parameters) of
				 {ok, false} ->
					  ok; 
				  _DataList -> 
					  dispatch_to_VCF(_Acmd, _Parameters, _DataList) 
			 end;
 
		 true -> 
			 {ok, false} 
	end.
	
	
	
	
	