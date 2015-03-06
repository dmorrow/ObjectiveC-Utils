//
//  UTTableViewPListDataSource.m
//  RingFinder
//
//  Created by Danny Morrow on 10/29/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTTableViewPListDataSource.h"
#import "UTTableViewCell.h"
#import "UTTableViewMultiOptionCell.h"
#import "UTEditableTableView.h"
#import "UTTableViewPhotoPickerCell.h"

@implementation UTTableViewPListDataSource

@synthesize path				=	_path;
@synthesize plistData			=	_plistData;

@synthesize tableCellDelegate;

- (id) initWithPList:(NSString *)path
{
	if (self = [super init])
	{
		self.path = path;
	}
	return self;
}

- (void) setPath:(NSString *) p
{
	if (![_path isEqualToString:p])
	{
		_path = p;
		[self parsePList];
	}
	
}

- (void) parsePList
{
	NSString* plistPath = [[NSBundle mainBundle] pathForResource:self.path ofType:nil inDirectory:@"plist"];
	if (plistPath == nil)
	{
		plistPath = [[NSBundle mainBundle] pathForResource:self.path ofType:nil inDirectory:@""];
	}

	self.plistData = [NSMutableDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:plistPath]];

}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self groups] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [[self fieldsInGroup:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style = UITableViewCellStyleValue1;
	NSDictionary* dataModel = ((UTEditableTableView*) tableView).dataModel;
	NSDictionary* data = [self dataAtIndexPath:indexPath];
	if ([[data valueForKey:@"Type"] isEqualToString:kTextFieldSpecifier])
	{
		UTTableViewTextFieldCell* cell = (UTTableViewTextFieldCell *)[tableView dequeueReusableCellWithIdentifier:kTextFieldSpecifier];
		if (!cell)
		{
			cell = [self textFieldCellFactory:style];
		}
		cell.delegate = self.tableCellDelegate;
		cell.data = data;
		
		cell.textField.keyboardType = [self keyboardFactory:[data valueForKey:@"KeyboardType"]];
		cell.textField.autocapitalizationType = [self capitalizationFactory:[data valueForKey:@"CapitalizationType"]];
		
		cell.value = [self setDefaultValue:dataModel data:data];
		
		return cell;
	}
	else if ([[data valueForKey:@"Type"] isEqualToString:kMultiValueSpecifer])
	{
		UTTableViewMultiOptionCell* cell = (UTTableViewMultiOptionCell *)[tableView dequeueReusableCellWithIdentifier:kMultiValueSpecifer];
		if (!cell)
		{
			cell = [self multioptionCellFactory:style];
		}
		cell.delegate = self.tableCellDelegate;
		cell.data = data;
		
		cell.value = [self setDefaultValue:dataModel data:data];
		return cell;
	}
	else if ([[data valueForKey:@"Type"] isEqualToString:kPhotoPicker])
	{
		UTTableViewPhotoPickerCell* cell = (UTTableViewPhotoPickerCell *)[tableView dequeueReusableCellWithIdentifier:kPhotoPicker];

		if (!cell)
		{
			cell = [self photoPickerCellFactory:style];
		}
		cell.delegate = self.tableCellDelegate;
		cell.data = data;
		
		cell.value = [self setDefaultValue:dataModel data:data];
		return cell;
	}
	else 
	{
		UITableViewCell *listCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"default"];
		if (!listCell) 
		{
			listCell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"default"];
		}
		return listCell;	
	}
	
}

- (id) setDefaultValue:(NSDictionary*) dataModel data:(NSDictionary *) data
{
	if ([dataModel valueForKey:[data valueForKey:@"Key"]])
	{
		return [dataModel valueForKey:[data valueForKey:@"Key"]];
	}
	else
	{
		return [data valueForKey:@"DefaultValue"];
	}
}

- (UIKeyboardType) keyboardFactory:(NSString*) keyboardType
{
	if ([[keyboardType lowercaseString] isEqualToString: @"alphabet"])
	{
		return UIKeyboardTypeDefault;
	}
	else if ([[keyboardType lowercaseString] isEqualToString: @"email"])
	{
		return UIKeyboardTypeEmailAddress;
	}
	else if ([[keyboardType lowercaseString] isEqualToString: @"url"])
	{
		return UIKeyboardTypeURL;
	}
	else 
	{
		return UIKeyboardTypeDefault;
	}

	
}

- (UITextAutocapitalizationType) capitalizationFactory:(NSString*) capitalizationType
{
	if ([[capitalizationType lowercaseString] isEqualToString: @"none"])
	{
		return UITextAutocapitalizationTypeNone;
	}
	else if ([[capitalizationType lowercaseString] isEqualToString: @"words"])
	{
		return UITextAutocapitalizationTypeWords;
	}
	else if ([[capitalizationType lowercaseString] isEqualToString: @"all"])
	{
		return UITextAutocapitalizationTypeAllCharacters;
	}
	else 
	{
		return UITextAutocapitalizationTypeSentences;
	}
	
	
}


#pragma mark -
#pragma mark field factories

- (UTTableViewTextFieldCell *) textFieldCellFactory:(UITableViewCellStyle) style
{
	return [[UTTableViewTextFieldCell alloc] initWithStyle:style reuseIdentifier:kTextFieldSpecifier];
}

- (UTTableViewMultiOptionCell *) multioptionCellFactory:(UITableViewCellStyle) style
{
	return [[UTTableViewMultiOptionCell alloc] initWithStyle:style reuseIdentifier:kMultiValueSpecifer];
}

- (UTTableViewPhotoPickerCell *) photoPickerCellFactory:(UITableViewCellStyle) style
{
	return [[UTTableViewPhotoPickerCell alloc] initWithStyle:style reuseIdentifier:kPhotoPicker];
}



#pragma mark -
#pragma mark lookup

- (NSDictionary *) dataAtIndexPath:(NSIndexPath *)indexPath
{
	return [[self fieldsInGroup:indexPath.section] objectAtIndex:indexPath.row];
}

- (NSDictionary *) groupAtIndex:(NSInteger)groupIndex
{
	return [self.groups objectAtIndex:groupIndex];
}

- (NSArray *) groups
{
	return [self.plistData objectForKey:@"Groups"];
}

- (NSArray *) fieldsInGroup:(NSInteger)groupIndex
{
	return [[self groupAtIndex:groupIndex] objectForKey:@"Fields"];
}

- (void) dealloc
{
	self.path = nil;
}

@end
