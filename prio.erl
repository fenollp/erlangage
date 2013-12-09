%% Copyright © 2013 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(prio).

%% prio: 

-export([aborc/1]).


%% API

aborc (ABorCs) ->
    lists:foldl(
      fun (Atom, {A, B, C}) ->
              case Atom of
                  a -> {[a|A], B, C};
                  b -> {A, [b|B], C};
                  _ -> {A, B, [c|C]}
              end
      end, {[], [], []}, ABorCs).

%% Internals

%% End of Module.
