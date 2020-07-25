#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from datetime import datetime


def percent_of_day(dt):
    elapsed_seconds = dt.hour*60*60 + dt.minute*60 + dt.second
    return 100*elapsed_seconds / (24*60*60)


if __name__ == '__main__':
    print('{:.2f}'.format(percent_of_day(datetime.now())))
