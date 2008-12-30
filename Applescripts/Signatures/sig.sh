#! /bin/bash
# Uses ~/sigtmp because /tmp wasn't dependable with network users - theoretically it shouldn't matter.

mkdir -p ~/sigtmp/
rm -rf ~/sigtmp/sig.html;

echo "
<table id=\"signature\" style=\"margin:0;height: 125px; width: 280px; font: 10px Verdana, Arial, Helvetica, sans-serif;\">
<tr>
<td style=\"width: 110px; padding: 0 5px 10px; line-height:1.3em;\">
<div><strong>$1</strong></div>
<div>$2</div>
<div style=\"margin: 0; padding: 0;\"><a href=\"mailto:$3@yourdomain.com\">$3@yourdomain.com</a><br />
555.555.5555 <strong>T</strong><br />" >> ~/sigtmp/sig.html;

if [ "$4" != '0' ]; then
	echo "$4 <strong>D</strong><br />" >> ~/sigtmp/sig.html;
fi
if [ "$5" != '0' ]; then
	echo "$5 <strong>C</strong><br />" >> ~/sigtmp/sig.html;
fi

echo "555.555.5555 <strong>F</strong><br />
<a href=\"http://www.yourdomain.com\">www.yourdomain.com</a></div>
</td>
<td>
<img src=\"http://www.yourdomain.com/signature_logo.jpg\" alt=\"Logo\" width=\"106\" height=\"67\" style=\"margin: 4px;\" /><br />
ADDRESS <br />
ADDRESS 2
</td>
</tr>
<td colspan=\"2\"><img src=\"http:/www.yourdomain.com/signature_tag.jpg\" alt=\"Tagline\" width=\"250\" height=\"25\" /></td></tr>
</table>
" >> ~/sigtmp/sig.html;