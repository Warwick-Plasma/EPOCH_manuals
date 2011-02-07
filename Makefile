# set latexfile to the name of the main file without the .tex
latexfile = epoch
TEX = latex
PDFTEX = pdflatex

IMAGES = 2dcone.pdf 3dcone.pdf coreblock1.pdf coreblock2.pdf coreblock.pdf \
  EPOCHLogo.pdf gaussic.pdf invgaussic.pdf late.pdf profile_angle.pdf \
  profile_flat.pdf profile_flat.ps profile_gauss.pdf pulse1.pdf pulse2.pdf \
  shape.pdf shapetest.pdf stagger.pdf sweep.pdf title_page_dev.pdf \
  title_page_user.pdf wave.pdf

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
$(latexfile).dvi : $(latexfile).tex epoch_dev_title.tex \
    epoch_user_title.tex sdf_format.tex $(EPS)
	while ($(TEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done; \
	$(TEX) $(latexfile)

$(latexfile).pdf : $(latexfile).tex epoch_dev_title.tex \
    epoch_user_title.tex sdf_format.tex
	while ($(PDFTEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true; \
	done; \
	$(PDFTEX) $(latexfile)

$(latexfile).ps : $(latexfile).dvi
	dvips -t a4 -o $(latexfile).ps $(latexfile).dvi

pdf: $(latexfile).pdf

ps: $(latexfile).ps

distclean: clean
	rm -f images/*.eps $(latexfile).pdf $(latexfile).ps

clean:
	rm -f *.aux *.dvi *.log *.toc
