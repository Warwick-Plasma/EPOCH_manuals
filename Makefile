# set latexfile to the name of the main file without the .tex
latexfile = epoch
TEX = latex
PDFTEX = pdflatex

IMAGES = 2dcone.pdf 3dcone.pdf EPOCHLogo.pdf coreblock.pdf example.pdf \
  example3.pdf example4.pdf gaussic.pdf invgaussic.pdf late.pdf \
  profile_diff_gauss.pdf profile_flat.pdf profile_gauss.pdf pulse1.pdf \
  pulse2.pdf shapetest.pdf stagger.pdf sweep.pdf

EPS := $(IMAGES:.pdf=.eps)

vpath %.pdf images
vpath %.ps images
vpath %.eps images

default: pdf

%.eps: %.pdf
	gs -q -dBATCH -dNOPAUSE -dSAFER -dDELAYSAFER -sDEVICE=epswrite -sOutputFile=images/$@ $<

# reruns latex if needed.  to get rid of this capability, delete the
# three lines after the rule. 
# idea from http://ctan.unsw.edu.au/help/uk-tex-faq/Makefile
$(latexfile).dvi : $(latexfile).tex devtitle.tex title.tex $(EPS)
	while ($(TEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done

$(latexfile).pdf : $(latexfile).tex devtitle.tex title.tex
	while ($(PDFTEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done

$(latexfile).ps : $(latexfile).dvi
	dvips -t a4 -o $(latexfile).ps $(latexfile).dvi

pdf: $(latexfile).pdf

ps: $(latexfile).ps 

distclean: clean
	rm -f images/*.eps epoch.pdf epoch.ps

clean:
	rm -f *.aux *.dvi *.log *.toc
