
SHELL := /bin/bash


new:
	starknet new_account


act:
	. ./setup.sh

clean:
	rm -rf out/*

compile:
	cairo-compile ${FILE}.cairo --output out/${FILE}_compiled.json

run:
	cairo-run \
		--program=out/${FILE}_compiled.json \
		--print_output --print_info \
		--relocate_prints

watch:
	while inotifywait -e close_write ./*; do clear; cairo-compile ${FILE} --output out/${FILE}_compiled.json; done
