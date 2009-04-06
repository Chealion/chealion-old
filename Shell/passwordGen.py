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

__author__ = "Micheal Jones (michealj@joemedia.tv)"
__version__ = "$Revision: 1.0 $"
__date__ = "$Date: 2009/01/01 $"
__copyright__ = "Copyright (c) 2009 Micheal Jones"
__license__ = "BSD"

import sys
import os

########################

def main(argv):
	
	#Need to use getopt
	
	phoneticAlphabet = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliet", "kilo", "lima", "mike", "november", "oscar", "papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu"]
	sub_phoneticAlphabet = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel", "juliet", "kilo", "mike", "november", "papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu", "two", "three", "four", "five", "six", "seven", "eight", "nine", "Tilde", "At sign", "Hash", "Dollar sign", "Percent sign", "Caret", "Ampersand", "Asterisk", "Left Parenthesis", "Right Parenthesis", "Dash", "Underscore", "Plus sign", "Equals sign", "Left curly bracket", "Right curly brakcet", "Left square bracket", "Right square bracket", "Vertical line", "Backslash", "Colon", "Semicolon", "Quote", "Double Quote", "Less than symbol", "Greater than symbol", "Period", "Comma"]
	sub_alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "2", "3", "4", "5", "6", "7", "8", "9", "~", "@", "#", "$", "%", "^", "&", "*", "(", ")", "\[", "\]", "-", "_", "+", "=", "{", "}", "|", "\\", ":", ";", "'", "\"", "<", ">", ".", "\,"]


########################

if __name__ == '__main__':
	main(sys.argv[1:])