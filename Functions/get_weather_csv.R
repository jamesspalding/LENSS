# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only
library(httr2)

get_weather_csv <- function(
    start,
    end,
    lat = "42.5831",
    lon = "-88.5394",
    tz = "America%2FChicago",
    var = "temperature_2m,precipitation,snowfall,snow_depth,cloud_cover,cloud_cover_low,cloud_cover_mid,cloud_cover_high",
    format = "csv",
    def_dir = "Data") {
  file <- paste("weather", start, end, sep = "_")
  path <- paste(def_dir, file, sep = "/")
  path <- paste(path, format, sep = ".")

  if (file.exists(path)) {
    cat(path, "already cached\n")
    return()
  }

  link <- paste0(
    "https://archive-api.open-meteo.com/v1/archive",
    "?latitude=", lat,
    "&longitude=", lon,
    "&start_date=", start,
    "&end_date=", end,
    "&hourly=", var,
    "&timezone=", tz,
    "&format=", format
  )
  req <- request(link)
  resp <- req_perform(req)
  cat(resp_body_string(resp), file = path, sep = "")
}
