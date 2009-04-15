#import "Controller.h"

@implementation Controller
- (IBAction)decrease {

	int sides = [polygon numberOfSides];
	
	//Disable button if next press after this would not be valid
	if(sides-2 < [polygon minimumNumberOfSides])
		decreaseButton.enabled = NO;
	
	if(increaseButton.enabled == NO)
		increaseButton.enabled = YES;
	
	[polygon setNumberOfSides:sides-1];
	[self updateInterface];
}

- (IBAction)increase {

	int sides = [polygon numberOfSides];
	
	//Disable button if next press after this would not be valid
	if(sides+2 > [polygon maximumNumberOfSides])
		increaseButton.enabled = NO;
	
	if(decreaseButton.enabled == NO)
		decreaseButton.enabled = YES;
	
	[polygon setNumberOfSides:sides+1];
	[self updateInterface];
}

- (void)updateInterface {
	//Update number of sides
	NSString *numberOfSidesForLabel = [NSString stringWithFormat:@"%d", [polygon numberOfSides]];
	numberOfSidesLabel.text = numberOfSidesForLabel;
	//NSLog(@"%@", numberOfSidesForLabel);
	
	NSString *nameOfPolygon = [NSString stringWithFormat:@"%@", [polygon name]];
	NSString *maxSides = [NSString stringWithFormat:@"%d", [polygon maximumNumberOfSides]];
	NSString *minSides = [NSString stringWithFormat:@"%d", [polygon minimumNumberOfSides]];
	NSString *radians = [NSString stringWithFormat:@"%1.6f", [polygon angleInRadians]];
	NSString *degrees = [NSString stringWithFormat:@"%.1f", [polygon angleInDegrees]];
	
	polygonName.text = nameOfPolygon;
	polygonMaxSides.text = maxSides;
	polygonMinSides.text = minSides;
	polygonRadians.text = radians;
	polygonDegrees.text = degrees;

}

- (void)awakeFromNib {

	[polygon setMaximumNumberOfSides:12];
	[polygon setMinimumNumberOfSides:3];
	[polygon setNumberOfSides:5];
	[self updateInterface];
	
	NSLog(@"My polygon: %@", polygon);
}
@end
