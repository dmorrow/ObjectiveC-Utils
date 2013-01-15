//
//  UTTableViewMultiOptionCell.h
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTTableViewTextFieldCell.h"


@interface UTTableViewMultiOptionCell : UTTableViewTextFieldCell <UIPickerViewDelegate, UIPickerViewDataSource>
{
	int _selectedIndex;
	UIView* _pickerView;
	BOOL _isOpen;
}

@property (nonatomic) int selectedIndex;

- (void) pickerWithDefault:(int)defaultRow;
- (void) done:(id)sender;
- (void) hidePicker;
- (void) showPicker;

@end
