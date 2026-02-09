all: pdf html epub

pdf:
	pandoc R0RM.md -o R0RM.pdf --pdf-engine=xelatex --metadata title="Revised⁰ Report on Möbius" -V mainfont="STIX" -V monofont="DejaVu Sans Mono"

html:
	pandoc R0RM.md -o R0RM.html --metadata title="Revised⁰ Report on Möbius"

epub:
	pandoc R0RM.md -o R0RM.epub --metadata title="Revised⁰ Report on Möbius"
