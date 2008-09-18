#!/bin/bash

# Convert code to a pdf.

if [ "$1" == "a" ]
then
	echo "Usage: code2pdf filename"
	exit
fi

enscript -GE -C -U2 --output=tmp.ps $1;
ps2pdf tmp.ps $1.pdf;
rm tmp.ps;
open $1.pdf;
