#! /bin/bash
# Removes .parentlock files from all Thunderbird Profiles folders
rm -f ~/Library/Thunderbird/Profiles/*.profile/.parentlock
rm -f ~/Library/Application\ Support/Thunderbird/Profiles/*.profile/.parentlock