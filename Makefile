# set latexfile to the name of the main file without the .tex
latexfile = epoch
TEX = latex

# reruns latex if needed.  to get rid of this capability, delete the
# three lines after the rule. 
# idea from http://ctan.unsw.edu.au/help/uk-tex-faq/Makefile
$(latexfile).dvi : $(latexfile).tex devtitle.tex title.tex
	while ($(TEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done

$(latexfile).pdf : $(latexfile).ps
	pstopdf $(latexfile).ps -o $(latexfile).pdf

$(latexfile).ps : $(latexfile).dvi
	dvips -t a4 -o $(latexfile).ps $(latexfile).dvi

pdf: $(latexfile).pdf

ps: $(latexfile).ps 

clean:
	rm -f *.aux *.dvi *.log *.toc epoch.pdf
