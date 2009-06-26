"""passwordGen.py

This program generates a simple 8 character password containing numbers, symbols, uppercase and lower case letters.
Below it will display the NATO Phonetic output as well

Usage: paswordGen.py 

# Can take the following arguments:
# -l # (length of password)
# -n # (number of passwords to generate)
# -s (simple - no symbols)
# -c (complex - allow similar looking symbols - i, l, o, 1, 0, I)

Sample Usage:

# Make 5 passwords with 10 characters with no symbols.
passwordGen.py -l 10 -n 5 -s -c
hu&89Jki38
hotel - uniform - Ampersand - eight - nine - JULIET - kilo - india - three - eight

"""

__author__ = "Micheal Jones (chealion@chealion.ca)"
__version__ = "$Revision: 1.0 $"
__date__ = "$Date: 2009/06/26 $"
__copyright__ = "Copyright (c) 2009 Micheal Jones"
__license__ = "BSD"

import sys
import os
import random

########################

def usage(error):
# Show Usage
	print "Usage: passwordGen.py STUFF\n\n"
	

########################

def createPassword():
# Create a random password - modified from passwordGen.py
	password = ""
	phonetics = ""

	#Create Dictionaries
	sub_phoneticAlphabet = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "juliet", "kilo", "mike", "november", "papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu", "ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO", "FOXTROT", "GOLF", "HOTEL", "JULIET", "KILO", "MIKE", "NOVEMBER", "PAPA", "QUEBEC", "ROMEO", "SIERRA", "TANGO", "UNIFORM", "VICTOR", "WHISKEY", "XRAY", "YANKEE", "ZULU", "two", "three", "four", "five", "six", "seven", "eight", "nine", "Tilde", "At sign", "Hash", "Dollar sign", "Percent sign", "Caret", "Ampersand", "Asterisk", "Dash", "Underscore", "Period"]
	sub_alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "2", "3", "4", "5", "6", "7", "8", "9", "~", "@", "#", "$", "%", "^", "&", "*", "-", "_", "."]

	for count in range(0,8):
		#Choose a random character
		character = random.randint(0, len(sub_alphabet) - 1)

		password += sub_alphabet[character]
		phonetics += sub_phoneticAlphabet[character] + " "

	return password, phonetics


########################

def main(argv):
	
	#Need to use getopt
	
	password = createPassword()
	phonetics = password[1]
	password = password[0]
	print "\nPassword:  " + password + "\nPhonetic:  " + phonetics + "\n"

########################

if __name__ == '__main__':
	main(sys.argv[1:])