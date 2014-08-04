//
//  UTTableViewPhotoPickerCell.m
//  RingFinder
//
//  Created by Danny Morrow on 11/7/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTTableViewPhotoPickerCell.h"

@implementation UTTableViewPhotoPickerCell

- (void) drawView
{
	[super drawView];
	self.textField.userInteractionEnabled = FALSE;
	_sizedImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	[self.contentView addSubview:_sizedImageView];
	_sizedImageView.autoresizingMask = UIViewAutoresizingNone;
}

- (void) select
{
	if ([self.delegate respondsToSelector:@selector(cellDidBeginEditting:)])
	{
		[self.delegate cellDidBeginEditting:self];
	}
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || self.hasPicture)
	{
		NSString* destructiveButtonTitle = (self.hasPicture) ? @"Remove Photo" : nil;
		UIActionSheet* select;
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		{
			select = [[UIActionSheet alloc] initWithTitle:nil 
												  delegate:self 
										 cancelButtonTitle:@"Cancel" 
									destructiveButtonTitle:destructiveButtonTitle 
										 otherButtonTitles:@"Choose Photo", @"Take Photo", nil];
		}
		else
		{
			select = [[UIActionSheet alloc] initWithTitle:nil 
												  delegate:self 
										 cancelButtonTitle:@"Cancel" 
									destructiveButtonTitle:destructiveButtonTitle 
										 otherButtonTitles:@"Choose Photo", nil];
		}
		if (select != nil)
		{
			select.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
			
			if ([[[self viewController] tabBarController] tabBar])
			{
				[select showFromTabBar:[self viewController].tabBarController.tabBar];
			}
			else 
			{
				[select showInView:self];
			}
		}
		
	}
	else
	{
		[self createPhotoPicker:UIImagePickerControllerSourceTypePhotoLibrary];
	}
	
	
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
	if (buttonIndex == actionSheet.destructiveButtonIndex)
	{
		self.value = nil;
		return;
	}
	if (buttonIndex == actionSheet.cancelButtonIndex)
	{
		return;
	}
	if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo"])
	{
		type = UIImagePickerControllerSourceTypeCamera;
	}
	 [self createPhotoPicker:type];
}

- (void) createPhotoPicker:(UIImagePickerControllerSourceType)type
{
	_photoPicker = [[UIImagePickerController alloc] init];
	_photoPicker.delegate = self;
	_photoPicker.sourceType = type;
    
	[[self viewController] presentViewController:_photoPicker animated:TRUE completion:nil];
}

- (void) updateText
{
	//self.textField.hidden = !(self.value);
}

- (void) setValue:(id)val
{
	[super setValue:val];
	[self drawImage];
}

- (void) drawImage
{
	if (self.hasPicture)
	{
		self.textField.hidden = TRUE;
		NSDictionary* valueDict = (NSDictionary*) self.value;
		_sizedImageView.image = [valueDict objectForKey:UIImagePickerControllerOriginalImage];
		_sizedImageView.frame = CGRectMake(CGRectGetMaxX(self.textField.frame)-self.accessoryView.frame.size.width - 38, 1, 35, 35);
	}
	else
	{
		_sizedImageView.image = nil;
		self.textField.hidden = FALSE;
	}
}

- (BOOL) hasPicture
{
	if (![self.value isKindOfClass:[NSDictionary class]]) return FALSE;
	return ([(NSDictionary*) self.value objectForKey:UIImagePickerControllerOriginalImage] != nil);
}

- (void) prepareForReuse
{
	_sizedImageView.image = nil;
	[super prepareForReuse];
}

-(UIResponder *) responder
{
	return nil;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	DLog(@"delegate %@", self.delegate);
	DLog(@"VC %@", [self viewController]);
	self.value = info;
	if ([self.delegate respondsToSelector:@selector(cellDidEndEditting:)])
	{
		[self.delegate cellDidEndEditting:self];
	}
	[[self viewController] dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if ([self.delegate respondsToSelector:@selector(cellDidEndEditting:)])
	{
		[self.delegate cellDidEndEditting:self];
	}
	[[self viewController] dismissViewControllerAnimated:TRUE completion:nil];
}




@end
