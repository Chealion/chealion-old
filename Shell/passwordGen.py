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
__version__ = "$Revision: 1.0.0 $"
__date__ = "$Date: 2009/06/29 $"
__copyright__ = "Copyright (c) 2009 Micheal Jones"
__license__ = "BSD"

import sys
import os
import random
import getopt

########################

def usage(error):
# Show Usage
	print error, "\n\nUsage: python passwordGen.py\n\n-l Length of Passwords\n-n Number of Passwords to Create\n-s Simple (Only Alphanumeric)\n-c Complex (Includes ambiguous characters eg. 1,l,o,0,O, etc.)\n\nSample Usage:\npython passwordGen.py -l 10 -n 5 -s\nhu&89Jki38\nhotel - uniform - Ampersand - eight - nine - JULIET - kilo - india - three - eight\n\n"


########################

def createPassword(length, complexity):
# Create a random password
# Length: Length of Password
# Complexity { '0' : Normal, '1' : Simple, '2' : Complex}
	if length < 0:
		exit(0)

	password = ""
	phonetics = ""

	#Create Dictionaries
	phoneticAlphabet = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "juliet", "kilo", "mike", "november", "papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu", "ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO", "FOXTROT", "GOLF", "HOTEL", "JULIET", "KILO", "MIKE", "NOVEMBER", "PAPA", "QUEBEC", "ROMEO", "SIERRA", "TANGO", "UNIFORM", "VICTOR", "WHISKEY", "XRAY", "YANKEE", "ZULU", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
	symbolPhonetics = ["Tilde", "At sign", "Hash", "Dollar sign", "Percent sign", "Caret", "Ampersand", "Asterisk", "Dash", "Underscore", "Period"]
	complexPhonetics = ["india", "INDIA", "lima", "one", "oscar", "OSCAR", "zero"]
	alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "2", "3", "4", "5", "6", "7", "8", "9"]
	symbolAlphabet = ["~", "@", "#", "$", "%", "^", "&", "*", "-", "_", "."]
	complexAlphabet = ["i", "I", "l", "1", "o", "O", "0"]
	
	if complexity == 0:
		phoneticAlphabet.extend(symbolPhonetics)
		alphabet.extend(symbolAlphabet)
	elif complexity == 2:
		symbolPhonetics.extend(complexPhonetics)
		phoneticAlphabet.extend(symbolPhonetics)
		symbolAlphabet.extend(complexAlphabet)
		alphabet.extend(symbolAlphabet)

	for count in range(0,length):
		#Choose a random character
		character = random.randint(0, len(alphabet) - 1)

		password += alphabet[character]
		phonetics += phoneticAlphabet[character] + " "

	return password, phonetics


########################

def main(argv):
	
	#Need to use getopt
	try:
		opts, args = getopt.getopt(argv, 'schl:n:')
	except getopt.GetoptError, err:
		usage(err)
		sys.exit(2)
	
	length = 8
	complexity = 0
	iterations = 1
	
	for o, a in opts:
		if o == "-l":
			length = int(a)
		elif o == "-n":
			iterations = int(a)
		elif o == "-s":
			complexity = 1
		elif o == "-c":
			complexity = 2
		elif o == "-h":
			usage('')
			sys.exit()
		else:
			assert False
	
	for i in range(0, int(iterations)):
		password = createPassword(length, complexity)
		phonetics = password[1]
		password = password[0]
		print "\nPassword:  " + password + "\nPhonetic:  " + phonetics + "\n"
	

########################

if __name__ == '__main__':
	main(sys.argv[1:])