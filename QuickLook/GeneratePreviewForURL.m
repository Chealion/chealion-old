#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#include <Cocoa/Cocoa.h>

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSURL* urlNS = (NSURL *)url;
	
	NSMutableString *html = [[[NSMutableString alloc] init] autorelease];
	[html appendString:@"<html><head></head><body><h1>"];
	[html appendString:[urlNS path]];
	[html appendString:@"</h1><code><pre>"];
	[html appendString:[NSString stringWithContentsOfFile:[urlNS path] encoding:NSUTF8StringEncoding error:nil]];
	[html appendString:@"</pre></code></html>"];
	
	NSLog(@"Source: %@", html);
	NSLog(@"URL: %@ %@", urlNS , [urlNS path]);
	
	CFDictionaryRef props = (CFDictionaryRef) [NSDictionary dictionary];
	
	QLPreviewRequestSetDataRepresentation(
	  preview,
	  (CFDataRef)[html dataUsingEncoding:NSUTF8StringEncoding],
	  kUTTypeHTML, 
	  props);
	
	[pool release];
	return noErr;
}

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}
