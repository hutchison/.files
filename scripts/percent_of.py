#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from datetime import datetime, timedelta
from math import floor
import argparse
import calendar
import sys


def diff_seconds(start, end):
    return int((end - start).total_seconds())


def percent_remaining(start, dt, end):
    return 100 * (1 - diff_seconds(dt, end)/diff_seconds(start, end))


def percent_of_day(dt=datetime.now()):
    elapsed_seconds = dt.hour*60*60 + dt.minute*60 + dt.second
    return 100 * (elapsed_seconds / (24*60*60))


def percent_of_week(dt=datetime.now()):
    _date = dt.date()
    diff_to_most_recent_monday = timedelta(days=_date.weekday())
    d_monday = _date - diff_to_most_recent_monday
    start = datetime(d_monday.year, d_monday.month, d_monday.day, 0, 0, 0)
    week = timedelta(days=7)
    second = timedelta(seconds=1)
    end = start + week - second
    return percent_remaining(start, dt, end)


def percent_of_month(dt=datetime.now()):
    start = datetime(dt.year, dt.month, 1, 0, 0, 0)
    _, last_day_of_month = calendar.monthrange(dt.year, dt.month)
    end = datetime(dt.year, dt.month, last_day_of_month, 23, 59, 59)
    return percent_remaining(start, dt, end)


def percent_of_year(dt=datetime.now()):
    start = datetime(dt.year, 1, 1, 0, 0, 0)
    end = datetime(dt.year, 12, 31, 23, 59, 59)
    return percent_remaining(start, dt, end)


BLOCKS = [chr(9608+i) for i in range(8)]

def blocky(p):
    r = ''
    if 0 <= p <= 100:
        t, o = divmod(p, 10)
        b_full = BLOCKS[0]
        r = floor(t)*b_full
        for i in range(8, 0, -1):
            if o <= 10*i//8:
                r += BLOCKS[-i]
                break

    r += (10-len(r)) * ' '
    return r


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('unit', choices=['day', 'week', 'month', 'year'])
    parser.add_argument('--precision', type=int, default=0, required=False)
    parser.add_argument('-b', '--block', action='store_true')

    args = parser.parse_args()

    as_block = args.block

    if args.unit == 'day':
        percentage = percent_of_day()
    elif args.unit == 'week':
        percentage = percent_of_week()
    elif args.unit == 'month':
        percentage = percent_of_month()
    elif args.unit == 'year':
        percentage = percent_of_year()

    prefix = args.unit[0].upper()

    width = 2+args.precision
    fmt_str = prefix + ' {:' + str(width) + '.' + str(args.precision) + 'f}'

    if as_block:
        print(blocky(percentage))
    else:
        print(fmt_str.format(percentage))
