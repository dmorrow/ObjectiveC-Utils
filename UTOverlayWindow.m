//
//  UTOverlayWindow.m
//  RingFinder
//
//  Created by Danny Morrow on 8/2/13.
//  Copyright (c) 2013 unitytheory. All rights reserved.
//

#import "UTOverlayWindow.h"

@interface UTOverlayWindow()
- (void)matchReferenceOrientation:(BOOL)animated;
- (void)updateViewForOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;
@end

@implementation UTOverlayWindow

@synthesize currentOrientation = _currentOrientation;


+ (UTOverlayWindow *) overlayWindow
{
    static dispatch_once_t onceQueue;
    static UTOverlayWindow *sharedInstance = nil;
    
    dispatch_once(&onceQueue, ^{
        sharedInstance = [[UTOverlayWindow alloc] init];
    });
    
    return sharedInstance;
}

- (void)didRotate:(NSNotification *)notification
{
    [self matchReferenceOrientation:YES];
}

- (void)matchReferenceOrientation:(BOOL)animated
{
    if (self.hidden)
    {
        _previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    
    UIViewController *rootVC = _previousKeyWindow.rootViewController;
    UIViewController *referenceViewController = rootVC;
    if (rootVC.presentedViewController) {
        referenceViewController = rootVC.presentedViewController;
    }
    UIInterfaceOrientation orientation = [referenceViewController interfaceOrientation];
    
    if ([referenceViewController respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        UIInterfaceOrientationMask orientationMask = [[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:_previousKeyWindow];
        if (referenceViewController.supportedInterfaceOrientations & orientationMask)
        {
            [self updateViewForOrientation:orientation animated:!self.hidden];
        }
    }
    else if ([referenceViewController shouldAutorotateToInterfaceOrientation:orientation]) {
        [self updateViewForOrientation:orientation animated:!self.hidden];
    }
}
/*
- (void)updateViewForOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated
{
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.3;
        if ( (UIInterfaceOrientationIsLandscape(self.currentOrientation) && UIInterfaceOrientationIsLandscape(orientation))
            || (UIInterfaceOrientationIsPortrait(orientation) && UIInterfaceOrientationIsPortrait(self.currentOrientation)) ) {
            duration = 0.6;
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            duration = duration * 1.3;
        }
    }
    self.currentOrientation = orientation;
    [UIView animateWithDuration:duration animations:^{
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                self.transform = CGAffineTransformMakeRotation(0);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                self.transform = CGAffineTransformMakeRotation(M_PI);
                break;
            case UIInterfaceOrientationLandscapeLeft:
                self.transform = CGAffineTransformMakeRotation(M_PI / -2);
                break;
            case UIInterfaceOrientationLandscapeRight:
                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
                break;
            default:
                break;
        }
    }];
    
}
*/

- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated
{
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    
    if(
       (UIInterfaceOrientationIsLandscape(orientation) && orientationFrame.size.height > orientationFrame.size.width) ||
       (UIInterfaceOrientationIsPortrait(orientation) && orientationFrame.size.width > orientationFrame.size.height)
       ) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
    }
    
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.3;
        if ( (UIInterfaceOrientationIsLandscape(self.currentOrientation) && UIInterfaceOrientationIsLandscape(orientation))
            || (UIInterfaceOrientationIsPortrait(orientation) && UIInterfaceOrientationIsPortrait(self.currentOrientation)) ) {
            duration = 0.6;
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            //duration = duration * 1.3;
        }
    }
    self.transform = CGAffineTransformIdentity;
    self.frame = orientationFrame;
    
    CGFloat posY = orientationFrame.size.height/2;
    CGFloat posX = orientationFrame.size.width/2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
            break;
        default: // UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    }
    
    self.currentOrientation = orientation;
    [UIView animateWithDuration:duration animations:^{
        
        self.transform = CGAffineTransformMakeRotation(rotateAngle);
        self.center = newCenter;
    }];
    
    
    
    
    [self setNeedsLayout];
    [self layoutSubviews];

}


/*
- (void) setRotation:(NSNotification*)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGRect orientationFrame = [UIScreen mainScreen].bounds;
    
    if(
       (UIInterfaceOrientationIsLandscape(orientation) && orientationFrame.size.height > orientationFrame.size.width) ||
       (UIInterfaceOrientationIsPortrait(orientation) && orientationFrame.size.width > orientationFrame.size.height)
       ) {
        float temp = orientationFrame.size.width;
        orientationFrame.size.width = orientationFrame.size.height;
        orientationFrame.size.height = temp;
    }
    
    self.transform = CGAffineTransformIdentity;
    self.frame = orientationFrame;
    
    CGFloat posY = orientationFrame.size.height/2;
    CGFloat posX = orientationFrame.size.width/2;
    
    CGPoint newCenter;
    CGFloat rotateAngle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            rotateAngle = M_PI;
            newCenter = CGPointMake(posX, orientationFrame.size.height-posY);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotateAngle = -M_PI/2.0f;
            newCenter = CGPointMake(posY, posX);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotateAngle = M_PI/2.0f;
            newCenter = CGPointMake(orientationFrame.size.height-posY, posX);
            break;
        default: // UIInterfaceOrientationPortrait
            rotateAngle = 0.0;
            newCenter = CGPointMake(posX, posY);
            break;
    }
    
    self.transform = CGAffineTransformMakeRotation(rotateAngle);
    self.center = newCenter;
    
    [self setNeedsLayout];
    [self layoutSubviews];
}
*/

- (void) addViewController:(UIViewController*) viewController animated:(BOOL) animated
{
    [self didRotate:nil];
    
    if (self.rootViewController == viewController) return;
    
    if (self.hidden)
    {
        _previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
        self.alpha = 0.0f;
        [UIView animateWithDuration:(animated) ? .5 : 0 animations:^{ self.alpha = 1; }];
        self.hidden = NO;
        [self makeKeyWindow];
    }
    
    // if something's been added to this window, then this window should have interaction
    self.userInteractionEnabled = YES;
    self.rootViewController = viewController;
}

- (void) hideAnimated:(BOOL) animated
{
    [UIView animateWithDuration:(animated) ? .5 : 0
                     animations:^{ self.alpha = 0; }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                         self.rootViewController = nil;
                         [_previousKeyWindow makeKeyWindow];
                         _previousKeyWindow = nil;
                     }];
}

- (void) addToMainWindow:(UIView *)view
{
    [self didRotate:nil];
    
    if ([self.subviews containsObject:view]) return;
    
    if (self.hidden)
    {
        _previousKeyWindow = [[UIApplication sharedApplication] keyWindow];
        //self.alpha = 0.0f;
        self.hidden = NO;
        [self makeKeyWindow];
    }
    
    // if something's been added to this window, then this window should have interaction
    self.userInteractionEnabled = YES;
    
    /*
    if (self.subviews.count > 0)
    {
        ((UIView*)[self.subviews lastObject]).userInteractionEnabled = NO;
    }
    
    if (_backgroundImage)
    {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:_backgroundImage];
        backgroundView.frame = self.bounds;
        backgroundView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:backgroundView];
        [backgroundView release];
        [_backgroundImage release];
        _backgroundImage = nil;
    }
    */
    
    [self addSubview:view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void) removeView:(UIView *)view
{
    [view removeFromSuperview];
    
    UIView *topView = [self.subviews lastObject];
    if ([topView isKindOfClass:[UIImageView class]])
    {
        // It's a background. Remove it too
        [topView removeFromSuperview];
    }
    
    if (self.subviews.count == 0)
    {
        self.hidden = YES;
        [_previousKeyWindow makeKeyWindow];
        _previousKeyWindow = nil;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    }
    else
    {
        ((UIView*)[self.subviews lastObject]).userInteractionEnabled = YES;
    }
}

@end
