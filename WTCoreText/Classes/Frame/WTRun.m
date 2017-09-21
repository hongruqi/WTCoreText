//
//  XYRun.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTRun.h"
#import "WTLine.h"
#import "WTRichTextView.h"
#import "WTElementAttachment.h"

@implementation WTRun

- (void)dealloc {
    
    if (_run) {
        CFRelease(_run);
    }
}

- (id)initWithLine:(WTLine *)line run:(CTRunRef)run attachment:(WTElementAttachment *)attachment {
    self = [super init];
    if (self) {
        
        self.line = line;
        self.run = run;
        
        self.attachment = attachment;
        
        CGPoint position;//= *CTRunGetPositionsPtr(run);
        CTRunGetPositions(run, CFRangeMake(0, 1), &position);
        
        self.origin = CGPointMake(line.origin.x + position.x, line.origin.y + position.y);
        
        CGFloat width = (CGFloat) CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &_ascent, &_descent, &_leading);
        CGFloat height = _ascent + _descent + _leading;
        
        self.size = CGSizeMake(width, height);
    }
    
    return self;
}

- (void)setRun:(CTRunRef)run {
    
    _run = run;
    CFRetain(_run);
}

- (void)renderInView:(WTRichTextView *)view context:(CGContextRef)context {
    
    CGFloat positionY = self.origin.y + self.line.descent + self.leading;
    
    CGFloat ascentOffset = 0;
    
    CGContextSetTextPosition(context, self.line.origin.x, positionY + ascentOffset);
    
    CTRunDraw(self.run, context, CFRangeMake(0, 0));
}
@end
