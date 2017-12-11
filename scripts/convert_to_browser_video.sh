#!/bin/bash

for inputfile in "$@"; do
	outputfile="${inputfile%.*}.mp4"
	avconv -i "$inputfile" -vcodec copy -acodec mp3 "$outputfile"
done
