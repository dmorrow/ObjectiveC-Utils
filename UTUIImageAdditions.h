//
//  UTUIImageAdditions.h
//  RingFinder
//
//  Created by Danny Morrow on 11/9/10.
//  Copyright 2010 unitytheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage  (unitytheory)

+ (UIImage*) imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
- (UIImage *) scaledImage;
- (UIImage *) imageWithTint:(UIColor *) color additionalLayers:(BOOL) additional;

- (UIImage *) croppedToRect:(CGRect)rect;
- (UIImage *) scaledToSize:(CGSize)newSize opaque:(BOOL)opaque;

+ (UIImage *)imageFromLayer:(CALayer *)layer;

@end
