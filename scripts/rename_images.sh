#!/bin/bash

if [[ -z "$1" ]]; then
	EXTENSION="jpg"
else
	EXTENSION="$1"
fi

for f in *.$EXTENSION ; do
	SHASUM=$(shasum "$f" | cut -d ' ' -f 1)
	MTIME=$(stat -t "%Y-%m-%d_%Hh%Mm%Ss" "$f" | cut -d ' ' -f 10 | sed s/\"//g)
	NEWNAME="${MTIME}_${SHASUM:34:40}".jpg

	if [[ $2 = "test" ]]; then
		echo "$f → $NEWNAME"
	else
		mv -v "$f" "$NEWNAME"
	fi
done
