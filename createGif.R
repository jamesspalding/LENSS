# Function to create gif frames given a range of 2 days

generateFrames <- function(start_date, end_date,
                           MID = F, SQM = F, BORTLE = F, SIZE = c(3201,1800)){ #buildGraph params
  date_diff = as.Date(end_date) - as.Date(start_date)
  
  for(time_elapsed in 0:date_diff){
    framedate = as.Date(start_date) + time_elapsed
    buildGraph(framedate, midLine = MID, sqm = SQM, bortle = BORTLE)

    ggsave(filename = paste0(getwd(), "/tempframes/frame", time_elapsed, ".png"),
           plot = last_plot(),
           width = SIZE[1],
           height = SIZE[2],
           units = "px")
  }
  
}

#generateFrames("2023-10-10", "2023-10-14")