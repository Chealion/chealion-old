//
//  HelloStanfordAppDelegate.m
//  HelloStanford
//
//  Created by Micheal Jones on 04/06/09.
//  Copyright Joe Media Group 2009. All rights reserved.
//

#import "HelloStanfordAppDelegate.h"

@implementation HelloStanfordAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
