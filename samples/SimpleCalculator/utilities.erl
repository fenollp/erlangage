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


-module(utilities).
-export([map_command_to_ValCF/2, map_command_to_BCF/2, map_command_to_VCF/2, map_command_to_ECF/2, map_command_to_SCF/2]).

map_command_to_ValCF(_Command, _Control_function) ->
	map_command_to_CF(_Command, _Control_function, get(validation), validation).

map_command_to_BCF(_Command, _Control_function) ->
	map_command_to_CF(_Command, _Control_function, get(business), business).


map_command_to_VCF(_Command, _Control_function) ->
	map_command_to_CF(_Command, _Control_function, get(view), view).

map_command_to_ECF(_Command, _Control_function) ->
	map_command_to_CF(_Command, _Control_function, get(error), error).

map_command_to_SCF(_Command, _Control_function) ->
	map_command_to_CF(_Command, _Control_function, get(security), security).


map_command_to_CF(_Command, _Control_function, _Map, _Map_name) ->
	_Map_to_put = dict:append(_Command, _Control_function, _Map),
	put(_Map_name, _Map_to_put).