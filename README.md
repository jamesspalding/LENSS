<!-- SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org> -->
<!-- SPDX-License-Identifier: AGPL-3.0-only -->
# LENSS Graphs Site

Project to turn LENSS data from [GLAS Education](https://glaseducation.org)
into presentable graphs.

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

- "What is twilight?" section
- Map of light pollution in US

## Outputs

![](https://github.com/jamesspalding/LENSS/blob/main/Images/combinedPlot.png)

Plot of all dates

![](https://github.com/jamesspalding/LENSS/blob/main/Images/Animation.gif)

Animation of all dates

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-23_mid_maxsqm.png)

Plot with max SQM reading and midnight both labeled

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-23_emoji.png)

Plot with moon phase displayed

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-10_mid_maxsqm_bortle.png)

Plot with Bortle scale overlaid

![](https://github.com/jamesspalding/LENSS/blob/main/Images/plot_2023-10-23_cloudcover.png)

Plot with cloud cover overlaid

## LICENSES

This code is under the GNU AGPL 3.0 open source license. Our data is provided by
our LENSS project sensor and is under the ODbL open sharealike database license.
