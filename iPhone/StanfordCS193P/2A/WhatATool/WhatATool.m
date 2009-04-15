#import <Foundation/Foundation.h>
#import "PolygonShape.h"

void PrintIntrospectionInfo() {
	NSMutableArray *multiObjects = [[NSMutableArray alloc] init];
	
	//Prep items
	NSArray *keys = [NSArray arrayWithObjects:@"Stanford University", @"Apple", @"CS193P", @"Stanford on iTunes U", @"Stanford Mail", nil];
	NSArray *objects = [NSArray arrayWithObjects:[NSURL URLWithString:@"http://www.stanford.edu"], [NSURL URLWithString:@"http://www.apple.com"], [NSURL URLWithString:@"http://cs193p.stanford.edu"], [NSURL URLWithString:@"http://itunes.stanford.edu"], [NSURL URLWithString:@"http://stanfordshop.com"], nil];
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	NSMutableString *mutableString = @"Mutable!";
	
	//Add Items to Array
	[multiObjects addObject:[NSURL URLWithString:@"http://chealion.ca"]];	//NSURL
	[multiObjects addObject:[NSString stringWithFormat:@"NSStrings are cool!"]]; //NSString
	[multiObjects addObject:[NSProcessInfo processInfo]];					//NSProcessInfo
	[multiObjects addObject:dictionary];									//NSDictionary
	[multiObjects addObject:keys];											//NSArray
	[multiObjects addObject:mutableString];									//NSMutableString
	
	
	for(id key in multiObjects) {
		
		//Bug the moment we have a true value...
		
		Class classType = [key class];
		BOOL member = [key isMemberOfClass:[NSString class]];
		BOOL kind = [key isKindOfClass:[NSString class]];
		BOOL responds = [key respondsToSelector:@selector(lowercaseString)];
		
		NSLog(@"Class Name:  %@", classType);
		NSLog(@"Is Member of NSString: %@", member ? @"YES" : @"NO");
		NSLog(@"Is Kind of NSString: %@", kind ? @"YES" : @"NO");
		NSLog(@"Responds to lowercaseString: %@", responds ? @"YES" : @"NO");
		if(responds)
			NSLog(@"lowercaseString is: %@", [key performSelector:@selector(lowercaseString)]);
		
		NSLog(@"======================================");
	}
	
	[multiObjects release];
}

void PrintBookmarkInfo() {

	NSArray *keys = [NSArray arrayWithObjects:@"Stanford University", @"Apple", @"CS193P", @"Stanford on iTunes U", @"Stanford Mail", nil];
	NSArray *objects = [NSArray arrayWithObjects:[NSURL URLWithString:@"http://www.stanford.edu"], [NSURL URLWithString:@"http://www.apple.com"], [NSURL URLWithString:@"http://cs193p.stanford.edu"], [NSURL URLWithString:@"http://itunes.stanford.edu"], [NSURL URLWithString:@"http://stanfordshop.com"], nil];

	NSMutableDictionary *bookmarks = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	
	for (id key in bookmarks)
	{
		if([key hasPrefix:@"Stanford"])
			NSLog(@"Key: '%@' URL: '%@'", key, [bookmarks objectForKey:key]);
	}

}

void PrintProcessInfo() {
	NSString *processName = [[NSProcessInfo processInfo] processName];
	int pid = [[NSProcessInfo processInfo] processIdentifier];
	
	NSLog(@"Process Name: '%@' Process ID: '%d'", processName, pid);
}

void PrintPathInfo() {
	NSString *path = @"~";
	path = [path stringByExpandingTildeInPath];
	NSArray *components = [[NSArray alloc] init];
	components = [path pathComponents];
	
	NSLog(@"My home folder is at '%@'", path);
	
	//Fast Enumeration
	for (NSString *component in components) {
		NSLog(@"%@", component);
	}
	NSLog(@"=====");
	[components release];
}

void PrintPolygonInfo() {	
	//Mutable Arrays
	NSMutableArray *polygons = [[NSMutableArray alloc] init];
	
	//Create Polygons and add them to array
	PolygonShape *small = [[PolygonShape alloc] initWithNumberOfSides:4 minimumNumberOfSides:3 maximumNumberOfSides:7];
	[polygons addObject:small];
	NSLog(@"%@", [small description]);
	
	PolygonShape *medium = [[PolygonShape alloc] initWithNumberOfSides:6 minimumNumberOfSides:5 maximumNumberOfSides:9];
	[polygons addObject:medium];
	NSLog(@"%@", [medium description]);
	
	PolygonShape *large = [[PolygonShape alloc] initWithNumberOfSides:12 minimumNumberOfSides:9 maximumNumberOfSides:12];
	[polygons addObject:large];
	NSLog(@"%@", [large description]);

	for(id polygon in polygons) {
		[polygon setNumberOfSides:10];
	}
	

	[small release];
	[medium release];
	[large release];
	[polygons release];
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    PrintPathInfo();
	PrintProcessInfo();
	PrintBookmarkInfo();
	PrintIntrospectionInfo();
	PrintPolygonInfo();
	
    [pool drain];
    return 0;
}
