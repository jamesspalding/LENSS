source("setup.R")

#Functions:
# dateGraph: returns a simple plot showing SQM readings for a given day
# SQMGraph: same as above, but shows the max SQM reading for the day





dateGraph = function(givenDate){
  #Find the midnight of the given date
  givenMid = which(midnights == which(date(kish$LocalTime) == givenDate & hour(kish$LocalTime) == 0 & minute(kish$LocalTime) == 0))
  plotDate = kish[c(start[givenMid]:finish[givenMid]), ]
    
  ggplot() +
      geom_line(data = plotDate, aes(x = seq_along(MagArcsec2),
                                     y = MagArcsec2))+
      labs(title = paste0("SQM Readings from ", as.character(givenDate), " to ", as.character(as.Date(givenDate) + 1)))+
      xlab("") +
      ylab(ylabel) +
      ylim(22, 5.8) +
      xlim(50, 250) +
      geom_vline(xintercept=144, linetype="dashed", alpha = .3)+
      theme(plot.title = element_text(face = "bold"),
            legend.position = "none",
            axis.ticks.x = element_blank(),
            axis.title.y = element_text(angle = 0, vjust = .5))+
      scale_x_continuous(breaks = c(72, 144, 216),
                         labels = c("6:00 P.M.",  "12:00 A.M.",  "6:00 A.M."))+
    coord_cartesian(xlim = c(50, 250))
}
  

#-----------------------------------------------------------------------------#


SQMGraph = function(givenDate, save = F){
  
  #----- Work on error handling -----#
  
  #  if(givenDate %in% date(kish$LocalTime)){
  tempMid = which(date(kish$LocalTime) == givenDate & hour(kish$LocalTime) == 0 & minute(kish$LocalTime) == 0)
  numMid = which(midnights == tempMid)
  #    if(length(numMid) == 0){
  #     return("Please enter a valid date.") #Catches 7/19 and 11/08 (incomplete cases)
  #   }
  # }else{
  #   return("Please enter a valid date.") #Catches all other invalid dates
  # }
  
  #----------#
  
  plotDate = kish[c(start[numMid]:finish[numMid]), ]
  maxSQM = max(plotDate$MagArcsec2)
  
  #ordering
  labelList = c()
  breakList = c()
  if(maxSQM > 20){
    labelList = c(as.character(maxSQM), "", "15", "10", "5") #unsure if leaving 20 out is best choice.
    breakList = c(maxSQM, 20, 15, 10, 5)
  }
  if(maxSQM > 15 & maxSQM <= 20){
    labelList = c("", as.character(maxSQM), "15", "10", "5")
    breakList = c(20, maxSQM, 15, 10, 5)
  }
  if(maxSQM > 10 & maxSQM <= 15){
    labelList = c("20", "15", as.character(maxSQM), "10", "5")
    breakList = c(20, 15, maxSQM, 10, 5)
  }
  if(maxSQM > 5 & maxSQM <= 10){
    labelList = c("20", "15", "10", as.character(maxSQM), "5")  
    breakList = c(20, 15, 10, maxSQM, 5)
  }
  if(maxSQM <= 10){
    labelList = c("20", "15", "10", "5", as.character(maxSQM))
    breakList = c(20, 15, 10, 5, maxSQM)
  }
  
  
  #Plot creation
  myPlot = ggplot() +
    geom_line(data = plotDate, aes(x = seq_along(MagArcsec2),
                                   y = MagArcsec2,
                                   fill = "black"))+
    labs(title = paste0("SQM Readings from ", as.character(givenDate), " to ", as.character(as.Date(givenDate)+1)))+
    xlab("") +
    ylab(ylabel) +
    geom_vline(xintercept=144, linetype="dashed", alpha = .3)+ #midnight
    geom_hline(yintercept = maxSQM, linetype="dashed", alpha=.3)+ #Max line
    theme(plot.title = element_text(face = "bold"),
          legend.position = "none",
          axis.ticks.x = element_blank(),
          axis.title.y = element_text(angle = 0, vjust = .5))+
    scale_x_continuous(breaks = c(72, 144, 216),
                       labels = c("6:00 P.M.",  "12:00 A.M.",  "6:00 A.M."))+
    scale_y_continuous(breaks = breakList,
                       labels = labelList,
                       limits = c(22, 5.8),
                       trans = "reverse")+
    coord_cartesian(xlim = c(50, 250))
  
  #saving
  if(save == T){
    outputName = paste0("/maxSQM", as.character(givenDate), ".png")
    image_write(myPlot, paste0(imgPath, outputName))
  }
  
  myPlot
}

