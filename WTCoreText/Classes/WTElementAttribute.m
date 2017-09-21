//
//  WTElementAttribute.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTElementAttribute.h"
#import <CoreText/CoreText.h>

@interface WTElementAttribute()

@property (nonatomic, strong) NSDictionary *attributes;

@end

@implementation WTElementAttribute

- (NSDictionary *)generateCoreTextAttributes {
    
    if (!_attributes) {
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        CTParagraphStyleRef style = [self createCTParagraphStyle];
        
        attributes[(__bridge id) kCTParagraphStyleAttributeName] = CFBridgingRelease(style);
        
        if (self.font) {
            attributes[(__bridge id) kCTFontAttributeName] = [UIFont systemFontOfSize:self.font.pointSize];
        }
        
        if (self.textColor) {
            attributes[(__bridge id) kCTForegroundColorAttributeName] = (id) self.textColor.CGColor;
        }
        
        if (self.underLineStyle) {
            attributes[(__bridge id) kCTUnderlineStyleAttributeName] = self.underLineStyle;
        }
        
        _attributes = attributes;
    }
    
    return _attributes;
}

- (CTParagraphStyleRef)createCTParagraphStyle {
    
    CTTextAlignment alignment = kCTTextAlignmentLeft;
    CGFloat firstLineHeadIndent = 0;
    CGFloat defaultTabInterval = 0;
    
    CGFloat paragraphSpacing = 0;
    CGFloat paragraphSpacingBefore = 0;
    
    CGFloat headIndent = 0;
    CGFloat tailIndent = 0;
    CTWritingDirection baseWritingDirection = kCTWritingDirectionLeftToRight;
    CGFloat lineHeightMultiple = 0;
    
    CGFloat minimumLineHeight = 0;
    CGFloat maximumLineHeight = 0;
    
    CGFloat minimunLineSpacing = self.minimunLineSpacing;
    CGFloat maximunLineSpacing = self.maximunLineSpacing;
    CGFloat lineAdjustment = self.lineAdjustment;
    
    CFArrayRef stops = NULL;
    
    CTLineBreakMode lineBreakMode = self.lineBreakMode;
    
    CTParagraphStyleSetting settings[] = {
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(firstLineHeadIndent), &firstLineHeadIndent},
        {kCTParagraphStyleSpecifierDefaultTabInterval, sizeof(defaultTabInterval), &defaultTabInterval},
        
        {kCTParagraphStyleSpecifierTabStops, sizeof(stops), &stops},
        
        {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(paragraphSpacing), &paragraphSpacing},
        {kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(paragraphSpacingBefore), &paragraphSpacingBefore},
        {kCTParagraphStyleSpecifierLineBreakMode, sizeof(lineBreakMode), &lineBreakMode},
        {kCTParagraphStyleSpecifierHeadIndent, sizeof(headIndent), &headIndent},
        {kCTParagraphStyleSpecifierTailIndent, sizeof(tailIndent), &tailIndent},
        {kCTParagraphStyleSpecifierBaseWritingDirection, sizeof(baseWritingDirection), &baseWritingDirection},
        {kCTParagraphStyleSpecifierLineHeightMultiple, sizeof(lineHeightMultiple), &lineHeightMultiple},
        
        {kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(minimumLineHeight), &minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(maximumLineHeight), &maximumLineHeight},
        
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(minimunLineSpacing), &minimunLineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(maximunLineSpacing), &maximunLineSpacing},
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(lineAdjustment), &lineAdjustment}
    };
    
    CTParagraphStyleRef ret = CTParagraphStyleCreate(settings, 15);
    
    return ret;
}

@end
