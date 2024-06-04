library("httr")

moon_phase <- function(date) {
  host <- "https://wttr.in"
  format <- "format=%m"
  wttr_url <- sprintf("%s/Moon@%s?%s", host, date, format)
  response <- GET(wttr_url)
  content <- content(response, "text")
  return(content)
}

moon <- moon_phase("2023-11-01")
print(moon)