# This is to make the stupid expansion in clean work.
SHELL=/bin/bash

DOCUMENT:=$(shell find . -name "python_problem-*\.tex" | cut -c 3- \
									| cut -d '.' -f 1)
SOLUTION=$(DOCUMENT)-solution

## Options
USECUSTOMFONTS = true

## Set switches inside the cls file.
ifeq (${USECUSTOMFONTS}, true)
	IFCUSTOMFONTS="\\let\\ifppcustomfonts\\iftrue"
else
	IFCUSTOMFONTS=""
endif

IFSOLUTION="\\let\\ifppsolutions\\iftrue${IFCUSTOMFONTS}"


#######################################################################
#                               Targets                               #
#######################################################################
.PHONY: pdf solution clean

all: pdf

pdf:
## Make the PDF twice to solve any referencing issues.
	xelatex -shell-escape "${IFCUSTOMFONTS}\input{$(DOCUMENT)}"
	@xelatex -shell-escape "${IFCUSTOMFONTS}\input{$(DOCUMENT)}" \
		> /dev/null 2>&1
	-@rm -Rf $(DOCUMENT).{aux,log,out}

solution:
## Symbolic link allows for the same file compiled under a different name.
	@ln -s $(DOCUMENT).tex $(SOLUTION).tex

## Compile with \ifppsolution set to true.
	-@xelatex -shell-escape "${IFSOLUTION}\input{$(SOLUTION)}"
	@xelatex -shell-escape "${IFSOLUTION}\input{$(SOLUTION)}" > /dev/null 2>&1

## Remove evidence that this occurred.
	@rm $(SOLUTION).tex
	-@rm -Rf $(SOLUTION).{aux,log,out}

tar: pdf
	@echo "Making tarball"
	@mkdir $(DOCUMENT)
	@cp Makefile $(DOCUMENT).{pdf,tex} python-problem.cls $(DOCUMENT)
	@tar -h -czvf $(DOCUMENT).tar.gz $(DOCUMENT)
	@rm -R $(DOCUMENT)

clean:
	-rm -Rf *.{aux,log,out}
