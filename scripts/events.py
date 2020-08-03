#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from datetime import date
from pathlib import Path


class Event:
    def __init__(self, name, date):
        self.name = name
        self.date = date

    def days_left(self):
        diff = self.date - date.today()
        return diff.days

    def __str__(self):
        return f'{self.name}\t{self.days_left()}'


def main(eventfile):
    with open(eventfile) as events:
        for line in events:
            n, d = line.split('\t')
            e = Event(n, date.fromisoformat(d.strip()))
            print(e)


if __name__ == '__main__':
    eventfile = Path.home() / '.events'
    if eventfile.exists():
        main(eventfile)
