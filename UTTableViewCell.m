//
//  UTTableViewCell.m
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTTableViewCell.h"


@implementation UTTableViewCell
@synthesize key		=	_key;
@synthesize value	=	_value;
@synthesize data	=	_data;
@synthesize delegate;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object 
{
	return tableView.rowHeight;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		[self drawView];
	}
	return self;
}

- (void) drawView
{
	
}

- (void) select
{
	

}

-(UIResponder *) responder
{
	return nil;
	
}

- (void) setValue:(id)val
{
	if (_value != val)
	{
		_value = val;
		if ([self.delegate respondsToSelector:@selector(valueDidChange:value:key:)])
		{
			[self.delegate valueDidChange:self value:val key:self.key];
		}
	}
	
}

- (UIViewController*) viewController 
{
	for (UIView* next = [self superview]; next; next = next.superview) 
	{
		UIResponder* nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]]) 
		{
			return (UIViewController*)nextResponder;
		}
	}
	return nil;
}

- (void) setData:(NSDictionary *)d
{
	if (_data != d)
	{
		_data = d;
		
		self.textLabel.text = [_data valueForKey:@"Title"];
		self.key = [_data valueForKey:@"Key"];

	}
}

- (void) dealloc
{
	self.delegate = nil;
	self.value = nil;
}



@end
