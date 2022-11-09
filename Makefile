
SHELL := /bin/bash


new:
	starknet new_account


act:
	. ./setup.sh

clean:
	rm -rf out/*

compile:
	cairo-compile src/${FILE}.cairo --output out/${FILE}_compiled.json

watch:
	while inotifywait -e close_write ./*; do clear; \
	cairo-compile src/${FILE}.cairo \
		--output out/${FILE}_compiled.json; done

s-watch:
	while inotifywait -e close_write ./*; do clear; \
	starknet-compile src/${FILE}.cairo \
		--output out/${FILE}_compiled.json \
		--abi out/${FILE}_abi.json; done

s-run:
	starknet run\
		--program=out/${FILE}_compiled.json \
		--print_output --print_info \
		--relocate_prints

run:
	cairo-run \
		--program=out/${FILE}_compiled.json \
    	--print_output --layout=small
