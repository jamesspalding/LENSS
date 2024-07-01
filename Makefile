# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

run:
	Rscript app.R

apk:
	apk add R R-dev libjpeg tiff-dev imagemagick-dev libarchive-dev py3-virtualenv g++ libxml2-dev linux-headers fontconfig-dev freetype-dev harfbuzz-dev fribidi-dev

rlibs:
	R -e 'install.packages("tidyverse", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("viridis", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("viridisLite", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("latex2exp", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("magick", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("shiny", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("archive", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("shinylive", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("shinydashboard", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("reticulate", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("ggimage", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("cowplot", repos="https://cloud.r-project.org/")'
	R -e 'install.packages("lintr", repos="https://cloud.r-project.org/")'

lint:
	reuse lint
	./lint.R

venv:
	virtualenv --download ./.venv
	. ./.venv/bin/activate && \
	pip install skyfield Pillow

.PHONY: run apk rlibs lint venv
