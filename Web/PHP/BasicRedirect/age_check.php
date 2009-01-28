<?php
//Incorrectly coming to said page.
if(isset($_COOKIE["age_check"]))
	Header( "Location: http://www.YOURDOMAIN.com/index.php");

//If they've confirmed send them back with the cookie set.
if(isset($_POST["age_check"])) {	
	$yearFromNow = 60 * 60 * 24 * 365 + time();
	setcookie("age_check", "true", $yearFromNow);
	Header("Location: " . $_POST["url"]);
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>AGE CHECK PAGE</title>
</head>

<body>
	<form action="age_check.php" method="post">
		<input type="hidden" name="age_check" value="true" />
		<input type="hidden" name="url" value="<?php echo $_GET["url"]; ?>">
		<!-- Feel free to change the submit to an image - customize your form per your design -->
		<input type="submit" value="I am 18." />
		<a href="http://www.google.ca">I am Not 18</a></form>
</body>
</html>
