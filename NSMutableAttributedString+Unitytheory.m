//
//  NSMutableAttributedString+Unitytheory.m
//
//  Created by Danny Morrow on 3/6/15.
//  Copyright (c) 2015 unitytheory. All rights reserved.
//

#import "NSMutableAttributedString+Unitytheory.h"
#import <CoreText/CTStringAttributes.h>

@implementation NSMutableAttributedString(unitytheory)


- (UIColor*) backgroundColor
{
    return [self attribute:NSBackgroundColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setBackgroundColor:(UIColor *)backgroundColor
{
    [self removeAttribute:NSBackgroundColorAttributeName range:self.range];
    [self addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:self.range];
}

- (CGFloat) baselineOffset
{
    return [(NSNumber*)[self attribute:NSBaselineOffsetAttributeName atIndex:0 effectiveRange:nil] floatValue];
}

- (UIFont*) font
{
    return [self attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setFont:(UIFont *)font
{
    [self removeAttribute:NSFontAttributeName range:self.range];
    [self addAttribute:NSFontAttributeName value:font range:self.range];
}

- (void) setBaselineOffset:(CGFloat)baselineOffset
{
    [self removeAttribute:NSBaselineOffsetAttributeName range:self.range];
    [self addAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:self.range];
}

- (UIColor*) color
{
    return [self attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setColor:(UIColor *)color
{
    [self removeAttribute:NSForegroundColorAttributeName range:self.range];
    [self addAttribute:NSForegroundColorAttributeName value:color range:self.range];
}

- (CGFloat) kerning
{
    return [(NSNumber*)[self attribute:NSKernAttributeName atIndex:0 effectiveRange:nil] floatValue];
}

- (void) setKerning:(CGFloat)kerning
{
    [self removeAttribute:NSKernAttributeName range:self.range];
    [self addAttribute:NSKernAttributeName value:@(kerning) range:self.range];
}

- (NSUInteger*) ligature
{
    return [(NSNumber*)[self attribute:NSLigatureAttributeName atIndex:0 effectiveRange:nil] integerValue];
}

- (void) setLigature:(NSUInteger *)ligature
{
    [self removeAttribute:NSLigatureAttributeName range:self.range];
    [self addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInt:ligature] range:self.range];
}

- (NSURL*) link
{
    return [self attribute:NSLinkAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setLink:(NSURL *)link
{
    [self removeAttribute:NSLinkAttributeName range:self.range];
    [self addAttribute:NSLinkAttributeName value:link range:self.range];
}

- (CGFloat) strokeWidth
{
    return [(NSNumber*)[self attribute:NSStrokeWidthAttributeName atIndex:0 effectiveRange:nil] floatValue];
}

- (void) setStrokeWidth:(CGFloat)strokeWidth
{
    [self removeAttribute:NSStrokeWidthAttributeName range:self.range];
    [self addAttribute:NSStrokeWidthAttributeName value:@(strokeWidth) range:self.range];
}

- (UIColor*) strokeColor
{
    return [self attribute:NSStrokeColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setStrokeColor:(UIColor *)strokeColor
{
    [self removeAttribute:NSStrokeColorAttributeName range:self.range];
    [self addAttribute:NSStrokeColorAttributeName value:strokeColor range:self.range];
}

- (NSInteger*) superscript
{
    return [(NSNumber*)[self attribute:(NSString*)kCTSuperscriptAttributeName atIndex:0 effectiveRange:nil] integerValue];
}

- (void) setSuperscript:(NSInteger *)superscript
{
    [self removeAttribute:(NSString*)kCTSuperscriptAttributeName range:self.range];
    [self addAttribute:(NSString*)kCTSuperscriptAttributeName value:[NSNumber numberWithInt:superscript] range:self.range];
}

- (UIColor*) underlineColor
{
    return [self attribute:NSUnderlineColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setUnderlineColor:(UIColor *)underlineColor
{
    [self removeAttribute:NSUnderlineColorAttributeName range:self.range];
    [self addAttribute:NSUnderlineColorAttributeName value:underlineColor range:self.range];
}

- (NSUnderlineStyle) underlineStyle
{
    return (NSUnderlineStyle)[self attribute:NSUnderlineStyleAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setUnderlineStyle:(NSUnderlineStyle)underlineStyle
{
    [self removeAttribute:NSUnderlineStyleAttributeName range:self.range];
    [self addAttribute:NSUnderlineStyleAttributeName value:@(underlineStyle) range:self.range];
}

- (CGFloat) lineSpacing
{
    return self.paragraphStyle.lineSpacing;
}

- (void) setLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle* paragraphStyle = [self.paragraphStyle mutableCopy];
    paragraphStyle.lineSpacing = lineSpacing;
    self.paragraphStyle = paragraphStyle;
}

- (NSTextAlignment) alignment
{
    return self.paragraphStyle.alignment;
}

- (void) setAlignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle* paragraphStyle = [self.paragraphStyle mutableCopy];
    paragraphStyle.alignment = alignment;
    self.paragraphStyle = paragraphStyle;
}

- (CGFloat) paragraphSpacing
{
    return self.paragraphStyle.paragraphSpacing;
}

- (void) setParagraphSpacing:(CGFloat)paragraphSpacing
{
    NSMutableParagraphStyle* paragraphStyle = [self.paragraphStyle mutableCopy];
    paragraphStyle.paragraphSpacing = paragraphSpacing;
    self.paragraphStyle = paragraphStyle;
}

- (CGFloat) lineHeightMultiple
{
    return self.paragraphStyle.lineHeightMultiple;
}

- (void) setLineHeightMultiple:(CGFloat)lineHeightMultiple
{
    NSMutableParagraphStyle* paragraphStyle = [self.paragraphStyle mutableCopy];
    paragraphStyle.lineHeightMultiple = lineHeightMultiple;
    self.paragraphStyle = paragraphStyle;
}

- (NSRange) range
{
    return NSMakeRange(0, self.length);
}

- (NSParagraphStyle*) paragraphStyle
{
    NSParagraphStyle* existingParagraphStyle = (NSParagraphStyle*)[self attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
    if (existingParagraphStyle)
    {
        return [existingParagraphStyle mutableCopy];
    }
    return [NSParagraphStyle defaultParagraphStyle];
}

- (void) setParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    [self removeAttribute:NSParagraphStyleAttributeName range:self.range];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:self.range];
}



@end
