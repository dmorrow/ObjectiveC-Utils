//
//  UTTableViewPListDataSource.h
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTTableViewTextFieldCell.h"
#import "UTTableViewMultiOptionCell.h"
#import "UTTableViewPhotoPickerCell.h"

#define kUTTableWidth                       320
#define kUTSpacing                          15
#define kUTMinLabelWidth                    80
#define kUTMinValueWidth                    35
#define kUTPaddingLeft                      9
#define kUTPaddingRight                     10

#define kTextFieldSpecifier		@"PSTextFieldSpecifier"
#define kTextField				@"PSTextField"
#define kMultiValueSpecifer		@"PSMultiValueSpecifer"
#define kPhotoPicker			@"PSPhotoPicker"
#define kHiddenSpecifier		@"PSHiddenSpecifier"

@interface UTTableViewPListDataSource : NSObject <UITableViewDataSource>
{
	NSString* _path;
	NSMutableDictionary* _plistData;

}

@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSMutableDictionary* plistData;
@property (nonatomic, weak) id <UTTableViewCellDelegate> tableCellDelegate;

- (id) initWithPList:(NSString *)path;
- (void) parsePList;
- (NSDictionary *) dataAtIndexPath:(NSIndexPath *)indexPath;
- (NSDictionary *) groupAtIndex:(NSInteger)groupIndex;
- (NSArray *) groups;
- (NSArray *) fieldsInGroup:(NSInteger)groupIndex;
- (UIKeyboardType) keyboardFactory:(NSString*) keyboardType;
- (UITextAutocapitalizationType) capitalizationFactory:(NSString*) capitalizationType;
- (id) setDefaultValue:(NSDictionary*) dataModel data:(NSDictionary *) data;

- (UTTableViewTextFieldCell *) textFieldCellFactory:(UITableViewCellStyle) style;
- (UTTableViewMultiOptionCell *) multioptionCellFactory:(UITableViewCellStyle) style;
- (UTTableViewPhotoPickerCell *) photoPickerCellFactory:(UITableViewCellStyle) style;



@end
