#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys


def convert_to_seconds(s):
    unit = s[-1]
    amount = int(s[:-1])
    if unit == 's':
        return amount
    elif unit == 'm':
        return 60 * amount
    elif unit == 'h':
        return 60 * 60 * amount
    elif unit == 'd':
        return 24 * 60 * 60 * amount
    else:
        return 0


def main():
    ret_t = 0

    for s in sys.argv[1:]:
        ret_t += convert_to_seconds(s)

    print(ret_t)


if __name__ == '__main__':
    main()
