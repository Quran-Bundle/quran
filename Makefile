#!/usr/bin/bash

.ONESHELL:

.PHONY: all
all: readme doc test sample sample-warsh cleanup ## build readme, manuals, samples, then clean up

.PHONY: doc
# The English manual needs LuaLaTeX (it shows the coloured diacritics); the Arabic one is built with
# XeLaTeX. Both use the package from ../tex, not an installed copy.
doc: ## build the English (LuaLaTeX) and Arabic (XeLaTeX) manuals
	cd doc || exit
	export TEXINPUTS=../tex//: LUAINPUTS=../tex//:
	lualatex quran-doc
	lualatex quran-doc
	xelatex quran-doc-ar
	xelatex quran-doc-ar

.PHONY: sample
sample: ## compile all sample documents
	cd sample || exit
	for f in quran-getting-started quran-divisions quran-ayah-styling \
	         quran-translations quran-persian-document quran-boxes; do \
	  xelatex $$f || exit 1; \
	done
	LUAINPUTS=../tex//: TEXINPUTS=../tex//: lualatex quran-diacritics
	cd .. || exit

# The Warsh sample needs the KFGQPC Warsh font (not shipped with the package, see the manual);
# it is skipped when the font is not installed.
.PHONY: sample-warsh
sample-warsh: ## compile the Warsh sample (skipped without the KFGQPC font)
	@if fc-list | grep -qi "KFGQPC Warsh V3"; then \
	  cd sample && xelatex quran-warsh; \
	else \
	  echo "KFGQPC Warsh V3 font not installed: skipping sample/quran-warsh.tex"; \
	fi

# Regression tests (testfiles/*.lvt vs *.tlg); use `l3build save <name>` to record a new baseline.
.PHONY: test
test: ## run l3build regression tests
	l3build check

.PHONY: cleanup
cleanup: ## remove auxiliary files in all subdirectories
	$(MAKE) clean
	$(MAKE) clean -C doc -f ../Makefile
	$(MAKE) clean -C tex -f ../Makefile
	$(MAKE) clean -C sample -f ../Makefile

.PHONY: clean
clean: ## remove auxiliary files in this directory
	@find . -maxdepth 1 -type f \( -name '*.aux' -o -name '*.log' -o -name '*.toc' -o -name '*.idx' -o -name '*.hd' -o -name '*.out' -o -name '*~' \) -print -delete

.PHONY: ctan
ctan: readme ## build quran.zip for ctan.org
	$(MAKE) cleanup
	mkdir -p quran/doc quran/tex
	cp -v README        quran
	cd tex || exit
	cp -v quran.sty quran-diacritics.lua qurantext-uthmani.def qurantext-uthmani-min.def qurantext-simple.def      ../quran/tex
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
	cp -v quran-*.tex    ../quran/doc
	cp -v quran-*.pdf    ../quran/doc
	cd ..
	zip -r quran.zip quran
	mv -fv quran.zip ..
	rm -rfv ../quran
	mv -fv quran ..

# Same content as `ctan` (whose zip is kept for ctan.org), packed with maximum compression for archiving.
ARCHIVE = quran-v$(QURANVERSION)-$(subst /,,$(QURANDATE)).tar.xz
.PHONY: ctan-archive
ctan-archive: ctan ## same as ctan, packed with maximum compression
	tar -C .. --transform 's,^quran,$(ARCHIVE:.tar.xz=),' -cf - quran | xz -9e -T0 > ../$(ARCHIVE)
	@echo "Created ../$(ARCHIVE)"

.PHONY: increase_tex_memory
increase_tex_memory: ## raise TeX main_memory to 8000000 (sudo)
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
dev: ## install the package into TEXMFLOCAL (sudo)
	TEXMF_LOCAL=$$(kpsewhich -var-value TEXMFLOCAL) && \
	sudo mkdir -p "$$TEXMF_LOCAL/tex/latex/quran" && \
	sudo cp -v tex/*.def tex/*.lua tex/quran.sty "$$TEXMF_LOCAL/tex/latex/quran" && \
	sudo mktexlsr

QURANDATE := $(shell grep "qurandate{" tex/quran.sty | cut -d'{' -f2 | tr -d '}')
QURANVERSION := $(shell grep "quranversion{" tex/quran.sty | cut -d'{' -f2 | tr -d '}')
YEAR := "$(shell echo ${QURANDATE} | cut -d'/' -f1)"
readme-file := README

.PHONY: readme
readme: ## generate the README file
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

.PHONY: help
help: ## list all rules with a short description
	@awk -F':.*## ' '/^[A-Za-z_-]+:.*## /{printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
