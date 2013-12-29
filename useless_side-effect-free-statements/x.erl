-module(x).
-export([y/0]).
-export([z/0]).

y () ->
    case 1 < 2 of
        true -> ok;
        false -> ko
    end,
    ignored,
    bad.

z () ->
    good.
