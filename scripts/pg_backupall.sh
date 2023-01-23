#!/usr/bin/env sh

CURRENT_DATE=$(date +"%FT%T")
OUTPUT_FILENAME="backup_all_${CURRENT_DATE}.sql"

sudo -u postgres pg_dumpall > "$OUTPUT_FILENAME"
xz "$OUTPUT_FILENAME"
