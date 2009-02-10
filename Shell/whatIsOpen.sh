#! /bin/bash
# Micheal Jones
# 10/20/08
# What's open on other volumes?
# Updated: 2/10/09 - Fixed false positives from folders simply called Volumes eg. /private/Network/Servers/*/Volumes/
#

lsof -F n | grep '^n/Volumes/' | sed 's/n\/Volumes\///g' | sort -f
