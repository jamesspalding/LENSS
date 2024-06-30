# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

#CHANGE FOR DIFFERENT QUALITY GRAPHS (5 default)
if (exists("minInterval") == FALSE) {
  minInterval <- 5
}


##### data/presentation #####
library(tidyverse)
library(viridis)
library(latex2exp)
library(magick)
library(png)
library(ggimage)
library(cowplot)

##### Shiny #####
library(shiny)
library(shinylive)
library(shinydashboard)
library(httpuv)

##### python #####
library(reticulate)
#will only run first time in R session
if (paste0(getwd(), "/.venv/bin/python") != py_config()[1]) {

  virtualenv_create(envname = "venv",
                    python = "/usr/bin/python3")

  virtualenv_install("venv",
                     packages = c("skyfield"))

  use_virtualenv(paste0(getwd(),"/.venv"), required = TRUE)
  #use_python(paste0(getwd(),'/.venv'))
}

##### web scraping #####
library(httr)

##### Functions #####
source_python("moon.py")
source_python("animateFrames.py")
source("buildGraph.R")
source("makeGif.R")

##### paths #####
framePath <- paste0(getwd(), "/Images/Frames") #frame location for gif generation
imgPath <- paste0(getwd(), "/Images") #output location for images
iconPath <- paste0(getwd(), "/Images/Icons") #location of emojis for moon and weather


##### data cleaning #####
kish <- read.csv("Data/Kish11-9.csv")
kish <- kish[-c(1:39), 1:5]
kish <- kish[-c(1:2), ]
colnames(kish) <- c("UTCTime", "LocalTime", "TempC", "Volts", "MagArcsec2")
kish <- mutate(kish, Hour = hour(kish$LocalTime))

kish$UTCTime <- as.ts(kish$UTCTime)
kish$LocalTime <- as.ts(kish$LocalTime)
kish$TempC <- as.numeric(kish$TempC)
kish$Volts <- as.numeric(kish$Volts)
kish$MagArcsec2 <- as.numeric(kish$MagArcsec2)

#remove low volt cases
kish <- kish %>%
  filter(Volts > 4.8)


#################################################

#remove times between 8 AM - 4 PM
kish <- kish %>%
  filter(Hour <= 8 | Hour >= 16)

#remove initial AM obs
kish <- kish[-c(1:408), ]

#filter to interval
detailLevel <- minInterval / 5
kish <- kish[seq(1, NROW(kish), by = detailLevel), ]

#add observation #
kish <- mutate(kish, Obs = seq_along(kish$LocalTime))

# 22860/204 5 min int
# 11430/102 10 min int 3
# 7620/68 15 min int 9

dayLength <- 204 / detailLevel


#First and Last dates (to be updated with new data)
FIRSTDAY <- as.Date("2023-07-20")
LASTDAY <- as.Date("2023-11-08")

#for every night past initial night, add 68

#################################################


# ##### plot setup #####
#   #Finding start and end values to center at midnight
#   #center at midnight, 144 obs each side 143 other
# midnights = which(hour(kish$LocalTime) == 0 & minute(kish$LocalTime) == 0)
# start = c()
# finish = c()
# for(i in 2:113){
#    start[i] = midnights[i] - 144 #noon of day before
#    finish[i] = midnights[i] + 143 #11:55 of day after
#  }
# start = start %>% na.omit()
# finish = finish %>% na.omit()
# midnights = midnights[-1]
# midnights = midnights[-113] #removing first and last values to line up with start and finish
