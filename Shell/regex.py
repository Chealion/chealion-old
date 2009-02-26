#! /usr/bin/env python
# Super basic script to grab the clipboard and run some regexes on it.
# My first Python script.
# pbpaste | python regex.py| pbcopy

import sys, re

#Grab input from stad in
input=""
lines = sys.stdin.readlines()
for line in lines:
	input += line

#Regular Expressions
output = re.sub("old","new",input)
output = re.sub("busted","shiny", output)

print(output)