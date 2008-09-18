#! /bin/sh

# Copy whatever is pasted to the clipboard. OS X only.
# Changes any : to / as it's designed for making POSIX paths.

echo $1 | sed 's/:/\//g' | pbcopy;