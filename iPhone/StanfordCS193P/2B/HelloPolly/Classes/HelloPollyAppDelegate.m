//
//  HelloPollyAppDelegate.m
//  HelloPolly
//
//  Created by Micheal Jones on 04/11/09.
//  Copyright Micheal Jones 2009. All rights reserved.
//

#import "HelloPollyAppDelegate.h"

@implementation HelloPollyAppDelegate

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
