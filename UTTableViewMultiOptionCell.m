//
//  UTTableViewMultiOptionCell.m
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTTableViewMultiOptionCell.h"


@implementation UTTableViewMultiOptionCell

@synthesize selectedIndex	=	_selectedIndex;

- (void) drawView
{
	[super drawView];
	self.textField.userInteractionEnabled = FALSE;
}

- (void) select
{
	if (_isOpen)
	{
		[self hidePicker];
	}
	else 
	{
		[self showPicker];
	}
}

- (void) setSelectedIndex:(int)idx
{
	if (_selectedIndex != idx)
	{
		_selectedIndex = idx;
		self.value = [[self.data objectForKey:@"Values"] objectAtIndex:idx];
	}
}




- (void) setValue:(id)val
{
	if (_value != val)
	{
		BOOL found = FALSE;
		for (id v in [self.data objectForKey:@"Values"])
		{
			if (v == val)
			{
				found = TRUE;
				self.selectedIndex = [[self.data objectForKey:@"Values"] indexOfObject:val];
			}
		}
		if (!found) self.selectedIndex = 0;
		[super setValue:[[self.data objectForKey:@"Values"] objectAtIndex:self.selectedIndex]];
	}
	
}

- (void) updateText
{
	self.textField.text = [[self.data objectForKey:@"Titles"] objectAtIndex:self.selectedIndex];
}



#pragma mark -
#pragma mark UIPickerView


//creates the actual picker
- (void)pickerWithDefault:(int)defaultRow
{
	if (!_pickerView)
	{
		_pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 261)];
		
		[[[UIApplication sharedApplication] keyWindow] addSubview:_pickerView];
		//create picker
		
		UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, 320, 161)];
		picker.delegate=self;
		picker.dataSource=self;
		picker.showsSelectionIndicator=YES;
		
		//if defaultstring is defined load the picker at that index.
		[picker selectRow:defaultRow inComponent:0 animated:NO];
		
		[_pickerView addSubview:picker];
		
		
		UIBarButtonItem *done = [[UIBarButtonItem alloc]
								 initWithTitle:@"Done"
								 style:UIBarButtonItemStyleBordered
								 target:self action:@selector(hidePicker)];
		UIBarButtonItem *flex = [[UIBarButtonItem alloc]
								 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
								 target:self action:nil];
		UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
		[_pickerView addSubview:toolbar];
		toolbar.barStyle=UIBarStyleBlackTranslucent;
		toolbar.items = [NSArray arrayWithObjects:flex, done, nil];
	}
	
}
- (void) showPicker
{
	_isOpen = TRUE;
		
	[self pickerWithDefault:self.selectedIndex];
	[UIView beginAnimations:@"show" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	CGRect f = _pickerView.frame;
	f.origin.y = 480 - f.size.height;
	_pickerView.frame = f;
	[UIView commitAnimations];	
	
	
	if ([self.delegate respondsToSelector:@selector(cellDidBeginEditting:)])
	{
		[self.delegate cellDidBeginEditting:self];
	}
	
}


- (void) hidePicker
{
	_isOpen = FALSE;
	
	
	DLog(@"hide picker");
	[UIView beginAnimations:@"hide" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	[UIView setAnimationDidStopSelector:@selector(done:)];
	
	CGRect f = _pickerView.frame;
	f.origin.y = 480;
	_pickerView.frame = f;
	
	[UIView commitAnimations];
	
	
	if ([self.delegate respondsToSelector:@selector(cellDidEndEditting:)])
	{
		[self.delegate cellDidEndEditting:self];
	}
	
	
	
}

- (void)done:(id)sender
{
	DLog(@"done");
	if (_pickerView)
	{
		[_pickerView removeFromSuperview];
		_pickerView = nil;
	}
	
	
}

-(UIResponder *) responder
{
	return self;
	
}

- (BOOL) resignFirstResponder
{
	[self hidePicker];
	return TRUE;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	self.selectedIndex = row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[self.data objectForKey:@"Titles"] objectAtIndex:row];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [[self.data objectForKey:@"Values"] count];
}

- (void) dealloc
{
	self.data = nil;
}


@end
