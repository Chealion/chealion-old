//
//  createFTP.m
//  Create FTP User
//
//  Created by Micheal Jones on 04/13/09.
//  Copyright 2009 Micheal Jones. All rights reserved.
//

#import "createFTP.h"
#import <WebKit/WebView.h>

@implementation createFTP

-(void)awakeFromNib {
	NSString *username = [[NSString alloc] initWithString:@"http://www.joemedia.tv/internalapps/ftp.php?secret=secret&username="];
	NSString *createURL = [username stringByAppendingString:NSUserName()];
	
	//NSLog(@"%@", createURL);
	//Has a non-warning that I don't know how to fix.
	[webView setMainFrameURL:createURL];
	
	[username release];
}

@end
