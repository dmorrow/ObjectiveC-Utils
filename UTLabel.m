//
//  UTLabel.m
//  RingFinder
//
//  Created by Daniel Morrow on 4/27/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import "UTLabel.h"


@implementation UTLabel

@synthesize textBlock = _textBlock;
@synthesize x = _x, y=_y, width=_width, height=_height;

+(id) textLine:(NSString *)t font:(UIFont *)f x:(float)xPos y:(float)yPos
{
	if (f == nil) return nil;

	return [[self alloc] initWithText:t font:f x:xPos y:yPos width:0];

}

+(id) textBlock:(NSString *)t font:(UIFont *)f x:(float)xPos y:(float)yPos width:(float)w
{
	if (f == nil) return nil;
	return [[self alloc] initWithText:t font:f x:xPos y:yPos width:w];
}

-(id) initWithText:(NSString *)t font:(UIFont *)f x:(float)xPos y:(float)yPos width:(float)w
{
	if ((f != nil) && (self = [super initWithFrame:CGRectMake(xPos, yPos, (w>0) ? w : 1, 1)]))
	{
		self.numberOfLines = 0;
		self.lineBreakMode = NSLineBreakByWordWrapping;
		_textBlock = (w>0);
		self.font = f;
		self.text = t;
		self.backgroundColor = [UIColor clearColor];
		_initialized = TRUE;
		[self resize];
	}
	return self;
}

-(void) resize
{
	if (_initialized)
	{
		float w = (self.textBlock) ? self.frame.size.width : 1000;
		float h = (self.numberOfLines == 1) ? 1 : 1000;
		CGSize s = [self.text sizeWithFont:self.font 
						 constrainedToSize:CGSizeMake(w, h) 
							 lineBreakMode:self.lineBreakMode];
		if (self.textBlock) s.width = self.frame.size.width;
		//NSLog(@"size %f %f for %@", size.width, size.height, self.text);
		CGRect f = self.frame;
		f.size = s;
		self.frame = f;
	}
}

-(void) setFont:(UIFont *)f
{
	if (f!= nil)
	{
		[super setFont:f];
		[self resize];
	}
	
}

-(void) setText:(NSString *)t
{
	[super setText:t];
	[self resize];
}

-(void) setTextBlock:(BOOL)tb
{
	self.textBlock = tb;
	[self resize];
}

-(float) x
{
	return self.frame.origin.x;
}

-(float) y
{
	return self.frame.origin.y;
}

-(float) width
{
	return self.frame.size.width;
}

-(float) height
{
	return self.frame.size.height;
}

-(void) setX:(float) x
{
	CGRect f = self.frame;
	f.origin.x = x;
	self.frame = f;
}

-(void) setY:(float) y
{
	CGRect f = self.frame;
	f.origin.y = y;
	self.frame = f;
}

-(void) setWidth:(float) w
{
	CGRect f = self.frame;
	f.size.width = w;
	self.frame = f;
}

-(void) setHeight:(float) h
{
	CGRect f = self.frame;
	f.size.height = h;
	self.frame = f;
}

@end
