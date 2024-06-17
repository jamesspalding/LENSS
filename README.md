<!-- SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org> -->
<!-- SPDX-License-Identifier: AGPL-3.0-only -->
# LENSS Graphs Site

Project to turn LENSS data from [GLAS Education](https://glaseducation.org)
into presentable graphs.

## TODOs

#### Àngel

- [ ] Write mag/arcsecond^2 about section
- [x] Moon phase library
- [ ] Set up skyfield for twilight calculation times at -18° angle
- [ ] Pipe data through scripts to automatically create .csv files
- [ ] Create website
- [ ] Integrate open-meteo.com weather API

#### James

- [x] Filter out <4.8 volts
- [x] Implement categorization of data according to [bortle scale](https://en.wikipedia.org/wiki/Bortle_scale)
- [x] Make interactive graphs with R shiny
- [ ] Redo X scale to reference actual time (instead of fixed numbers) to account for daylight savings

*Emojis to use*

* ☀️ 🌤️ 🌥️ ☁️ 🌧️
* 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘

#### Website idea

- Transfer data
- Automatically generate "frames" for each day
- Upload to image folder
- Automatically be added to interactive slider
- "What is twilight?" section
- Map of light pollution in US

## Outputs

![](https://github.com/jamesspalding/LENSS/blob/main/Images/combinedPlot.png)

Plot of all dates

![](https://github.com/jamesspalding/LENSS/blob/main/Images/Animation.gif)

Animation of all dates

![](https://github.com/jamesspalding/LENSS/blob/main/Images/maxSQM2023-09-26.png)

Plot with the max SQM reading on the Y axis

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-10_mid_maxsqm_bortle.png)

Plot with Bortle scale overlaid

## LICENSES

This code is under the GNU AGPL 3.0 open source license. Our data is provided by
our LENSS project sensor and is under the ODbL open sharealike database license.
