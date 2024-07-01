#!/bin/sh -eu
# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only
# TODO: switch to R

lat="42.5831"
lon="-88.5394"
start="2023-07-18"
end="2023-11-09"
tz="America%2FChicago"
var="temperature_2m,precipitation,snowfall,snow_depth,cloud_cover,cloud_cover_low,cloud_cover_mid,cloud_cover_high"
format="csv"
path="Data/weather_${start}_$end.csv"

if ! [ -e "$path" ]; then
	curl -f "https://archive-api.open-meteo.com/v1/archive?latitude=$lat&longitude=$lon&start_date=$start&end_date=$end&hourly=$var&timezone=$tz&format=$format" > "$path"
else
	echo "already cached!"
fi
