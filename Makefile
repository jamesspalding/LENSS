# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

run:
	Rscript app.R
.PHONY: run

apk:
	doas apk add R R-dev libjpeg tiff-dev imagemagick-dev libarchive-dev
.PHONY: alpine

r-libs:
	R -e 'install.packages("tidyverse", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("viridis", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("viridisLite", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("latex2exp", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("magick", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("shiny", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("archive", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("shinylive", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("shinydashboard", repos="http://cran.us.r-project.org")'
	R -e 'install.packages("reticulate", repos="http://cran.us.r-project.org")'
.PHONY: r-libs

alpine: apk r-libs
	echo "done!"
.PHONY: alpine

lint:
	reuse lint
.PHONY: lint

venv:
	virtualenv --download ./.venv
	. ./.venv/bin/activate
	pip install skyfield
.PHONY: virtenv

moon:
	. ./.venv/bin/activate
	./moon.py
.PHONY: moon
