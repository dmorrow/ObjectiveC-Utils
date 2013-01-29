//
//  UIImageAdditions.m
//  RingFinder
//
//  Created by Danny Morrow on 11/9/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import "UTUIImageAdditions.h"


@implementation UIImage (unitytheory)

+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize
{  
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
		
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }     
	
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
	
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
	
    CGContextRef bitmap;
	
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
    }   
	
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
		
        CGContextRotateCTM (bitmap, RADIANS(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
		
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
		
        CGContextRotateCTM (bitmap, RADIANS(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
		
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, RADIANS(-180.));
    }
	
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
	
    CGContextRelease(bitmap);
    CGImageRelease(ref);
	
    return newImage; 
}

- (UIImage *) imageWithTint:(UIColor *) color additionalLayers:(BOOL) additional
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGRect r = CGRectMake(0, 0, self.size.width, self.size.height);
	CGSize imageSize = r.size;
	
	// create a bitmap graphics context the size of the image
	CGContextRef context = CGBitmapContextCreate (NULL, imageSize.width, imageSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	
	// free the rgb colorspace
	CGColorSpaceRelease(colorSpace);    
	
	if (context==NULL) return NULL;
	
	CGContextClipToMask(context, r, self.CGImage); // respect alpha mask
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, r);
	if (additional)
	{
		CGColorRef alphaColor = CGColorCreateCopyWithAlpha(color.CGColor, .5);
		CGContextSetFillColorWithColor(context, alphaColor);
		CGColorRelease(alphaColor);
		CGContextFillRect(context, r);
	}
	
	// convert the finished resized image to a UIImage 
	CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(context);
	UIImage *theImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];
	// image is retained by the property setting above, so we can 
	// release the original
	CGImageRelease(mainViewContentBitmapContext);
	
	// return the image
	return theImage;
	
}

- (UIImage *) scaledImage
{
	return [UIImage imageWithCGImage:self.CGImage scale:2.0 orientation:UIImageOrientationUp];
}

- (UIImage *) croppedToRect:(CGRect)rect
{
    UIImage *ret = nil;
    CGRect cropRect;
    // This performs the image cropping.
    if(self.imageOrientation == UIImageOrientationLeft || self.imageOrientation == UIImageOrientationRight)
    {
        cropRect = CGRectMake(rect.origin.y, rect.origin.x, rect.size.height, rect.size.width);
    }
    else
    {
        cropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    
    ret = [UIImage imageWithCGImage:imageRef
                              scale:0
                        orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return ret;
}

- (UIImage *) scaledToSize:(CGSize)newSize opaque:(BOOL)opaque
{
    UIGraphicsBeginImageContextWithOptions(newSize, opaque, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
