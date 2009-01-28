<?php
/* Add this very early on in your index.php - before anything is written to a buffer or
 outputted. */

/*Note: The && empty() statement is designed for Joomla if the person isn't linked directly to a page. This can be removed to access any page. Uncomment this if you want this.*/
//if(!isset($_COOKIE["age_check"]) && empty($_GET))
if(!isset($_COOKIE["age_check"])) {
	$url = $_SERVER["HTTP_HOST"] . $_SERVER["REQUEST_URI"];
	Header("Location: http://www.YOURDOMAIN.com/age_check.php?url=" . $url);
}
?>