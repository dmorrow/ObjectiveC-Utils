//
//  NSObjectAdditions.h
//  RingFinder
//
//  Created by Danny Morrow on 11/16/12.
//  Copyright (c) 2012 unitytheory. All rights reserved.
//

@interface NSObject (unitytheory)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;


@end
