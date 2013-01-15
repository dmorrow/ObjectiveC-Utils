//
//  untitled.m
//  RingFinder
//
//  Created by Daniel Morrow on 4/14/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import "UTSingleton.h"

static id sharedInstance = nil;


@implementation UTSingleton


#pragma mark singleton functions
+ (id)instance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
			sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;
}

/*
- (id)retain 
{
    return self;
}

- (unsigned)retainCount 
{
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release 
{
    //do nothing
}

- (id)autorelease 
{
    return self;
}

- (void)dealloc
{

	[super dealloc];
}
*/

@end
