	#! /bin/bash
	
	#Find current revision
	currentRevision=`cat /Applications/WebKit.app/Contents/Resources/VERSION`
	
	#Get address
	#Download, find address
	address=`curl -s http://nightly.webkit.org/start/?current-revision=$currentRevision | grep 'WebKit-SVN-r[0-9]*' -o | head -n 1`
	
	#Remove extra line.
	
	#Abort if there is no update
	if [ "$address" == "" ]
	then
		echo "There is no update for WebKit available"
		exit
	fi
	
	#Append download address
	address='http://nightly.webkit.org/files/trunk/mac/'${address}'.dmg'
	
	echo "Downloading... $address"
	curl -s $address -o /tmp/WebKit.dmg
	#Mount Image
	hdid -readonly -quiet /tmp/WebKit.dmg
	
	echo "Copying..."
	#Copy to Applications
	revision=`cat /Volumes/WebKit/WebKit.app/Contents/Resources/VERSION`
	
	cp -RfL /Volumes/WebKit/* /Applications/ 2>/dev/null
	ls /Volumes/WebKit/
	
	echo "Cleaning up..."
	#Clean up
	hdiutil detach /Volumes/WebKit/ -quiet
	rm -rf /tmp/WebKit.dmg
	
	echo "Finished. (r$revision)"