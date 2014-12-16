//
//  UIView+Unitytheory.h
//  RingFinder
//
//  Created by Danny Morrow on 12/9/14.
//  Copyright (c) 2014 unitytheory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Unitytheory)

- (UIView*) subviewWithClassName:(NSString*)className orInherits:(BOOL)inherits;

@end
