//
//  UTImageView.m
//  RingFinder
//
//  Created by Daniel Morrow on 4/3/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import "UTImageView.h"


@implementation UTImageView

@synthesize image;
@synthesize quality;
@synthesize trans;
@synthesize previousScale;

-(UTImageView *) initWithImage:(UIImage *)img quality:(CGInterpolationQuality)qual
{
	//CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
	//NSLog(@"made utimageview");
	if (self = [super initWithImage:img])
	{
		[self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
		//self.image = img;
		self.quality = qual;
		self.trans = CGAffineTransformIdentity;
		self.previousScale = 1.0f;
		//self.contentMode = UIViewContentModeRedraw;
	}
	return self;
}

-(void) drawRect:(CGRect)rect
{
	if (self.image)
	{
		//NSLog(@"redraw");
		
		int width = rect.size.width;
		int height = rect.size.height;
		DLog(@"width:%i, height:%i", width, height);
		CGRect imageRect;
		
		if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown)
		{
			imageRect = CGRectMake(0, 0, width, height);
		}
		else 
		{
			imageRect = CGRectMake(0, 0, height, width);
		}
		//rect = CGRectApplyAffineTransform(rect, trans);
		//CGAffineTransform newTrans = CGAffineTransformScale(trans, 1.0f/previousScale, 1.0f/previousScale);
		
		//self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, imageRect.size.width, imageRect.size.height);
		
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		CGContextTranslateCTM(context, 0, height);
		CGContextScaleCTM(context, 1.0, -1.0);
		
		
		switch (image.imageOrientation) 
		{
			case UIImageOrientationLeft:
				CGContextRotateCTM(context, M_PI/2);
				CGContextTranslateCTM(context, 0, -width);
				break;
			case UIImageOrientationRight:
				CGContextRotateCTM(context, -M_PI/2);
				CGContextTranslateCTM(context, -height, 0);
				break;
			case UIImageOrientationDown:
				CGContextTranslateCTM(context, width, height);
				CGContextRotateCTM(context, M_PI);
				break;
			default:
				break;
		}
		
		CGContextSetInterpolationQuality(context, self.quality);
		CGContextDrawImage(context, imageRect, self.image.CGImage);
		//CGContextRelease(context);
	}

}

-(void) redrawAtScale:(float)newScale
{
	
	CGAffineTransform newTransform = CGAffineTransformScale(self.transform, 1.0f/newScale, 1.0f/newScale);
	[super setTransform:CGAffineTransformIdentity];
	self.frame = CGRectApplyAffineTransform(self.frame, newTransform);
	[self setNeedsDisplay];
}

-(void) setTransform:(CGAffineTransform)newValue
{
	[super setTransform:CGAffineTransformScale(newValue, 1.0f/previousScale, 1.0f/previousScale)];
}

-(void) setTransformWithoutScaling:(CGAffineTransform)newTransform
{
	[super setTransform:newTransform];
}



@end
