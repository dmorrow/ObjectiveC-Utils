//
//  UTOverlayWindow.h
//  RingFinder
//
//  Created by Danny Morrow on 8/2/13.
//  Copyright (c) 2013 unitytheory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UTOverlayWindow : UIWindow
{
    UIWindow* _previousKeyWindow;
    UIInterfaceOrientation _currentOrientation;
}

+ (UTOverlayWindow *) overlayWindow;
- (void) addToMainWindow:(UIView *)view;
//- (void) setRotation:(NSNotification*)notification;
- (void) removeView:(UIView *)view;


- (void)didRotate:(NSNotification *)notification;

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;


@end
