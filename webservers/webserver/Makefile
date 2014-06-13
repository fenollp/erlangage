all: erl.mk

erl.mk:
	curl -fsSLo $@ 'https://raw.github.com/fenollp/erl-mk/master/erl.mk' || rm $@

include erl.mk

# Your targets after this line.

distclean: clean
	$(if $(wildcard erl.mk), rm erl.mk   )
	$(if $(wildcard deps  ), rmdir deps  )
.PHONY: distclean

debug: all
	erl -pa ebin/ -eval -s $(APP) -noshell
