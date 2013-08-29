//
//  UTTouchDetectingLabel.m
//  RingFinder
//
//  Created by Danny Morrow on 7/2/13.
//  Copyright (c) 2013 unitytheory. All rights reserved.
//

#import "UTTouchDetectingLabel.h"



@implementation UTTouchDetectingLabel

@synthesize dataDetectorTypes = _dataDetectorTypes;
@synthesize linkAttributes = _linkAttrbutes;
@synthesize tappedLinkAttributes;

- (void) setDataDetectorTypes:(NSTextCheckingTypes )dataDetectorTypes
{
    if (_dataDetectorTypes != dataDetectorTypes)
    {
        _dataDetectorTypes = dataDetectorTypes;
        [self findLinks];
    }
}

- (void) setText:(NSString *)text
{
    [super setText:text];
    [self findLinks];
}

- (void) setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self findLinks];
}

- (void) setLinkAttributes:(NSDictionary *)attributes
{
    _linkAttrbutes = attributes;
    [self styleLinks];
}

- (void) findLinks
{
    if (_dataDetectorTypes == UIDataDetectorTypeNone) return;
    if (self.text.length == 0) return;
    NSError* error;
    NSDataDetector *detector = [NSDataDetector
                                dataDetectorWithTypes:_dataDetectorTypes
                                error:&error];
    
    _linkRanges = nil;
    NSArray *links = [detector matchesInString:self.text
                                       options:0
                                         range:NSMakeRange(0, [self.text length])];
    
    if ([links count] > 0)
    {
        NSMutableIndexSet *tempRanges = [NSMutableIndexSet indexSet];
        for (NSTextCheckingResult *match in links)
        {
            [tempRanges addIndexesInRange:[match range]];
        }
        _linkRanges = [tempRanges copy];
        self.userInteractionEnabled = TRUE;
    }
    [self styleLinks];
}

- (void) styleLinks
{
    if ([_linkRanges count] == 0) return;
    
    if (_linkAttrbutes && [self respondsToSelector:@selector(setAttributedText:)])
    {
         NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self.text];
        
        [_linkRanges enumerateRangesUsingBlock:^(NSRange range, BOOL *stop){
            for (NSString* key in _linkAttrbutes)
            {
                [string addAttribute:key value:[self.linkAttributes valueForKey:key] range:range];
            }
            
        }];
        
        self.attributedText = string;
        
    }
    
}


@end
