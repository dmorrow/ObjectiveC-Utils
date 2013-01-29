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

+ (NSString*) path2x:(NSString*)path
{
	return [[path stringByDeletingLastPathComponent] 
			stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@", 
											[[path lastPathComponent] stringByDeletingPathExtension], 
											[path pathExtension]]];
	
}

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path 
{
    if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] == 2.0 ) {
        NSString *path2x = [UTImage path2x:path];	
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path2x]] CGImage] scale:2.0 orientation:UIImageOrientationUp];
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
    CGSize size = CGSizeMake(rect.size.width+2*rect.origin.x, rect.size.height+2*rect.origin.y);
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
