//
//  UTTableViewCell.h
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UTTableViewCellDelegate;

@interface UTTableViewCell : UITableViewCell 
{
	id <UTTableViewCellDelegate> __weak delegate;
	NSString* _key;
	id _value;
	NSDictionary* _data;
}

@property (nonatomic, strong) NSDictionary* data;
@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) id value;
@property (nonatomic, weak) id <UTTableViewCellDelegate> delegate;
@property (weak, nonatomic, readonly) UIResponder* responder;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object ;


- (void) drawView;
- (void) select;
- (UIViewController*) viewController;

@end

@protocol UTTableViewCellDelegate <NSObject>

@optional
- (void) valueDidChange:(UTTableViewCell *) cell value:(id)value key:(NSString*)key;
- (void) cellDidBeginEditting:(UTTableViewCell *)cell;
- (void) cellDidEndEditting:(UTTableViewCell *)cell;
- (void) cellDidSubmit:(UTTableViewCell *)cell;

@end

