#!/usr/bin/bash

.ONESHELL:

.PHONY: all
all: readme doc test test-warsh cleanup

.PHONY: doc
doc:
	cd doc || exit
	xelatex quran-doc
	xelatex quran-doc
	xelatex quran-doc-ar
	xelatex quran-doc-ar

.PHONY: test
test:
	$(MAKE) -C sample  quran-test.tex quran-test1.tex quran-test2.tex quran-test-warsh.tex
	cd sample || exit
	xelatex quran-test
	xelatex quran-test1
	xelatex quran-test2
	xelatex quran-test-warsh
	cd .. || exit

# The Warsh sample needs the KFGQPC Warsh font (not shipped with the package, see the manual);
# it is skipped when the font is not installed.
.PHONY: test-warsh
test-warsh:
	@if fc-list | grep -qi "KFGQPC Warsh V3"; then \
	  cd sample && xelatex quran-test-warsh; \
	else \
	  echo "KFGQPC Warsh V3 font not installed: skipping sample/quran-test-warsh.tex"; \
	fi

# Regression tests (testfiles/*.lvt vs *.tlg); use `l3build save <name>` to record a new baseline.
.PHONY: check
check:
	l3build check

.PHONY: cleanup
cleanup:
	$(MAKE) clean
	$(MAKE) clean -C doc -f ../Makefile
	$(MAKE) clean -C tex -f ../Makefile
	$(MAKE) clean -C sample -f ../Makefile

.PHONY: clean
clean:
	@rm -fv ./*.{aux,log,toc,idx,hd,out} ./*~

.PHONY: ctan
ctan: readme
	$(MAKE) cleanup
	mkdir -p quran/doc quran/tex
	cp -v README        quran
	cd tex || exit
	cp -v quran.sty qurantext-uthmani.def qurantext-uthmani-min.def qurantext-simple.def      ../quran/tex
	cp -v qurantext-warsh.def quran-warsh-tables.def		../quran/tex
	cp -v qurantext-en.transliteration.def quran-translt.def	../quran/tex
	cp -v qurantext-en.translation.def quran-transen.def		../quran/tex
	cp -v qurantext-de.translation.def quran-transde.def		../quran/tex
	cp -v qurantext-fa.translation.def quran-transfa.def		../quran/tex
	cp -v qurantext-fr.translation.def quran-transfr.def		../quran/tex
	cd ../doc/ || exit
	cp -v quran-doc.pdf quran-doc.tex quran.png     ../quran/doc
	cp -v quran-doc-ar.pdf quran-doc-ar.tex         ../quran/doc
	cd ../sample || exit
	cp -v quran-test*.tex    ../quran/doc
	cp -v quran-test.pdf quran-test1.pdf quran-test2.pdf    ../quran/doc
	cp -v quran-test-warsh.pdf    ../quran/doc 2>/dev/null || true
	cd ..
	zip -r quran.zip quran
	mv -fv quran.zip ..
	rm -rfv ../quran
	mv -fv quran ..

.PHONY: increase_tex_memory
increase_tex_memory:
	@FILE=$(shell kpsewhich texmf.cnf) && \
	if ! grep -q '^main_memory *= *8000000' $$FILE; then \
	  if grep -q '^main_memory *= *[0-9]\+' $$FILE; then \
	    sudo sed -i 's/^main_memory *= *[0-9]\+/main_memory = 8000000/' $$FILE; \
	  else \
	    echo "main_memory = 8000000" | sudo tee -a $$FILE; \
	  fi; \
	  sudo fmtutil-sys --all; \
	fi

.PHONY: dev
dev:
	TEXMF_LOCAL=$$(kpsewhich -var-value TEXMFLOCAL) && \
	sudo mkdir -p "$$TEXMF_LOCAL/tex/latex/quran" && \
	sudo cp -v tex/*.def tex/quran.sty "$$TEXMF_LOCAL/tex/latex/quran" && \
	sudo mktexlsr

QURANDATE := $(shell grep "qurandate{" tex/quran.sty | cut -d'{' -f2 | tr -d '}')
QURANVERSION := $(shell grep "quranversion{" tex/quran.sty | cut -d'{' -f2 | tr -d '}')
YEAR := "$(shell echo ${QURANDATE} | cut -d'/' -f1)"
readme-file := README

.PHONY: readme
readme:
	@echo "_____________________" > "${readme-file}"
	@echo "The quran package" >> "${readme-file}"
	@echo "v${QURANVERSION}" >> "${readme-file}"
	@echo "" >> "${readme-file}"
	@echo "The package is designed for typesetting the Holy Quran." >> "${readme-file}"
	@echo "It offers several macros for typesetting the entire text " >> "${readme-file}"
	@echo "or specific sections, based on its traditional divisions." >> "${readme-file}"	
	@echo "" >> "${readme-file}"
	@echo "For further details, please refer to the documentation." >> "${readme-file}"
	@echo "" >> "${readme-file}"
	@echo "Release Date of the Current Version: ${QURANDATE}" >> "${readme-file}"
	@echo "___________________" >> "${readme-file}"
	@echo "Javad Razavian" >> "${readme-file}"
	@echo "javadr@gmail.com" >> "${readme-file}"
	@echo "" >> "${readme-file}"
	@echo "Copyright © 2015-${YEAR}" >> "${readme-file}"
	@echo "This package may be distributed and/or modified under the terms of the LaTeX Project Public License," >> "${readme-file}"
	@echo "version 1.3c or later (at your option). The latest version of" >> "${readme-file}"
	@echo "the license is at: http://www.latex-project.org/lppl.txt" >> "${readme-file}"
	@echo "" >> "${readme-file}"
	@echo "This work has the LPPL maintenance status 'author-maintained'." >> "${readme-file}"
