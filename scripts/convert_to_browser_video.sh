#!/bin/bash

# Welcher Konverter soll benutzt werden?
if type avconv >/dev/null 2>&1; then
	CONVERTER=avconv
elif type ffmpeg >/dev/null 2>&1; then
	CONVERTER=ffmpeg
else
	echo "No converter found. Checked for avconv and ffmpeg."
	exit 1
fi

# Welcher Videocodec soll benutzt werden?
videocodec=copy
while getopts v: opt 2> /dev/null
do
	case $opt in
		# -z heißt "String hat die Länge 0."
		# dann gibt [ 0 zurück, was true entspricht
		# dann wird durch && der Rest ausgeführt
		v)	[ -z "$OPTARG" ] && echo "Argument fehlt!" && exit 1
			videocodec="$OPTARG"
			shift 2
			;;
		?)	echo "Fehler bei den Argumenten!"
			exit 1
			;;
	esac
done

for inputfile in "$@"; do
	echo "$inputfile"
	outputfile="${inputfile%.*}.mp4"
	$CONVERTER -i "$inputfile" -vcodec "$videocodec" -acodec mp3 "$outputfile"
done
