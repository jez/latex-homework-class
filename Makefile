TARGET=homework

all: $(TARGET).pdf

## Generalized rule: how to build a .pdf from each .tex
LATEXPDFS=$(patsubst %.tex,%.pdf,$(wildcard *.tex))
$(LATEXPDFS): %.pdf: %.tex
	pdflatex -interaction nonstopmode $(patsubst %.pdf,%.tex,$@)

touch:
	touch *.tex

again: touch all

clean:
	rm -f \
		$(TARGET).aux \
		$(TARGET).log \
		$(TARGET).nav \
		$(TARGET).out \
		$(TARGET).snm \
		$(TARGET).toc \
		$(TARGET).vrb \
		|| true

veryclean: clean
	rm -f $(TARGET).pdf

view: $(TARGET).pdf
	if [ "Darwin" = "$(shell uname)" ]; then open $(TARGET).pdf ; else evince $(TARGET).pdf ; fi

submit: $(TARGET).pdf
	cp $(TARGET).pdf ../

print: $(TARGET).pdf
	lpr $(TARGET).pdf

.PHONY: all again touch clean veryclean view print
