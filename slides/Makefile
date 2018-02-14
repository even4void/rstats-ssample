TARGET := $(patsubst %.md,%.pdf,$(wildcard *.md))

.PHONY: all clean

all: $(TARGET)

%.pdf : %.md
	pandoc -s --pdf-engine=xelatex --filter pandoc-citeproc --listings -t beamer $^ header.yaml -o $@

clean:
	rm -f $(TARGET)
