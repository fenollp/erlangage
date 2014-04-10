all: erl.mk

erl.mk:
	wget -nv -O $@ 'https://raw.github.com/fenollp/erl-mk/master/erl.mk' || rm $@

include erl.mk

# Your targets after this line.

distclean: clean
	$(if $(wildcard erl.mk), rm erl.mk)
	$(if $(wildcard deps/), rm -rf deps/)
.PHONY: distclean

debug: all
	erl -pa ebin/ -pa deps/*/ebin/ -eval 'c:l($(APP)).'

test: eunit
