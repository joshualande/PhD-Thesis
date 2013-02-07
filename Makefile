base = lande_thesis_stanford
lande_thesis_stanford:
	pdflatex $(base)
	bibtex $(base) 
	makeglossaries $(base)
	pdflatex  $(base)
	pdflatex  $(base)

introduction_include=\includeonly{chapters/introduction/introduction}
introduction : $(texfiles)
	pdflatex "$(introduction_include) \input{$(base)}"
	bibtex $(base)
	makeglossaries $(base)
	pdflatex "$(introduction_include) \input{$(base)}"
	pdflatex "$(introduction_include) \input{$(base)}"


clean:
	-rm -f $(base).aux $(base).log $(base).out \
      $(base).toc $(base).dvi $(base).bbl \
      $(base).blg $(base).ps $(base).lot $(base).lof \
      $(base).tdo $(base).glo $(base).gls $(base).ist \
      $(base).acn $(base).alg $(base).acr \
      $(base).glg
	-find . -iname "*\.aux" | xargs -t rm


