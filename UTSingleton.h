//
//  untitled.h
//  RingFinder
//
//  Created by Daniel Morrow on 4/14/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTSingleton : NSObject {

}

+ (id)instance;
- (id)retain; 
- (unsigned)retainCount;
- (void)release;
- (id)autorelease;
- (void)dealloc;


@end
