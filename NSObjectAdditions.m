//
//  NSObjectAdditions.m
//  RingFinder
//
//  Created by Danny Morrow on 11/16/12.
//  Copyright (c) 2012 unitytheory. All rights reserved.
//

#import "NSObjectAdditions.h"

@implementation NSObject(unitytheory)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	int64_t delta = (int64_t)(1.0e9 * delay);
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}


@end
