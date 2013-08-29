//
//  UTTouchDetectingLabel.h
//  RingFinder
//
//  Created by Danny Morrow on 7/2/13.
//  Copyright (c) 2013 unitytheory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UTTouchDetectingLabel : UILabel
{
    NSTextCheckingTypes _dataDetectorTypes;
    NSIndexSet* _linkRanges;
    NSDictionary* _linkAttrbutes;
}

@property (nonatomic) NSTextCheckingTypes dataDetectorTypes;
@property (nonatomic, retain) NSDictionary* linkAttributes;
@property (nonatomic, retain) NSDictionary* tappedLinkAttributes;

- (void) findLinks;
- (void) styleLinks;

@end
