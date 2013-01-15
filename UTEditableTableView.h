//
//  UTEditableTableView.h
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTTableViewCell.h"

@interface UTEditableTableView : UITableView <UTTableViewCellDelegate, UITableViewDelegate>
{
	float _maxHeight;
	BOOL _keyboardVisible;
	id _firstResponder;
	NSMutableDictionary* __weak _dataModel;
	UITableViewCell* _selectedCell;
	CGRect _originalFrame;

}

@property (nonatomic) float maxHeight;
@property (weak, nonatomic, readonly) NSMutableDictionary* dataModel;


- (void) closeKeyboard;
- (void) addObservers;
- (void) removeObservers;
- (void) scrollTo:(CGPoint)offset animated:(BOOL) animated;
- (void) setContentSize:(CGSize)size animated:(BOOL)animated;
- (void) setFrame:(CGRect)frame animated:(BOOL)animated;

- (void)keyboardWillHide:(NSNotification*)notification;
- (void)keyboardWillShow:(NSNotification *)notification;

@end
