# set latexfile to the name of the main file without the .tex
latexfile = epoch
TEX = latex
PDFTEX = pdflatex

IMAGES = 2dcone.eps 3dcone.eps EPOCHLogo.eps coreblock.eps example.eps \
  example3.eps example4.ps gaussic.eps invgaussic.eps late.eps \
  profile_diff_gauss.eps profile_flat.eps profile_gauss.eps pulse1.eps \
  pulse2.eps shapetest.eps stagger.eps sweep.eps

PDFS := $(IMAGES:.eps=.pdf)
PDFS := $(PDFS:.ps=.pdf)

vpath %.pdf images
vpath %.ps images
vpath %.eps images

%.pdf: %.ps
	epstopdf --outfile=images/$@ $<

%.pdf: %.eps
	epstopdf --outfile=images/$@ $<

# reruns latex if needed.  to get rid of this capability, delete the
# three lines after the rule. 
# idea from http://ctan.unsw.edu.au/help/uk-tex-faq/Makefile
$(latexfile).dvi : $(latexfile).tex devtitle.tex title.tex
	while ($(TEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done

$(latexfile).pdf : $(latexfile).tex devtitle.tex title.tex $(PDFS)
	while ($(PDFTEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done

$(latexfile).ps : $(latexfile).dvi
	dvips -t a4 -o $(latexfile).ps $(latexfile).dvi

pdf: $(latexfile).pdf

ps: $(latexfile).ps 

clean:
	rm -f *.aux *.dvi *.log *.toc epoch.pdf
