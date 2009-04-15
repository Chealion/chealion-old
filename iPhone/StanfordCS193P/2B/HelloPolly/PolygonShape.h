//
//  PolygonShape.h
//  WhatATool
//
//  Created by Micheal Jones on 04/09/09.
//  Copyright 2009 Micheal Jones. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PolygonShape : NSObject {

	int numberOfSides;
	int minimumNumberOfSides;
	int maximumNumberOfSides;
	
}

+(id)PolygonShape;
-(id)init;
-(id)initWithNumberOfSides:(int)sides minimumNumberOfSides:(int)min maximumNumberOfSides:(int)max;
-(void)setNumberOfSides:(int)sides;
-(void)setMinimumNumberOfSides:(int)min;
-(void)setMaximumNumberOfSides:(int)max;
-(float)angleInDegrees;
-(float)angleInRadians;
-(NSString*)name;
-(void)awakeFromNib;
-(void)dealloc;

@property (assign) int numberOfSides;
@property (assign) int minimumNumberOfSides;
@property (assign) int maximumNumberOfSides;
@property (readonly) float angleInDegrees;
@property (readonly) float angleInRadians;
@property (readonly) NSString* name;

@end