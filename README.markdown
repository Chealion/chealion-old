#Chealion.git

Web Page: [chealion.ca](http://chealion.ca)

Various Code Snippets and projects that don't deserve their own Github repository by Micheal Jones.

Please feel free to submit patches or request that one of the projects be forked (or made available to fork as it's own project)
 
Everything here is available under an MIT License, but if you'd let me know where or how you used it I wouldn't mind. It's nice to know something I created isn't just languishing.

------------------

## File Listing

	AppleScripts
		CurrentPlayingTrack
			CurrentPlayingTrack.scpt
				Applescript takes the current playing track in iTunes and
				displays it using Growl. More a proof of concept than anything
				but plays nice with LaunchBar when I'm in the middle of a song.

		Signatures
			Signature Creating AppleScript, answer some AppleScript questions and
			fills out a pre-made HTML signature and installs for Mail or
			Thunderbird. See README.markdown found in folder for more details.

		TabCountGrowl
			tabcounttogrowl.scpt
				AppleScript to take the current number of open tabs in Safari
				and send it to Growl. Great for when I have more tabs open then
				I can count. (eg. the >> appears in Safari)


	Custom
		Rumpus
			A mix of different technologies to create FTP accounts in Rumpus 5. It
			uses PHP for the web app, a simple Cocoa app for the user end, and
			Python for the actual script itself. It was largely a learning project
			to learn how to script using Python and some super basic Cocoa.


	Dashboard
		logo.wdgt - A super simple widget with the express purpose of showing logo.jpg
		that will resize proportionally without any borders or anything similar.


	Flickr
		flickrInfo.sh
			Shell Script to scrape a screen capture of your Flickr stats or a set
			to your computer. Requires webkit2png.
		<to be added: launchd plist>


	LockedDVD
		openLockedDVD.scpt
			AppleScript to open and copy a locked DVD created by Sony DVD Recorders


	QuickLook
		CSVQL
			A really, really simply QuickLook generator that will display .csv
			files. It's super basic and there's bound to be a better way because it
			just reads the text files and spits it out in a <code><pre> tag set for
			HTML viewing with some super basic CSS.


	Shell
		bashrc
			My .bashrc file - includes functions to show the top 5 memory "hogs"
			running along with a backup with date fuction (great for backing up
			configuration files)

		code2html.sh
			Shell Script to use enscript to create an HTML document of a piece of
			code.

		code2pdf.sh
			Shell Script to use enscript and ps2pdf to create a PDF of code. Was
			used to take code and convert it to a PDF so I could then print it on a
			printer at University. Requires Ghostscript to be installed as ps2pdf
			is not in the default Mac OS X installation.

		gitconfig
			My .gitconfig file

		gitignore
			My .gitignore file

		java.sh
			Shell Script to simplify jcr (Java Compile and run) of basic java
			applications.

		parentlock.sh
			Removes all .parentlock files from Camino, Firefox and any Thunderbird
			Profiles in ~/Library/ or ~/Library/Application Support

		passwordGen.py
			A simple password generator INCOMPLETE

		regex.py
			Simple python script to facilitate running regular expressions on the
			clipboard contents. My first Python script

		whatIsOpen.sh
			Lists what files are open on external disks (helps let you know why
			they will not eject). Best used in conjunction with Platypus' Text
			Window


	Web
		PHP
			BasicRedirect
				A super basic example of how to setup a page that requires a
				cookie to be present in order to view the site. This however
				does not redirect them back however as it's only present in
				index.php and is designed for use with Joomla.


	WebKitNightly
		nightly.sh
			Shell Script that retrieves the latest version of WebKit and installs
			it. Kind of useless now that they've implemented Sparkle.

------------------

##Submodules Used:

Webarchiver.git (Applescripts/Signatures) - [GitHub : paulwilliam : webarchiver](http://github.com/paulwilliam/webarchiver/tree/master)

------------------

The MIT License

Copyright (c) 2009 Micheal Jones

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.