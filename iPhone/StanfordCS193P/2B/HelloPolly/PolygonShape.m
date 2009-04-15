//
//  PolygonShape.m
//  WhatATool
//
//  Created by Micheal Jones on 04/09/09.
//  Copyright 2009 Micheal Jones. All rights reserved.
//

#import "PolygonShape.h"


@implementation PolygonShape

@synthesize numberOfSides;
@synthesize minimumNumberOfSides;
@synthesize maximumNumberOfSides;

+ (id) PolygonShape {
	return [[[PolygonShape alloc] init] autorelease];
}

- (id) init {
	if(self = [super init]) {
		[self initWithNumberOfSides:5 minimumNumberOfSides:3 maximumNumberOfSides:9];
	}
	
	return self;
}

- (id)initWithNumberOfSides:(int)sides minimumNumberOfSides:(int)min 
	   maximumNumberOfSides:(int)max {
	
	[self setMinimumNumberOfSides:min];
	[self setMaximumNumberOfSides:max];
	[self setNumberOfSides:sides];
	
	return self;
}

-(void) setNumberOfSides:(int)sideInput {
	if(sideInput >= self.minimumNumberOfSides)
		if(sideInput <= self.maximumNumberOfSides)
			numberOfSides = sideInput;
		else {
			NSLog(@"Invalid number of sides: %d is less than the minimum of %d allowed.", sideInput, maximumNumberOfSides);
		}
	else {
		NSLog(@"Invalid number of sides: %d is less than the minimum of %d allowed.", sideInput, minimumNumberOfSides);
	}
	
}

-(void) setMinimumNumberOfSides:(int)sideInput {
	if(sideInput <= 2){
		NSLog(@"The minimum number of sides must be greater than 2..");
	} else
		minimumNumberOfSides = sideInput;
}

-(void) setMaximumNumberOfSides:(int)sideInput {
	if(sideInput > 12) {
		NSLog(@"The maximum number of sides must not be greater than 12.");
	} else
		maximumNumberOfSides = sideInput;
}

-(float) angleInDegrees {
	return (self.numberOfSides - 2) * 180 / (self.numberOfSides);
}

-(float) angleInRadians {
	return (self.numberOfSides - 2) * M_PI / (self.numberOfSides);
}

-(NSString*) name {
	NSArray *names = [NSArray arrayWithObjects:@"Triangle", @"Square", @"Pentagon", @"Hexagon", @"Heptagon", @"Octagon", @"Enneagon", @"Decagon",
					  @"Hendecagon", @"Dodecagon", nil];

	return [names objectAtIndex:(self.numberOfSides-3)];
}

-(NSString*) description {
	NSString *descriptionText = [NSString stringWithFormat:@"Hello I am a %d-sided polygon (aka a %@) with angles of %.1f degrees (%1.6f radians)", self.numberOfSides,
								 [self name], [self angleInDegrees], [self angleInRadians]];
	
	return descriptionText;
}

-(void) awakeFromNib {
}

-(void) dealloc {
	NSLog(@"Dealloc has been called!");
	
	[super dealloc];
}


@end
