#!/usr/bin/env sh

#[ $# -ge 1 -a -f "$1" ] && input="$1" || input=""
# if the number of arguments is >= 1 and $1 is a file
# then input is the file
# otherwise input is -

if [ $# -ge 1 -a -f "$1" ]; then
	sed 's/\(.\)/\1\n/g' $1 | sed '/^[[:space:]]*$/d' | sort | uniq -c | sort -rn
else
	sed 's/\(.\)/\1\n/g' | sed '/^[[:space:]]*$/d' | sort | uniq -c | sort -rn
fi
