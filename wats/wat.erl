diff --git a/src/erldocs.erl b/src/erldocs.erl
index 62acf7a..05438fe 100644
--- a/src/erldocs.erl
+++ b/src/erldocs.erl
@@ -45,15 +45,15 @@ parse (["-o", Dest | Rest], Conf) ->
 parse (["-I", Include | Rest], #conf{includes = Includes} = Conf) ->
     parse(Rest, Conf#conf{includes = [absp(Include)|Includes]});
 
+parse (["--ga", GA | Rest], Conf) ->
+    parse(Rest, Conf#conf{ga = GA});
+
 parse ([Dir0 | Rest], #conf{dirs = Dirs} = Conf) ->
     case Dir0 of
         "." -> Dir = cwd();
         _   -> Dir = Dir0
     end,
-    parse(Rest, Conf#conf{dirs = [absp(Dir)|Dirs]});
-
-parse (["--ga", GA | Rest], Conf) ->
-    parse(Rest, Conf#conf{ga = GA}).
+    parse(Rest, Conf#conf{dirs = [absp(Dir)|Dirs]}).
 
 
 run (Conf) ->
