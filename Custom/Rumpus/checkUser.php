<?php

$username = $_GET["username"];

// **** CHANGE
exec("/PATH/TO/PYTHON/python /PATH/TO/rumpusAddUser.py --check $username", &$output, &$return);

if($return == 0)
	echo "false";
else
	echo "true";

?>