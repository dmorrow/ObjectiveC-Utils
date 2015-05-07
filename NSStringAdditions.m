//
//  NSStringAdditions.m
//  RingFinder
//
//  Created by Danny Morrow on 11/5/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "NSStringAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (unitytheory)

- (NSDictionary *) urlParameterValues
{
	NSMutableDictionary* returnDict = [NSMutableDictionary dictionary];

    NSArray* nameValuePairs = [self componentsSeparatedByString:@"&"];
    if ([nameValuePairs count] > 0)
    {
        for (NSString* pair in nameValuePairs)
        {
            NSArray* splitPair = [pair componentsSeparatedByString:@"="];
            if ([splitPair count] == 2)
            {
                [returnDict setObject:[[splitPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] 
                               forKey:[[splitPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
	return ([returnDict count] > 0) ? [NSDictionary dictionaryWithDictionary:returnDict] : nil;
}

- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:self];
}

- (NSString*)md5HexDigest
{
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)unformattedPhoneNumber
{
    NSCharacterSet *toExclude = [NSCharacterSet characterSetWithCharactersInString:@"+/.()- "];
    return [[self componentsSeparatedByCharactersInSet:toExclude] componentsJoinedByString: @""];
}

@end
