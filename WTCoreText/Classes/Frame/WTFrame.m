//
//  WTFrame.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTFrame.h"
#import "WTLine.h"

@interface WTFrame ()

@property (nonatomic, assign) CGMutablePathRef pathRef;
@property (nonatomic, assign) CTFrameRef       frameRef;
@property (nonatomic, assign) NSUInteger       numberOfLines;
@property (nonatomic, assign) CGFloat          truncatingWidth;

@end

@implementation WTFrame

- (void)dealloc {
    
    if (_pathRef) {
        CGPathRelease(_pathRef);
    }
}

- (id)initWithAttributeString:(NSAttributedString *)attributedString size:(CGSize)size numberOfLines:(NSUInteger)numberOfLines{
    self = [super init];
    if (self) {
        
        self.attributedString = attributedString;
        self.truncatingWidth = size.width;
        _pathRef = CGPathCreateMutable();
        CGPathAddRect(_pathRef, NULL, CGRectMake(0, 0, size.width, size.height));
        
        self.numberOfLines = numberOfLines;
        
        [self buildLines];
    }
    
    return self;
}

- (void)buildLines {
    
    CTFrameRef frameRef = self.frameRef;
    
    CFArrayRef linesRef = CTFrameGetLines(frameRef);
    CFIndex count = CFArrayGetCount(linesRef);
    
    CGPoint lineOrigins[count];
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), lineOrigins);
    
    NSMutableArray *lines = [NSMutableArray array];
    
    CGFloat maxWidth = 0;
    
    NSUInteger numberOfLines = self.numberOfLines > 0 ? self.numberOfLines : count;
    CGFloat heightOffset = lineOrigins[MIN(numberOfLines, count) - 1].y;
    
    for (int i = 0; i < MIN(numberOfLines, count); i++) {
        
        CTLineRef lineRef = CFArrayGetValueAtIndex(linesRef, i);
        
        CGPoint origin = CGPointMake(lineOrigins[i].x, lineOrigins[i].y - heightOffset);
        WTLine *line = [[WTLine alloc] initWithFrame:self line:lineRef lineOrigin:origin];
        
        
        maxWidth = MAX(maxWidth, line.size.width);
        if (i == MIN(numberOfLines, count) - 1) {
            if (i < count - 1) {
                
                CFRange lastLineRange = CTLineGetStringRange(lineRef);
                NSUInteger truncationAttributePosition = lastLineRange.location + lastLineRange.length - 1;
                
                NSDictionary *tokenAttributes = [self.attributedString attributesAtIndex:truncationAttributePosition
                                                                          effectiveRange:NULL];
                NSAttributedString *tokenString = [[NSAttributedString alloc] initWithString:@"\u2026"
                                                                                  attributes:tokenAttributes];
                CTLineRef truncationToken = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)tokenString);
                
                CGRect tokenRect = CTLineGetBoundsWithOptions(truncationToken, kCTLineBoundsUseGlyphPathBounds);
                CTLineRef newLineRef = CTLineCreateTruncatedLine(lineRef, self.truncatingWidth - tokenRect.size.width - tokenRect.origin.x, kCTLineTruncationEnd, truncationToken);
                
                if (newLineRef) {
                    
                    CGFloat adjustHeight = line.size.height;
                    
                    line = [[WTLine alloc] initWithFrame:self line:newLineRef lineOrigin:origin];
                    
                    adjustHeight = line.size.height - adjustHeight;
                    
                    for (WTLine *adjustline in lines) {
                        if (adjustline.origin.y != 0) {
                            CGPoint origin = adjustline.origin;
                            origin.y += adjustHeight;
                            adjustline.origin = origin;
                        }
                    }
                    
                    if (line.origin.y != 0) {
                        CGPoint origin = line.origin;
                        origin.y += adjustHeight;
                        line.origin = origin;
                    }
                }
                
            }
        }
        
        [lines addObject:line];
    }
    
    self.lines = lines;
    
    WTLine *lastLine = [self.lines firstObject];
    CGFloat height = lastLine.origin.y + lastLine.size.height;
    self.size = CGSizeMake(maxWidth, height);
}

- (CTFrameRef)frameRef {
    
    if (!_frameRef) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) self.attributedString);
        
        _frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attributedString.length), self.pathRef, NULL);
        
        CFRelease(framesetter);
    }
    
    return _frameRef;
}
@end
