<?php

/*
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
	
	// **** CHANGE
	$cmd = "/PATH/TO/python2.5 /PATH/TO/rumpusAddUser.py \"$emailAddress\" \"$username\" \"$password\"";
	exec($cmd, &$output, &$return);
}

if(isset($_GET["username"]))
	$username = $_GET["username"];
else
	$username = "";

// **** CHANGE
$users = array("fill", "in", "user", "names", "here");


?>

<html>
	<head>
		<title>FTP Creation</title>
		<script type="text/javascript">
			<!--
			var validUser = false;
			var validEmail = <?php echo ($username != "") ? 'true' : 'false' ?>;

			var k;
			if(window.XMLHttpRequest) {
				k = new XMLHttpRequest();
			}
			
			function checkInput() {
				//In case username still has focus.
				validateUsername();
				
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
				var e = document.getElementById("progressIndicator");
				e.style.display = "block";
				var username = document.getElementById("username").value;
				
				if(window.ActiveXObject)
					k = new ActiveXObject("Microsoft.XMLHTTP");
				
				// **** CHANGE
				k.open("POST", "http://www.domain.com/path/to/checkUser.php?username=" + username);
				k.send(null);
				
				k.onreadystatechange = function() {
					if(k.readyState == 4) {
						var exists = k.responseText;
						e = document.getElementById("username");
						var error = document.getElementById("error");
						if(exists == "false") {
							validUser = true;
							if(e.style.background != "")
								e.style.background = "";
							error.innerHTML = "";
						} else {
							validUser = false;
							e.style.background = "#ff0000";
							error.innerHTML = "Username already exists";
						}
						e = document.getElementById("progressIndicator");
						e.style.display = "none";
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
					width: 640px;
					min-height: 480px;
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
			form {  width: 420px;
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
			#infoBox {
					text-align: center;
					margin: 5px auto;
					padding: 5px;
					border-width: 1px 0px 1px 0;
					border: solid #000;
					width: 430px;
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
				COMPANY NAME<br />FTP Creation
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
			
			if(isset($_POST["submission"])) {
				//We will show the details here in version 1.5.0 additionally have the Cocoa app automount the mail mount
				print "<div id=\"infoBox\">Created! Please check your email for the username and password details</div>";
			}
			
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
						<td><input type="text" name="username" id="username" onblur="validateUsername();" /></td><td><img src="indicator.gif" id="progressIndicator" /><span id="error" class="small"></span></td>
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
