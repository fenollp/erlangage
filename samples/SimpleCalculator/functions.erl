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


-module(functions).
-author(lee).
-import(app_controller, [dispatch_to_ECF/2]).
-compile(export_all).

inspect_parametersValCF(_Parameters, _ResultList) ->
	if 
		length(_Parameters) =/= 2 ->
			 dispatch_to_ECF(bad_param_count, ["there must be exactly 2 parameters"]),
			 {ok, false}; 
		 true -> 
			 {ok, true} 
	end.


multiply_numsBCF(_Parameters, _ResultList) ->
	[A, B] = _Parameters,
	{ok, A*B}.
	
sum_numsBCF(_Parameters, _ResultList) ->
	[A, B] = _Parameters,
	{ok, A+B}.
	
power_numsBCF(_Parameters, _ResultList) ->
	[A, B] = _Parameters,
	{ok, math:pow(A, B)}.
	
print_mult_sumVCF(_Parameters, _ResultList) ->
	[A, B|_] = _Parameters,
	[Product, Sum|_] = _ResultList,
	io:format("~p + ~p = ~p ~n~p * ~p = ~p~n", [A, B, Sum, A, B, Product]),
	{ok,true}.
	
print_seperatorVCF(_Parameters, _ResultList) ->
	io:format("~n*****************************************~n"),
	{ok, true}.
	
	
print_powerVCF(_Parameters, _ResultList) ->
	[A, B|_] = _Parameters,
	[_, _, Power] = _ResultList,
	io:format("~p^~p = ~p~n", [A, B, Power]),
	{ok, true}.
	

print_error_msgECF(_Parameters, _ResultList) ->
	%get the first parameter
	[Msg] = _Parameters,
	%insert the first parameter into the format list
	io:format("ERROR: ~p~n", [Msg]),
	{ok, true}.
	
	
	