all: pdf html epub

pdf:
	pandoc manual.md -o manual.pdf --pdf-engine=xelatex --metadata title="The Möbius Manual" -V mainfont="STIX" -V monofont="DejaVu Sans Mono"

html:
	pandoc manual.md -o manual.html --metadata title="The Möbius Manual"

epub:
	pandoc manual.md -o manual.epub --metadata title="The Möbius Manual"
