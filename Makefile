# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

CRAN_MIRROR := https://cloud.r-project.org/

run:
	Rscript app.R

apk:
	apk add R R-dev libjpeg tiff-dev imagemagick-dev libarchive-dev py3-virtualenv g++ libxml2-dev linux-headers fontconfig-dev freetype-dev harfbuzz-dev fribidi-dev curl-dev

apt:
	apt install r-base-dev libjpeg-dev libtiff-dev imagemagick libmagick++-dev libarchive-dev virtualenv g++ libxml2-dev linux-headers libfontconfig-dev libfreetype-dev libharfbuzz-dev libfribidi-dev libcurl4-openssl-dev

rlibs:
	R -e 'install.packages("tidyverse", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("viridis", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("viridisLite", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("latex2exp", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("magick", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("shiny", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("archive", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("shinylive", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("shinydashboard", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("reticulate", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("ggimage", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("cowplot", repos="$(CRAN_MIRROR)")'
	R -e 'install.packages("lintr", repos="$(CRAN_MIRROR)")'

lint:
	reuse lint
	./lint.R

venv:
	virtualenv --download ./.venv
	. ./.venv/bin/activate && \
	pip install skyfield Pillow

.PHONY: run apk apt rlibs lint venv
