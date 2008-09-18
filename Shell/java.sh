#!/bin/bash

# Used as jcr (Java Compile and Run) shortcut.

if [ "$1" = "-y" ]
then
    rm ${2/.java}.class
fi
javac $2
cropped=${2/.java}
java $cropped
