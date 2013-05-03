base = lande_thesis_stanford
lande_thesis_stanford:
	pdflatex $(base)
	bibtex $(base) 
	makeglossaries $(base)
	pdflatex  $(base)
	pdflatex  $(base)

pulsar_pwn_system_include=\includeonly{chapters/pulsar_pwn_system/pulsar_pwn_system}
pulsar_pwn_system : $(texfiles)
	pdflatex "$(pulsar_pwn_system_include) \input{$(base)}"

likelihood_include=\includeonly{chapters/likelihood/likelihood}
likelihood : $(texfiles)
	pdflatex "$(likelihood_include) \input{$(base)}"


extended_search_include=\includeonly{chapters/extended_search/extended_search}
extended_search : $(texfiles)
	pdflatex "$(extended_search_include) \input{$(base)}"

introduction_include=\includeonly{chapters/introduction/introduction}
introduction : $(texfiles)
	pdflatex "$(introduction_include) \input{$(base)}"

offpeak_include=\includeonly{chapters/offpeak/offpeak}
offpeak : $(texfiles)
	pdflatex "$(offpeak_include) \input{$(base)}"

tevcat_include=\includeonly{chapters/tevcat/tevcat}
tevcat : $(texfiles)
	pdflatex "$(tevcat_include) \input{$(base)}"

outlook_include=\includeonly{chapters/outlook/outlook}
outlook : $(texfiles)
	pdflatex "$(outlook_include) \input{$(base)}"

population_study_include=\includeonly{chapters/population_study/population_study}
population_study: $(texfiles)
	pdflatex "$(population_study_include) \input{$(base)}"

clean:
	-rm -f $(base).aux $(base).log $(base).out \
      $(base).toc $(base).dvi $(base).bbl \
      $(base).blg $(base).ps $(base).lot $(base).lof \
      $(base).tdo $(base).glo $(base).gls $(base).ist \
      $(base).acn $(base).alg $(base).acr \
      $(base).glg
	-find . -iname "*\.aux" | xargs -t rm


