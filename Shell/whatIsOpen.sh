#! /bin/bash
# Micheal Jones
# 10/20/08
# What's open on other volumes?
lsof -F n | grep '/Volumes/' | sed 's/n\/Volumes\///g'| sort -f
