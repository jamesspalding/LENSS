# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

#####################
##### Libraries #####
#####################

# data/presentation
library(tidyverse)
library(viridis)
library(latex2exp)
library(magick)
library(png)
library(ggimage)
library(cowplot)
library(httr)

# Shiny
library(shiny)
library(shinylive)
library(shinydashboard)
library(httpuv)

# python
library(reticulate)
#will only run first time in R session
if (paste0(getwd(), "/.venv/bin/python") != py_config()[1]) {

  use_virtualenv(paste0(getwd(), "/.venv"), required = TRUE)
  use_python(paste0(getwd(), "/.venv/bin/python"))
}

# Custom Functions
source_python("moon.py")
source_python("animateFrames.py")
source("buildGraph.R")
source("makeGif.R")

# paths 
framePath <- paste0(getwd(), "/Images/Frames") #frame location for gif generation
imgPath <- paste0(getwd(), "/Images") #output location for images
iconPath <- paste0(getwd(), "/Images/Icons") #location of emojis for moon and weather

#First and Last dates (to be updated with new data)
FIRSTDAY <- as.Date("2023-07-20")
LASTDAY <- as.Date("2023-11-08")

#CHANGE FOR DIFFERENT QUALITY GRAPHS (5 default)
if (exists("minInterval") == FALSE) {
  minInterval <- 5
}



########################
##### Weather Data #####
########################

# get weather data
if((is.integer(which(grepl("weatherData.csv", list.files("./Data")))) && length(which(grepl("weather", list.files("./Data")))) == 0L)==F){
  #check for existing weather file, and removing if found
  file.remove(paste0(getwd(),"/Data/",list.files("./Data")[which(grepl("weather", list.files("./Data")))]))
}

system2(command = "./weather.sh",
        args = c(as.character(FIRSTDAY), as.character(LASTDAY+1))) #gets necessary data

weatherData <- read_csv("Data/weatherData.csv", 
                         skip = 2)

# formatting to match other dataset
second(weatherData$time) <- second(weatherData$time+5)
weatherData <- mutate(weatherData, Day = date(weatherData$time))
weatherData <- mutate(weatherData, Hour = hour(weatherData$time))




######################
#### Bortle Data #####
######################

kish <- read.csv("Data/Kish11-9.csv")
kish <- kish[-c(1:39), 1:5]
kish <- kish[-c(1:2), ]
colnames(kish) <- c("UTCTime", "LocalTime", "TempC", "Volts", "MagArcsec2")

#separate day/hour
kish <- mutate(kish, Day = date(kish$LocalTime))
kish <- mutate(kish, Hour = hour(kish$LocalTime))

kish$UTCTime <- as.ts(kish$UTCTime)
kish$LocalTime <- as.ts(kish$LocalTime)
kish$TempC <- as.numeric(kish$TempC)
kish$Volts <- as.numeric(kish$Volts)
kish$MagArcsec2 <- as.numeric(kish$MagArcsec2)

#remove low volt cases
kish <- kish %>%
  filter(Volts > 4.8)

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

# number of obs/day
dayLength <- 204 / detailLevel

#joining datasets
kish <- kish %>% 
  left_join(weatherData, by = c("Day", "Hour")) %>%
  select(-c("time", "Day", "temperature_2m (°C)",
            "cloud_cover_low (%)", "cloud_cover_mid (%)", "cloud_cover_high (%)"))

kish$`cloud_cover (%)` <- kish$`cloud_cover (%)`/100
