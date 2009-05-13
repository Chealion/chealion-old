#! /bin/bash

# Based off my WebKit nightly script (now defunct as WebKit uses Sparkle)
# Copyright 2009 Micheal Jones
# Software License: Do whatever you want.

#Find current revision
currentRevision=`/usr/libexec/PlistBuddy -c 'Print :SVNRevision' /Applications/Chromium.app/Contents/Info.plist`

#Get latest revision
latestRevision=`curl -s http://build.chromium.org/buildbot/snapshots/sub-rel-mac/LATEST`

#Abort if there is no update
if [ $latestRevision -le $currentRevision ]
then
	echo "There is no update for Chromium available"
	exit
fi

#Append download address
address='http://build.chromium.org/buildbot/snapshots/sub-rel-mac/'${latestRevision}'/chrome-mac.zip'

echo "Downloading... $address"
curl -s $address -o /tmp/chrome.zip

#Unzip
unzip /tmp/chrome.zip 1>/dev/null

echo "Copying..."
#Copy to Applications
revision=`/usr/libexec/PlistBuddy -c 'Print :SVNRevision' /Applications/Chromium.app/Contents/Info.plist`

cp -RfL /tmp/chrome-mac/Chromium.app /Applications/ 2>/dev/null

echo "Cleaning up..."
#Clean up
rm -rf /tmp/chrome*

echo "Finished. (r$revision)"