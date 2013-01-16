base = lande_thesis_stanford
lande_thesis_stanford:
	pdflatex $(base)
	bibtex $(base) 
	pdflatex  $(base)
	pdflatex  $(base)

clean:
	-rm -f $(base).aux $(base).log $(base).out \
      $(base).toc $(base).dvi $(base).bbl \
      $(base).blg $(base).ps $(base).lot $(base).lof \
	  $(base).tdo
	-find . -iname "*\.aux" | xargs -t rm


