//
//  NSMutableAttributedString+Unitytheory.h
//
//  Created by Danny Morrow on 3/6/15.
//  Copyright (c) 2015 unitytheory. All rights reserved.
//

@interface NSMutableAttributedString(unitytheory)

/*
 Attributed String options
*/

@property (nonatomic) UIColor* backgroundColor;
@property (nonatomic) CGFloat baselineOffset;
@property (nonatomic) UIFont* font;
@property (nonatomic) UIColor* color;
@property (nonatomic) CGFloat kerning;
@property (nonatomic) NSUInteger* ligature;
@property (nonatomic) NSURL* link;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic) UIColor* strokeColor;
@property (nonatomic) NSInteger* superscript;
@property (nonatomic) UIColor* underlineColor;
@property (nonatomic) NSUnderlineStyle underlineStyle;

@property (nonatomic, readonly) NSRange range;


/*
 Paragraph options
*/
@property (nonatomic) NSTextAlignment alignment;
@property (nonatomic) NSParagraphStyle* paragraphStyle;
@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) CGFloat paragraphSpacing;
@property (nonatomic) CGFloat lineHeightMultiple;
@end
