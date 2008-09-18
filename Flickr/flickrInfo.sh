#! /bin/bash

cd /Users/micheal/Pictures/flickr/
# Check web connectivity TODO

# webkit2png - scrapes my Interestingness, Stats and most viewed pages. Uses the cookies from Safari - so make sure you're logged in with Safari.
python /Users/micheal/ShellScripts/webkit2png http://www.flickr.com/photos/chealion/sets/72157594466301744/ -F --filename=set -d

python /Users/micheal/ShellScripts/webkit2png http://www.flickr.com/photos/chealion/stats/ -F --filename=stats -d

python /Users/micheal/ShellScripts/webkit2png http://www.flickr.com/photos/chealion/popular-views/ --filename=pop -d -F

filebase=`date "+%Y%m%d"`

#If optipng is installed this will compress the png from webkit2png 
/usr/local/bin/optipng -log optilog.log -o 5 -q $filebase*