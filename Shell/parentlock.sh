#! /bin/bash
# Removes .parentlock files from all Thunderbird, Camino and Firefox Profiles folders
# Update 3/2/09: Version 1.1 : Add Firefox
# Platypus Settings: tv.joemedia.parentlock.app
# Output None (osascript notifies)
# 
exec 2>/dev/console
rm -f ~/Library/Thunderbird/Profiles/*.default/.parentlock
rm -f ~/Library/Application\ Support/Thunderbird/Profiles/*.default/.parentlock
rm -f ~/Library/Application\ Support/Camino/.parentlock
rm -f ~/Library/Application\ Support/Firefox/.parentlock

/usr/bin/osascript <<-EOF
	tell application "parentlock"
	display dialog "Removed .parentlock files."
	end tell
EOF