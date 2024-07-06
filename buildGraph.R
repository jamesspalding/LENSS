# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only
library(tidyverse)

##### Build graphs for shiny app #####
buildGraph <- function(givenDate, midLine = FALSE, sqm = FALSE, bortle = FALSE, cloud = FALSE, phase = FALSE, save = FALSE, size = c(3201,1800)) {


  currentDay <- c(1, dayLength) + (dayLength * (as.Date(givenDate) - FIRSTDAY))


  plotDate <- kish[currentDay[1]:currentDay[2],]


  maxSQM <- max(plotDate$MagArcsec2)
  outputName <- paste0("/plot_", as.character(givenDate))


  ##### Base Plot #####
  myPlot <- ggplot() +
  geom_line(data = plotDate, aes(x = seq_along(MagArcsec2),
                                 y = MagArcsec2)) +
  labs(title = paste0("SQM Readings from ", as.character(givenDate), " to ",
                      as.character(as.Date(givenDate) + 1))) +
  xlab("") +
  ylab(TeX("$\\frac{Magnitude}{Arcsec^2}$")) +
  ylim(22, 5.8) +
  #xlim(50, 250) +
  theme(plot.title = element_text(face = "bold"),
        legend.position = "none",
    axis.ticks.x = element_blank(),
    axis.title.y = element_text(angle = 0, vjust = .5)) +
    #coord_cartesian(xlim = c(50, 250))+
  scale_x_continuous(breaks = c(.15 * dayLength, .5 * dayLength, .85 * dayLength),
                     labels = c("6:00 P.M.",  "12:00 A.M.",  "6:00 A.M."))


  ##### Midnight line #####
  if (midLine == TRUE) {
    myPlot <- myPlot +
    geom_vline(xintercept = dayLength / 2, linetype = "dashed", alpha = .3)

    outputName <- paste0(outputName, "_mid")
  }


  ##### Max SQM Readings #####
  if (sqm == TRUE) {

    labelList <- c()
    breakList <- c()

    #Ordering for breaks
    if (maxSQM > 20) {
      labelList <- c(as.character(maxSQM), "", "15", "10", "5")
      breakList <- c(maxSQM, 20, 15, 10, 5)
    }

    if (maxSQM > 15 && maxSQM <= 20) {
      labelList <- c("", as.character(maxSQM), "15", "10", "5")
      breakList <- c(20, maxSQM, 15, 10, 5)
    }

    if (maxSQM > 10 && maxSQM <= 15) {
      labelList <- c("20", "15", as.character(maxSQM), "10", "5")
      breakList <- c(20, 15, maxSQM, 10, 5)
    }

    if (maxSQM > 5 && maxSQM <= 10) {
      labelList <- c("20", "15", "10", as.character(maxSQM), "5")
      breakList <- c(20, 15, 10, maxSQM, 5)
    }

    if (maxSQM <= 10) {
      labelList <- c("20", "15", "10", "5", as.character(maxSQM))
      breakList <- c(20, 15, 10, 5, maxSQM)
    }

    myPlot <- myPlot +
    scale_y_continuous(breaks = breakList,
                       labels = labelList,
                       limits = c(22, 5.8),
                       trans = "reverse") +
    geom_hline(yintercept = maxSQM, linetype = "dashed", alpha = .3)

    outputName <- paste0(outputName, "_maxsqm")
  }


  ##### Bortle Overlay #####
  if (bortle == TRUE) {
    cloud = FALSE

    myPlot <- myPlot +
      #Urban (9-7)
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
                fill = "blue") +

      #Labels
      annotate("text", x = dayLength, y = 6, label = "Urban") +

      annotate("text", x = .974 * dayLength, y = 18.8, label = "Suburban") +

      annotate("text", x = dayLength, y = 21.15, label = "Rural")

      outputName <- paste0(outputName, "_bortle")
  }

  
  ##### Cloud overlay #####
  # mutually exclusive with bortle overlay
  if(cloud == TRUE){
    cloudHours <- plotDate$`cloud_cover (%)`[seq(1, 68, by=4)]
    cloudHours <- cloudHours/2.5
    
    # for(i in 0:16){
    #   myPlot <- myPlot +
    #     geom_rect(aes(xmin = 1+(i*4), xmax = 4+(i*4), ymin = -Inf, ymax = Inf),
    #                 alpha = cloudHours[i+1],
    #                 fill = "blue")
    # }
    
    #unsure why for loop doesnt work...
    
    myPlot <- myPlot +
      geom_rect(aes(xmin = 0, xmax = 4, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[1],
                fill = "blue") +
      geom_rect(aes(xmin = 4, xmax = 8, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[2],
                fill = "blue") +
      geom_rect(aes(xmin = 8, xmax = 12, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[3],
                fill = "blue") +
        geom_rect(aes(xmin = 12, xmax = 16, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[4],
                fill = "blue") +
      geom_rect(aes(xmin = 16, xmax = 20, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[5],
                fill = "blue") +
      geom_rect(aes(xmin = 20, xmax = 24, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[6],
                fill = "blue") +
      geom_rect(aes(xmin = 24, xmax = 28, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[7],
                fill = "blue") +
      geom_rect(aes(xmin = 28, xmax = 32, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[8],
                fill = "blue") +
      geom_rect(aes(xmin = 32, xmax = 36, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[9],
                fill = "blue") +
      geom_rect(aes(xmin = 36, xmax = 40, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[10],
                fill = "blue") +
      geom_rect(aes(xmin = 40, xmax = 44, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[11],
                fill = "blue") +
      geom_rect(aes(xmin = 44, xmax = 48, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[12],
                fill = "blue") +
      geom_rect(aes(xmin = 48, xmax = 52, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[13],
                fill = "blue") +
      geom_rect(aes(xmin = 52, xmax = 56, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[14],
                fill = "blue") +
      geom_rect(aes(xmin = 56, xmax = 60, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[15],
                fill = "blue") +
      geom_rect(aes(xmin = 60, xmax = 64, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[16],
                fill = "blue") +
      geom_rect(aes(xmin = 64, xmax = 68, ymin = -Inf, ymax = Inf),
                alpha = cloudHours[17],
                fill = "blue")

      
    outputName <- paste0(outputName, "_cloudcover")
  }
  

  ##### Phase Emoji #####
  if (phase == TRUE) {
    phaseDate <- as.character(givenDate)
     phaseY <- as.numeric(strsplit(phaseDate,"-")[[1]][1])
     phaseM <- as.numeric(strsplit(phaseDate,"-")[[1]][2])
     phaseD <- as.numeric(strsplit(phaseDate,"-")[[1]][3])

    degree <- moon_phase(phaseY, phaseM, phaseD)
    margin <- 45 / 2
    phaseNum <- 0 #default at new moon

    # Determine which PNG to use on graph via angles
    for(phaseIndex in 1:7) {
      if (degree < 45 * phaseIndex + margin && degree >= 45 * phaseIndex - margin) {
        phaseNum <- phaseIndex
      }
    }

    phasePNG <- readPNG(
      paste0(getwd(), "/Images/Icons/moon", phaseNum, ".png"))

    myPlot <- ggdraw(myPlot) +
      draw_image(phasePNG,
                 width = .1,
                 height = .1)
    #Can't get the image to move anywhere

    outputName <- paste0(outputName, "_emoji")

  }


  ##### Output #####
  if (save == TRUE) {
    ggsave(filename = paste0(imgPath, outputName, ".png"),
           plot = myPlot,
           width = size[1],
           height = size[2],
           units = "px")
  }

  return(myPlot)
}



##### Usage #####
#buildGraph("2023-10-10", midLine = T, sqm = F, bortle = T, phase = T)
#buildGraph("2023-10-29",cloud=T)
