#! /bin/bash

# Based off my WebKit nightly script (now defunct as WebKit uses Sparkle)
# Copyright 2009 Micheal Jones
# Software License: Do whatever you want.

#Find current revision

if [ -f '/Applications/Chromium.app/Contents/Info.plist' ]; then
	currentRevision=`/usr/libexec/PlistBuddy -c 'Print :SCMRevision' /Applications/Chromium.app/Contents/Info.plist`
else
	currentRevision=0
fi

#Get latest available revision
latestRevision=`curl -s http://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac/LAST_CHANGE`

#Use http://build.chromium.org/buildbot/snapshots/chromium-rel-mac/LATEST for the latest but not always available

#Abort if there is no update
if [ $latestRevision -le $currentRevision ]
then
	echo "There is no update for Chromium available"
	exit
fi

#Append download address
address='http://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac/'${latestRevision}'/chrome-mac.zip'

echo "Downloading... $address"
curl -sL $address -o /tmp/chrome.zip

#Abort if the build is not available
if [ "`head -n 3 /tmp/chrome.zip | tail -n 1`" = "<title>404 Not Found</title>" ];
then
	echo "Latest Version is not available yet (try again in a couple minutes)"
	#rm -rf /tmp/chrome-mac.zip
	exit
fi

#Unzip
cd /tmp
unzip /tmp/chrome.zip 1>/dev/null

echo "Copying..."
#Copy to Applications
mv /Applications/Chromium.app ~/.Trash/Chromium.app
cp -RfL /tmp/chrome-mac/Chromium.app /Applications/ 2>/dev/null

#If Chrome is installed we'll steal some support from it.

if [ -f '/Applications/Google Chrome.app/Contents/Info.plist' ]; then

	# Add PDF Plugin
	echo "Adding PDF Support From Chrome to Chromium"
	cp -RfL /Applications/Google\ Chrome.app/Contents/Versions/*/Google\ Chrome\ Framework.framework/Internet\ Plug-Ins/PDF.plugin /Applications/Chromium.app/Contents/Versions/*/Chromium\ Framework.framework/Internet\ Plug-Ins/

	#Add ffmpeg
	echo "Adding Chrome's ffmpeg support (H.264)"
	cp -RfL /Applications/Google\ Chrome.app/Contents/Versions/*/Google\ Chrome\ Framework.framework/Libraries/ffmpegsumo.so /Applications/Chromium.app/Contents/Versions/*/Chromium\ Framework.framework/Libraries/

fi

echo "Cleaning up..."
#Clean up
rm -rf /tmp/[Cc]hrome*

revision=`/usr/libexec/PlistBuddy -c 'Print :SCMRevision' /Applications/Chromium.app/Contents/Info.plist`

echo "Finished. (r$revision)"
