#!./.venv/bin/python3
# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

from skyfield import almanac
from skyfield.api import load

def moon_phase(year, month, date):
  # selected from
  # https://rhodesmill.org/skyfield/planets.html#choosing-an-ephemeris
  eph = load("de421.bsp")
  ts = load.timescale()

  t = ts.utc(year, month, date)
  return almanac.moon_phase(eph, t).degrees

def moon_emoji(degree):
  margin = 45/2
  if degree < (45 + margin) and degree >= (60 - margin):
    return "🌒"
  elif degree < (90 + margin) and degree >= (90 - margin):
    return "🌓"
  elif degree < (135 + margin) and degree >= (135 - margin):
    return "🌔"
  elif degree < (180 + margin) and degree >= (180 - margin):
    return "🌕"
  elif degree < (225 + margin) and degree >= (225 - margin):
    return "🌖"
  elif degree < (270 + margin) and degree >= (270 - margin):
    return "🌗"
  elif degree < (315 + margin) and degree >= (315 - margin):
    return "🌘"
  else:
    return "🌑"

def parse_iso8601(date):
  year, month, day = map(int, date.split('-'))
  return year, month, day

# christmas = "2023-12-25"
# year, month, day = parse_iso8601(christmas)
# phase = moon_phase(year, month, day)
# print('Moon phase: {:.1f} degrees with emoji '.format(phase) + moon_emoji(phase))
