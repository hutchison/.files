#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import calendar
from datetime import datetime, timedelta
import sys


def diff_seconds(start, end):
    return int((end - start).total_seconds())


def percent_remaining(start, dt, end):
    return 100 * (1 - diff_seconds(dt, end)/diff_seconds(start, end))


def percent_of_day(dt):
    elapsed_seconds = dt.hour*60*60 + dt.minute*60 + dt.second
    return 100 * (elapsed_seconds / (24*60*60))


def percent_of_week(dt):
    _date = dt.date()
    diff_to_most_recent_monday = timedelta(days=_date.weekday())
    d_monday = _date - diff_to_most_recent_monday
    start = datetime(d_monday.year, d_monday.month, d_monday.day, 0, 0, 0)
    week = timedelta(days=7)
    second = timedelta(seconds=1)
    end = start + week - second
    return percent_remaining(start, dt, end)


def percent_of_month(dt):
    start = datetime(dt.year, dt.month, 1, 0, 0, 0)
    _, last_day_of_month = calendar.monthrange(dt.year, dt.month)
    end = datetime(dt.year, dt.month, last_day_of_month, 23, 59, 59)
    return percent_remaining(start, dt, end)


def percent_of_year(dt):
    start = datetime(dt.year, 1, 1, 0, 0, 0)
    end = datetime(dt.year, 12, 31, 23, 59, 59)
    return percent_remaining(start, dt, end)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('unit', choices=['day', 'week', 'month', 'year'])
    parser.add_argument('--precision', type=int, default=0, required=False)

    args = parser.parse_args()

    _now = datetime.now()

    if args.unit == 'day':
        percentage = percent_of_day(_now)
    elif args.unit == 'week':
        percentage = percent_of_week(_now)
    elif args.unit == 'month':
        percentage = percent_of_month(_now)
    elif args.unit == 'year':
        percentage = percent_of_year(_now)

    prefix = args.unit[0].upper()

    width = 2+args.precision
    fmt_str = prefix + ' {:' + str(width) + '.' + str(args.precision) + 'f}'

    print(fmt_str.format(percentage))
