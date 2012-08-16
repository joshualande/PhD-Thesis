base = lande_thesis_stanford
lande_thesis_stanford:
	latex $(base)
	bibtex $(base) 
	latex  $(base)
	latex  $(base)
	dvips $(base)
	# These commands make sure no compression is applied
	# # http://cosmocoffee.info/viewtopic.php?p=213
	ps2pdf -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode $(base).ps

clean:
	-rm -f $(base).aux $(base).log $(base).out \
      $(base).toc $(base).dvi $(base).bbl \
      $(base).blg $(base).ps

