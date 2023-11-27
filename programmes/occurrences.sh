#!/usr/bin/env bash

langue=$1
lineno=$2
FICHIER="../dumps-text/$langue-$lineno.txt"

#Si le premier argument n'est pas un fichier
if [ $# -ne 2 ]
then
    echo "deux arguments attendus exactement"
    exit 1
fi

if [ $langue=="fr" ]
then 
	cat "$FICHIER" | grep -P -o "\p{Latin}+" | tr "[:upper:]" "[:lower:]" | tr "É" "é" | sort | uniq -c | grep -P "santé" | grep -P -o "[[:digit:]]+"

elif [ $langue=="ukr" ]
then
	cat "$FICHIER" | grep -P -o "\p{Cyrillic}+" | tr "[:upper:]" "[:lower:]" | sort | uniq -c | grep -P "Здоров'я" | grep -P -o "[[:digit:]]+"
	
elif [ $langue=="chin" ]
then
	cat "$FICHIER" | grep -P -o "\p{Latin}+" | tr "[:upper:]" "[:lower:]" | tr "É" "é" | sort | uniq -c | grep -P "santé" | grep -P -o "[[:digit:]]+"
fi
