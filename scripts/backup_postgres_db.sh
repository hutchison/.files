#!/usr/bin/env bash

# Export die Datenbank $DBNAME ($1) als SQL-Datei
# in das Verzeichnis $DESTDIR ($2)
# mit dem Präfix $PREFIX ($3)

# Mittels "psql $DBNAME < $DESTFILENAME" kann diese importiert werden.
# Vorher muss die alte Datenbank gelöscht werden:
# $ drop_db $DBNAME
# $ sudo -u postgres createdb -O $USER bpcupid

usage() {
	echo "$0 dbname destdir prefix"
	exit 1
}

if [[ $# -ne 3 ]]; then
	usage
else
	DBNAME="$1"
	DESTDIR="$2"
	PREFIX="$3"

	CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")
	DESTFILENAME="${PREFIX}_${DBNAME}_${CURRENT_DATETIME}.sql"

	pg_dump "$DBNAME" > "${DESTDIR}/${DESTFILENAME}"
	xz "${DESTDIR}/${DESTFILENAME}"
fi
