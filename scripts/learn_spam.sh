#!/bin/bash

for f in ~/users/martin/.Spam/cur/*; do
	spamc -L spam -U ~/tmp/spamd.sock < "$f"
	grep -h ^Subject: "$f"
done
