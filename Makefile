.PHONY: deps compile test

default: deps compile test

deps:
	scripts/dep.sh Olical aniseed origin/master
	scripts/dep.sh nvim-telescope telescope.nvim origin/master

compile:
	rm -rf lua

	# Remove this if you only want Aniseed at compile time.
	deps/aniseed/scripts/embed.sh aniseed fenpoon

	# Also remove this embed prefix if you're not using Aniseed inside your plugin at runtime.
	ANISEED_EMBED_PREFIX=fenpoon deps/aniseed/scripts/compile.sh

test:
	rm -rf test/lua
	deps/aniseed/scripts/test.sh
