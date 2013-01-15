//
//  UTColor.h
//  RingFinder
//
//  Created by Daniel Morrow on 4/14/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTColor : UIColor 
{

}

+ (UIColor *)colorWithHex:(UInt32)hex;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
