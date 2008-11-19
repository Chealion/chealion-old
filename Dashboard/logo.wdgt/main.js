var existingWidth;
var existingHeight = 0;
var growboxInset;
 
function mouseDown(event) {
 	//Set existing height and width.
	existingHeight = window.innerHeight;
	existingWidth = window.innerWidth;
    document.addEventListener("mousemove", mouseMove, true);
    document.addEventListener("mouseup", mouseUp, true);
 
    growboxInset = {x:(window.innerWidth - event.x), y:(window.innerHeight - event.y)};
 
    event.stopPropagation();
    event.preventDefault();
}
 
function mouseMove(event) {
    var x = event.x + growboxInset.x;
    var y = event.y + growboxInset.y;

	//Manipulate so movement is proportional
	if(event.x > event.y)
		y = x * existingHeight / existingWidth;
	else
		x = y * existingWidth / existingHeight;
	
	//w/h = w'/h'
	//w' = h' * w / h
	//h' = w' * h / w
    document.getElementById("resize").style.top = (y-12);
    window.resizeTo(x,y);
 
    event.stopPropagation();
    event.preventDefault();
}
 
 
function mouseUp(event) {
    document.removeEventListener("mousemove", mouseMove, true);
    document.removeEventListener("mouseup", mouseUp, true);
 
    event.stopPropagation();
    event.preventDefault();
}
