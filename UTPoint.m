//
//  UTPoint.m
//  RingFinder
//
//  Created by Daniel Morrow on 4/6/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import "UTPoint.h"


@implementation UTPoint

@end

float distanceBetweenPoints(CGPoint pa, CGPoint pb) {
    float deltaX = pa.x - pb.x;
    float deltaY = pa.y - pb.y;
    return sqrtf( (deltaX * deltaX) + (deltaY * deltaY) );
}

CGPoint midpointBetweenPoints(CGPoint pa, CGPoint pb) {
    CGFloat x = (pa.x + pb.x) / 2.0;
    CGFloat y = (pa.y + pb.y) / 2.0;
    return CGPointMake(x, y);
}