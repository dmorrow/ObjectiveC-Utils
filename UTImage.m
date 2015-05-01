//
//  UTImage.m
//  RingFinder
//
//  Created by Danny Morrow on 10/25/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTImage.h"


@implementation UTImage

+ (UIImage *) imageWithContentsOfFile:(NSString *)path
{
	NSString *parsedPath = [[NSBundle mainBundle] pathForResource:[path lastPathComponent] ofType:nil inDirectory:[path stringByDeletingLastPathComponent]];
	
	return [UTImage imageWithContentsOfResolutionIndependentFile:parsedPath];
}

+ (UIImage *) imageWithFill:(UIColor *)color ofSize:(CGSize)aSize alpha:(float)alpha
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGRect r = CGRectMake(0, 0, aSize.width, aSize.height);
	
	CGContextRef context = CGBitmapContextCreate (NULL, aSize.width, aSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpace);    
	
	if (context==NULL) return NULL;
	
	CGColorRef alphaColor = CGColorCreateCopyWithAlpha(color.CGColor, alpha);
	CGContextSetFillColorWithColor(context, alphaColor);
	CGColorRelease(alphaColor);
	CGContextFillRect(context, r);

	CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(context);
	UIImage *theImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];

	CGImageRelease(mainViewContentBitmapContext);
	CGContextRelease(context);
	
	return theImage;
}

+ (NSString*) path:(NSString*)path atScale:(NSUInteger)scale
{
    NSString* scaleString = [NSString stringWithFormat:@"@%@x", @(scale)];
    if ([path rangeOfString:scaleString].location != NSNotFound) return path;
    NSString* ipadLabel = @"";
    if ([path rangeOfString:@"~ipad"].location != NSNotFound)
    {
        NSRange lastOccurance = [path rangeOfString:@"~ipad" options:NSBackwardsSearch];
        ipadLabel = @"~ipad";
        path = [path stringByReplacingCharactersInRange:lastOccurance withString:@""];
    }
    return [[path stringByDeletingLastPathComponent]
            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@.%@",
                                            [[path lastPathComponent] stringByDeletingPathExtension],
                                            scaleString,
                                            ipadLabel,
                                            [path pathExtension]]];
}

+ (NSString*) path2x:(NSString*)path
{
    return [UTImage path:path atScale:2];
}

+ (NSString*) path3x:(NSString*)path
{
    return [UTImage path:path atScale:3];
}

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path 
{
    CGFloat scale = [UIScreen mainScreen].scale;
    for (NSUInteger i = 3; i>=2; i--)
    {
        if (scale >= i)
        {
            NSString *adjustedPath = [UTImage path:path atScale:i];
            if ( [[NSFileManager defaultManager] fileExistsAtPath:adjustedPath] )
            {
                return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:adjustedPath]] CGImage] scale:i orientation:UIImageOrientationUp];
            }
        }
    }
	
    return [self initWithData:[NSData dataWithContentsOfFile:path]];
}

+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path 
{
    return [[UTImage alloc] initWithContentsOfResolutionIndependentFile:path];
}

+ (UIImage *) circleWithRect:(CGRect)rect withFill:(UIColor*)fillColor
{
    CGSize size = CGSizeMake(CGRectGetWidth(rect)+2*CGRectGetMinX(rect), CGRectGetHeight(rect)+2*CGRectGetMinY(rect));
    UIGraphicsBeginImageContextWithOptions(size, FALSE, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextFillPath(ctx);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

@end
