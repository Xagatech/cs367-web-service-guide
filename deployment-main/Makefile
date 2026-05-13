ENV ?= dev

test:
	hurl tests/hurl/api.hurl --variables-file ./hurl/env/$(ENV).env --test

test-verbose:
	hurl tests/hurl/api.hurl --variables-file ./hurl/env/$(ENV).env --verbose
