# Uses generateFrames and animateFrames to create gif

makeGif <- function(start_date, end_date,
                    MID = F, SQM = F, BORTLE = F, SIZE = c(3201,1800)){ #makegraph params
  
  dirName = paste0(getwd(), "/tempframes")
  
  generateFrames(start_date, end_date, MID, SQM, BORTLE, SIZE)
  
  animateFrames(dirName)
}