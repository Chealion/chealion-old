#! /bin/bash
# Removes .parentlock files from all Thunderbird and Camino Profiles folders
exec 2>/dev/console
rm -f ~/Library/Thunderbird/Profiles/*.default/.parentlock
rm -f ~/Library/Application\ Support/Thunderbird/Profiles/*.default/.parentlock
rm -f ~/Library/Application\ Support/Camino/.parentlock

/usr/bin/osascript <<-EOF
	tell application "parentlock"
	display dialog "Removed .parentlock files."
	end tell
EOF