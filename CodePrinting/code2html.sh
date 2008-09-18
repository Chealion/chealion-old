#!/bin/bash

# Convert code to a html page.

if [ "$1" == "a" ]
then
	echo "Usage: code2html filename"
	exit
fi

enscript -GE -C --color -W html --output=$1.html $1;
tidy -asxhtml -cimq $1.html 2>/dev/null 1>/dev/null
