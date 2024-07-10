# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

run:
	Rscript app.R

apk:
	apk add --no-cache R R-dev libjpeg tiff-dev imagemagick-dev libarchive-dev py3-virtualenv g++ libxml2-dev linux-headers fontconfig-dev freetype-dev harfbuzz-dev fribidi-dev curl-dev

apt:
	apt install r-base-dev libjpeg-dev libtiff-dev imagemagick libmagick++-dev libarchive-dev virtualenv g++ libxml2-dev linux-headers libfontconfig-dev libfreetype-dev libharfbuzz-dev libfribidi-dev libcurl4-openssl-dev

lint:
	reuse lint
	./lint.R
	hadolint Dockerfile

renv:
	R -e 'install.packages("renv", repos = "https://cloud.r-project.org")'
	R -e 'renv::restore()'

venv:
	virtualenv --download ./.venv
	. ./.venv/bin/activate && \
	pip install skyfield Pillow

.PHONY: run apk apt lint renv venv
