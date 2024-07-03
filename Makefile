SHELL:=/bin/bash

.PHONY: clean-venv
clean-venv:
	-rm -rf \
		.venv*

.omdev:
	mkdir -p .omdev 
	for f in pyproject.py interp.py ; do \
		curl --output .omdev/$f https://raw.githubusercontent.com/wrmsr/omlish/master/omdev/scripts/$f ; \
	done
	
PYPROJECT_PYTHON=python3
PYPROJECT=${PYPROJECT_PYTHON} .omdev/pyproject.py

VENV?=default
PYPROJECT_VENV=${PYPROJECT} venv ${VENV}

PYTHON:=$$(${PYPROJECT_VENV} exe)
SOURCES:=$$(${PYPROJECT_VENV} srcs)

.PHONY: venv
venv: .omdev
	${PYTHON} --version

.PHONY: test
test: venv
	${PYPROJECT_VENV} test
