# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only
# creates a gif within specified range

makeGif <- function(start_date, end_date,
                    MID = F, SQM = F, BORTLE = F, PHASE = F, SIZE = c(3201,1800), #makegraph params
                    duration = 200) { #gif duration

  date_diff <- as.Date(end_date) - as.Date(start_date)
  dirName <- paste0(getwd(), "/tempframes")

  for (time_elapsed in 0:date_diff) {
    framedate <- as.Date(start_date) + time_elapsed
    buildGraph(framedate, midLine = MID, sqm = SQM, bortle = BORTLE, phase = PHASE)

    ggsave(filename = paste0(dirName, "/frame", time_elapsed, ".png"),
           plot = last_plot(),
           width = SIZE[1],
           height = SIZE[2],
           units = "px")
  }

  animateFrames(dirName, duration = duration)

}
