#!/bin/bash

if type avconv >/dev/null 2>&1; then
	CONVERTER=avconv
elif type ffmpeg >/dev/null 2>&1; then
	CONVERTER=ffmpeg
else
	echo "No converter found. Checked for avconv and ffmpeg."
	exit 1
fi

for inputfile in "$@"; do
	outputfile="${inputfile%.*}.mp4"
	$CONVERTER -i "$inputfile" -vcodec copy -acodec mp3 "$outputfile"
done
