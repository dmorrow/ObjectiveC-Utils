//
//  UTTableViewTextFieldCell.h
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTTableViewCell.h"

@interface UTTableViewTextFieldCell : UTTableViewCell <UITextFieldDelegate>
{
	UITextField* _textField;
}

@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, readonly) float fixedTextPosition;

- (void) updateText;

@end
