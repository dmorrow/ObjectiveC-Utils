//
//  UTImageView.h
//  RingFinder
//
//  Created by Daniel Morrow on 4/3/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCore/QuartzCore.h"


@interface UTImageView : UIImageView 
{
	UIImage *image;
	CGInterpolationQuality quality;
	CGAffineTransform trans;
	float previousScale;
}

-(UTImageView *) initWithImage:(UIImage *)img quality:(CGInterpolationQuality)qual;
//-(void) setTransformWithoutScaling:(CGAffineTransform)newTransform;
-(void) redrawAtScale:(float)newScale;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CGInterpolationQuality quality;
@property (nonatomic) CGAffineTransform trans;
@property (nonatomic) float previousScale;



@end
