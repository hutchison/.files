#!/bin/bash

dir="$1"

if [[ "$dir" != "" ]]; then
	for f in "$dir/"*; do
		spamc -L ham -U $HOME/tmp/spamd.sock < "$f"
	done
else
	echo "Please specify a directory which contains ham-mails."
fi
