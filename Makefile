# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

run:
	Rscript app.R
.PHONY: run

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
.PHONY: alpine

lint:
	reuse lint
.PHONY: lint

virtenv:
	virtualenv --download .
	. ./bin/activate
	pip install skyfield
.PHONY: virtenv

moon:
	. ./bin/activate
	./moon.py
.PHONY: moon
