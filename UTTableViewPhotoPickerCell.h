//
//  UTTableViewPhotoPickerCell.h
//  RingFinder
//
//  Created by Danny Morrow on 11/7/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTTableViewTextFieldCell.h"


@interface UTTableViewPhotoPickerCell : UTTableViewTextFieldCell <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
	UIImagePickerController* _photoPicker;
	UIImageView* _sizedImageView;
}

@property (nonatomic, readonly) BOOL hasPicture;

- (void) createPhotoPicker:(UIImagePickerControllerSourceType)type;
- (void) drawImage;

@end
