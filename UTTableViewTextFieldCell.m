//
//  UTTableViewTextFieldCell.m
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTTableViewTextFieldCell.h"
#import "UTTableViewPListDataSource.h"


@implementation UTTableViewTextFieldCell

@synthesize textField			=	_textField;

- (void) drawView
{
	[super drawView];
	_textField = [[UITextField alloc] initWithFrame:CGRectZero];
	_textField.textAlignment = UITextAlignmentRight;
	_textField.delegate = self;
	_textField.adjustsFontSizeToFitWidth = TRUE;
	_textField.minimumFontSize = 12;
	[self addSubview:_textField];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.textLabel.backgroundColor = [UIColor clearColor];
	CGSize labelSize = [self.textLabel sizeThatFits:CGSizeZero];
	labelSize.width = MIN(labelSize.width, self.textLabel.bounds.size.width);
	
	
	CGRect textFieldFrame = self.textLabel.frame;
	
	textFieldFrame.origin.x = self.textLabel.frame.origin.x + MAX(kUTMinLabelWidth, labelSize.width) + kUTSpacing;
		
	if (!self.textLabel.text.length)
	{
		textFieldFrame.origin.x = self.textLabel.frame.origin.x;
	}
	 
	textFieldFrame.size.width = self.textField.superview.frame.size.width - textFieldFrame.origin.x - 2*self.textLabel.frame.origin.x;
	
	if (self.accessoryView)
	{
		textFieldFrame.size.width -= self.accessoryView.frame.size.width + 5;
	}
	
	self.textField.frame = textFieldFrame;
	 
}

- (void) setData:(NSDictionary *)d
{
	super.data = d;
	_textField.placeholder = [super.data valueForKey:@"Placeholder"];
	_textField.secureTextEntry = [[super.data valueForKey:@"IsSecure"] boolValue];
}

- (float) fixedTextPosition
{
	return 150;
}

#pragma mark -
#pragma mark textFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	//textField.textAlignment = UITextAlignmentLeft;
	
	if ([self.delegate respondsToSelector:@selector(cellDidBeginEditting:)])
	{
		[self.delegate cellDidBeginEditting:self];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.value = textField.text;
	//textField.textAlignment = UITextAlignmentRight;
	if ([self.delegate respondsToSelector:@selector(cellDidEndEditting:)])
	{
		[self.delegate cellDidEndEditting:self];
	}
}

- (void) setValue:(id)val
{
	[super setValue:val];
	[self updateText];
}

- (void) updateText
{
	self.textField.text = self.value;
}

-(UIResponder *) responder
{
	return self.textField;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if ([string isEqualToString:@"\n"])
	{
		[textField resignFirstResponder];
		[self textFieldDidEndEditing:textField];
		
		if ([self.delegate respondsToSelector:@selector(cellDidSubmit:)])
		{
			[self.delegate cellDidSubmit:self];
		}
		
		return FALSE;
		
	}
	return TRUE;
}


- (void) select
{
	[_textField becomeFirstResponder];
}


@end
