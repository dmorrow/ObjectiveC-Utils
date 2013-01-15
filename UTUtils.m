//
//  UTUtils.m
//  RingFinder
//
//  Created by Danny Morrow on 11/15/12.
//  Copyright (c) 2012 unitytheory. All rights reserved.
//

#import "UTUtils.h"

BOOL UTIsStringWithAnyText(id object)
{
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void UTAlertNoTitle(NSString* message) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}