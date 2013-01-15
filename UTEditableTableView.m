//
//  UTEditableTableView.m
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTEditableTableView.h"
#import "UTTableViewCell.h"
#import "UTTableViewPhotoPickerCell.h"
#import "UTTableViewPListDataSource.h"

@implementation UTEditableTableView

@synthesize maxHeight		=	_maxHeight;
@synthesize dataModel		=	_dataModel;

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
	if (self = [super initWithFrame:frame style:style])
	{
		_dataModel = [NSMutableDictionary dictionary];
		self.delegate = self;
		[self addObservers];
	}
	return self;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[((UTTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]) select];
	
	//[self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//DLog(@"kind of %@", [tableView cellForRowAtIndexPath:indexPath]);
	NSDictionary* data = [(UTTableViewPListDataSource*)tableView.dataSource dataAtIndexPath:indexPath];
	if ([[data valueForKey:@"Type"] isEqualToString:kPhotoPicker])
	{
		if ([[self.dataModel valueForKey:[data valueForKey:@"Key"]] isKindOfClass:[NSDictionary class]])
		{
			
			return 55;
		}
	}

	return 38;//tableView.rowHeight;
		 
}
*/

#pragma mark -
#pragma mark tableviewcell delegates

- (void) scrollBack
{
	if (!_keyboardVisible)
	{
		_firstResponder = nil;
		_selectedCell = nil;
	}
}


-(void)cellDidBeginEditting:(UTTableViewCell *)cell
{
	_originalFrame = self.frame;
	[_firstResponder resignFirstResponder];
	_firstResponder = cell.responder;
	
	_selectedCell = cell;
	DLog(@"begin editting");
	
	if ( _keyboardVisible)
	{
		[self scrollToRowAtIndexPath:[self indexPathForCell:_selectedCell] atScrollPosition:UITableViewScrollPositionTop animated:TRUE];		
	}
	

}

- (void)cellDidEndEditting:(UTTableViewCell *)cell
{
	[self scrollBack];
}

#pragma mark -
#pragma mark keyboard

- (void)addObservers 
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
}

- (void)removeObservers 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillShowNotification" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIKeyboardWillHideNotification" object:nil];
}


- (void)keyboardWillHide:(NSNotification*)notification 
{
	//[self setContentSize:CGSizeMake(320, self.maxHeight+50) animated:TRUE];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:TRUE];
	UIView* footer = self.tableFooterView;
	CGRect f = footer.frame;
	f.size.height -= 200;
	footer.frame = f;
	self.tableFooterView = footer;
	[UIView commitAnimations];
	
	
	_keyboardVisible = FALSE;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	//[self setContentSize:CGSizeMake(320, self.maxHeight+50+240) animated:FALSE];
	
	UIView* footer = self.tableFooterView;
	CGRect f = footer.frame;
	f.size.height += 200;
	footer.frame = f;
	self.tableFooterView = footer;
	_keyboardVisible = TRUE;
	[self scrollToRowAtIndexPath:[self indexPathForCell:_selectedCell] atScrollPosition:UITableViewScrollPositionTop animated:TRUE];
	_selectedCell = nil;
	
}

- (void) scrollTo:(CGPoint)offset animated:(BOOL) animated
{
	if (animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:.3];
		[UIView setAnimationBeginsFromCurrentState:TRUE];
	}
	
	self.contentOffset = offset;
	
	if (animated)
	{
		[UIView commitAnimations];
	}
}

- (void) setContentSize:(CGSize)size animated:(BOOL)animated
{
	if (animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:.3];
		[UIView setAnimationBeginsFromCurrentState:TRUE];
	}
	
	self.contentSize = size;
	
	if (animated)
	{
		[UIView commitAnimations];
	}
}

- (void) setFrame:(CGRect)frame animated:(BOOL)animated
{
	if (animated)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:.3];
		[UIView setAnimationBeginsFromCurrentState:TRUE];
	}
	
	self.frame = frame;
	
	if (animated)
	{
		[UIView commitAnimations];
	}
}

- (void) closeKeyboard
{
	if ([_firstResponder respondsToSelector:@selector(resignFirstResponder)])
	{
		[_firstResponder resignFirstResponder];
	}
}

- (void) setMaxHeight:(float)h
{
	_maxHeight = h;//CGRectGetMaxY(f);
	//DLog(@"max height %f", _maxHeight);
	//self.contentSize = CGSizeMake(320, _maxHeight+300);
}

- (void) valueDidChange:(UTTableViewCell*)cell value:(id)val key:(NSString*)key
{
	if ([self.dataModel valueForKey:key] != val)
	{
		[self.dataModel setValue:val forKey:key];
		
		/*
		if ([cell isKindOfClass:[UTTableViewPhotoPickerCell class]])
		{
			[self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[self indexPathForCell:cell], nil] withRowAnimation:UITableViewRowAnimationNone];
		}
		*/
		//DLog(@"%@ %@ %@", val, key, self.dataModel);
	}
	
}

- (void) setValue:(id)value forKey:(NSString *)key
{
	[self.dataModel setValue:value forKey:key];
	[self reloadData];
}

- (void) dealloc
{
	//self.dataModel = nil;
	[self removeObservers];
}


@end
