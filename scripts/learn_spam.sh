#!/bin/bash

for dir in ~/users/*; do
	[ -e "$dir" ] || continue
	for f in $dir/.Spam/cur/*; do
		[ -e "$f" ] || continue
		spamc -L spam -U ~/tmp/spamd.sock < "$f"
		grep -h ^Subject: "$f"
	done
done
