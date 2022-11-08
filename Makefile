
SHELL := /bin/bash


new:
	starknet new_account


act:
	. ./setup.sh

clean:
	rm -rf out/*

compile:
	cairo-compile src/${FILE}.cairo --output out/${FILE}_compiled.json

build:
	starknet-compile src/${FILE}.cairo \
		--output out/${FILE}_compiled.json \
		--abi out/${FILE}_abi.json

run:
	starknet-run \
		--program=out/${FILE}_compiled.json \
		--print_output --print_info \
		--relocate_prints

run2:
	cairo-run \
		--program=out/${FILE}_compiled.json \
    	--print_output --layout=small

watch:
	while inotifywait -e close_write ./*; do clear; cairo-compile ${FILE} --output out/${FILE}_compiled.json; done
