```shell
0 sup_ofomw masterλ make -j debug
erl -pz ebin/  -eval 'c:l(ofomw).'
Erlang/OTP 17 [erts-6.3.1] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Eshell V6.3.1  (abort with ^G)
1> application:start(ofomw).
ok
2> ofomw:children().
[]
3> ofomw_sup:start_child(ofomw_worker_a, [{the_arg, iama_AMA}]).
ofomw_worker_a:start_link Args = {the_arg,iama_AMA}
ofomw_worker_a:init Args = {the_arg,iama_AMA}
{ok,<0.45.0>}
4> ofomw_sup:start_child(ofomw_worker_b, [{the_arg, i_am_b}]).
ofomw_worker_b:start_link Args = {the_arg,i_am_b}
ofomw_worker_b:init Args = {the_arg,i_am_b}
{ok,<0.47.0>}
5> ofomw:children().
[{i_am_b,<0.47.0>,worker,[ofomw_worker_b]},
 {iama_AMA,<0.45.0>,worker,[ofomw_worker_a]}]
6> ofomw_sup:start_child(ofomw_worker_b, [{the_arg, but_im_b_too}]).
ofomw_worker_b:start_link Args = {the_arg,but_im_b_too}
{error,{{already_started,<0.47.0>},
        {child,undefined,but_im_b_too,
               {ofomw_worker_b,start_link,[{the_arg,but_im_b_too}]},
               permanent,5000,worker,
               [ofomw_worker_b]}}}
7> ofomw:children().
[{i_am_b,<0.47.0>,worker,[ofomw_worker_b]},
 {iama_AMA,<0.45.0>,worker,[ofomw_worker_a]}]
8>
```

