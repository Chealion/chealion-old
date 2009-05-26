#!/bin/sh

# Get Mac Addresses, add missing 0s, only grab the first 8 characters, change to dashes and uppercase
arp -a | awk {'print toupper($4)'} | sed 's/^[0-9A-F]:/0&/g' | sed 's/:\([0-9A-F]\):/:0\1:/g' | cut -c 1-8 | sed 's/:/-/g' > /tmp/arp.txt

for line in `cat /tmp/arp.txt`
	do
	company=`grep $line /Users/michealj/Desktop/oui.txt`
	echo $line '=' $company
done

rm /tmp/arp.txt