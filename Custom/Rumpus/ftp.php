<?php

/*
Implementation Notes:

1) Check IP - if not local not an error saying off site creation is disabled.
2) JavaScript check on username onblur
3) Design for 640x480 window.
4) HTML Form
5) Spit back the output of the command in a special section
6) Check for $_GET["username"] if it exists in list of users.


FTP Creation Page
(c) 2009 Micheal Jones
*/

//If this has been submitted:
if(isset($_POST["submission"])) {
	//Do things for submission
	$emailAddress = $_POST["emailAddress"];
	$username = $_POST["username"];
	$password = $_POST["password"];
	$output = "";
	$return = 0;
	
	exec("/opt/local/bin/python2.5 /Volumes/MailRAID/websites/jmg/internalapps/rumpusAddUser.py $emailAddress $username $password", &$output, &$return);
}

if(isset($_GET["username"]))
	$username = $_GET["username"];
else
	$username = "";

$users = array("howardw", "iand", "mattg", "michealj", "mikes", "missyv", "reception", "support");


?>

<html>
	<head>
		<title>Joe Media FTP Creation</title>
		<script type="text/javascript">
			<!--
			var validUser = false;
			var validEmail = <?php echo ($username != "") ? 'true' : 'false' ?>;

			var k;
			if(window.XMLHttpRequest) {
				k = new XMLHttpRequest();
			}
			
			function checkInput() {
				
				if(validUser && validEmail) {
					var e = document.getElementById("ftp_creation");
					e.submit();
				}
				
				if(!validUser) {
					var e = document.getElementById("username");
					e.style.background = "#ff0000";
				}
				if(!validEmail) {
					var e = document.getElementById("email");
					e.style.background = "#ff0000";
				}
				
			}
			
			function toggleInstructions() {
				var e = document.getElementById("instructions");
				if(e.style.display == "block")
					e.style.display = "none";
				else
					e.style.display = "block";
			}
			
			function validateUsername() {
				var username = document.getElementById("username").value;
				
				if(window.ActiveXObject)
					k = new ActiveXObject("Microsoft.XMLHTTP");
				
				k.open("POST", "http://www.joemedia.tv/internalapps/checkUser.php?username=" + username);
				k.send(null);
				var e = document.getElementById("progressIndicator");
				e.style.display = "";
				k.onreadystatechange = function() {
					var exists = k.responseText;
					alert(exists);
					e = document.getElementById("username");
					var error = document.getElementById("error");
					if(!exists) {
						validUser = true;
						if(e.style.background != "")
							e.style.background = "";
						error.innerHTML = "";
					} else {
						validUser = false;
						e.style.background = "#ff0000";
						error.innerHTML = "Username already exists";
					}
				}
			}
			
			function validateEmail() {
				var email = document.getElementById("email");
				if(email.value != "") {
					validEmail = true;
					email.style.background = "";
				} else {
					validemail = false;
					email.style.background = "#ff0000";
				}
				
			}
			-->
		</script>
		<style type="text/css">
			body {
				height: 480px;
				width: 640px;
				padding:0;
				margin:0;
				font-family: "Segoe UI", "Candara", serif;
			}
			#box { 	border: 3px double #000;
					background: #ddd;
					margin: 2px;
					padding: 5px;
				}
			#header {
					font-weight: bold;
					font-size: 36px;
					text-align: center;
					margin: 0 0 15px 0;
					padding: 0;
				}
			#subheader {
					font-size: small;
					width: 300px;
					margin: 0 auto;
			}
			#instructions {
				display: none;
			}
			form {  width: 400px;
					margin: 0 auto;
					padding: 0;
			}
			label { 
					width: 4em;
					text-align: right;
					margin-right: 0.5em;
				}
			input {
					border: 1px solid #000;
			}
			.small {
					font-size: x-small;
			}
			#progressIndicator {
				display: none;
			}
			#error {
				display: none;
			}
			#copyright {
					font-size: small;
					text-align: center;
					margin-top: 15px;
					padding: 0;
			}
		</style>
	</head>
	<body>
		<div id="box">
			<div id="header">
				JOE: Media Group <br />FTP Creation
			</div>
			<div id="subheader">
				<strong>Instructions:</strong> <a href="#" onclick="toggleInstructions();"><span id="instruction" class="small">(Click to toggle instructions)</span></a><br />
				<ol>
					<div id="instructions">
					<li>Choose your email address to have the details sent to.</li>
					<li>Enter the desired Username. If this turns red, the username is not available</li>
					<li>Enter the desired password. If you leave this blank one will be automatically generated for you.</li>
					<li>Press Submit</li>
					</div>
				</ol>
			</div>
			<?php 
			
			if(isset($_POST["submission"]))
				print_r($output);
			
			?>
			<form id="ftp_creation" name="ftp" method="POST" action="">
				<table>
					<tr>
						<td><label>Your Email Address:</label></td>
						<td><select name="emailAddress" id="email" onmouseup="validateEmail();">
					
						<?php

							//Select Usernames
							if($username == "")
								echo "<option selected=\"selected\">Choose Email Address</option>";

							foreach($users as $user) {
								if($user == $username)
									echo "<option selected=\"selected\">$user</option>";
								else
									echo "<option>$user</option>";
							}

						?>
					
						</select></td>
						<td>@joemedia.tv</td>
					</tr>
					<tr><td><label>Username:</label></td>
						<td><input type="text" name="username" id="username" onblur="validateUsername();" /></td><td><img src="indicator.gif" id="progressIndicator" /><span id="error">ERROR TEXT</span></td>
					</tr>
					<tr>
						<td><label>Password:<br /><span class="small">(Leave blank to have one auto generated)</span></label></td>
						<td><input type="password" name="password" /></td><td></td>
					</tr>
					<tr><td></td><td>
							<input type="hidden" name="submission" value="true" />
							<input type="button" id="submitButton" onMouseUp="checkInput();" value="Create User" />
						</td><td></td></tr>
				</table>
			</form>
			<div id="copyright">
				&copy; 2009 - Version 1.0.0
			</div>
		</div>
	</body>
</html>
