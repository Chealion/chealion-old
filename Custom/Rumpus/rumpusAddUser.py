"""rumpusAddUser.py

This program adds a user to the Rumpus Database.

Usage: /opt/local/bin/python2.5 rumpusAddUser.py "Email Address" "USERNAME" "PASSWORD"
or
Usage: rumpusAddUser.py --check "USERNAME"

# Takes the following arguments:
# $1 = Your Email Address
# $2 = Username
# $3 = Password

# Error Codes
# 1 Argument Error
# 2 User already exists
# 3 Unable to reload Database

Made for Python 2.5.4

Version History:

1.1.6		Fix issue with submitting with a password would fail.
1.1.5		Add version output
			Fix spacing of email
			Fix login links for website (namely add it)
1.1.4		Remove phonetics
			Remove @, ? and &s from generated passwords
			Revise email (note: can not make auto login link - doesn't support GET)
1.1.3		Add printDetails for parsing in ftp.php
1.1.2		Fix password spacing
			Fix missing "/" at end of paths causing broken accounts
1.1.1		Fix bcc support
1.1.0		Add --check mechanism
1.0.1		Add bcc to support@joemedia.tv
1.0.0		Initial Release

"""
version = "1.1.6"
__author__ = "Micheal Jones (michealj@joemedia.tv)"
__version__ = "$Revision: 1.1.6 $"
__date__ = "$Date: 2009/06/09 $"
__copyright__ = "Copyright (c) 2009 Micheal Jones"
__license__ = "BSD"

import sys
import os
import httplib
import smtplib
import random

########################

def displayVersion():
# Show version
	print version


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
# Check entries to see if user exists

	for user in users:
		user = user.split()
		if user[0] == username:
			return False
	
	return True

########################

def createPassword():
# Create a random password - modified from passwordGen.py
	password = ""
	
	#Create Dictionary
	sub_alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "2", "3", "4", "5", "6", "7", "8", "9", "~", "#", "$", "%", "^", "*", "-", "_", "."]
	
	for count in range(0,8):
		#Choose a random character
		character = random.randint(0, len(sub_alphabet) - 1)
		
		password += sub_alphabet[character]
	
	return password

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
	
	#Get login link
	websiteLoginLink = "http://www.DOMAIN HERE:8080/?login=" + username + ":" + password
	ftpLoginLink = "ftp://" + username + ":" + password + "@FTP_SITE_HERE"
	
	# **** CHANGE
	#Set up headers first
	message = "From: SENDING@ADDRESS\r\nSubject: FTP Account Created\r\nTo: " + email + "\r\n\r\n"
	
	message += """
Hi,

A new FTP account has been created on the  FTP server for you.

Your Username is: """ + username + """
Your Password is: """ + password + """

To access the files available for this account you may use one of the following options:

1) Use our website
	Use this link to access the Client Site and be logged in automatically: < """ + websiteLoginLink + """ >
	or
	Go to http://DOMAIN/ and click on the client login section on the top menu bar where you may enter your username and password.

2) Use a FTP client
	Use this link to log you in directly: < """ + ftpLoginLink + """ >
	or manually enter the following details:
	Server: FTP_SERVER
	Username and password from above	
	# Send the email - we are not handling any exceptions because of our static environment
	conn = smtplib.SMTP('MAIL SERVER HERE', '25')
	conn.sendmail('SENDING ADDRESS', [email, 'BCC EMAIL ADDRESS'], message)
	conn.quit()

########################

def printDetails(username, password):
# Write out details

 	print username + "\n" + password + "\n" + "\n afp://AFP_SERVEr/client_site/" + username

########################

def addEntry(CLIENT_PATH, username, password):
# ADD NEW ENTRY
	
	if password == "":
		password = createPassword()

	path = CLIENT_PATH + username + "/"

	user = username + "\t" + password + "\t" + path + "	YYYYYYYYNNN	0	0		N1	N16	N10	NBRR	P	N16	N-				.	\n"
	
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
	SERVER = "SERVER_DOMAIN"
	PORT = "8080"
	RELOAD_URL = "/reloadUserDB" #SERVER_DOMAIN/RELOAD_URL
	CLIENT_PATH = "/PATH/TO/WHERE/THE/FOLDERS/ARE/STORED"
	
	#Check if arguments are valid
	
	if argv[1] == "--version":
		displayVersion()
		exit(0)
	
	if len(argv) < 3:
		usage(1)
		exit(1)
	elif len(argv) < 4:
		argv.append("")
	
	EMAIL = argv[1] + "@DOMAIN"
	username = argv[2]
	password = argv[3]

	os.chdir(CLIENT_PATH)
	users = []
	users = readEntries(RUMPUS_PATH)
	
	#Checking mechanism
	if argv[1] == "--check":
		if checkEntries(users, argv[2]) == False:
			print "User Exists"
			exit(2)
		else:
			print "Valid Username"
			exit(0)

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
	printDetails(username, password)

	
########################

if __name__ == '__main__':
	main(sys.argv)
