//
//  UTScrollView.m
//  RingFinder
//
//  Created by Daniel Morrow on 4/16/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import "UTScrollView.h"


@implementation UTScrollView

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.dragging)
	{
		[self.nextResponder touchesEnded:touches withEvent:event];
	}
	
	[super touchesEnded:touches withEvent:event];
}

@end
