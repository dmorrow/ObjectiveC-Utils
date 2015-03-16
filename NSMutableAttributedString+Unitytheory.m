//
//  NSMutableAttributedString+Unitytheory.m
//
//  Created by Danny Morrow on 3/6/15.
//  Copyright (c) 2015 unitytheory. All rights reserved.
//

#import "NSMutableAttributedString+Unitytheory.h"
#import <CoreText/CTStringAttributes.h>

@implementation NSMutableAttributedString(unitytheory)

- (void) setMultiple:(NSDictionary *)properties
{
    for (NSString* key in properties)
    {
        NSAssert([self respondsToSelector:NSSelectorFromString(key)], @"trying to set nonexistant property: '%@'", key);
        //[self setAttribute:key value:properties[key]];
        [self setValue:properties[key] forKey:key];
    }
}

- (void) setAttribute:(NSString *)name value:(id)value
{
    [self removeAttribute:name range:self.range];
    [self addAttribute:name value:value range:self.range];
}

- (UIColor*) backgroundColor
{
    return [self attribute:NSBackgroundColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setBackgroundColor:(UIColor *)backgroundColor
{
    [self setAttribute:NSBackgroundColorAttributeName value:backgroundColor];
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
    [self setAttribute:NSFontAttributeName value:font];
}

- (void) setBaselineOffset:(CGFloat)baselineOffset
{
    [self setAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset)];
}

- (UIColor*) color
{
    return [self attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setColor:(UIColor *)color
{
    [self setAttribute:NSForegroundColorAttributeName value:color];
}

- (CGFloat) kerning
{
    return [(NSNumber*)[self attribute:NSKernAttributeName atIndex:0 effectiveRange:nil] floatValue];
}

- (void) setKerning:(CGFloat)kerning
{
    [self setAttribute:NSKernAttributeName value:@(kerning)];
}

- (CGFloat) photoshopKerning
{
    return self.kerning * 1000 / self.font.pointSize;
}

- (void) setPhotoshopKerning:(CGFloat)photoshopKerning
{
    CGFloat pointSize = self.font.pointSize;
    self.kerning = photoshopKerning / 1000 * pointSize;
}

- (NSUInteger*) ligature
{
    return [(NSNumber*)[self attribute:NSLigatureAttributeName atIndex:0 effectiveRange:nil] integerValue];
}

- (void) setLigature:(NSUInteger *)ligature
{
    [self setAttribute:NSLigatureAttributeName value:[NSNumber numberWithInt:ligature]];
}

- (NSURL*) link
{
    return [self attribute:NSLinkAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setLink:(NSURL *)link
{
    [self setAttribute:NSLinkAttributeName value:link];
}

- (CGFloat) strokeWidth
{
    return [(NSNumber*)[self attribute:NSStrokeWidthAttributeName atIndex:0 effectiveRange:nil] floatValue];
}

- (void) setStrokeWidth:(CGFloat)strokeWidth
{
    [self setAttribute:NSStrokeWidthAttributeName value:@(strokeWidth)];
}

- (UIColor*) strokeColor
{
    return [self attribute:NSStrokeColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setStrokeColor:(UIColor *)strokeColor
{
    [self setAttribute:NSStrokeColorAttributeName value:strokeColor];
}

- (NSInteger*) superscript
{
    return [(NSNumber*)[self attribute:(NSString*)kCTSuperscriptAttributeName atIndex:0 effectiveRange:nil] integerValue];
}

- (void) setSuperscript:(NSInteger *)superscript
{
    [self setAttribute:(NSString*)kCTSuperscriptAttributeName value:[NSNumber numberWithInt:superscript]];
}

- (UIColor*) underlineColor
{
    return [self attribute:NSUnderlineColorAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setUnderlineColor:(UIColor *)underlineColor
{
    [self setAttribute:NSUnderlineColorAttributeName value:underlineColor];
}

- (NSUnderlineStyle) underlineStyle
{
    return (NSUnderlineStyle)[self attribute:NSUnderlineStyleAttributeName atIndex:0 effectiveRange:nil];
}

- (void) setUnderlineStyle:(NSUnderlineStyle)underlineStyle
{
    [self setAttribute:NSUnderlineStyleAttributeName value:@(underlineStyle)];
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
    [self setAttribute:NSParagraphStyleAttributeName value:paragraphStyle];
}



@end
