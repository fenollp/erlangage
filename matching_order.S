{module, matching_order}.  %% version = 0

{exports, [{do1,1},{do2,1},{module_info,0},{module_info,1}]}.

{attributes, []}.

{labels, 9}.


{function, do1, 1, 2}.
  {label,1}.
    {line,[{location,"matching_order.erl",14}]}.
    {func_info,{atom,matching_order},{atom,do1},1}.
  {label,2}.
    {test,is_tuple,{f,1},[{x,0}]}.
    {test,test_arity,{f,1},[{x,0},3]}.
    {get_tuple_element,{x,0},0,{x,1}}.
    {test,is_eq_exact,{f,1},[{x,1},{atom,'='}]}.
    {move,{atom,ok},{x,0}}.
    return.


{function, do2, 1, 4}.
  {label,3}.
    {line,[{location,"matching_order.erl",17}]}.
    {func_info,{atom,matching_order},{atom,do2},1}.
  {label,4}.
    {test,is_tuple,{f,3},[{x,0}]}.
    {test,test_arity,{f,3},[{x,0},3]}.
    {get_tuple_element,{x,0},1,{x,1}}.
    {test,is_eq_exact,{f,3},[{x,1},{atom,'='}]}.
    {move,{atom,k},{x,0}}.
    return.


{function, module_info, 0, 6}.
  {label,5}.
    {line,[]}.
    {func_info,{atom,matching_order},{atom,module_info},0}.
  {label,6}.
    {move,{atom,matching_order},{x,0}}.
    {line,[]}.
    {call_ext_only,1,{extfunc,erlang,get_module_info,1}}.


{function, module_info, 1, 8}.
  {label,7}.
    {line,[]}.
    {func_info,{atom,matching_order},{atom,module_info},1}.
  {label,8}.
    {move,{x,0},{x,1}}.
    {move,{atom,matching_order},{x,0}}.
    {line,[]}.
    {call_ext_only,2,{extfunc,erlang,get_module_info,2}}.
