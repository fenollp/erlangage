%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(revbin).

%% revbin: 

-export([ rev/2 ]).


%% API

rev (Bin, Acc) when is_binary(Bin) ->
    case Bin of
        <<>> ->
            Acc;
        <<H:1/binary, Rest/binary>> ->
            rev(Rest, <<H/binary, Acc/binary>>)
    end.

%% End of Module.
