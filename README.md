<!-- SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org> -->
<!-- SPDX-License-Identifier: AGPL-3.0-only -->
# LENSS Graphs Site

> Shiny webapp for visualizing light sensor data

## INSTALLATION

The simplest way to run our app is with docker:

```sh
docker pull acsquared/lenss:latest
docker run -p 1897:1897 acsquared/lenss:latest
```

## TODOs

#### Àngel

- [ ] Write mag/arcsecond^2 about section
- [x] Moon phase library
- [x] Set up skyfield for twilight calculation times at -18° angle
- [ ] Pipe data through scripts to automatically create .csv files
- [ ] Create website
- [x] Integrate open-meteo.com weather API

#### James

- [x] Filter out <4.8 volts
- [x] Implement categorization of data according to [bortle scale](https://en.wikipedia.org/wiki/Bortle_scale)
- [x] Make interactive graphs with R shiny
- [x] Redo X scale to reference actual time (instead of fixed numbers) to account for daylight savings
- [x] Improve efficiency
- [ ] Use Google API to automatically grab new data files when updated

#### Website

- [ ] "What is twilight?" section
- [ ] Map of light pollution in US

## Data over time

Given a start and end date, data can be visualized in both image and gif format as shown below:

![](https://github.com/jamesspalding/LENSS/blob/main/Images/combinedPlot.png)

![](https://github.com/jamesspalding/LENSS/blob/main/Images/Animation.gif)

## buildGraph Function

This function is the heart of the shiny app. It takes various interactive parameters to make graphs with LENSS data.

```
buildGraph(date, midLine = FALSE, sqm = FALSE, bortle = FALSE, cloud = FALSE, phase = FALSE, save = FALSE, size = c(3201,1800))
```

Outputs from changing parameters are shown in the following section.

### Outputs

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-23_mid_maxsqm.png)

Plot with max SQM reading and midnight both labeled. ```buildGraph("2023-10-23", sqm = TRUE, midLine = TRUE)```

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-23_emoji.png)

Plot with moon phase displayed. ```buildGraph("2023-10-23", phase = TRUE)```

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-10_mid_maxsqm_bortle.png)

Plot with Bortle scale overlaid. ```buildGraph("2023-10-10", bortle = TRUE)```

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-23_cloudcover.png)

Plot with cloud cover overlaid. ```buildGraph("2023-10-23", cloud = TRUE)```

## LICENSES

This code is under the GNU AGPL 3.0 open source license. Our light data is
provided by [GLAS Education](https://glaseducation.org) under the ODbL open
database license, and our weather data is provided by [open
meteo](https://open-meteo.com) under the CC-BY 4.0 license.
