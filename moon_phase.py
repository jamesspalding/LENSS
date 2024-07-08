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
