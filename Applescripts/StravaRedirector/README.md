# Strava Redirector from Cyclemeter

This downloads the linked GPX file and then creates a new email message to send it to upload@strava.com. I can take very little credit as this is mostly copy and paste sample code with some shell scripting I do actually know how to do.

## Instructions

This is based on the following assumptions:
  - You are using Cyclemeter to automatically send you emails to the same email address you have set up with Strava when you're done
  - You have put the GPX URL in the email using the Settings on Cyclemeter
  - It's not instant; upload@strava.com currently has up to 24 hour delays.

  1. Set up Cyclemeter to send the GPX URL to your email account
  2. Install the .scpt file in ~/Library/Application Scripts/com.apple.mail/ if on Mountain Lion. If on Lion or earlier it matters less but this script has only been tested on 10.8
  3. Create a rule based on the Subject line begining with Cyclemeter Cycle and have it run the StravaRedirect AppleScript

