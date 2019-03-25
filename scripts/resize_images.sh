#!/bin/bash

for file in $@; do
	size=$(stat -c "%s" "$file")
	if (($size > 1000000)); then
		trimmed_filename=${file%.*}
		echo -n "Resizing $file ... "
		convert "$file" -resize 600x "${trimmed_filename}_resized.jpg"
		mv "${trimmed_filename}_resized.jpg" "$file"
		echo "done"
	fi
done
