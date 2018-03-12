TARGET := $(patsubst %.md,%.pdf,$(wildcard *.md))

.PHONY: all clean

all: $(TARGET)

%.pdf : %.md
	pandoc -s --pdf-engine=xelatex --filter pandoc-fignos --listings $^ header.yaml -o $@

clean:
	rm -f $(TARGET)
