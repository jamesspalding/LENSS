run:
	Rscript app.R

alpine:
	sudo apk install R R-dev libjpeg tiff-dev imagemagick-dev libarchive-dev
	R -e 'install.packages("tidyverse", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("viridis", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("viridisLite", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("latex2exp", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("magick", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("shiny", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("archive", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("shinylive", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("shinydashboard", repos="http://cran.us.r-project.org")'
