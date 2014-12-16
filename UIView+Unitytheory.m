//
//  UIView+Unitytheory.m
//  RingFinder
//
//  Created by Danny Morrow on 12/9/14.
//  Copyright (c) 2014 unitytheory. All rights reserved.
//

#import "UIView+Unitytheory.h"

@implementation UIView(Unitytheory)

- (UIView*) subviewWithClassName:(NSString*)className orInherits:(BOOL)inherits
{
    for (UIView *subview in self.subviews)
    {
        if ((inherits && [subview isKindOfClass:NSClassFromString(className)]) || (!inherits && [subview isMemberOfClass:NSClassFromString(className)]))
        {
            return subview;
        }
        else
        {
            UIView* subviewFound = [subview subviewWithClassName:className orInherits:inherits];
            if (subviewFound) return subviewFound;
        }
    }
    return  nil;
}

@end
