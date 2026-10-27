# Build the native implementation and Rocq developments.
.PHONY: all build test mech check clean

all: build mech

build:
	$(MAKE) -C impl build

test:
	$(MAKE) -C impl test

mech:
	$(MAKE) -C mech/fe_calculus
	$(MAKE) -C mech/fe_implicit

check: test mech

clean:
	$(MAKE) -C impl clean
	$(MAKE) -C mech/fe_calculus clean
	$(MAKE) -C mech/fe_implicit clean
