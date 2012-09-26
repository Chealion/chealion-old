# Strava Redirector from Cyclemeter

This downloads the linked GPX file and then creates a new email message to send it to upload@strava.com. I can take very little credit as this is mostly copy and paste sample code with some shell scripting I do actually know how to do.

It will try three times to download the GPX file; I've found it fails at times. Currently it puts up a dialog box.

## Instructions

This is based on the following assumptions:
  - You are using Cyclemeter to automatically send you emails to the same email address you have set up with Strava when you're done
  - You have put the GPX URL in the email using the Settings on Cyclemeter

  1. Set up Cyclemeter to send the GPX URL to your email account
  2. Install the .scpt file in ~/Library/Application Scripts/com.apple.mail/ if on Mountain Lion. If on Lion or earlier it matters less but this script has only been tested on 10.8
  3. Create a rule based on the Subject line begining with Cyclemeter Cycle and have it run the StravaRedirect AppleScript
  4. If necessary add your email account to the .scpt file if you have multiple email addresses and your preferences are set to last used mail box. (Check your sent messages to figure out what email address it was sent from)

## Troubleshooting

Check the Console for what error is occuring; search for AppleScript.
Is it sending from the email address you use for Strava?
Click on the .gpx URL in the email; does it 404 in your browser? If so, just send it manually from Cyclemeter.

