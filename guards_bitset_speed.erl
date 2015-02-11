%% -*- coding: utf-8 -*-
%% //maxim.livejournal.com/448125.html
-module(guards_bitset_speed).

%% guards_bitset_speed: 

%% 1> guards_bitset_speed:mcow().
%% {36,<<>>}
%% 2> guards_bitset_speed:mbull().
%% {125,<<>>}
% Not bad

-export([ mcow/0
        , mbull/0
        , measure_cow/1
        , measure_bull/1
        ]).

-define(IS_ALPHA(C),
  (C =:= $a) or (C =:= $b) or (C =:= $c) or (C =:= $d) or (C =:= $e) or
  (C =:= $f) or (C =:= $g) or (C =:= $h) or (C =:= $i) or (C =:= $j) or
  (C =:= $k) or (C =:= $l) or (C =:= $m) or (C =:= $n) or (C =:= $o) or
  (C =:= $p) or (C =:= $q) or (C =:= $r) or (C =:= $s) or (C =:= $t) or
  (C =:= $u) or (C =:= $v) or (C =:= $w) or (C =:= $x) or (C =:= $y) or
  (C =:= $z) or
  (C =:= $A) or (C =:= $B) or (C =:= $C) or (C =:= $D) or (C =:= $E) or
  (C =:= $F) or (C =:= $G) or (C =:= $H) or (C =:= $I) or (C =:= $J) or
  (C =:= $K) or (C =:= $L) or (C =:= $M) or (C =:= $N) or (C =:= $O) or
  (C =:= $P) or (C =:= $Q) or (C =:= $R) or (C =:= $S) or (C =:= $T) or
  (C =:= $U) or (C =:= $V) or (C =:= $W) or (C =:= $X) or (C =:= $Y) or
  (C =:= $Z)
).

%% API

mcow () -> Bin = crypto:rand_bytes(1000),  timer:tc(?MODULE,measure_cow, [Bin]).
mbull () -> Bin = crypto:rand_bytes(1000), timer:tc(?MODULE,measure_bull,[Bin]).

%% Internals

%% is_alpha_cow(X) -> ?IS_ALPHA(X).
%% is_alpha_bull(X) -> (X >= $a andalso X =< $z) orelse (X >= $A andalso X =< $Z).

measure_cow(<<>>) -> <<>>;
measure_cow(<<B:1/binary, Bin/binary>>) -> is_alpha_cow(B), measure_cow(Bin).
measure_bull(<<>>) -> <<>>;
measure_bull(<<B:1/binary, Bin/binary>>) -> is_alpha_bull(B), measure_bull(Bin).

is_alpha_cow(X) when ?IS_ALPHA(X) -> true;
is_alpha_cow(_) -> false.
is_alpha_bull(X) when (X >= $a andalso X =< $z) orelse (X >= $A andalso X =< $Z) -> true;
is_alpha_bull(_) -> false.

%% End of Module.
