#!/usr/bin/env bash

langue=$1
URLS=$2
lineno=1

while read -r URL
do
	aspirations=$(curl $URL -o ../aspirations/$langue-$lineno.html)
	lineno=$(expr $lineno + 1)
done < ../URLs/$URLS
