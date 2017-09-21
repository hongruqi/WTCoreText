//
//  WTLine.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTLine.h"
#import "WTFrame.h"
#import "WTRun.h"
#import "WTElement.h"
#import "WTCoreTextConstants.h"
#import "WTElementAttachment.h"

@interface WTLine ()

@end

@implementation WTLine

- (void)dealloc {
    
    if (_ctLine) {
        CFRelease(_ctLine);
    }
}

- (id)initWithFrame:(WTFrame *)frame line:(CTLineRef)line lineOrigin:(CGPoint)origin {
    self = [super init];
    if (self) {
        
        self.frame = frame;
        
        self.ctLine = line;
        
        self.origin = origin;
        
        [self buildGlyphRuns];
    }
    
    return self;
}

- (void)buildGlyphRuns {
    
    CTLineRef line = self.ctLine;
    
    CGFloat width = (CGFloat) CTLineGetTypographicBounds(line, &_ascent, &_descent, &_leading);
    
    //获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    
    CFIndex runCount = CFArrayGetCount(runs);
    
    NSMutableArray *glyphRuns = [NSMutableArray array];
    
    for (CFIndex i = 0; i < runCount; i++) {
        
        CTRunRef run = CFArrayGetValueAtIndex(runs, i);
        
        NSDictionary *dictionary = (__bridge NSDictionary *) CTRunGetAttributes(run);
        
        WTElementAttachment *attachment = dictionary[kWTElementAttachmentName];
        
        WTElement *element = attachment.originElement;
        
        Class elementClass = [[element class] glyphRunClass];
        
        if ([elementClass isSubclassOfClass:[WTRun class]]) {
            
            WTRun *xyRun = [(WTRun *) [elementClass alloc] initWithLine:self run:run attachment:attachment];
            
            [glyphRuns addObject:xyRun];
        }
    }
    
    self.runs = glyphRuns;
    
    self.size = CGSizeMake(width, (_ascent + _descent + _leading));
}

- (void)setCtLine:(CTLineRef)ctLine {
    _ctLine = ctLine;
    CFRetain(_ctLine);
}
@end
