//
//  UTColor.m
//  RingFinder
//
//  Created by Daniel Morrow on 4/14/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import "UTColor.h"


@implementation UTColor

+ (UIColor *)colorWithHex:(UInt32)hex {
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert 
{
	NSScanner *scanner = [NSScanner scannerWithString:[stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [UTColor colorWithHex:hexNum];
}

@end
