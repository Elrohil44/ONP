%%%-------------------------------------------------------------------
%%% @author Wiesiek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. mar 2017 09:10
%%%-------------------------------------------------------------------
-module('ONP').
-author("Wiesiek").

%% API
-export([onp/1]).


parse(N) ->
  case string:to_float(N) of
    {error,no_float} -> list_to_integer(N);
    {F,_Rest} -> F
  end.


onp([], []) -> 0;
onp([X], []) -> X;
onp([B, A | T],["+" | X]) -> onp([A+B | T], X);
onp([B, A | T],["*" | X]) -> onp([A*B | T], X);
onp([B, A | T],["-" | X]) -> onp([A-B | T], X);
onp([0, A | T],["/" | X]) -> "You cannot divide by 0";
onp([B, A | T],["/" | X]) -> onp([A/B | T], X);
onp([A | T],["sqrt" | X]) -> onp([math:sqrt(A) | T], X);
onp([B, A | T],["pow" | X]) -> onp([math:pow(A,B) | T], X);
onp([A | T],["sin" | X]) -> onp([math:sin(A) | T], X);
onp([A | T],["cos" | X]) -> onp([math:cos(A) | T], X);
onp([A | T],["tan" | X]) -> onp([math:tan(A) | T], X);
onp(X, [A | T])  -> onp([parse(A) | X], T).

onp(Expression) -> onp([],string:tokens(Expression," ")).
