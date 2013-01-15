//
//  NSStringAdditions.h
//  RingFinder
//
//  Created by Danny Morrow on 11/5/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (unitytheory)

- (NSDictionary *) urlParameterValues;
- (BOOL) validateEmail;
- (NSString*)md5HexDigest;

@end
