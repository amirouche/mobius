SOURCES := $(shell find src/english -name '*.md' | sort)

.PHONY: all clean

all: manual.md manual.html manual.epub manual.pdf

manual.md: $(SOURCES)
	cat src/english/_preamble.md > $@
	find src/english -type d -mindepth 1 -maxdepth 1 | sort | while read dir; do \
		find "$$dir" -name '*.md' | sort | xargs cat >> $@; \
	done
	cat src/english/_annexes.md >> $@
	@echo "✓ Assembled manual.md from source files"

manual.html: manual.md
	pandoc -o $@ $< && echo "✓ Generated manual.html"

manual.epub: manual.md
	pandoc -o $@ $< && echo "✓ Generated manual.epub"

manual.pdf: manual.md
	pandoc --pdf-engine=xelatex \
		-V mainfont="DejaVu Sans" \
		-V monofont="DejaVu Sans Mono" \
		-o $@ $< && echo "✓ Generated manual.pdf"

clean:
	rm -f manual.md manual.html manual.epub manual.pdf

.PHONY: test-assembly
test-assembly: manual.md
	@echo "Assembly test: checking file count..."
	@wc -l manual.md
	@echo "First few lines:"
	@head -5 manual.md
	@echo "Last few lines:"
	@tail -5 manual.md
