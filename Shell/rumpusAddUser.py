"""rumpusAddUser.py

This program adds a user to the Rumpus Database.

Usage: rumpusAddUser.py "Email Address" "USERNAME" "PASSWORD"

# Takes the following arguments:
# $1 = Your Email Address
# $2 = Username
# $3 = Password

# Error Codes
# 1 Argument Error
# 2 User already exists
# 3 Unable to reload Database

Made for Python 2.6.1

Version History:

1.0.1		Add bcc to support@DOMAIN
1.0.0		Initial Release

"""

__author__ = "Micheal Jones (michealj@joemedia.tv)"
__version__ = "$Revision: 1.0.1 $"
__date__ = "$Date: 2009/04/06 $"
__copyright__ = "Copyright (c) 2009 Micheal Jones"
__license__ = "BSD"

import sys
import os
import httplib
import smtplib
import random

########################

def usage(error):
# Show Usage
	print "Usage: rumpusAddUser.py \"CREATOR EMAIL\" \"USERNAME\" \"PASSWORD\"\n\n"
	
	if error == 1:
		print "Not Enough Arguments - Missing Username and Password?"
	else:
		print "User already exists - aborting."

########################

def readEntries(RUMPUS_PATH):
# READ ENTRIES INTO LIST
	#Open File with rU for universal line endings
	f = open(RUMPUS_PATH, 'rU')
	
	users = f.readlines()
		
	f.close()
	return users
	
########################

def checkEntries(users, username):
# Check entries

	for user in users:
		user = user.split()
		if user[0] == username:
			return False
	
	return True

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

def makeFolder(PATH):
# Create containing folder at PATH if it doesn't exist.
	if os.path.isdir(PATH) == True:
		print "WARNING: Folder already exists"
		return
	os.mkdir(PATH)

########################

def emailUser(email, username, password):
# Email whomever made the account with the account details
	
	#Split list
	phonetics = password[1]
	password = password[0]
	
	#Set up headers first
	message = "From: support@DOMAIN\r\nSubject: FTP Account Created\r\nBcc: support@DOMAIN\r\nTo: " + email + "\r\n\r\n"
	
	message += "The account has been successfully created.\n\n Username: " + username + "\n Password:  " + password + "\n Phonetic: " + phonetics + "\n\n URLS\n======\n" + "FTP Connection: ftp://" + username + ":" + password + "@FTP_SERVER \n Website: http://DOMAIN:8080/Login \n Local Connection: afp://LOCAL_SERVER/" + username
	
	# Send the email - we are not handling any exceptions because of our static environment
	conn = smtplib.SMTP('MAIL_SERVER', '25')
	conn.sendmail('support@DOMAIN', email, message)
	conn.quit()

########################

def addEntry(CLIENT_PATH, username, password):
# ADD NEW ENTRY
	
	if password == "":
		password = createPassword()
	else:
		password = (password, "")
	path = CLIENT_PATH + username

	user = username + "\t" + password[0] + "\t" + path + "	YYYYYYYYNNN	0	0		N1	N16	N10	NBRR	P	N16	N-				.	\n"
	
	return user, password

########################

def sortEntries(users):
# SORT ENTRIES

	#Sort Users
	users.sort(key=lambda x: x.lower())
	return users

########################

def writeEntries(users, RUMPUS_PATH):
# WRITE ENTRIES INTO FILE
	f = open(RUMPUS_PATH, 'w')
	for userline in users:
		f.write(str(userline))
	
	f.close()

########################

def reloadURL(SERVER, PORT, RELOAD_URL):
# RELOAD THE RUMPUS DATABASE
	conn = httplib.HTTPConnection(SERVER, PORT)
	conn.request('GET', RELOAD_URL)
	
	reloadSuccess = conn.getresponse()
	
	if reloadSuccess.read() != "User Database Reloaded":
		print "Unable to reload database"
		exit(3)
	
	conn.close()

########################

def main(argv):
	RUMPUS_PATH = "/usr/local/Rumpus/Rumpus.users"
	SERVER = "DOMAIN"
	PORT = "8080"
	RELOAD_URL = "/reloadUserDB"
	CLIENT_PATH = "LOCAL_PATH"
	
	#Check if arguments are valid
	if len(argv) < 3:
		usage(1)
		exit(1)
	elif len(argv) < 4:
		argv.append("")
	
	EMAIL = argv[1]
	username = argv[2]
	password = argv[3]

	os.chdir(CLIENT_PATH)
	users = []
	users = readEntries(RUMPUS_PATH)

	if checkEntries(users, username) == False:
		usage(2)
		exit(2)
	makeFolder(CLIENT_PATH + username)
	user = addEntry(CLIENT_PATH, username, password)
	users.append(user[0])
	password = user[1]
	users = sortEntries(users)
	writeEntries(users, RUMPUS_PATH)
	reloadURL(SERVER, PORT, RELOAD_URL)
	emailUser(EMAIL, username, password)

	
########################

if __name__ == '__main__':
	main(sys.argv)
