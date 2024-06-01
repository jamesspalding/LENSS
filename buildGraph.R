source("setup.R")


##### Build graphs for shiny app #####
buildGraph = function(givenDate, midLine = F, sqm = F, bortle = F, save = F){
  
  
  ##### Values #####
  givenMid = which(midnights == which(date(kish$LocalTime) == givenDate &
                                      hour(kish$LocalTime) == 0 &
                                      minute(kish$LocalTime) == 0))
  plotDate = kish[c(start[givenMid]:finish[givenMid]), ]
  maxSQM = max(plotDate$MagArcsec2)


  ##### Base Plot #####
  myPlot = ggplot() +
      geom_line(data = plotDate, aes(x = seq_along(MagArcsec2),
                                     y = MagArcsec2))+
      labs(title = paste0("SQM Readings from ", as.character(givenDate), " to ",
                          as.character(as.Date(givenDate) + 1)))+
      xlab("") +
      ylab(ylabel) +
      ylim(22, 5.8) +
      xlim(50, 250) +
      theme(plot.title = element_text(face = "bold"),
            legend.position = "none",
            axis.ticks.x = element_blank(),
            axis.title.y = element_text(angle = 0, vjust = .5))+
      scale_x_continuous(breaks = c(72, 144, 216),
                         labels = c("6:00 P.M.",  "12:00 A.M.",  "6:00 A.M."))+
      coord_cartesian(xlim = c(50, 250))

  
  ##### Midnight line #####
  if(midLine == T){
    myPlot = myPlot + 
      geom_vline(xintercept=144, linetype="dashed", alpha = .3)
  }

  
  ##### Max SQM Readings #####
  if(sqm == T){
    
    labelList = c()
    breakList = c()
    
    #Ordering for breaks
    if(maxSQM > 20){
      labelList = c(as.character(maxSQM), "", "15", "10", "5")
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
    
    myPlot = myPlot+
               scale_y_continuous(breaks = breakList,
                                  labels = labelList,
                                  limits = c(22, 5.8),
                                  trans = "reverse")+
               geom_hline(yintercept = maxSQM, linetype="dashed", alpha=.3)

  }


  ##### Bortle Overlay #####
  if(bortle == T){
    
    myPlot = myPlot +
      #City (9-7)
      geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = 18.5),
                alpha = .15,
                fill = "red") + 
  
      #Suburban (6-4.5)
      geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 18.5, ymax = 20.8),
                alpha = .15,
                fill = "purple") + 
      
      #Rural (4-1)
      geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 20.8, ymax = Inf),
                alpha = .15,
                fill = "blue")
  }
  
  
  ##### Saving output #####
  if(save == T){
    outputName = paste0("/maxSQM", as.character(givenDate), ".png")
    image_write(myPlot, paste0(imgPath, outputName))
  }
  
  
  ##### Plot Output #####
  print(myPlot)
  return()
}

##### Usage #####
# buildGraph("2023-10-10", sqm = F, bortle = T, midLine = T)