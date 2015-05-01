//
//  UTImage.h
//  RingFinder
//
//  Created by Danny Morrow on 10/25/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTImage : UIImage 
{

}

+ (UIImage *) imageWithFill:(UIColor *)color ofSize:(CGSize)aSize alpha:(float)alpha;

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (NSString*) path2x:(NSString*)path;
+ (NSString*) path3x:(NSString*)path;
+ (NSString*) path:(NSString*)path atScale:(NSUInteger)scale;
+ (UIImage *) circleWithRect:(CGRect)rect withFill:(UIColor*)fillColor;

@end
