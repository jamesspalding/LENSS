# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

##### data/presentation #####
library(tidyverse)
library(viridis)
library(latex2exp)
library(magick)

##### Shiny #####
library(shiny)
library(shinylive)
library(shinydashboard)
library(httpuv)

##### python #####
library(reticulate)
#needs to run when R session starts, but cannot be run multiple times or causes error
# use_virtualenv(paste0(getwd(),"/.venv"), required=T)
# use_python(paste0(getwd(),'/.venv'))

##### web scraping #####
library(httr)

##### Functions #####
source("buildGraph.R")
source("makeGif.R")
source_python("moon.py")
source_python("animateFrames.py")

##### paths #####
framePath = paste0(getwd(),"/Images/Frames") #frame location for gif generation
imgPath = paste0(getwd(),"/Images") #output location for images
iconPath = paste0(getwd(),"/Images/Icons") #location of emojis for moon and weather


##### data cleaning #####
kish = read.csv("Data/Kish11-9.csv")
kish = kish[-c(1:39),1:5]
kish = kish[-c(1:2),]
colnames(kish) = c("UTCTime", "LocalTime", "TempC", "Volts", "MagArcsec2")
kish = mutate(kish, Hour = hour(kish$LocalTime), Obs = seq_along(kish$LocalTime))

kish$UTCTime = as.ts(kish$UTCTime)
kish$LocalTime = as.ts(kish$LocalTime)
kish$TempC = as.numeric(kish$TempC)
kish$Volts = as.numeric(kish$Volts)
kish$MagArcsec2 = as.numeric(kish$MagArcsec2)

#remove low volt cases
kish = kish %>%
   filter(Volts > 4.8)


##### plot setup #####
  #Finding start and end values to center at midnight
  #center at midnight, 144 obs each side 143 other
midnights = which(hour(kish$LocalTime) == 0 & minute(kish$LocalTime) == 0)
start = c()
finish = c()
for(i in 2:113){
   start[i] = midnights[i] - 144 #noon of day before
   finish[i] = midnights[i] + 143 #11:55 of day after
 }
start = start %>% na.omit()
finish = finish %>% na.omit()
midnights = midnights[-1]
midnights = midnights[-113] #removing first and last values to line up with start and finish
ylabel = TeX("$\\frac{Magnitude}{Arcsec^2}")
