all: app  | erl.mk

erl.mk:
	curl -fsSLo $@ 'https://raw.github.com/fenollp/erl-mk/master/erl.mk' || rm $@

-include erl.mk
# Your targets after this line.

clean: clean-ebin
distclean: clean clean-deps
	$(if $(wildcard erl.mk), rm erl.mk)

.PHONY: distclean clean debug test

debug: debug-app
