#!/usr/bin/env bash

langue=$1
lineno=1
FICHIER="../dumps-text/$1-$lineno.txt"

#Si le premier argument n'est pas un fichier
if [ $# -ne 1 ]
then
    echo "un argument attendu exactement"
    exit 1
fi

cat "$FICHIER" | grep -P -o "\p{Latin}+" | tr "[:upper:]" "[:lower:]" | tr "É" "é" | sort | uniq -c | grep -P "santé" | grep -P -o "[[:digit:]]+"