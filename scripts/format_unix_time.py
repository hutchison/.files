#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import datetime


def usage():
    script_name = sys.argv[0]
    print(f"usage: {script_name} unix_timestamp format_string")


def main():
    if len(sys.argv) != 3:
        usage()
        sys.exit(1)

    ts = int(sys.argv[1])
    f = sys.argv[2]

    d = datetime.datetime.fromtimestamp(ts)
    print(d.strftime(f))

    sys.exit(0)


if __name__ == '__main__':
    main()
