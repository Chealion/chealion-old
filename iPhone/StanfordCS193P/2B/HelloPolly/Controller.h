#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PolygonShape.h"

@interface Controller : NSObject {
    IBOutlet UIButton *decreaseButton;
    IBOutlet UIButton *increaseButton;
    IBOutlet UILabel *numberOfSidesLabel;
	IBOutlet UILabel *polygonName;
	IBOutlet UILabel *polygonMaxSides;
	IBOutlet UILabel *polygonMinSides;
	IBOutlet UILabel *polygonRadians;
	IBOutlet UILabel *polygonDegrees;
	IBOutlet PolygonShape *polygon;
}
- (IBAction)decrease;
- (IBAction)increase;
- (void)updateInterface;
- (void)awakeFromNib;
@end
