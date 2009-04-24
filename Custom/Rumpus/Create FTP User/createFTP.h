//
//  createFTP.h
//  Create FTP User
//
//  Created by Micheal Jones on 04/13/09.
//  Copyright 2009 Micheal Jones. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebView.h>

@interface createFTP : NSObject {
	IBOutlet WebView *webView;
}

-(void)awakeFromNib;
-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)theApplication;


@end
