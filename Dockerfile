# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

FROM alpine:latest
WORKDIR /app

# system font needed for generating graphs
RUN apk add --no-cache make font-noto-all
COPY Makefile ./

RUN make apk
RUN make venv

COPY renv.lock ./
RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
RUN make renv

COPY . ./
CMD [ "make", "run" ]
EXPOSE 1897
