//
//  UTLabel.h
//  RingFinder
//
//  Created by Daniel Morrow on 4/27/10.
//  Copyright 2010 Tiffany & Co.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTLabel : UILabel 
{
	BOOL _textBlock;
	BOOL _initialized;
	float _x;
	float _y;
	float _width;
	float _height;
}

@property (nonatomic, assign) BOOL textBlock;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;


+(id) textLine:(NSString *)t font:(UIFont *)f x:(float)xPos y:(float)yPos;
+(id) textBlock:(NSString *)t font:(UIFont *)f x:(float)xPos y:(float)yPos width:(float)w;

-(id) initWithText:(NSString *)t font:(UIFont *)f x:(float)xPos y:(float)yPos width:(float)w;
-(void) resize;

@end
