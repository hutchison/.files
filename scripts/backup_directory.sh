#!/usr/bin/env bash

# Exportiert das Verzeichnis $SOURCEDIR ($1) als .tar Datei
# in das Verzeichnis $DESTDIR ($2)
# mit dem Präfix $PREFIX ($3).

usage() {
	echo "$0 sourcedir destdir prefix"
	exit 1
}

if [[ $# -ne 3 ]]; then
	usage
else
	SOURCEDIR="$1"
	DESTDIR="$2"
	PREFIX="$3"

	CURRENT_DATETIME=$(date +"%Y%m%d_%H%M%S")
	PARENTDIR="$(dirname ${SOURCEDIR})"
	SOURCEDIRNAME="$(basename ${SOURCEDIR})"
	DESTFILENAME="${PREFIX}_${CURRENT_DATETIME}.tar"

	tar --create \
		--file "${DESTDIR}/${DESTFILENAME}" \
		--directory="${PARENTDIR}" \
		${SOURCEDIRNAME}
fi
