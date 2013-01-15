//
//  NSDictionaryAdditions.m
//  RingFinder
//
//  Created by Danny Morrow on 11/2/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "NSDictionaryAdditions.h"


// helper function: get the string form of any object
static NSString *toString(id object) 
{
	return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) 
{
	NSString *string = toString(object);
	return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (unitytheory)

-(NSString*) urlEncodedString 
{
	NSMutableArray *parts = [NSMutableArray array];
	for (id key in self) {
		id value = [self objectForKey: key];
		NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
		[parts addObject: part];
	}
	return [parts componentsJoinedByString: @"&"];
}

@end
