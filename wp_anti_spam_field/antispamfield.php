<?php
/*
Plugin Name: Anti Spam Field Plugin
Plugin URI: http://www.chealion.ca/tobedetermined
Description: Adds a simple field required to be filled out for when submitting a comment. Just asks for the present 4-digit year. If a spam attack is targeted at the specific site it'll do nothing but more likely the information will be bogus.
Version: 0.0.1
Author: Micheal Jones
Author URI: http://chealion.ca
*/

/*

ISSUES: NOT TELLING YOU THAT IT DIDN'T LIKE WHAT YOU ENTERED.

*/


add_action('comment_form', 'displayField');
add_action('comment_post', 'checkField');


//Need to use comment_post for checking
//Need to use comment_form to insert the check

function displayField($id) {
	global $user_ID;
	//If registered just exit
	if( $user_ID ) {
		return $id;
	}
	
	echo "<p><label for=\"antispamfield\">Please enter the <strong>current 4 digit year</strong> (eg. 1999):</label><input type=\"text\" name=\"antispamfield\" id=\"antispamfield\" /></p>";
}

function checkField($id) {
	global $user_ID;
	
	if( $user_ID ) {
		return $id;
	}

	if( $_POST["antispamfield"] == (date ( 'Y' )) ) {
		return $id;
	}

	wp_set_comment_status($id, 'delete');
	
	//Display error:
	echo "
	<html>
	    <head><title>Error Validating Anti-Spam-Field (Incorrect)</title></head>
		<body>
			<form name=\"data\" action=\"" . $_SERVER["HTTP_REFERER"] . "#respond\" method=\"post\">
				<input type=\"hidden\" name=\"author1\" value=\"" . htmlspecialchars($_POST["author"]) . "\" />
				<input type=\"hidden\" name=\"email1\" value=\"" . htmlspecialchars($_POST["email"]) . "\" />
				<input type=\"hidden\" name=\"url1\" value=\"" .  htmlspecialchars($_POST["url"]) . "\" />
				<textarea style=\"display:none;\" name=\"comment1\">" . htmlspecialchars($_POST["comment"]) . "</textarea>
				<input type=\"hidden\" name=\"antispamfield1\" value=\"" . htmlspecialchars($_POST["antispamfield"]) . " />
			</form>
			<script type=\"text/javascript\">
			<!--
			document.forms[0].submit();
			//-->
			</script>					
		</body>
	</html>";
}

?>