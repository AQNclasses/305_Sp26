SOURCE_DOCS := $(wildcard topics/*.md)
SLIDES := $(wildcard slides/*.md)

EXPORTED_DOCS := \
  $(SOURCE_DOCS:.md=.pdf) \
  $(SOURCE_DOCS:.md=.html)

SLIDE_PDFS := $(SLIDES:.md=.pdf)

PANDOC_OPTIONS := --standalone
PANDOC_PDF_OPTIONS := --to=context+tagging -V pdfa=3a
PANDOC_HTML_OPTIONS := --to html5 --mathml
PANDOC_SLIDE_OPTIONS := --to=beamer --slide-level=2 # --incremental

.PHONY: all context html slides clean

all: $(EXPORTED_DOCS) $(SLIDE_PDFS)

topics/%.pdf : topics/%.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<

topics/%.html : topics/%.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

slides/%.pdf : slides/%.md
	pandoc $(PANDOC_OPTIONS) $(PANDOC_SLIDE_OPTIONS) -o $@ $<

context : $(SOURCE_DOCS:.md=.pdf)

html : $(SOURCE_DOCS:.md=.html)

slides : $(SLIDE_PDFS)

clean:
	rm -f $(EXPORTED_DOCS) $(SLIDE_PDFS)
