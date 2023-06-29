#!/usr/bin/env bash

# Exportiert die Datenbank $DBNAME ($1) als SQL-Datei
# in das Verzeichnis $DESTDIR ($2)
# mit dem Präfix $PREFIX ($3).

# Damit die Datenbank exportiert werden kann, braucht der ausführende Nutzer
# $username Zugriff:
# sudo -u postgres psql $DBNAME
# $DBNAME=# GRANT CONNECT ON DATABASE database_name TO username;
# $DBNAME=# GRANT USAGE ON SCHEMA schema_name TO username;
# GRANT SELECT ON ALL TABLES IN SCHEMA schema_name TO username;
# GRANT SELECT ON ALL SEQUENCES IN SCHEMA schema_name TO username;

# Mittels "psql $DBNAME < $DESTFILENAME" kann diese importiert werden.
# Vorher muss die alte Datenbank gelöscht werden:
# $ drop_db $DBNAME
# $ sudo -u postgres createdb -O $USER $DBNAME

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
