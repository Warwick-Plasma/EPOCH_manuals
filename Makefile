# set latexfile to the name of the main file without the .tex
latexfile1 = epoch_user
latexfile2 = epoch_dev
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
$(latexfile1).dvi : $(latexfile1).tex $(latexfile2).tex epoch_dev_title.tex \
    epoch_head.tex epoch_user_title.tex sdf_format.tex $(EPS)
	while ($(TEX) $(latexfile1) ; \
	grep -q "Rerun to get cross" $(latexfile1).log ) do true; \
	bibtex $(latexfile1) ; \
	done; \
	while ($(TEX) $(latexfile2) ; \
	grep -q "Rerun to get cross" $(latexfile2).log ) do true; \
	bibtex $(latexfile2) ; \
	done; \
	$(TEX) $(latexfile1)

$(latexfile1).pdf : $(latexfile1).tex $(latexfile2).tex epoch_dev_title.tex \
    epoch_head.tex epoch_user_title.tex sdf_format.tex
	while ($(PDFTEX) $(latexfile1) ; \
	grep -q "Rerun to get cross" $(latexfile1).log ) do true; \
	bibtex $(latexfile1) ; \
	done; \
	while ($(PDFTEX) $(latexfile2) ; \
	grep -q "Rerun to get cross" $(latexfile2).log ) do true; \
	bibtex $(latexfile2) ; \
	done; \
	$(PDFTEX) $(latexfile1)

$(latexfile1).ps : $(latexfile1).dvi $(latexfile2).dvi
	dvips -t a4 -o $(latexfile1).ps $(latexfile1).dvi
	dvips -t a4 -o $(latexfile2).ps $(latexfile2).dvi

pdf: $(latexfile1).pdf $(latexfile2).pdf

ps: $(latexfile1).ps $(latexfile2).ps

distclean: clean
	rm -f $(EPS) $(latexfile1).pdf $(latexfile2).pdf \
	    $(latexfile1).ps $(latexfile2).ps

clean:
	rm -f *.aux *.dvi *.log *.toc *.bbl *.blg
