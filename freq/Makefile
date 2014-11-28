all: app  | erl.mk

erl.mk:
	curl -fsSLo $@ 'https://raw.github.com/fenollp/erl-mk/master/erl.mk' || rm $@

-include erl.mk
# Your targets after this line.
.PHONY: distclean clean debug

clean: clean-ebin
distclean: clean clean-deps clean-erlmk
debug: debug-app

clean-erlmk:
	$(if $(wildcard erl.mk), rm erl.mk)
